RADIOPI
#Konfigurationsfiles für den Radio Raspberry Pi
#sc-card mit fdisk formatieren auf W95 FAT32 #http://www.technik-tipps-und-tricks.de/raspberry-pi/raspberry-pi-betriebssystem-installation/raspberry-pi-sd-karte-formatieren/#linux
#oder mit dem rpi-imager formatieren

#Start mit Raspberry PI 4 und bookworm 64 bit und wayland x11 ♥#... und Bullseye
df #5053516 18%♥

#dann als erstes♥
sudo apt update
sudo apt upgrade
df #5479484 20%♥

#nochmal mit raspi-config vnc einschalten, dann gehts

#display drehen mit Preferences→Screen_Configuration (wirkt dauerhaft erst nach mehreren Versuchen)²

#den touch um 90° drehen laut https://www.raspberrypi.com/documentation/accessories/touch-display-2.html#install
#  mit dtoverlay=vc4-kms-dsi-ili9881-7inch,sizex=400,swapxy,invy in /boot/firmware/config.txt
#  https://www.instructables.com/Rotate-Raspberry-Pi-Display-and-Touchscreen/ ging dafür auch

#den authorized_key "Galax" für connect-bot reinkopieren aus dem alten authorized_keys, dann geht connect-bot	

#genügend swap-Speicher bereitstellen
sudo nano /etc/dphys-swapfile #von 200 auf 1024 ♥# dort statt 100 eine 1024 einsetzen #pimylifeup.com/raspberry-pi-swap-file
sudo reboot

#in einem extra Terminal
sudo watch cat /proc/swaps

df #7119336 25%

dd if=/dev/zero of=./largefile bs=1M count=1024 #21.7 MB/s ♥#31.4 MB/s statt 43,7 MB/s statt 6,4 MB/s
rm largefile

#Preferences firefox, ssh, vnc, serial ohne console, remote GPIO, dann reboot und update ♥#und in Preferences vnc und ssh erlauben in Configuration und gleich mit Hostname Radio setzen
df #7127580 25%

cat /proc/cpuinfo #a03111 ♥#revision aus https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md
cat /sys/firmware/devicetree/base/model
aplay /usr/share/sounds/alsa/Noise.wav #vorher laut stellen ♥
speaker-test -t wav -c 8 #war vorher 4 ♥
rvlc https://soundcloud.com/sickspud/tyk-tyk-tyk
rvlc http://www.uzic.ch/tek.m3u
#und wenn kein Stereo dann folgendes: ist weg

#im Dateimanager Einstellungen: single Klick, Remove, no ask

#oben schon ♥#Geschwindigkeit testen:

#neuen ssh-key für github erzeugen
ssh-keygen #und mit vnc aufs Tablet holen und zu github schaffen ♥#Enter Enter Enter
ssh-copy-id pi@localhost #geht momentan nicht, sudo? ♥#pi@KEYSTATION_61 #und weitere
cd Desktop
git clone git@github.com:OpaStefanVogel/OpaStefanVogel.github.io.git CLONE
cd CLONE
git submodule init #momentan nicht drin, deshalb einzeln clonen
git submodule update
df #?? 27%#

#wenn submodule nicht geht, einzeln:
#git clone git@github.com:OpaStefanVogel/KLETTERN_UND_RUTSCHEN.git
#git clone git@github.com:OpaStefanVogel/RADIOPI.git #und so weiter alle durch ♥

#dann Anwendung node-red hinzuinstallieren aus Menü "Recommended Software"
sudo apt install nodered #weil Menü noch leer, geht aber auch nicht, also später ♥
#oder wenn nicht geht das bash script aus https://nodered.org/docs/getting-started/raspberrypi
#dann die fehlenden nodes nachladen
#node email neues passwort https://bustatech.com/send-and-receive-email-on-node-red/
df #?? ??%#

#node-red starten
cd RADIOPI
node-red ./flows_Radio.json 
#in .node-red/settings.js setze flowFilePretty: true
#mit Tablet-Browser localhost:1880 menu-install dropbox daemon
#und schon geht Temperaturansage von alleine los
#inject Radio an#oder besser über Touchscreen.html
#und node email adresse neu einsetzen#dann kommt schon die neue Email

