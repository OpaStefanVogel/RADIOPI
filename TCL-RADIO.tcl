wm geometry . +328+37
wm title . "Radio"
grid [ttk::frame .c -padding "3 3 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::button .c.radioan  -text "Radio an " -command "mache {Radio an}" ] -column 1 -row 1 -sticky w
grid [ttk::button .c.radioaus -text "Radio aus" -command "mache {Radio aus}"] -column 1 -row 2 -sticky w
grid [ttk::button .c.radioleiser -text "lauter" -command "mache {Radio lauter}"] -column 1 -row 3 -sticky w
grid [ttk::button .c.radiolauter -text "leiser" -command "mache {Radio leiser}"] -column 1 -row 4 -sticky w
grid [ttk::button .c.bus31 -text "Bus 31" -command "mache Bus31"] -column 1 -row 5 -sticky w
grid [ttk::button .c.bus62 -text "Bus 62" -command "mache Bus62"] -column 1 -row 6 -sticky w
grid [ttk::button .c.rpib -text "RPI B" -command RPIB] -column 1 -row 7 -sticky w
grid [ttk::button .c.ttyAMA1 -text "ttyAMA1" -command ttyAMA1] -column 1 -row 8 -sticky w
grid [ttk::button .c.ansageein -text "Ansage an" -command "mache {Ansage an}"] -column 1 -row 9 -sticky w
grid [ttk::button .c.ansageaus -text "Ansage aus" -command "mache {Ansage aus}"] -column 1 -row 10 -sticky w
grid [ttk::button .c.swapoff -text "swapoff" -command "swapoffon"] -column 1 -row 11 -sticky w
grid [ttk::button .c.reboot -text "reboot" -command "sudoreboot"] -column 1 -row 12 -sticky w


foreach w [winfo children .c] {grid configure $w -padx 2 -pady 2}

bind . <E> {RadioAn}
bind . <A> {RadioAus}
bind . <P> {RadioLauter}
bind . <M> {RadioLeiser}

proc mache {text} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile $text
  close $outfile
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
  exec sudo swapoff /dev/zram1
  exec sudo swapon /dev/zram1
  exec sudo swapoff /dev/zram2 
  exec sudo swapon /dev/zram2
  exec sudo swapoff /dev/zram3 
  exec sudo swapon /dev/zram3
  exec sudo swapoff /var/swap
  exec sudo swapon /var/swap
  }

proc sudoreboot {} {
  exec sudo reboot
  }

vwait forever

