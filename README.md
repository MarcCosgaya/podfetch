# podfetch
This is a bash script that automatically downloads podcasts from a list of YouTube channels/playlists.

## Use
Create a text file with a channel/playlist name in each line as follows:
```URL|NAME|```

Optionally, you can start in reverse order:
```URL|NAME|r```

Then you can finally run:
```
./podfetch.sh <CHANNELS-FILE> <OUTPUT-DIR> <MAX-DOWNLOADS-PER-CHANNEL>
```

This will create audio files in `OUTPUT-DIR` with the format `NAME - TITLE.mp3`.

## Dependencies
`yt-dlp`
