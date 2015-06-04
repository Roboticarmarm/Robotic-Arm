#Serial control for ttyUSB=ttyACM0

echo "Now initializing Serial port for ttyACM0..."
sudo chmod 777 /dev/ttyACM0
if [ "$?" == "0" ]; then
	echo "Succeeded!"
	case $1 in
	"-hold")
		sudo echo "90,90,90,90,90,90,90,90,90,90,90,90,90,90,90" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"")
		echo "Usage: mainarm.sh [operation]";
		echo "Support operations:";
		echo "-hold";
		;;
	*)
		echo "You must specify a functional operation!";
		;;
        esac
else
	echo "Init error!"
fi