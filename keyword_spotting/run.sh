#!/bin/bash
#matlab -nojvm -nosplash 
file=test.wav
for i in $(seq 1 10) 
do
echo $i
arecord -q -d 1 -c 1 -f S16_LE -r8000 wav/$file
echo "test $(pwd)/wav/$file" > wav/test.scp
compute-mfcc-feats --sample-frequency=8000 scp:wav/test.scp ark,t:feature/test.ark 2>/dev/null
#play $file

# template matching
cd dynamic_time_warping_v2.1;word=$(./dtw_classify ../feature/test.ark | tail -1);cd ..


word=$(echo $word | cut -d_ -f1)
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
