#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "../src/data_preprocess.h"
#include "../src/util.h"
#include "../src/board.h"

#define SIZE	0x1000



int main(){

    int ret  = 0;

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
out:

    return ret;

}
