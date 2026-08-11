#!/bin/bash

python_folder_bin="/mnt/FASTstorage/FASTprogs/python_macros/venv_for_experiments/bin/"
python_executable="python3"
dlp_executable_script="yt-dlp"

active_folder="/mnt/FASTstorage/FASTprogs/webcrookedstuff/videos"
recover_folder="/mnt/REBORN/NEW_VIDEOS"

mkdir -p "$recover_folder"

pushd "$active_folder"
max_jobs=4

for file in ./*.mp4; do
    
    basename="${file#./}"
    basename="${basename%.mp4}"

    title="${basename//_/ }"

    echo "Searching: $title"

    (
        "${python_folder_bin}${dlp_executable_script}" \
            --no-playlist \
            "ytsearch1:$title" \
            -f 'bv*[vcodec^=avc1][ext=mp4]+ba[acodec^=mp4a]/b[ext=mp4]' \
            --merge-output-format mp4 \
            --postprocessor-args 'ffmpeg:-movflags +faststart' \
            --write-info-json \
            -o "$recover_folder/$basename [%(id)s].%(ext)s"
    ) &

    while [ "$(jobs -rp | wc -l)" -ge "$max_jobs" ]; do
        wait -n
    done
done