#nö ♥#von vivaldi download die Adresse mit vnc reinkopieren die aktuelle Version 
#wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.9.1705.41-1_armhf.deb
#wget https://downloads.vivaldi.com/stable/vivaldi-stable_3.0.1874.38-1_armhf.deb
#wget https://downloads.vivaldi.com/stable/vivaldi-stable_4.3.2439.65-1_armhf.deb
#dann im Filemanager installieren und starten und gleich synchronisieren und als Startbrowser einstellen

cd KLETTERN_UND_RUTSCHEN
git submodule init
git submodule update --depth 1
df #9209052 33%#
#wenn git submodule update nicht duchgeht:
cd
ln -f -r -s ./Desktop/CLONE_2023/KLETTERN_UND_RUTSCHEN/threejs2024/build/ ./Desktop/CLONE/KLETTERN_UND_RUTSCHEN/threejs2024/.
ln -f -r -s ./Desktop/CLONE_2024/KLETTERN_UND_RUTSCHEN/threejs2024/examples/ ./Desktop/CLONE/KLETTERN_UND_RUTSCHEN/threejs2024/.

#ok firefox geht auf Anhieb!!! ♥#jetzt sollte schon MIT_KONSTRUK_FF.html gehen

#Desktop füllen
cd
ln -f -r -s ./Desktop/CLONE/RADIOPI/README.md ./Desktop/.
ln -f -r -s ./Desktop/CLONE/*/*.desktop ./Desktop/.
ln -f -r -s ./Desktop/CLONE/*.desktop ./Desktop/.
ln -f -r -s ./Desktop/CLONE/RADIOPI/.xsessionrc .xsessionrc

ln -f -r -s /tmp ./Desktop/CLONE/RADIOPI/.


df #20400688 29% #♥#

sudo apt install gitk
sudo apt install screen
sudo apt install espeak #für Ansage Zeit/Temperatur/Bus
sudo apt install wolframscript #später♥#
sudo apt install zynaddsubfx#noch kein Ton ♥#juhuuu geht wieder, jetzt auf aseqdump -p20:0
zynaddsubfx -I alsa -O alsa -l So_hat_Weihnachten_2015_geklungen.xmz &
sudo apt install xscreensaver
sudo apt install pulseeffects

#aus der vorherigen SD rüberkopieren weil nicht comitted:
#Diagonalen.js
#ERGS2_2945_20180813.js
#Download/THULE...jpg
#BARE/STREICHHOL... und so weiter

#uart5 einschalten:
sudo nano /boot/config.txt
dtoverlay=uart5

#.history füllen mit
make;hexdump kernel.img -v -e '1/4 "%08x" "\n"' >/dev/ttyS0;echo -n "MN" >/dev/ttyS0
ytdl "https://youtu.be/1OxRLXTHqls" | mpv --force-seekable=yes - #Hexer und Medizinmann

touch broadlink/switch_off
touch broadlink/switch_on
touch /tmp/ttyS0_RXD
touch /tmp/RADIO_Ansage.txt
wolframscript -cloud -code "10^200-(10^100+1)*(10^100-1)"


#alternativ zum nachfolgenden lighttpd: apache2
sudo apt install apache2
sudo nano /etc/apache2/envvars #dort eintragen APACHE_RUN_USER=pi und APACHE_RUN_GROUP=pi
sudo mv /var/www/html/ /var/www/html2/
sudo ln -f -r -s ./Desktop/CLONE/ /var/www/html
sudo chown www-data:www-data /var/www/html

#ganz neu, ein richtiger web-server für Rezepte.xml:
#https://www.elektronik-kompendium.de/sites/raspberry-pi/1905271.htm
sudo apt install lighttpd
sudo systemctl status lighttpd #active (running) ♥
sudo groupadd www-data #already exists ♥
sudo usermod -G www-data -a pi
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 775 /var/www/html
sudo service lighttpd force-reload
sudo nano /etc/lighttpd/lighttpd.conf
#dort die Zeile server.document-root umändern auf server.document-root = "/home/pi/Desktop/CLONE" 
sudo reboot
#Dann http://RADIO/Desktop/CLONE/Rezepte.xml

sudo apt-get install gap
gap
gap> 1/0; 
brk> quit;
gap> SaveWorkspace("GAP_WORKSPACE");
gap> quit;
df #???? ??%


#piper installieren laut https://youtu.be/9e1Wt82GKmU




#bei Bedarf aus haydenjames.io/raspberry-pi-performance-add-zram-kernel-parameters/
sudo apt install zram-tools
sudo nano /etc/default/zramswap # dort CORES=1, ALLOCATION=2048, PRIORITY=96
  #zuletzt CORES=4, ALLOCATION=500, PRIORITY=5, #geht bisjetzt am flüssigsten
  #zuletzt CORES=1, ALLOCATION=500, PRIORITY=-1, #geht wie? bei 380 bleibt swap löschen stecken
  #zuletzt CORES=4, ALLOCATION=600, PRIORITY=-1, #geht wie?
  #zuletzt SIZE=400, PRIORITY=5, #♥#und CORE gibts nicht mehr
sudo nano /etc/sysctl.conf #dort ergänzen:
vm.vfs_cache_pressure=100             #zuletzt 500#100
vm.swappiness=10                      #100#10 10=SWAP startet ab 90% gefüllt
vm.dirty_background_ratio=10          #1
vm.dirty_ratio=50                     #50

sudo reboot
sudo watch cat /proc/swaps

//rpi-apps aus ???

#-----------------------------------soweit Bookworm ♥ und Bullseye---------------------------------------------------
#------------------------------------------------------------------------------------------------------



#laut https://jamesachambers.com/raspberry-pi-4-bootloader-firmware-updating-recovery-guide/
#sudo apt-get install rpi-eeprom #nur wenn nicht da
#sudo nano /etc/default/rpi-eeprom-update #dort "critical" in "beta" umändern
sudo rpi-eeprom-update # um zu schauen ob aktuell
sudo rpi-eeprom-update -a #zum aktualisieren wenn nicht aktuell
sudo reboot #wenn aktualisiert
#siehe auch https://github.com/raspberrypi/rpi-eeprom/blob/master/firmware/release-notes.md

--Test
sudo nano /boot/config.txt
#force_turbo=1
arm_freq=1200
#              1x gap          3x gap       
#        1300  404 s 58 °C     620 s 64 °C
#        1500  387 s 60 °C     610 s 70 °C
#        1700
arm_freq_min=600 #500 geht nicht

#laut https://scribles.net/customizing-boot-up-screen-on-raspberry-pi/
sudo nano /boot/cmdline.txt #dort am Ende oder aktuell nach rootwait quit entfernen damit boot ok messages ausgegeben werden

vcgencmd measure_clock arm
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

#bei nspawn64:
#sudo cp -ax /var/lib/machines/debian-buster-64{,.bak}
#ds64-shell
#sudo apt-get update
#sudo apt-get upgrade
#exit
#neu:
#sudo apt install -y raspbian-nspawn-64
#sudo apt purge pulseaudio

#Farbe Terminal einstellen

df #7438 26% woher die auf einmal?
#+neues Verzeichnis Desktop/CLONE
cd Desktop/CLONE
#git clone https://github.com/OpaStefanVogel/RADIOPI
#und mehr
cp -s /*/.*.desktop .
git pull

