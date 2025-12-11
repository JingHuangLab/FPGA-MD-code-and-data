#include <stdio.h>
#include <stdint.h>
#include "util.h"   

int write_data_to_file(void *data, size_t size, char *file_name){

    FILE *fd = NULL;
    
    fd = fopen(file_name,"wb");
    if(!fd)
    {
        printf("Error: create file %s\n",file_name);
        return -1;
    }
    fwrite(data, sizeof(uint8_t),size,fd);
    fclose(fd);
    return 0;
}

void dataSwap(uint8_t *data, uint32_t size){
    int i, cnt, end, start;
    if(!data){
        printf("Error: %s data is NULL\n",__func__);
    }
    cnt = size / 2;
    start = 0;
    end = size - 1;
    uint8_t tmp;
    for(i = 0; i < cnt; i++){
        tmp = data[i];
        data[i] = data[end - i];
        data[end - i] = tmp;
    }
}
