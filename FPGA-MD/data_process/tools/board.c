#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "../src/data_preprocess.h"
#include "../src/util.h"
#include "../src/board.h"

#define SIZE	0x1000
#define BLOCK_SIZE	0x11E010


int main(){

    int ret  = 0;

/*

    uint8_t *data = malloc(SIZE);
    uint8_t *result = malloc(SIZE);
	memset(data,0x5a,SIZE);
	memset(result,0,SIZE);
    write_data_to_file(data, SIZE, "origin.data");
    

    ret = write_device(DeviceADDR,data,SIZE);
	if(ret < 0) 
            goto freeBuffer;

   
    ret = read_device(DeviceADDR,result,SIZE);
        if(ret < 0) 
            goto freeBuffer;

    write_data_to_file(result, SIZE, "result.data");

freeBuffer:
    free(data);
    free(result);


*/

	uint16_t size=64;
	uint16_t result=0;
	ret = write_reg(BLOCK_SIZE,&size,2);
	if(ret<0){
		printf("failed to write_reg\n");
		goto out;
	}
	ret = read_reg(BLOCK_SIZE,&result,2);
	if(ret<0){
		printf("failed to read_reg\n");
		goto out;
	}

	printf("result:%u\n",result);

out:

    return ret;

}