df #7673 #27%

#sudo apt-get remove pulseaudio #bei nspawn64, doch erstmal nicht

#sudo nano /boot/cmdline.txt #und dort am Zeilenende nach Leerzeichen consoleblank=0 ergänzen

sudo apt-get install zynaddsubfx #und schon mal mit ./.xsessionrc starten:


df #7848 28%
ssh-keygen
nano .ssh/authorized_keys #dort key aus id_rsa.pub eintragen wegen ssh pi@localhost
#sudo apt-get --allow-releaseinfo-change update #wenn nur update nicht geht wegen "testing" "stable"

#sudo apt-get install florence at-spi2-core
sudo apt-get install mosquitto mosquitto-clients
mosquitto_sub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z"
mosquitto_pub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z" -m "Radio an"


#Hintergrundbild einstellen

hostnamectl
#hostnamectl set-hostname Radio #wenn noch nicht eingestellt

cd Desktop/GHDL
sudo apt-get install ghdl gtkwave #bzw. ghdl-llvm laut https://github.com/ghdl/ghdl/issues/1028
#aber dann der vfp-Fehler...
./ghdl/ghdl_llvm -i simple.vhdl
./ghdl/ghdl_llvm -m simple
./simple -disp-time

file $(which ls) #bin/ls: ELF 32-bit
ds64-shell
file $(which ls) #/bin/ls: ELF 64-bit
top #14 Prozesse
sudo apt update
sudo apt upgrade
#dann nochmal ghdl von oben wiederholen, mit gcc:
sudo apt-get install ghdl gtkwave gcc
ghdl-gcc -i simple.vhdl
ghdl-gcc -m simple
./simple --disp-time
gtkwave test.ghw view.sav
exit
df #9086 32%


