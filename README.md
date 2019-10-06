# RADIOPI
Konfigurationsfiles für den Radio Raspberry Pi

Start mit neuem Raspberry PI 4:

sudo apt-get install gitk
sudo apt-get install screen
#in .node-red/settings.js setze flowFilePretty: true
#diverse node-red module installieren dropbox daemon 
#sudo apt-get install pico2wave #(geht nicht mehr, dafür erstmal espeak)
sudo apt-get install espeak
sudo apt-get install zynaddsubfx
sudo apt-get install xscreensaver #und damit Bildschirmschoner ein-/ausschalten
ssh-keygen
nano .ssh/authorized_keys
sudo nano /etc/dphys-swapfile # dort statt 100 eine 2000 einsetzen
sudo apt-get --allow-releaseinfo-change update #wenn nur update nicht geht wegen "testing" "stable"
sudo apt-get install florence at-spi2-core
sudo apt-get install mosquitto mosquitto-clients
mosquitto_sub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z"
mosquitto_pub -h test.mosquitto.org -t "Testheini78x11/psswd_ha72z" -m "Radio an"








nano .xsessionrc #mit folgendem Inhalt:
cd ./Desktop/GIT_CLONE_GITHUB/RADIOPI/
.xsessionrc
cd

# laut https://www.heise.de/newsticker/meldung/Raspberry-Pi-Erste-Fassung-des-64-Bit-Kernels-verfuegbar-4524121.html
uname -a #Linux Radio 4.19.66-v7l+ #1253 SMP Thu Aug 15 12:02:08 BST 2019 armv7l GNU/Linux
sudo rpi-update #vorher noch sudo apt update; sudo apt install rpi-eeprom #und reboot
sudo nano /boot/config.txt #dort die Zeile arm_64bit=1 ergänzen
sudo reboot
uname -a #Linux Radio 4.19.73-v8+ #1267 SMP PREEMPT Fri Sep 20 18:14:38 BST 2019 aarch64 GNU/Linux


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

