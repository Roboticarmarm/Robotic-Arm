#!/bin/bash
list=word_list.txt
rep=$1

if [ ! -d "wav" ]; then mkdir wav;fi
if [ ! -d "feature" ]; then mkdir feature;fi

# record
for word in $(cat $list)
do
	for i in $(seq 1 $rep)
	do
		file=$word'_'$i
		echo $file
		arecord -q -d 1 -c 1 -f S16_LE -r8000 wav/$file.wav
		cd iif;matlab -nojvm -nosplash -r "genIIF('../wav/$file.wav',1,'../feature/$file.csv');quit;" > tmp;cd ..
	done
done

# play
for word in $(cat $list)
do
	for i in $(seq 1 $rep)
	do
		file=$word'_'$i
		play wav/$file.wav
	done
done

