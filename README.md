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
