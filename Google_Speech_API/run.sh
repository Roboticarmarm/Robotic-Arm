#!/bin/bash

for i in {1..100}
do
arecord -q -d 1 -c 1 -f S16_LE -r8000 test${i}.wav
./asr.sh ${i} &
done
