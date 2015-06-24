#!/bin/bash
#Serial control for ttyUSB=ttyACM0
 
echo "Now initializing Serial port for ttyACM0..."
chmod 777 /dev/ttyACM0
if [ "$?" == "0" ]; then
	echo "Succeeded!"
	case $1 in
	"-hold9")
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold8")
		sudo echo "70,80,80,80" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold7")
		sudo echo "60,70,70,70" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold6")
		sudo echo " 50,60,60,60" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold5") 
		sudo echo "50,50,50,50" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold4")
		sudo echo "40,40,40,40" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold3")
		sudo echo "30,30,30,30" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold2")
		sudo echo "20,20,20,20" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-hold1")
		sudo echo "10,10,10,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-init")
		sudo echo "80,70,99,90" >> /dev/ttyACM0
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