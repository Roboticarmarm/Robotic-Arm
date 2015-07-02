#!/bin/bash
file=test.wav
arecord -q -d 1 -c 1 -f S16_LE -r8000 ./wav/$file																	# WAV
echo "test $(pwd)/wav/$file" > ./wav/test.scp																		# SCP
compute-mfcc-feats --sample-frequency=8000 scp:$(pwd)/wav/test.scp ark,t:$(pwd)/feature/test.ark 2>/dev/null		# MFCC
word=$(./dynamic_time_warping_v2.1/dtw_classify ./feature/ test.ark ./wav/4Rotate.scp | tail -1 | cut -d_ -f1 )		# DTW
echo $word
