#!/bin/bash

subtracted=2

matching_proc_string="ssh-agent"

search_cmd="ps aux"

filter_cmd="grep \"${matching_proc_string}\""

filtered_search_cmd="$search_cmd | $filter_cmd"

count_cmd="wc -l"

counted_filtered_search_cmd="$filtered_search_cmd | $count_cmd"

signal_desc_string="KILL"

kill_all_matching_procs_for_string="killall -$signal_desc_string $matching_proc_string"

exec_cmd_func(){

	bash -c "$1"


}


num_procs=$(($(exec_cmd_func "$counted_filtered_search_cmd")-subtracted))


echo $num_procs


if [ $num_procs -gt 0 ];
then
	exec_cmd_func "$kill_all_matching_procs_for_string"
fi

eval $(ssh-agent -s)
ssh-add ~/sshkeys_4_meh/tha_linuz_keyh
ssh -T git@github.com
ssh -T git@codeberg.org