#dann noch RaspAP, aber heute nicht

#wenn README.md geschafft:
cd
cd Desktop/GIT_CLONE_GITHUB/RADIOPI
gitk --all &
git commit -a -m "neuinstalliert20200601"
git push

#aktuell laut https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/downloads.html
sudo apt-get install gcc-arm-none-eabi


#Hotspot laut
#https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md
#und
#https://www.raspberrypi.org/forums/viewtopic.php?f=36&t=279500&p=1692756&hilit=https%3A%2F%2Fwww.raspberrypi.org%2Fdocumentation%2Fconfiguration%2Fwireless%2Faccess+point+routed.md#p1692756
#aber in
sudo nano /etc/dnsmasq.conf
#mit der Zeile
address=/RADIO.wlan/192.168.4.1






















---alles folgende nicht mehr weil kein Unterschied oder nicht mehr nötig:
#gap64
sudo apt-get install autoconf gcc g++ make wget
cd gap64
./autogen.sh
./configure
make bootstrap-pkg-full
./bin/gap.sh




# laut https://www.heise.de/newsticker/meldung/Raspberry-Pi-Erste-Fassung-des-64-Bit-Kernels-verfuegbar-4524121.html
uname -a #Linux Radio     4.19.66-v7l+ #1253 SMP Thu Aug 15 12:02:08 BST 2019 armv7l GNU/Linux
         #Linux raspberry 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l GNU/Linux
uname -i #unknown
sudo rpi-update #vorher noch sudo apt update; sudo apt install rpi-eeprom #und reboot
sudo nano /boot/config.txt #dort die Zeile arm_64bit=1 ergänzen
sudo reboot
uname -a #Linux Radio     4.19.73-v8+ #1267 SMP PREEMPT Fri Sep 20 18:14:38 BST 2019 aarch64 GNU/Linux
         #Linux raspberry 4.19.79-v8+ #1273 SMP PREEMPT Fri Oct 11 18:35:44 BST 2019 aarch64 GNU/Linux
         #Linux Radio 4.19.83-v8+ #1277 SMP PREEMPT Mon Nov 11 16:53:30 GMT 2019 aarch64 GNU/Linux
df # 07712 27%



df # 07712 27%
#laut https://www.raspberrypi.org/forums/viewtopic.php?p=1422775
sudo raspi-config #dort "7 Advanced Options" then "A7 GL Driver" then "G2 GL (Fake KMS) OpenGL desktop driver with fake KMS" und reboot
file $(which ls) #/bin/ls: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=67a394390830ea3ab4e83b5811c66fea9784ee69, stripped
cat /etc/os-release #PRETTY_NAME="Raspbian GNU/Linux 10 (buster)"...
wget -c http://http.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2019.1_all.deb #mit aktuellem 19.1 statt 17.5 von http://http.us.debian.org/debian/pool/main/d/debian-archive-keyring
sudo apt install ./debian-archive-keyring_2019.1_all.deb
sudo apt-get -y install debootstrap systemd-container zenity # pulseaudio #pulseaudio nicht, sonst gehen Keystation61 und VLC nicht gleichzeitig
sudo mkdir -pv /var/lib/machines


