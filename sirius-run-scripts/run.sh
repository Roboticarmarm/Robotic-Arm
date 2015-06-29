#!/bin/bash
#./start-asr-server.sh kaldi 140.112.21.19 8081
#  arecord -q -c 1 -f S16_LE -r8000 test.wav
#  ./sirius-asr-test.sh ./test.wav
export pin=192

sudo chmod 777 /sys/class/gpio/unexport
echo $pin > /sys/class/gpio/unexport
sudo chmod 777 /sys/class/gpio/export
echo $pin > /sys/class/gpio/export
sudo chmod 777 /sys/class/gpio/gpio$pin/direction
echo "out" > /sys/class/gpio/gpio$pin/direction
sudo  chmod 777 /sys/class/gpio/gpio$pin/value
if [ "$?" == "0" ] ; then
  for ((;;))
  do
    echo 1 > /sys/class/gpio/gpio$pin/value
    arecord -q -d 5 -c 1 -f S16_LE -r8000 test.wav
    echo 0 > /sys/class/gpio/gpio$pin/value
    /home/rock/Robotic-Arm/sirius-run-scripts/sirius-asr-test.sh ./test.wav > histry
    cat histry
    if !(grep -q noise histry); then
      if (grep -q yeah histry) || (grep -q yes histry);then
        echo "YES!!!"
         /home/rock/Robotic-Arm/mainarm.sh -hold9
      elif (grep  -q no histry);then
        echo "NO!!!"   
        /home/rock/Robotic-Arm/mainarm.sh -init
      elif (grep  -q no histry);then
        echo "go back"   
        /home/rock/Robotic-Arm/mainarm.sh -clap
     fi
   fi
  done
else
  echo "init error!!"  
fi
