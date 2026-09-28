#!/bin/bash

#all non-derived constants


#should we just log off or fully power off?
#(We call the former testing mode and the latter non-testing mode)

kill_script_location="/mnt/FASTstorage/FASTprogs/utils/"


#the battery to check
the_battery_to_check="BAT0"


#extract info from these files and act accordingly
battery_capacity_file="capacity"
battery_status_file="status"
battery_voltage_now_file="voltage_now"


window_manager_name="dwm"

kill_script_file_name="kill_started_procs.sh"

percentage_of_time_left_for_warning_to_trigger=0.25

tick_length=1.0

testing_mode=0

secs_in_one_min=60.0

total_minutes_to_wait=3.0


#kill_script_location

kill_script_full_file_path="${kill_script_location}${kill_script_file_name}"

#window_manager_name

kill_session_command="killall ${window_manager_name}"

#helper_funcs

clear_screen(){
	
	local is_it_fully=${1}
	
	if [ $is_it_fully -gt 0 ]
	then
		printf "\033[2J"
	fi
	
	printf "\033[H"
	
}

produce_float_from_arg(){
	
	local the_arg="${1}"
	
	echo "${the_arg}" | bc
	
}

#its in seconds

time_to_dec_for_discharging_tick=$(produce_float_from_arg "${tick_length}")
time_to_inc_for_non_discharging_tick=$(produce_float_from_arg "$time_to_dec_for_discharging_tick * 2.0" )



compute_seconds_to_wait(){
	
	echo $(produce_float_from_arg "$tick_length")
	
}

minutes_to_seconds(){
	
	local mins_to_convert=${1}
	
	echo $(produce_float_from_arg "$mins_to_convert * $secs_in_one_min")
	
}


percentage_of_time_left_for_warning_to_trigger_graphical_val=$(produce_float_from_arg "$percentage_of_time_left_for_warning_to_trigger * 100.0" ) 


the_max_time=$(minutes_to_seconds $total_minutes_to_wait)

curr_time=$the_max_time

the_time_for_warning=$(produce_float_from_arg "$percentage_of_time_left_for_warning_to_trigger * $the_max_time")


dec_time(){
	
	curr_time=$(produce_float_from_arg "$curr_time - $time_to_dec_for_discharging_tick")
	
}
inc_time(){
	
	curr_time=$(produce_float_from_arg "$curr_time + $time_to_inc_for_non_discharging_tick")
		
}




the_total_seconds_to_wait=$(minutes_to_seconds 5)

battery_files_directory="/sys/class/power_supply/${the_battery_to_check}/"

echo_contextualized_contents_of_file(){
	
	local file_path=${1};
	
	echo "currently reading from file with full_path: ${file_path}"
	echo ""
	local current_count=0
	while IFS= read -r line_from_file
	do
		current_count=$(($current_count + 1 ))
		echo "Line number ${current_count}: ${line_from_file}"
	
	done < <(cat $file_path)
	
	echo ""
	echo "We read: ${current_count} lines!"
	echo ""
	
	
}

echo_current_contextualized_battery_status(){
	
	echo_contextualized_contents_of_file "${battery_files_directory}${battery_capacity_file}"
	echo_contextualized_contents_of_file "${battery_files_directory}${battery_status_file}"
	echo_contextualized_contents_of_file "${battery_files_directory}${battery_voltage_now_file}"
	
	
}

echo_contents_of_file(){
	
	local file_path=${1};
	
	while IFS= read -r line_from_file
	do
		echo "${line_from_file}"
	
	done < <(cat $file_path)
}

get_percentage(){
	
	echo_contents_of_file "${battery_files_directory}${battery_capacity_file}"
	
}

get_status(){
	
	echo_contents_of_file "${battery_files_directory}${battery_status_file}"
	
}

get_voltage(){
	
	echo_contents_of_file "${battery_files_directory}${battery_voltage_now_file}"
	
}

echo_current_battery_status(){
	
	get_percentage
	get_status
	get_voltage
}

echo_current_contextualized_battery_status


check_the_time(){
	
	echo $(produce_float_from_arg "$curr_time < 0.0")	
}
we_have_too_much_time(){
	
	echo $(produce_float_from_arg "$curr_time >= $the_max_time")
}
we_have_close_to_no_time(){
	
	echo $(produce_float_from_arg "$curr_time <= $the_time_for_warning")
}

compute_curr_time(){

	local the_status=$(get_status)
	if [ "$the_status" = "Discharging" ];
	then
		
		dec_time
	
	elif [ $(we_have_too_much_time) -eq 0 ]
	then	
		inc_time
		if [ $(we_have_too_much_time) -eq 1 ]
		then
			curr_time=$the_max_time
		fi
	fi
	

}

main_loop_func(){
	clear_screen 1
	
	printf "Welcome to the battery daemon!\nA warning text will be displayed\n"
	printf	"at a threshold of less than ${percentage_of_time_left_for_warning_to_trigger_graphical_val}%% "
	printf	"of the total time\n"
	printf	"which is ${total_minutes_to_wait} minutes (${the_max_time} seconds)\n"
	printf	"The threshold is: ${the_time_for_warning} seconds\n\n"
	printf	"Please enjoy your day"

	sleep 5.0

	while true;
	do
		clear_screen 1

		echo_current_battery_status
		echo "The current time is: $curr_time"
		compute_curr_time
		local are_we_joever=$(check_the_time)
		local are_we_close=$(we_have_close_to_no_time)
		echo "Are we over? ${are_we_joever}"
		echo "Are we close? ${are_we_joever}"
		if [ $are_we_close -eq 1 ]
		then
			echo "We have less than ${percentage_of_time_left_for_warning_to_trigger_graphical_val}% of the total time left!"
		fi
		if [ $are_we_joever -eq 1 ]
		then
			echo "We ran out of time We are shutting down. Sorry, man"
			$kill_script_full_file_path
			if [ $testing_mode -eq 1 ]
			then
				echo "JUST KIDDING, HAHAHAAH! (For now. As this is just for testing)"
				echo "Lets just log off..."
				sleep 2
				$kill_session_command
			else
				poweroff
			fi
		else
			sleep $(compute_seconds_to_wait)
		fi
	done
}

main_loop_func
