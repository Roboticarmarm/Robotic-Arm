#arecord -q -c 1 -f S16_LE -r8000 test.wav
#./sirius-asr-test.sh ./test.wav

for i in {1..1}
do
  echo $i
  arecord -q -d 5 -c 1 -f S16_LE -r8000 test.wav
  ./sirius-asr-test.sh ./test.wav > histry
  cat histry
  if grep -q yes histry
  then
    echo "YES!!!"
  fi
done


