 RADIOPI
Konfigurationsfiles für den Radio Raspberry Pi

Start mit neuem Raspberry PI 4:
df #3735
#++copy von /media/..../.... Desktop Downloads

#+also erstmal Welcome to Rasoberry Pi durchmachen und nochmal
sudo apt update
sudo apt full-upgrade
cat /proc/cpuinfo #revision aus https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md
cat /sys/firmware/devicetree/base/model

#laut https://www.raspberrypi.org/forums/viewtopic.php?p=1544144#p1557580
sudo /etc/init.d/alsa-utils reset
aplay /usr/share/sounds/alsa/Noise.wav
speaker-test -t wav -c 4 #und wenn kein Stereo dann folgendes:
#wenn kein Stereo sudo nano /usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf 
# und dort die Zeile ab Mapping analog-mono mit ";" beginnen lassen bis priority=7
#wenn gar nicht geht
#sudo apt purge pulseaudio

#dann Anwendungen alle außer node-red und vnc entfernen oder diese hinzufügen
#und vnc * ssh erlauben in Configuration und gleich mit Hostname Radio setzen
#und screenblanking disablen
df #

#im Dateimanager Einstellungen: single Klick, Remove, no ask
#- Desktop...README.md hereinkopieren
df #5403 19%


sudo nano /etc/dphys-swapfile # dort statt 100 eine 2000 einsetzen
#aus haydenjames.io/raspberry-pi-performance-add-zram-kernel-parameters/
sudo apt install zram-tools
sudo nano /etc/default/zramswap # dort CORES=1, ALLOCATION=2048, PRIORITY=96
  #zuletzt CORES=4, ALLOCATION=500, PRIORITY=5, #geht bisjetzt am flüssigsten
  #zuletzt CORES=1, ALLOCATION=500, PRIORITY=-1, #geht wie?
sudo nano /etc/sysctl.conf #dort ergänzen:
vm.vfs_cache_pressure=100             #zuletzt 500#100
vm.swappiness=10                      #100#10 10=SWAP startet ab 90% gefüllt
vm.dirty_background_ratio=10          #1
vm.dirty_ratio=50                     #50

sudo reboot
sudo watch cat /proc/swaps

df #6227 22%
dd if=/dev/zero of=./largefile bs=1M count=1024 #43,7 MB/s statt 6,4 MB/s
rm ./largefile

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
sudo nano /boot/cmdline.txt #dort am Ende oder aktuell nach roozwait quit entfernen damit boot ok messages ausgegeben werden

vcgencmd measure_clock arm
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

#bei nspawn64:
#sudo cp -ax /var/lib/machines/debian-buster-64{,.bak}
#ds64-shell
#sudo apt-get update
#sudo apt-get upgrade
#exit
#neu:
sudo apt install -y raspbian-nspawn-64
sudo apt purge pulseaudio

#Farbe Terminal einstellen

df #7438 26% woher die auf einmal?
#+neues Verzeichnis Desktop/CLONE
cd Desktop/CLONE
#git clone https://github.com/OpaStefanVogel/RADIOPI
#und mehr
cp -s /*/.*.desktop .
cd RADIO
git pull

#von vivaldi download die Adresse mit vnc reinkopieren die aktuelle Version 
#wget https://downloads.vivaldi.com/stable/vivaldi-stable_2.9.1705.41-1_armhf.deb
#wget https://downloads.vivaldi.com/stable/vivaldi-stable_3.0.1874.38-1_armhf.deb
#dann im Filemanager installieren und starten und 
df #7673 #27%

#sudo apt-get remove pulseaudio #bei nspawn64, doch erstmal nicht
sudo apt-get install gitk
sudo apt-get install screen
sudo apt-get install espeak #für Ansage Zeit/Temperatur/Bus
node-red ./flows_Radio.json 
#in .node-red/settings.js setze flowFilePretty: true
#mit Tablet-Browser localhost:1880 menu-install dropbox daemon
#und schon geht Temperaturansage von alleine los
#inject Radio an#oder besser über Touchscreen.html
#und node email adresse neu einsetzen#dann kommt schon die neue Email

df #7796 28%
#sudo apt-get install xscreensaver #und damit Bildschirmschoner ein-/ausschalten
#nicht mehr nötig
#sudo nano /boot/cmdline.txt #und dort am Zeilenende nach Leerzeichen consoleblank=0 ergänzen

sudo apt-get install zynaddsubfx #und schon mal mit ./.xsessionrc starten:
zynaddsubfx -I alsa -O alsa -l So_hat_Weihnachten_2015_geklungen.xmz &


df #7848 28%
ssh-keygen
ssh-copy-id pi@localhost #pi@KEYSTATION_61 #und weitere
nano .ssh/authorized_keys #dort key aus id_rsa.pub eintragen wegen ssh pi@localhost
#sudo apt-get --allow-releaseinfo-change update #wenn nur update nicht geht wegen "testing" "stable"

#sudo apt-get install florence at-spi2-core
sudo apt-get install mosquitto mosquitto-clients
mosquitto_sub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z"
mosquitto_pub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z" -m "Radio an"

#cd
#nano .xsessionrc #mit folgendem Inhalt, und ausführbar machen:
#cd ./Desktop/GIT_CLONE_GITHUB/RADIOPI/
#./.xsessionrc
#cd
#oder neuerdings nur
cd
ln -s ./Desktop/CLONE/RADIOPI/.xsessionrc .xsessionrc

#Desktop füllen
cd Desktop
ln -s ./Desktop/CLONE/*/*.desktop ./Desktop/.
cd

#Hintergrundbild einstellen

hostnamectl
#hostnamectl set-hostname Radio #wenn noch nicht eingestellt


sudo apt-get install gap
gap
gap> 1/0; 
brk> quit;
gap> SaveWorkspace("GAP_WORKSPACE");
gap> quit;
df #8743 31%

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

