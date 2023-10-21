#include "Includes/preprocessor.h"
const char* prefix="private static final String";
const char* suffix=";";
#define ARGVMAX 100
char* convertSingleEnum(char* enumLine){



}
char* removeBloatCharacters(char* enumLine){




}
int makeargv(char *s, char *argv[ARGVMAX]) {
    int ntokens = 0;

    if (s == NULL || argv == NULL || ARGVMAX == 0)
        return -1;
    argv[ntokens] = strtok(s, " \t\n");
    while ((argv[ntokens] != NULL) && (ntokens < ARGVMAX)) {
        ntokens++;
        argv[ntokens] = strtok(NULL, " \t\n");
    }
    argv[ntokens] = NULL; // it must terminate with NULL
    return ntokens;
}



void strToUpper(char* nilEndedBuff){

    for(int i=0;nilEndedBuff[i]!=0;i++){
    char* c=nilEndedBuff+i;
    if(!isalpha(*c)){

        *c='_';
    }
        *c= toupper(*c);

    }



}
void removeCommasParenthesisAndQuotes(char* nilEndedBuff){

	int size=strlen(nilEndedBuff);
	int cursor=0;
	for(int i=0;i<size;i++){
		
	
		if(nilEndedBuff[i]=='('||nilEndedBuff[i]==')'||nilEndedBuff[i]==','||nilEndedBuff[i]=='"'||nilEndedBuff[i]==';'){
			
			nilEndedBuff[i]=' ';
		}

	}
	
	


}
/*void removeDoubleQuotes(char* str){

	int size=strlen(nilEndedBuff);
	int cursor=0;
	for(int i=0;nilEndedBuff[i];i++){
		
	
		if(nilEndedBuff[i]=='"'){
			
			char* tmpBuff=malloc(size-1);
			memset(tmpBuff,0,size-1);
			memcpy(tmpBuff,nilEndedBuff+1,size-1);
			memset(nilEndedBuff,0,size);
			memcpy(nilEndedBuff,tmpBuff,size-1);
			size-=1;
			free(tmpBuff);
		}

	}
	
	


}*/
void removeBloatFromFilePath(char* nilEndedBuff){
	int size=strlen(nilEndedBuff);
	int cursor=0;
	for(int i=0;nilEndedBuff[i];i++){
		
	
		if(nilEndedBuff[i]=='/'&&i){
			
			char* tmpBuff=malloc(size-cursor+1);
			memset(tmpBuff,0,size-cursor+1);
			memcpy(tmpBuff,nilEndedBuff+cursor+1,size-cursor+1);
			memset(nilEndedBuff,0,size);
			memcpy(nilEndedBuff,tmpBuff,size-cursor+1);
			size-=cursor;
			free(tmpBuff);
			cursor=0;
		}
		else{
			
		cursor++;		
			
		}

	}
	
	
	



}

int main(int argc, char ** argv){
		FILE* file,*tmpfile;
		char* splitStringContainer[ARGVMAX],*stringBuff=malloc(1024);
		char* tmpString=malloc(1024);
		memset(tmpString,0,1024);
		char* tmpString2=strcat(getcwd(tmpString,1024),"/tmpfile");
		int size= strlen(tmpString2);
		char tmpfilepath[size+1];
		memset(tmpfilepath,0,size+1);
		memcpy(tmpfilepath,tmpString2,size);
		free(tmpString);
		memset(stringBuff,0,1024);
		if(argc<1){
			
			perror("argc tem de ser 1: falta a path do ficheiro input");
			exit(-1);
		}
			
		
			if(!(file=fopen(argv[1],"a+"))){

			perror("Erro na abertura de fichero\n");
			exit(-1);
			}
			if(!(tmpfile=fopen(tmpfilepath,"w+"))){

			perror("Erro na abertura de fichero temporario\n");
			exit(-1);
			}
		while(fgets(stringBuff,1024,file)){

			fprintf(tmpfile,"%s",stringBuff);

		}
		fclose(file);
		fclose(tmpfile);
		char tmp[1024];
		memset(tmp,0,1024);
		memcpy(tmp,"cat ",4);
		strcat(tmp,tmpfilepath);
		remove(argv[1]);
		close(creat(argv[1],0666));
			if(!(file=fopen(argv[1],"a"))){

			perror("Erro na abertura de fichero\n");
			exit(-1);
			}
			if(!(tmpfile=fopen(tmpfilepath,"r"))){

			perror("Erro na abertura de fichero\n");
			exit(-1);
			}
		//system(tmp);
		memset(stringBuff,0,1024);
		int length=1024;
		while((length=getline(&stringBuff,&length,tmpfile))>=0){
			stringBuff[length]=0;
			removeCommasParenthesisAndQuotes(stringBuff);
			makeargv(stringBuff,splitStringContainer);
			if(!splitStringContainer[1]){
				
				splitStringContainer[1]="";
			}
			fprintf(file,"%s %s=\"%s\";\n",prefix,splitStringContainer[0],splitStringContainer[1]);
		memset(stringBuff,0,1024);
		}
		

		fclose(file);
		fclose(tmpfile);
		free(stringBuff);
		remove(tmpfilepath);
	return 0;
}
