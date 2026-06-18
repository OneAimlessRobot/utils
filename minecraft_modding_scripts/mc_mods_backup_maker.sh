#!/bin/bash


parent_of_folder_to_backup="/mnt/SUPER_CAVALEIRO/eclipse_environment_for_minecraft_mods/"

server_backup_folder_name="addysmods"

server_folder_to_backup="${parent_of_folder_to_backup}${backup_folder_name}"

mod_jars_regexp="build/libs/*.{jar}"



github_repo_folder="/mnt/FASTstorage/GithubFAST/my_mc_mods"

root_server_folder_backup_locations=("${github_repo_folder}" "/mnt/SUPER_CAVALEIRO/progsBackup" "/mnt/REBORN/FASTERprogs" "/mnt/FASTstorage/FASTprogs")

parent_of_client_mod_folder="/home/addysmagic/.minecraft2/"

client_mod_folder_name="mods"


client_mod_folder_backup_locations=("/home/addysmagic/Desktop/Writing2/Narratives/ksun/persona/ksun_minecraft_stuff/client_stuff" "${github_repo_folder}")

client_mod_folder_to_backup="${parent_of_client_mod_folder}${client_mod_folder_name}"

num_of_server_backup_locations=${#root_folder_backup_locations[@]}


remove_server_folder_from_backup_locations(){

	for(( i=0; i< num_of_server_backup_locations; i++ ))
	do
		rm -rfv "${root_server_folder_backup_locations[$i]}/${server_backup_folder_name}"&
	done
	wait

}
list_server_files_in_backup_locations(){

	for(( i=0; i< num_of_server_backup_locations; i++ ))
	do
		find "${root_server_folder_backup_locations[$i]}/${server_backup_folder_name}" -type f
	done
	wait

}


copy_server_folder_to_backup_locations(){

	for(( i=0; i< num_of_server_backup_locations; i++ ))
	do
		cp -rfv  "${server_folder_to_backup}" "${root_folder_backup_locations[$i]}"&
	done
	wait
}

remove_client_mod_folder_from_backup_locations(){

	for(( i=0; i< num_of_server_backup_locations; i++ ))
	do
		rm -rfv "${client_mod_folder_backup_locations[$i]}/${client_mod_folder_name}"&
	done
	wait

}
list_client_mod_files_in_backup_locations(){

	for(( i=0; i< num_of_client_mod_backup_locations; i++ ))
	do
		find "${client_mod_folder_backup_locations[$i]}/${client_mod_folder_name}" -type f
	done
	wait

}


copy_client_mod_folder_to_backup_locations(){

	for(( i=0; i< num_of_server_backup_locations; i++ ))
	do
		cp -rfv  "${client_mod_folder_to_backup}" "${client_mod_folder_backup_locations[$i]}"&
	done
	wait
}


remove_server_folder_from_backup_locations

copy_server_folder_to_backup_locations

remove_client_mod_folder_from_backup_locations

copy_client_mod_folder_to_backup_locations

pushd "${github_repo_folder}"

bash ./up*sh

popd