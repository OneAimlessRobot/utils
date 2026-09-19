#!/bin/bash



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

#first arg is session name
#second member is sleep time before next session
#third member is sleep time before next window cmd in session


							
session_name_http_server_array=("http_server"
						"0.5"
						"0.5"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/http_server_final/server ; bash server_start.sh")

#give it time to start
session_name_mysql_array=("mysql"
						"20.5"
						"0.5"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/mysqlstuffpriv/amxmodxserver_mgmt/scripts ; bash start*daemon*sh")
			
session_name_lutris_array=("lutris"
						"0.5"
						"0.5"
						"lutris -d")
									
session_name_agario_array=("agario"
							"0.5"
							"0.5"
			"pushd /mnt/FASTstorage/Agariobackup/MultiOgarII/src ; node ./index.js"
			"pushd /mnt/FASTstorage/Agariobackup/MultiOgarII/src")
			
session_name_trackmania_array=("trackmania"
						"0.5"
						"0.5"
			"pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/TmUnitedForeverServer ; bash Run*sh"
			"pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/xaseco ; bash ./AsecoF.sh")
			
			
session_name_emotionstreamer_array=("emotionstreamer_stuff"
						"0.5"
						"0.5"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/emotionstreamer/code; ${term_exec_string} ./startup.sh"
			"pushd /mnt/SUPER_CAVALEIRO/progsBackup/emotionstreamer/code")
			
session_name_half_life_array=("half_life"
								"0.5"
								"3.5"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*game*sh"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*disp*sh"
								"pushd /mnt/REBORN/half_life_stuff/Half-Life ; bash launch*prox*sh")


session_name_minecraft_server=("minecraft_server"
						"0.5"
						"0.5"
			"pushd $HOME/minecraft_servers_fast_storage/forge_1-12-2; bash server_launcher.sh")

array_of_all_tmux_sessions=(
					session_name_http_server_array
					session_name_mysql_array
					session_name_lutris_array
					session_name_agario_array
					session_name_trackmania_array
					session_name_emotionstreamer_array
					session_name_half_life_array
					session_name_minecraft_server)


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
	local slot_where_windows_start=3
	echo "here: |${#arr[@]}|"
	echo ${arr[@]}
	echo $slot_where_windows_start
	for((i=$slot_where_windows_start; i<${#arr[@]}; i++));
	do
		j=$(($i - $slot_where_windows_start + 1))
		echo "tmux new-window -t \"${arr[0]}\":\"$j\" \"bash -lc '${arr[$i]}; exec bash'\""
		tmux new-window -t "${arr[0]}":"$j" "bash -lc '${arr[$i]}; exec bash'"
		sleep $(echo "${arr[2]}" | bc)
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
		sleep $(echo "${lst[1]}" | bc)
	done
}

start_all

