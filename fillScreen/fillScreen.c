#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DEFAULT_WIDTH 1000
#define DEFAULT_U_PERIOD 1000
#define TIMES 1
int main(int argc, char** argv){
	
	int width,uperiod,times;
	if(argc != 4){

		width=DEFAULT_WIDTH;
		uperiod=DEFAULT_U_PERIOD;
		times=TIMES;
	}
	else{
		width= atoi(argv[1]);
		uperiod= atoi(argv[2]);
		times=atoi(argv[3]);
	}
	for(int i=0;i<times;i++){

		for(int i=0;i<width;i++){

			printf("#");
		}
		usleep(uperiod);
		printf("\n");
	}
	return 0;
}
