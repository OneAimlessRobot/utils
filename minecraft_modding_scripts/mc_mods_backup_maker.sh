#!/bin/bash


parent_of_folder_to_backup="/mnt/SUPER_CAVALEIRO/eclipse_environment_for_minecraft_mods/"

server_backup_folder_name="addysmods"

server_folder_to_backup="${parent_of_folder_to_backup}${server_backup_folder_name}"

server_jars_folder="/home/addysmagic/minecraft_servers_fast_storage/forge_1-12-2/mods"

writing_server_jars_folder="/home/addysmagic/Desktop/Writing2/Narratives/ksun/persona/ksun_minecraft_stuff/server_stuff/mods"

writing_client_jars_folder="/home/addysmagic/Desktop/Writing2/Narratives/ksun/persona/ksun_minecraft_stuff/client_stuff"


build_command="./gradlew build"

modpack_archive_name="asem-1.3.jar"

mod_jar="build/libs/${modpack_archive_name}"

freshly_built_modpack_filepath="${server_folder_to_backup}/${mod_jar}"






github_repo_folder="/mnt/FASTstorage/GithubFAST/my_mc_mods"

root_server_folder_backup_locations=("${github_repo_folder}" "/mnt/SUPER_CAVALEIRO/progsBackup/my_mc_mods" "/mnt/REBORN/FASTERprogs/my_mc_mods" "/mnt/FASTstorage/FASTprogs/my_mc_mods")

parent_of_client_mod_folder="/home/addysmagic/.minecraft2/"

client_mod_folder_name="mods"


client_mod_folder_backup_locations=("${github_repo_folder}" "${writing_client_jars_folder}" "/mnt/SUPER_CAVALEIRO/progsBackup/my_mc_mods" "/mnt/REBORN/FASTERprogs/my_mc_mods" "/mnt/FASTstorage/FASTprogs/my_mc_mods")

client_mod_folder_to_backup="${parent_of_client_mod_folder}${client_mod_folder_name}"

num_of_server_backup_locations=${#root_server_folder_backup_locations[@]}

num_of_client_backup_locations=${#client_mod_folder_backup_locations[@]}


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
		cp -rfv  "${server_folder_to_backup}" "${root_server_folder_backup_locations[$i]}"&
	done
	wait
}






















remove_client_mod_folder_from_backup_locations(){

	for(( i=0; i< num_of_client_backup_locations; i++ ))
	do
		rm -rfv "${client_mod_folder_backup_locations[$i]}/${client_mod_folder_name}"&
	done
	wait

}
list_client_mod_files_in_backup_locations(){

	for(( i=0; i< num_of_client_backup_locations; i++ ))
	do
		find "${client_mod_folder_backup_locations[$i]}/${client_mod_folder_name}" -type f
	done
	wait

}


copy_client_mod_folder_to_backup_locations(){

	for(( i=0; i< num_of_client_backup_locations; i++ ))
	do
		cp -rfv  "${client_mod_folder_to_backup}" "${client_mod_folder_backup_locations[$i]}"&
	done
	wait
}



pushd "${server_folder_to_backup}"

${build_command}

rm "${server_mods_folder}/${modpack_archive_name}"

cp "${mod_jar}" "${server_mods_folder}"


rm -rfv "${writing_server_jars_folder}"

cp -rfv "${server_jars_folder}" "${writing_server_jars_folder}"


popd

remove_server_folder_from_backup_locations

copy_server_folder_to_backup_locations

remove_client_mod_folder_from_backup_locations

copy_client_mod_folder_to_backup_locations

pushd "${github_repo_folder}"

bash ./up*sh

popd

echo "Remember to then update the Writing folder backup!"