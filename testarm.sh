#!/bin/bash
#Serial control for ttyUSB=ttyACM0
case $1 in
"-left1")               
     for i in  {99..10..-1}
        do
        sudo echo "$i,81,01,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-right1")               
     for i in  {10..99..1}
        do
        sudo echo "$i,81,01,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-left2")               
     for i in  {99..10..-1}
        do
        sudo echo "01,$i,01,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-right2")               
     for i in  {10..99..1}
        do
        sudo echo "01,$i,01,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-left3")               
     for i in  {99..10..-1}
        do
        sudo echo "01,81,$i,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-right3")               
     for i in  {10..99..1}
        do
        sudo echo "01,81,$i,81" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-left4")               
     for i in  {99..10..-1}
        do
        sudo echo "01,81,01,$i" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"-right4")               
     for i in  {10..99..1}
        do
        sudo echo "01,81,01,$i" >> /dev/ttyACM0
        if [ "$?" == "0" ]; then
	     echo "...done...$i"
	else
	     echo "Write error!"
        fi
             sleep 0.1
        done              
        ;; 
"")
	echo "Usage: testarm.sh [right/left+1/2/3/4]";
	echo "Support operations:";
	echo "-right/left+1/2/3/4";
	echo "|1|";
	echo "|2|";
	echo "|3|";
	echo "|4|";
	;;
*)
	echo "You must specify a functional operation!";
	;;
esac
