#!/bin/bash
list=word_list.txt
rep=$1

if [ ! -d "wav" ]; then mkdir wav;fi
if [ ! -d "feature" ]; then mkdir feature;fi
rm -f wav/wav.scp;
rm -f feature/*

# record
for word in $(cat $list)
do
	for i in $(seq 1 $rep)
	do
		file=$word'_'$i
		echo $file
		arecord -q -d 1 -c 1 -f S16_LE -r8000 wav/$file.wav
		#cd iif;matlab -nojvm -nosplash -r "genIIF('../wav/$file.wav',1,'../feature/$file.csv');quit;" 2>dev/null;cd ..	
		echo "$file $(pwd)/wav/$file.wav" >> wav/wav.scp
	done
done
compute-mfcc-feats --sample-frequency=8000 scp:wav/wav.scp ark,t:feature/mfcc.ark
# split ark
cd feature;cat mfcc.ark | split -l 99
for file in x*
do
	name=$(head -1 $file | sed -e 's/  \[/.ark/g')
	mv $file $name
done;cd ..

# play
for word in $(cat $list)
do
	for i in $(seq 1 $rep)
	do
		file=$word'_'$i
		play wav/$file.wav
	done
done

#cd wav;ls -l *wav | cut -d ' ' -f3,10 | sed "s@wyc @$(pwd)/@g" > file
#ls -l *wav | cut -d ' ' -f10 | cut -d. -f1 | paste - file > wav.scp;rm file;cd ..
