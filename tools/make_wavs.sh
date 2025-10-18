#!/bin/bash
if [ $# -ne 2 ]; then
	echo "First argument: the target mp3 file without extension"

	echo "second argument: the output wav filepat with no extension"
	exit -1
fi
ffmpeg -threads 4 -i $1.mp3 -acodec pcm_s16le -ar 44100 -ac 2 $2.wav
