#Serial control for ttyUSB=ttyACM0

echo "Now initializing Serial port for ttyACM0..."
sudo chmod 777 /dev/ttyACM0
if [ "$?" == "0" ]; then
	echo "Succeeded!"
	case $1 in
	"-hold -9")
		sudo echo "90,90,90,90,90,90,90,90,90,90,90,90,90,90,90" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -8")
		sudo echo "80,80,80,80,80,80,80,80,80,80,80,80,80,80,80" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -7")
		sudo echo "70,70,70,70,70,70,70,70,70,70,70,70,70,70,70" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -6")
		sudo echo "60,60,60,60,60,60,60,60,60,60,60,60,60,60,60" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -5")
		sudo echo "50,50,50,50,50,50,50,50,50,50,50,50,50,50,50" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -4")
		sudo echo "40,40,40,40,40,40,40,40,40,40,40,40,40,40,40" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -3")
		sudo echo "30,30,30,30,30,30,30,30,30,30,30,30,30,30,30" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -2")
		sudo echo "20,20,20,20,20,20,20,20,20,20,20,20,20,20,20" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold -1")
		sudo echo "10,10,10,10,10,10,10,10,10,10,10,10,10,10,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-init")
		sudo echo "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"")
		echo "Usage: mainarm.sh [operation] [level]";
		echo "Support operations:";
		echo "-hold [-1]-[-9]";
		echo "-init";
		;;
	*)
		echo "You must specify a functional operation!";
		;;
        esac
else
	echo "Init error!"
fi