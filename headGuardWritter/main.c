#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

void strToUpper(char* nilEndedBuff){

    for(int i=0;nilEndedBuff[i]!=0;i++){
    char* c=nilEndedBuff+i;
    if(!isalpha(*c)){

        *c='_';
    }
        *c= toupper(*c);

    }



}

void removeBloatFromFilePath(char* nilEndedBuff){
	int size=strlen(nilEndedBuff);
	int cursor=0;
	for(int i=0;nilEndedBuff[i];i++){
		
	
		if(nilEndedBuff[i]=='/'&&i){
			
			char* tmpBuff=malloc(size-cursor);
			memset(tmpBuff,0,size-cursor);
			memcpy(tmpBuff,nilEndedBuff+cursor,size-cursor);
			memset(nilEndedBuff,0,size);
			memcpy(nilEndedBuff,tmpBuff,size-cursor);
			size-=cursor;
			free(tmpBuff);
			cursor=0;
		}
		else{
			
		cursor++;		
			
		}

	}
	
	
	



}


int main(int argc, char** argv){

    if(argc<2){
        printf("Tens de meter uma path de ficheiro como argumento");
        return 1;

    }
    FILE* file= fopen(argv[1],"r");
    if(!file){

        printf("Ficheiro %s nao abriu!!!!!!\n",argv[1]);
        return 2;


    }
    char* buff=malloc(strlen(argv[1]));
    char* fileName= argv[1];
    memset(buff,0,strlen(argv[1]));
    memcpy(buff,argv[1],strlen(argv[1]));
    removeBloatFromFilePath(argv[1]);
    strToUpper(argv[1]);
    int sizeOfHeaderStart=strlen("#ifndef ")+strlen(fileName)+strlen("\n#define ")+strlen(fileName)+1;
    char* HGStart=malloc(sizeOfHeaderStart);
    char* HGEnd="#endif";
    char* fileInMem;
    memset(HGStart,0,sizeOfHeaderStart);
    sprintf(HGStart,"#ifndef %s\n#define %s\n",fileName,fileName);

    fseek(file,0,SEEK_END);
    int length=ftell(file);
    fseek(file,0,SEEK_SET);
    fileInMem=malloc(length+1);
    memset(fileInMem,0,length+1);
    int finalSize=sizeOfHeaderStart+length+strlen("#endif")+1;
    char* finalFileBuff=malloc(finalSize+1);
    if(fileInMem){
        fread(fileInMem,1,length,file);
    memset(finalFileBuff,0,finalSize+1);
	fclose(file);
	file=fopen(buff,"w");
    sprintf(finalFileBuff,"%s\n%s%s\n",HGStart,fileInMem,HGEnd);
    fwrite(finalFileBuff,1,finalSize,file);
	fclose(file);
    }
    else{
    fclose(file);
    }
    free(HGStart);
    free(fileInMem);
    free(finalFileBuff);
    free(buff);



}
