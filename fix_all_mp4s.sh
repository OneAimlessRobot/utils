#!/bin/bash



active_folder="$(pwd)"

expression_to_search="*"
file_ext="mp4"
video_basenames=()
num_of_videos=0

fill_up_array(){
	for filename in $(ls ${active_folder}/*${expression_to_search}*.${file_ext})
	do
		video_basenames[$num_of_videos]=$(basename $filename ".${file_ext}");
		let num_of_videos=num_of_videos+1;
		echo $num_of_videos;
		echo $filename;
	done
}

echo_all_videos(){
	for ((i=0;i<num_of_videos;i++));
	do
		echo ${video_basenames[i]};

	done
}


do_all_videos(){
	for ((i=0;i<num_of_videos;i++));
	do
		fix_function "${video_basenames[i]}"&
	done
	wait
}

fix_function(){
	
	filename_to_do=$1
	echo "${active_folder}/${filename_to_do}.${file_ext}"
	ffmpeg -i "${active_folder}/${filename_to_do}.${file_ext}" -c copy -movflags +faststart "${active_folder}/${filename_to_do}2.${file_ext}"
	&&
	mv "${active_folder}/${filename_to_do}2.${file_ext}" "${active_folder}/${filename_to_do}.${file_ext}"

}

fill_up_array
echo_all_videos
do_all_videos
