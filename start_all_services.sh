#!/bin/bash



sleep_time=0.5

sleep_time_mult_attach_cmd_proc=0.5

directory=$(pwd)

tmp_session_names_file=".tmp_session_names_file"

term_exec_string=""

term_exec_string_case_wayland="wayst -e bash -c"

term_exec_string_case_X11="xterm -e bash -c"



if [ -z "${DISPLAY}"  ];
then
	term_exec_string="${term_exec_string_case_wayland}"
else
	term_exec_string="${term_exec_string_case_X11}"
fi

rm "${tmp_session_names_file}"

if [ -f "${tmp_session_names_file}"  ]
then
	chmod a+rwx "${tmp_session_names_file}"
fi


session_name_half_life_array=("half_life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*game*sh"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*disp*sh"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*prox*sh")

								
session_name_agario_array=("agario"
			"pushd /mnt/FASTstorage/Agariobackup/MultiOgarII/src ; node ./index.js"
			"pushd /mnt/FASTstorage/Agariobackup/MultiOgarII/src")
			
session_name_lutris_array=("lutris"
							"lutris -d")
							
session_name_emotionstreamer_array=("emotionstreamer_stuff"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/emotionstreamer/code; ${term_exec_string} ./startup.sh"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/emotionstreamer/code")

session_name_trackmania_array=("trackmania"
			"pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/TmUnitedForeverServer ; bash Run*sh"
			"pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/xaseco ; bash ./AsecoF.sh")


session_name_http_server_array=("http_server"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/http_server_final/server ; bash server_start.sh")

session_name_mysql_array=("mysql"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/mysqlstuffpriv/amxmodxserver_mgmt/scripts ; bash start*daemon*sh")


array_of_all_tmux_sessions=(session_name_half_life_array
					session_name_agario_array
					session_name_lutris_array
					session_name_trackmania_array
					session_name_http_server_array
					session_name_mysql_array
					session_name_emotionstreamer_array)


print_cmd_arr(){
	local arr=("$@")
	for((i=0; i<${#arr[@]}; i++));
	do
		echo "Cmd numero $i = ${arr[$i]}"
	done
}

start_another_session_func_inner(){
	
	local arr=("$@")
	print_cmd_arr "${arr[@]}"
	echo "session ${arr[0]} starting!"
	tmux new-session -d -s "${arr[0]}"
	start_session_tabs_func "${arr[@]}"
	tmux attach -t "${arr[0]}"

}
start_session_tabs_func(){
	local arr=("$@")
	echo "here: |${#arr[@]}|"
	echo ${arr[@]}
	for((i=1; i<${#arr[@]}; i++));
	do
		echo "tmux new-window -t \"${arr[0]}\":\"$i\" \"bash -lc '${arr[$i]}; exec bash'\""
		tmux new-window -t "${arr[0]}":"$i" "bash -lc '${arr[$i]}; exec bash'"
		sleep $(echo "${sleep_time}*${sleep_time_mult_attach_cmd_proc}" | bc)
	done


}
export sleep_time
export sleep_time_mult_attach_cmd_proc
export -f start_session_tabs_func
export -f print_cmd_arr
export -f start_another_session_func_inner



start_all(){
	pushd "${directory}"
	echo "${#array_of_all_tmux_sessions[@]}"

	for group in "${array_of_all_tmux_sessions[@]}"; do
		declare -n lst=$group
		echo "Sessao de nome $group tem ${#lst[@]} elementos"
		echo "${lst[0]}" >> "${tmp_session_names_file}"
		${term_exec_string}  'start_another_session_func_inner "$@"' "placeholder" "${lst[@]}"&
		sleep $(echo "${sleep_time}*${sleep_time_mult_attach_cmd_proc}" | bc)
	done
}

start_all

