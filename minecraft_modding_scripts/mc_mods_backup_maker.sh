#!/bin/bash


parent_of_folder_to_backup="/mnt/SUPER_CAVALEIRO/eclipse_environment_for_minecraft_mods/"

backup_folder_name="addysmods"

folder_to_backup="${parent_of_folder_to_backup}${backup_folder_name}"

github_repo_folder="/mnt/FASTstorage/GithubFAST/my_mc_mods"

root_folder_backup_locations=("${github_repo_folder}" "/mnt/SUPER_CAVALEIRO/progsBackup" "/mnt/REBORN/FASTERprogs" "/mnt/FASTstorage/FASTprogs")


num_of_backup_locations=${#root_folder_backup_locations[@]}


remove_folder_from_backup_locations(){

	for(( i=0; i< num_of_backup_locations; i++ ))
	do
		rm -rfv "${root_folder_backup_locations[$i]}/${backup_folder_name}"&
	done
	wait

}
list_files_in_backup_locations(){

	for(( i=0; i< num_of_backup_locations; i++ ))
	do
		find "${root_folder_backup_locations[$i]}/${backup_folder_name}" -type f
	done
	wait

}


copy_folder_to_backup_locations(){

	for(( i=0; i< num_of_backup_locations; i++ ))
	do
		cp -rfv  "${folder_to_backup}" "${root_folder_backup_locations[$i]}"&
	done
	wait
}

#list_files_in_backup_locations

#rm -rfi "${root_folder_backup_locations[$1]}/${backup_folder_name}"

remove_folder_from_backup_locations

copy_folder_to_backup_locations


pushd "${github_repo_folder}"

bash ./up*sh

popd