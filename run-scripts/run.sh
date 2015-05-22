arecord -q -c 1 -f S16_LE -r8000 test.wav
./sirius-asr-test.sh ./test.wav

