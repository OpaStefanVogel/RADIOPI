echo $1 | sudo tee /sys/class/leds/led$2/trigger > /dev/null
