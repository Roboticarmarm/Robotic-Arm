#Basic control
export PIN1=192

function open()
{
	echo "Open GPIO!"
	echo 1 > /sys/class/gpio/gpio$PIN1/value
}

function close()
{
	echo "Close GPIO!"
	echo 0 > /sys/class/gpio/gpio$PIN1/value
}

echo "Now initializing GPIO=$PIN1..."
sudo chmod 777 /sys/class/gpio/unexport
echo $PIN1 > /sys/class/gpio/unexport
sudo chmod 777 /sys/class/gpio/export
echo $PIN1 > /sys/class/gpio/export
if [ "$?" == "0" ]; then
	echo "Succeeded!"
	sudo chmod 777 /sys/class/gpio/gpio$PIN1/direction
	echo "out" > /sys/class/gpio/gpio$PIN1/direction
	sudo chmod 777 /sys/class/gpio/gpio$PIN1/value
	if [ "$1" == "1" ]; then
		open
	else
		close
	fi
else
	echo "init error!"
fi
