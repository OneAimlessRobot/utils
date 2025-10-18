#include "Includes/preprocessor.h"
#define TMP_FILE_PATH "./tmp"
char		*findcmd[]={"ls",NULL,NULL},
		*removecmd[]={"rm","-rf",TMP_FILE_PATH,NULL},
		*targetDir=NULL;
int fd=-1;
void executeFileCmdToTmpFile(void){
	if((fd=open(TMP_FILE_PATH,O_CREAT|O_RDWR|O_TRUNC,0777))<0){

		perror("ficheiro n criado!!!!\n");
		exit(-1);
	}
	int pid= fork();
	switch(pid){
	case -1:
		perror("ERROR FORK!!!!\n");
		close(fd);
		exit(-1);
	case 0:
		dup2(fd,1);
		execvp(findcmd[0],findcmd);
		perror("ERRO EXECVP\n");
		exit(-1);
	default:
		wait(NULL);
		close(fd);
		break;
	}

}
void fixFileString(char* string){

	for(int i=0;string[i];i++){

		if(isspace(string[i])){
			string[i]='_';
		}
	}


}
int string_is_fixed(char* string){

	for(int i=0;string[i];i++){

		if(isspace(string[i])){
			return 0;
		}
	}
	return 1;

}
void* move_file(void* mem){

	char** fnames= (char**)mem;

	int fd_in=-1,fd_out=-1;
	
	if((fd_in=open(fnames[0],O_RDWR,0777))<0){

		perror("filepath invalid in file moving!!!\n");
		exit(-1);
	}
	
	if((fd_out=open(fnames[1],O_CREAT|O_WRONLY|O_TRUNC,0777))<0){
		close(fd_in);
		perror("filepath invalid out file moving!!!\n");
		exit(-1);
	}
	
	char buff[1024]={0};
	int numread=0;
	while((numread=read(fd_in,buff,1024))>0){

		write(fd_out,buff,numread);
		memset(buff,0,1024);

	}
	
	close(fd_in);
	close(fd_out);

	remove(fnames[0]);
	
	return mem;






}



void mvFiles(void){
	FILE* fp=NULL;
	if(!(fp= fopen(TMP_FILE_PATH,"r"))){

		perror("filepath invalid in file moving!!!\n");
		exit(-1);
	}
	char buffsrc[1024]={0};
	char buffdst[1024]={0};
	while(fgets(buffsrc,1024,fp)){
		buffsrc[strlen(buffsrc)-1]=0;
		strcpy(buffdst,buffsrc);

		fixFileString(buffdst);
		printf("File src: %s\n",buffsrc);
		printf("File dst: %s\n",buffdst);
		if(string_is_fixed(buffsrc)){
			printf("String is fixed!!\n%s\n",buffsrc);
			continue;
		}
		pthread_t tid;
		char* fnames[2];
		fnames[0]=buffsrc;
		fnames[1]=buffdst;
//		move_file((void*)fnames);
		pthread_create(&tid,NULL,move_file,(void*)fnames);
		pthread_join(tid,NULL);
		memset(buffsrc,0,1024);
		memset(buffdst,0,1024);

	}
	fclose(fp);

}
void removeTmpFile(void){

	int pid= fork();
	switch(pid){
	case -1:
		perror("ERROR FORK!!!!\n");
		exit(-1);
	case 0:
		execvp(removecmd[0],removecmd);
		perror("ERRO EXECVP\n");
		exit(-1);
	default:
		wait(NULL);
		break;
	}


}
int main(int argc, char ** argv){
	

	targetDir=argv[1];
	executeFileCmdToTmpFile();
	mvFiles();
	removeTmpFile();

	return 0;
}
