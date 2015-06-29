#!/bin/bash
#matlab -nojvm -nosplash 
file=test.wav
for i in $(seq 1 3) 
do
arecord -q -d 1 -c 1 -f S16_LE -r8000 $file
#play $file

# template matching
cd dynamic_time_warping_v2.1;matlab -nojvm -nosplash -r "dtw_classify('../$file');quit;";cd ..
done
rm $file
