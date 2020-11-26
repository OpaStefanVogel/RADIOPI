wm geometry . +00+300
wm title . "Radio"
grid [ttk::frame .c -padding "3 3 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::button .c.radioan  -text "Radio an " -command RadioAn ] -column 1 -row 2 -sticky w
grid [ttk::button .c.radioaus -text "Radio aus" -command RadioAus] -column 1 -row 3 -sticky w
grid [ttk::button .c.rpib -text "RPI B" -command RPIB] -column 1 -row 4 -sticky w


foreach w [winfo children .c] {grid configure $w -padx 2 -pady 2}

bind . <Return> {calculate}

proc RadioAus {} {  
set outfile [open "tcl_an_nodered.txt" w]
puts $outfile "Radio aus"
close $outfile

}

proc RadioAn {} {  
set outfile [open "tcl_an_nodered.txt" w]
puts $outfile "Radio an"
close $outfile

}

proc RPIB {} {
  exec lxterminal -e "stty -F /dev/ttyS0 115200 raw cs8 -cstopb -parenb -crtscts -echo ixon -ixoff;stty raw -echo opost quit ^C isig ixon -ixoff; cp /dev/ttyS0 /dev/tty & cp /dev/tty /dev/ttyS0" &
  }

vwait forever

