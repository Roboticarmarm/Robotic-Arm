xdotool search "Default" windowactivate
xdotool search "NS" windowactivate
for i in {1..10}
do
	xdotool key --clearmodifiers space
done
