#!/bin/bash

if [ ! $# -eq 3 ]; then
	echo "Use: $0 <CHANNELS-FILE> <OUTPUT-DIR> <MAX-DOWNLOADS-PER-CHANNEL>"
	sleep 2
	exit 1
fi

if [ ! -d "$2" ]; then
	mkdir "$2"
fi

if [[ "$1" == /* ]]; then
	file=$1
else
	file=`pwd`/$1
fi
echo $file
cd "$2"

while read line
do
	url=`echo $line | cut -d "|" -f1`
	name=`echo $line | cut -d "|" -f2`
	flags=`echo $line | cut -d "|" -f3`

	commandStr="yt-dlp $url -x --audio-format mp3 --max-downloads $3 --match-filter 'duration>600' -o '$name - %(title)s.%(ext)s' -S +size,+br -f ba/ba*"

	if [[ "$flags" == *"r"* ]]; then
		append='--playlist-reverse'
		commandStr="$commandStr $append"
	fi

	eval $commandStr
done < "$file"
printf '\a';

sleep 2
