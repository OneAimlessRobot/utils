#!/bin/bash

#generalized constants for any version

build_command="./gradlew build"

parent_of_folder_to_backup="/mnt/SUPER_CAVALEIRO/eclipse_environment_for_minecraft_mods/"

github_repo_folder="/mnt/FASTstorage/GithubFAST/my_mc_mods/"

parent_folder_for_servers="/home/addysmagic/minecraft_servers_fast_storage/"

parent_folder_for_game_folders="/home/addysmagic/"

mod_subfolder_name="mods/"

#uncomment this entire block
#and comment the other entire one!
#depending on the version you want.
#you gotta make a new block one for each version!


#STUFF FOR FABRIC 1.19.4 MODS!


#mod_backup_folder_name="addysmods1-19/"

#modpack_archive_name="sedm-2.3.jar"

#mod_loader_version_subfolder_name="fabric-1.19.4_stuff/"

#server_game_folder_name="fabric_1.19.4/"

#client_game_folder_name=".minecraft3/"



#stuff for forge 1.12.2 mods!

mod_backup_folder_name="addysmods/"

modpack_archive_name="asem-1.3.jar"

mod_loader_version_subfolder_name="forge-1.12.2_stuff/"

server_game_folder_name="forge_1-12-2_latest/"

client_game_folder_name=".minecraft2/"








parent_of_client_mod_folder="${parent_folder_for_game_folders}${client_game_folder_name}"

github_repo_folder_subfolder="${github_repo_folder}${mod_loader_version_subfolder_name}"



mod_folder_to_backup="${parent_of_folder_to_backup}${mod_backup_folder_name}"

server_folder="${parent_folder_for_servers}${server_game_folder_name}"

server_jars_folder="${server_folder}/${mod_subfolder_name}"


writing_server_game_folder="/home/addysmagic/Desktop/Writing2/Narratives/ksun/persona/ksun_minecraft_stuff/server_stuff"

writing_client_game_folder="/home/addysmagic/Desktop/Writing2/Narratives/ksun/persona/ksun_minecraft_stuff/client_stuff"


mod_jar="build/libs/${modpack_archive_name}"

freshly_built_modpack_filepath="${mod_folder_to_backup}/${mod_jar}"







client_game_folder_backup_locations=("${writing_client_game_folder}")

root_mod_folder_backup_locations=("${github_repo_folder_subfolder}" "/mnt/SUPER_CAVALEIRO/progsBackup/my_mc_mods/${mod_loader_version_subfolder_name}" "/mnt/REBORN/FASTERprogs/my_mc_mods/${mod_loader_version_subfolder_name}" "/mnt/FASTstorage/FASTprogs/my_mc_mods/${mod_loader_version_subfolder_name}")



client_game_folder_to_backup="${parent_folder_for_game_folders}${client_game_folder_name}"

num_of_client_game_folder_backup_locations=${#client_game_folder_backup_locations[@]}

num_of_root_mod_folder_backup_locations=${#root_mod_folder_backup_locations[@]}


remove_root_mod_folder_backup_locations(){

	for(( i=0; i< num_of_root_mod_folder_backup_locations; i++ ))
	do
		rm -rfv "${root_mod_folder_backup_locations[$i]}/${mod_folder_to_backup}"&
	done
	wait

}
list_root_mod_folder_backup_locations(){

	for(( i=0; i< num_of_root_mod_folder_backup_locations; i++ ))
	do
		find "${root_mod_folder_backup_locations[$i]}/${mod_folder_to_backup}" -type f
	done
	wait

}


copy_root_mod_folder_backup_locations(){

	for(( i=0; i< num_of_root_mod_folder_backup_locations; i++ ))
	do
		mkdir -p   "${root_mod_folder_backup_locations[$i]}" ;  cp -rfv "${mod_folder_to_backup}" "${root_mod_folder_backup_locations[$i]}"&
	done
	wait
}






















remove_client_mod_folder_from_backup_locations(){

	for(( i=0; i< num_of_client_game_folder_backup_locations; i++ ))
	do
		rm -rfv "${client_game_folder_backup_locations[$i]}/${client_game_folder_name}"&
	done
	wait

}
list_client_mod_files_in_backup_locations(){

	for(( i=0; i< num_of_client_game_folder_backup_locations; i++ ))
	do
		find "${client_game_folder_backup_locations[$i]}/${client_game_folder_name}" -type f
	done
	wait

}


copy_client_mod_folder_to_backup_locations(){

	for(( i=0; i< num_of_client_game_folder_backup_locations; i++ ))
	do	
		mkdir -p "${client_game_folder_backup_locations[$i]}" ; cp -rfv  "${client_game_folder_to_backup}" "${client_game_folder_backup_locations[$i]}"&
	done
	wait
}



pushd "${parent_of_folder_to_backup}/${mod_backup_folder_name}"

${build_command}

rm "${server_jars_folder}/${modpack_archive_name}"

cp "${mod_jar}" "${server_jars_folder}"


rm -rfv "${writing_server_game_folder}"

cp -rfv "${server_folder}" "${writing_server_game_folder}"


popd

remove_root_mod_folder_backup_locations

copy_root_mod_folder_backup_locations

remove_client_mod_folder_from_backup_locations

copy_client_mod_folder_to_backup_locations

pushd "${github_repo_folder}"

bash ./up*sh

popd

echo "Remember to then update the Writing folder backup!"
