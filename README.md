# podfetch
This is a bash script that automatically downloads podcasts from a list of YouTube channels/playlists.

## Use
Create a text file with a channel/playlist name for each line as follows:
```URL|PODCAST_NAME|```

Optionally, you can start in reverse order (oldest first):
```URL|PODCAST_NAME|r```

Then you can finally run:
```
./podfetch.sh <CHANNELS-FILE> <OUTPUT-DIR> <MAX-DOWNLOADS-PER-CHANNEL>
```

This will create `.mp3` files in the `OUTPUT-DIR` with the format `PODCAST_NAME - TITLE`.

## Dependencies
`yt-dlp`

## Supported platforms
The script currently supports YouTube, Rumble and Odysee.
