#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DEFAULT_WIDTH 1000
#define DEFAULT_U_PERIOD 1000
int main(int argc, char** argv){
	
	int width,uperiod;
	if(argc != 3){

		width=DEFAULT_WIDTH;
		uperiod=DEFAULT_U_PERIOD;
	}
	else{
		width= atoi(argv[1]);
		uperiod= atoi(argv[2]);

	}
	while(1){

		for(int i=0;i<width;i++){

			printf("#");
		}
		usleep(uperiod);
		printf("\n");
	}
	return 0;
}
