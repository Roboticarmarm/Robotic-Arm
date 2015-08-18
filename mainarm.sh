#!/bin/bash
#Serial control for ttyUSB=ttyACM0
export i=0
export j=0
echo "Now initializing Serial port for ttyACM0..."
sudo chmod 777 /dev/ttyACM0
if [ "$?" == "0" ]; then
	echo "Succeeded!"
	case $1 in
	"-hold9")
		sudo echo "00,80,00,80" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-slowhold")               
               for i in  {99..45..-1}
                   do
		   sudo echo "$i,99,50,10" >> /dev/ttyACM0
		   if [ "$?" == "0" ]; then
			echo "...done...$i"
		   else
			echo "Write error!"
		    fi
         	   sleep 0.1
               done              
         	;; 

	"-clap")
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-rotate")
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,20,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,20,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "50,99,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
                sleep 0.5
		sudo echo "80,20,50,10" >> /dev/ttyACM0
		if [ "$?" == "0" ]; then
			echo "...done."
		else
			echo "Write error!"
		fi
         	;;
	"-init")
		sudo echo "70,80,90,80" >> /dev/ttyACM0
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