sudo debootstrap --arch=arm64 --include=systemd-container,pulseaudio,zenity stretch /var/lib/machines/debian-stretch-64 http://deb.debian.org/debian/ 
sudo apt purge debian-archive-keyring #entfernen wenn gewünscht
df #08386 30%

df #08386 30%
sudo systemd-nspawn --settings=no --directory=/var/lib/machines/debian-stretch-64
root@raspberrypi:~# passwd root
root@raspberrypi:~# useradd --user-group --groups adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev --create-home --uid 1000 --shell /bin/bash pi
root@raspberrypi:~# passwd pi
root@raspberrypi:~# echo -e "127.0.0.1\tdebian-stretch-64" >> /etc/hosts
root@raspberrypi:~# logout

sudo systemd-nspawn --settings=no --machine=debian-stretch-64 --boot --bind=/home/pi --bind=/etc/resolv.conf
##vor dem login in einem anderem terminal:
sudo hostnamectl --machine=debian-stretch-64 set-hostname debian-stretch-64
sudo machinectl shell root@debian-stretch-64 /bin/bash
root@debian-stretch-64:~# ps -aux

##noch in einem dritten terminal:
sudo journalctl --machine=debian-stretch-64
sudo systemctl --machine=debian-stretch-64
sudo systemctl --machine=debian-stretch-64 --failed

#jetzt login im ersten terminal aks root, dann:
apt-get update && apt-get -y upgrade
apt-get install -y sudo
apt-get install -y file
file $(which ls)
logout

#und login als pi:
ls
sudo apt-get install -y locales
sudo dpkg-reconfigure locales #dort de.UTF-9 UTF-9 gewählt
locale -a #C C.UTF POSIX
sudo dpkg-reconfigure tzdata
sudo reboot
journalctl --boot --priority=err #-- No entries -
sudo poweroff
#Rest mit X11-apps und Sound weglassen
df #08481 30%

df #08481 30%
#und neustart mit:
sudo systemd-nspawn --settings=no --machine=debian-stretch-64 --boot --bind=/home/pi --bind=/etc/resolv.conf
sudo machinectl shell root@debian-stretch-64 /bin/bash #geht nicht???
sudo apt-get install gtkwave
cd Desktop/GHDL/
DISPLAY=:0.0 gtkwave test.ghw view.sav
sudo apt-get install ghdl #gibts nicht, deshalb alles nochmal mit buster:


sudo debootstrap --arch=arm64 --include=systemd-container,pulseaudio,zenity stretch /var/lib/machines/debian-stretch-64 http://deb.debian.org/debian/ 
df #08386 30%
sudo systemd-nspawn --settings=no --directory=/var/lib/machines/debian-buster-64


------nicht:
#laut https://forums.xilinx.com/t5/Installation-and-Licensing/I-get-quot-ERROR-This-installation-is-not-supported-on-32-bit/td-p/597759https://www.xilinx.com/member/forms/download/xef-vivado.html
uname -i #unknown
sudo dpkg-divert --add --rename --divert /bin/uname.orig /bin/uname
sudo ln -s /usr/lib/klibc/bin/uname /bin/uname
uname -i #aarch64
zurueck mit sudo dpkg-divert --rename --remove /bin/uname #ging aber nicht


#laut packages.debian.org/de/buster/aqrm64/libc6/download
sudo nano /etc/apt/sources.list # und dort ergänzen deb http://ftp.de.debian.org/debian buster main
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade





###ttyS0 in Raspberyy Konfiguration erlauben. Dann
stty -F /dev/ttyS0 115200 cs8 -cstopb -parenb -crtscts -echo ixon -ixoff
stty raw -echo opost quit ^C isig ixon -ixoff #hiernach ist es finster!!!
cp /dev/ttyS0 /dev/tty & cp /dev/tty /dev/ttyS0

#nur speichern:
stty -F /dev/ttyS0 115200 raw cs8 -crtscts -cstopb -parenb 
cp /dev/ttyS0 Test.txt

