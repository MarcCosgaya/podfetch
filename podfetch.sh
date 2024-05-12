#!/bin/bash

if [ ! $# -eq 3 ]; then
	echo "Use: $0 <CHANNELS-FILE> <OUTPUT-DIR> <MAX-DOWNLOADS-PER-CHANNEL>"
	sleep 2
	exit 1
fi

if [ ! -d "$2" ]; then
	mkdir "$2"
fi
file=`pwd`/$1
cd "$2"

while read line
do
	url=`echo $line | cut -d "|" -f1`
	name=`echo $line | cut -d "|" -f2`
	flags=`echo $line | cut -d "|" -f3`
	domain=`echo $url | cut -d "/" -f3`

	commandString='yt-dlp $url -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" -o "$name - %(title)s.%(ext)s"'
	if [[ "$domain" == *"youtube"* ]]; then
		append='-f bestaudio'
		commandString="$commandString $append"
	elif [[ "$domain" == *"rumble"* ]]; then
		append='-f mp4-360p-1'
		commandString="$commandString $append"
	elif [[ "$domain" == *"odysee"* ]]; then
		append='-f original'
		commandString="$commandString $append"
	fi

	if [[ "$flags" == *"r"* ]]; then
		append='--playlist-reverse'
		commandString="$commandString $append"
	fi

	eval $commandString
done < "$file"
printf '\a';

sleep 2
