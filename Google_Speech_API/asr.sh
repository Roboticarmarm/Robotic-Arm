
sox test$1.wav message$1.flac rate 8k
curl -s -X POST \
--data-binary @message$1.flac --user-agent 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko)  Chrome/16.0.912.77 Safari/535.7' \
--header 'Content-Type: audio/x-flac; rate=8000;' \
'https://www.google.com/speech-api/v2/recognize?output=json&client=chromium&lang=zh-TW&maxresults=10&key=AIzaSyCGJLLtZ-8j-vQ4pUKP_JopBQBLOqtSfSo&pfilter=2' | cut -d ':' -f 4 > text
rm message$1.flac

echo test$1.wav
cat text
#cat text | grep 1 >/dev/null && ./go_left.sh
#cat text | grep 2 >/dev/null && ./go_left.sh
cat text | grep jump >/dev/null && ./blank.sh
