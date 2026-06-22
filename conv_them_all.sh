#!/bin/bash



ogg_extension=".ogg"
mp3_extension=".mp3"
song_directory=""
song_subdirectory="./unconverted_songs/"
destination_dir="./OGGs/"
expression_to_search="*"
song_basenames=()
num_of_songs=0

for filename in $(ls ${song_directory}${song_subdirectory}*${expression_to_search}*${mp3_extension})
do
	echo "${destination_dir}$(basename $filename $mp3_extension)${ogg_extension}"
	if [ -f ${destination_dir}$(basename $filename $mp3_extension)$ogg_extension ];
	then
    		echo "File ${destination_dir}${filename} already_converted! Not adding!!"
	elif [ -f $filename ];
	then
		song_basenames[$num_of_songs]=$(basename $filename);
		let num_of_songs=num_of_songs+1;
		echo $num_of_songs;
		echo $filename;
	fi
done

for ((i=0;i<num_of_songs;i++));
do
	echo ${song_basenames[i]};

done



for ((i=0;i<num_of_songs;i++));
do
	ffmpeg -i "${song_subdirectory}${song_basenames[i]}" -c:a libvorbis -q:a 4 "${destination_dir}${song_basenames[i]/%mp3/ogg}"
done

echo "Done compiling all the songs!";

