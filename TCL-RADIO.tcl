wm geometry . +328+37
wm title . "Radio"
. configure -background black
pack [button .radioan  -text "Radio an " -command "mache {Radio an}" ]
pack [button .radioaus -text "Radio aus" -command "mache {Radio aus}"]
pack [button .lichtan  -text "Licht an " -command LICHT_AN ]
pack [button .lichtaus -text "Licht aus" -command LICHT_AUS]
pack [button .radiolauter -text "lauter" -command "mache {Radio lauter}"] -expand 1
pack [button .radioleiser -text "leiser" -command "mache {Radio leiser}"]
pack [button .info -text "Info" -command "mache {Radio Info}"]
pack [button .bus31 -text "Bus 31" -command "mache Bus31"]
pack [button .bus62 -text "Bus 62" -command "mache Bus62"]
pack [button .rpib -text "RPI B" -command RPIB]
pack [button .ttyAMA1 -text "ttyAMA1" -command ttyAMA1]
pack [button .wlan_ein -text "WLAN ein" -command "exec touch tmp/hostapd_start"]
pack [button .wlan_aus -text "WLAN aus" -command "exec touch tmp/hostapd_stop"]
pack [button .ansageein -text "Ansage an" -command "mache {Ansage an}"]
pack [button .ansageaus -text "Ansage aus" -command "mache {Ansage aus}"]
pack [button .bildaus -text "Bild aus" -command "destroy .c; toplevel .c -background black -cursor none; wm attributes .c -fullscreen 1;bind .c X { focus -force . ; destroy .c}; bind .c <Button-1> {destroy .c ; focus -force .}; bind .c I {.info invoke}; "]
pack [button .swapoff -text "swapoff" -command "swapoffon"]
pack [button .reboot -text "reboot" -command "sudoreboot"]

foreach w [winfo children .] {pack configure $w -fill both -padx 2 -pady 2 -ipady 0}

bind . E {.radioan invoke}
bind . A {.radioaus invoke}
bind . P {.radiolauter invoke}
bind . M {.radioleiser invoke}
bind . I {.info invoke}
bind . B {.bus31 invoke}
bind . C {.bus62 invoke}
bind . X {.bildaus invoke}

set Test 0

proc mache {text} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile $text
  close $outfile
  }

proc LICHT_AN {} {
  exec touch /home/pi/broadlink/switch_on
  }

proc LICHT_AUS {} {
  exec touch /home/pi/broadlink/switch_off
  }

proc RPIB {} {
  exec lxterminal -e "stty -F /dev/ttyS0 115200 raw cs8 -cstopb -parenb -crtscts -echo ixon -ixoff;stty raw -echo opost quit ^C isig ixon -ixoff; tee </dev/ttyS0 /tmp/ttyS0_RXD & cp /dev/tty /dev/ttyS0" &
  exec echo >/dev/ttyS0 "77 88 M* M."
  exec echo >/dev/ttyS0 "77 88 M* M. F0 EMIT 9D EMIT 84 EMIT 9E EMIT 20 EMIT"
  }

proc ttyAMA1 {} {
  exec lxterminal -e "stty -F /dev/ttyAMA1 115200 raw cs8 -cstopb -parenb -crtscts -echo ixon -ixoff;stty raw -echo opost quit ^C isig ixon -ixoff; cp /dev/ttyAMA1 /dev/tty & cp /dev/tty /dev/ttyAMA1" &
  exec echo >/dev/ttyS0 "55 66 77 M* M."
  exec echo >/dev/ttyS0 "55 66 M* M. F0 EMIT 9D EMIT 84 EMIT 9E EMIT 20 EMIT"
  }

proc swapoffon {} {
  exec sudo swapoff /dev/zram0 
  exec sudo swapon /dev/zram0
#  exec sudo swapoff /dev/zram1
#  exec sudo swapon /dev/zram1
#  exec sudo swapoff /dev/zram2 
#  exec sudo swapon /dev/zram2
#  exec sudo swapoff /dev/zram3 
#  exec sudo swapon /dev/zram3
  exec sudo swapoff /var/swap
  exec sudo swapon /var/swap
  }

proc sudoreboot {} {
  exec sudo reboot
  }




proc serverOpen {channel addr port} {
    global connected
    set connected 1
    #fconfigure $channel -blocking 0
    fileevent $channel readable "readLine Server $channel"
    puts "OPENED"
}

proc readLine {who channel} {
    global didRead
    if { [gets $channel line] < 0} {
	fileevent $channel readable {}
	after idle "close $channel;set out 1"
    } else {
	puts "READ LINE: $line"
	puts $channel "Return of $line"
	flush $channel;
	set didRead 1
	focus -force .
    }
}

set connected 0
# catch {socket -server serverOpen 9900} server
if {$Test == 0} {set server [socket -server serverOpen 9900]}



#vwait forever

