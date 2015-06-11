#arecord -q -c 1 -f S16_LE -r8000 test.wav
#./sirius-asr-test.sh ./test.wav

for i in {1..10}
do
  echo $i
  arecord -q -d 3 -c 1 -f S16_LE -r8000 test.wav
  ./sirius-asr-test.sh ./test.wav > histry
  tail -n 2 histry

  if grep -q yes histry;then
    echo "YES!!!"
  elif grep -q no histry;then
    echo "NO!!!"
  elif grep -q move histry;then
    echo "MOVE!!!"
  elif grep -q back histry;then
    echo "back!!!"
  fi



done


