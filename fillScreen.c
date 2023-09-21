#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DEFAULT_WIDTH 1000

int main(int argc, char** argv){
	
	int width;
	if(argc != 2){

		width=DEFAULT_WIDTH;

	}
	else{
		width= atoi(argv[1]);

	}
	while(1){

		for(int i=0;i<width;i++){

			printf("#");
		}
		usleep(50000);
		printf("\n");
	}
	return 0;
}
