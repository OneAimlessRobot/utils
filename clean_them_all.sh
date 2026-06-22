#!/bin/bash



ogg_extension=".ogg"
song_directory=""
song_subdirectory="./dirty_songs/Trackmania_songs/Race/"
destination_dir="./clean_songs/Trackmania_songs/Race/"
expression_to_search="*"
song_basenames=()
num_of_songs=0

for filename in $(ls ${song_directory}${song_subdirectory}*${expression_to_search}*${ogg_extension})
do
	echo "${destination_dir}$(basename $filename $mp3_extension)${ogg_extension}"
	song_basenames[$num_of_songs]=$(basename $filename);
	let num_of_songs=num_of_songs+1;
	echo $num_of_songs;
	echo $filename;

done

for ((i=0;i<num_of_songs;i++));
do
	echo ${song_basenames[i]};

done

for ((i=0;i<num_of_songs;i++));
do
	ffmpeg -i "${song_subdirectory}${song_basenames[i]}" -map 0:a:0 -c:a libvorbis -q:a 4 "${destination_dir}${song_basenames[i]}"&
done
wait

echo "Done compiling all the songs!";

