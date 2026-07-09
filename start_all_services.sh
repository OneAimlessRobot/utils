#!/bin/bash

sleep_time=0.5

directory=$(pwd)

tmp_pid_file=".tmp_pids"

term_exec_string=""

term_exec_string_case_wayland="wayst -e bash -c"

term_exec_string_case_X11="xterm -e"



if [ -z "${DISPLAY}"  ];
then
	term_exec_string="${term_exec_string_case_wayland}"
else
	term_exec_string="${term_exec_string_case_X11}"
fi

start_another_proc_func_inner(){


	echo "$BASHPID" >> "${tmp_pid_file}"
	${term_exec_string} "$1"

}

start_another_proc_func(){

	sleep "${sleep_time}"

	start_another_proc_func_inner "$1"&

}
if [ -f "${termux_tmp_pid_file}"  ]
then
	chmod a+rwx "${tmp_pid_file}"
fi


pushd "${directory}"



start_another_proc_func "pushd /mnt/SUPER_CAVALEIRO/progsBackup/http_server_final/server && ./server.exe && exec bash"

start_another_proc_func "pushd /mnt/SUPER_CAVALEIRO/progsBackup/emotionstreamer/code && bash kill*s.sh && bash startup.sh && exec bash"

start_another_proc_func "pushd /mnt/REBORN/half_life_stuff/Half-Life && bash launch*game*sh && exec bash"

start_another_proc_func "pushd /mnt/REBORN/half_life_stuff/Half-Life && bash launch*disp*sh && exec bash"

start_another_proc_func "pushd /mnt/REBORN/half_life_stuff/Half-Life && bash launch*prox*sh && exec bash"

start_another_proc_func "pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/TmUnitedForeverServer && bash Run*sh && exec bash"

start_another_proc_func "pushd /mnt/REBORN/TMF_SERVER_TMP/TMF/xaseco && bash ./AsecoF.sh && exec bash"


cat "${tmp_pid_file}"
