#!/bin/bash
if [ $# -ne 2 ]; then
	echo "First argument: the target mp3 file without extension"

	echo "second argument: the output wav filepat with no extension"
	exit -1
fi
bash make_wavs.sh ../../media-server/webcrookedstuff/audios/Music/$1 ../raw_songs/$2
