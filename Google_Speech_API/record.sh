for i in {1..10}
do
	arecord -d 1 -c 1 -f S16_LE -r8000 test${i}.wav
done
