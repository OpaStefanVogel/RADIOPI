wm geometry . +328+37
wm title . "Radio"
grid [ttk::frame .c -padding "3 3 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::button .c.radioan  -text "Radio an " -command RadioAn ] -column 1 -row 1 -sticky w
grid [ttk::button .c.radioaus -text "Radio aus" -command RadioAus] -column 1 -row 2 -sticky w
grid [ttk::button .c.radioleiser -text "lauter" -command RadioLauter] -column 1 -row 3 -sticky w
grid [ttk::button .c.radiolauter -text "leiser" -command RadioLeiser] -column 1 -row 4 -sticky w
grid [ttk::button .c.bus31 -text "Bus 31" -command Bus31] -column 1 -row 5 -sticky w
grid [ttk::button .c.bus62 -text "Bus 62" -command Bus62] -column 1 -row 6 -sticky w
grid [ttk::button .c.rpib -text "RPI B" -command RPIB] -column 1 -row 7 -sticky w


foreach w [winfo children .c] {grid configure $w -padx 2 -pady 2}

bind . <E> {RadioAn}
bind . <A> {RadioAus}
bind . <P> {RadioLauter}
bind . <M> {RadioLeiser}

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

proc RadioLauter {} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile "Radio lauter"
  close $outfile
  }

proc RadioLeiser {} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile "Radio leiser"
  close $outfile
  }

proc Bus31 {} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile "Bus31"
  close $outfile
  }

proc Bus62 {} {  
  set outfile [open "tcl_an_nodered.txt" w]
  puts $outfile "Bus62"
  close $outfile
  }

proc RPIB {} {
  exec lxterminal -e "stty -F /dev/ttyS0 115200 raw cs8 -cstopb -parenb -crtscts -echo ixon -ixoff;stty raw -echo opost quit ^C isig ixon -ixoff; cp /dev/ttyS0 /dev/tty & cp /dev/tty /dev/ttyS0" &
  }

vwait forever

