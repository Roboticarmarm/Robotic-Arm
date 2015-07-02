#!/bin/bash 
#wSet=wav/wav.scp
wSet=wav/$1.scp
file=test.wav

for i in $(seq 1 3) 
do
	echo $i
	arecord -q -d 1 -c 1 -f S16_LE -r8000 ./wav/$file																	# WAV
	echo "test $(pwd)/wav/$file" > ./wav/test.scp																		# SCP
	compute-mfcc-feats --sample-frequency=8000 scp:$(pwd)/wav/test.scp ark,t:$(pwd)/feature/test.ark 2>/dev/null		# MFCC
	word=$(./dynamic_time_warping_v2.1/dtw_classify ./feature/ test.ark $wSet | tail -1 | cut -d_ -f1 )					# DTW

echo $word
  if [ $word = "yes" ];then
    echo "YES!!!"
    #../mainarm.sh -hold9
  elif [ $word = "no" ];then
    echo "NO!!!"   
    #../mainarm.sh -init
  elif [ $word = "move" ];then
    echo "MOVE!!!"   
    #../mainarm.sh -clap
  elif [ $word = "stop" ];then
    echo "STOP!!!"   
    #../mainarm.sh -clap
  fi

#cd dynamic_time_warping_v2.1;matlab -nojvm -nosplash -r "dtw_classify('../$file');quit;";cd ..
done
