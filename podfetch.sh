#!/bin/bash

sleep 1

if [ ! $# -eq 3 ]; then
	echo "Use: $0 <CHANNELS-FILE> <OUTPUT-DIR> <MAX-DOWNLOADS-PER-CHANNEL>"
	sleep 2
	exit 1
fi

if [ ! -d "$2" ]; then
	mkdir "$2"
fi
cd "$2"

while read line
do
	url=`echo $line | cut -d "|" -f1`
	name=`echo $line | cut -d "|" -f2`
	flags=`echo $line | cut -d "|" -f3`
	domain=`echo $url | cut -d "/" -f3`

	if [ "$flags" = "" ]; then
		if [ "$domain" = "www.youtube.com" ]; then
			yt-dlp $url -f bestaudio -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" -o "$name - %(title)s.%(ext)s"
		elif [ "$domain" = "www.rumble.com" ]; then
			yt-dlp $url -f mp4-360p-1 -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" -o "$name - %(title)s.%(ext)s"
		else
			yt-dlp $url -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" -o "$name - %(title)s.%(ext)s"
		fi
	elif [ "$flags" = "r" ]; then
		if [ "$domain" = "www.youtube.com" ]; then
			yt-dlp $url -f bestaudio -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" --playlist-reverse -o "$name - %(title)s.%(ext)s"
		elif [ "$domain" = "www.rumble.com" ]; then
			yt-dlp $url -f mp4-360p-0 -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" --playlist-reverse -o "$name - %(title)s.%(ext)s"
		else
			yt-dlp $url -x --audio-format mp3 --max-downloads $3 --match-filter "duration>600" --playlist-reverse -o "$name - %(title)s.%(ext)s"
		fi
	else
		echo "Wrong flags for '${name}'"
	fi
done < "$1"
printf '\a';

sleep 2
