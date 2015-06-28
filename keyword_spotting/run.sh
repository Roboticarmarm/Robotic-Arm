#!/bin/bash
name=test
file=$name.wav
arecord -q -d 1 -c 1 -f S16_LE -r8000 $file
play $file
echo 'done'
# iif feature
cd iif;matlab -nojvm -nosplash -r "genIIF('../$file',1,'$name.csv');quit;";cd ..

cat iif/iif.csv | wc
awk '{FS=","} { print NF }' iif/iif.csv | sort -u
# template matching
#for and best
cd dynamic_time_warping_v2.1;matlab -nojvm -nosplash -r "run_dtw('../iif/$name.csv','../iif/$name.csv',50);quit;";cd ..

# output
