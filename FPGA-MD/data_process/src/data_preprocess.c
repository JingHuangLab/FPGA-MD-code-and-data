#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "../include/base.h"
#include "../include/data_preprocess.h"   


static uint32_t get_homecell_size(uint32_t num){
    int i;
    num = num + NC_NUM+1+1; //first 1 is for SEP flag, last 1 is for END flag
    for(i = 31; i>=0; i--)
    {
        if((num>>i))
            break;
    }
    if(num > (1<<i))
        return (1<<(i+1))*WIDTH;
    return (1<<(i))*WIDTH;
}

static int comp(const void *a, const void *b){
    return *(uint32_t *)a - *(uint32_t *)b;
}


int get_particle_data(Particle *p_particle){

    assert(p_particle);

    int ret = OK;
    FILE *fp = NULL;
    Info *info;

    char *particle_filename = getenv("PARTICLE_FILE_NAME");
    ON_ZERO_GOTO(particle_filename,out,"can't get env PARTICLE_FILE_NAME");
    
    fp = fopen(particle_filename, "r");
    ON_ZERO_GOTO(fp,out,"Open file failed");
    
    for(int i=0; i< N; i++){
        info = &(p_particle[i].info);
        //printf("%d : %p\n",i ,info);
        //printf("Index: %p, x: %p, y: %p, z: %p\n", &((*info).Index),&((*info).x),&((*info).y),&((*info).z));
        //fscanf(fp,"%u %u %f %f %f %f",&((*info).Index),&((*info).ljtype_index),&((*info).charge),&((*info).x),&((*info).y),&((*info).z));
        fscanf(fp,"%u %f %f %f",&((*info).Index),&((*info).x),&((*info).y),&((*info).z));
        //printf("Index: %p, x: %p, y: %p, z: %p\n", &((*info).Index),&((*info).x),&((*info).y),&((*info).z));
        info->sub_x = (uint8_t)(((uint32_t)info->x) / (uint8_t)X_SIZE);
        info->sub_y = (uint8_t)(((uint32_t)info->y) / (uint8_t)Y_SIZE);
        info->sub_z = (uint8_t)(((uint32_t)info->z) / (uint8_t)Z_SIZE);
        info->mass = 1.0;
    }

    fclose(fp);

out:
    return ret;
}

int get_homecell_info(Particle *p_particle,CP_Info *p_cpinfo, uint32_t *size){
    
    assert(p_particle);
    assert(p_cpinfo);
    assert(size);

    int ret = OK;


    uint32_t *cell_particle_num =(uint32_t *)malloc(sizeof(uint32_t) * CELL_SIZE);
    ON_ZERO_GOTO(cell_particle_num,out,"Allocate  cell_particle_num buffer failed");
    memset(cell_particle_num, 0, sizeof(uint32_t)*CELL_SIZE);

    uint32_t max_cell_num = 0;
    uint32_t min_cell_num = N;
    Info *info;
    for(int i=0; i< N; i++){
        uint32_t count = 0;
        info = &(p_particle[i].info);
        uint32_t index = Three2One(info->sub_x,info->sub_y,info->sub_z);
        count = ++cell_particle_num[index];
        if(count >= MAX_HC_NUM) {
            printf("sub_x: %d, sub_y: %d, sub_z: %d, index: %d, i:%d\n",info->sub_x, info->sub_y, info->sub_z, index,i);
            printf("Error: particle number (%u) in one cell surpass assume value (%u), please expand the assume value and retry\n", count, MAX_HC_NUM);
            ret = -1;
            goto clean_cell_particle_num;
        }
         
        p_cpinfo[index].num = count;
        p_cpinfo[index].index[count-1] = i; //index from 0
        //printf("info->x:%u, info->y:%u,info->z:%u\n", (uint32_t)info->x,(uint32_t)info->y,(uint32_t)info->z);
        //printf("sub_x:%d,sub_y:%d,sub_z:%d\n",info->sub_x, info->sub_y, info->sub_z);
        //printf("three2one: %d\n",Three2One(info->sub_x,info->sub_y,info->sub_z));
        //printf("cell_particle_num:%d\n",cell_particle_num[Three2One(info->sub_x,info->sub_y,info->sub_z)]);
    }

    // sort
    qsort(cell_particle_num, CELL_SIZE, sizeof(uint32_t), comp);
    max_cell_num = cell_particle_num[CELL_SIZE-1];
    min_cell_num = cell_particle_num[0];
    printf("Max particle numbers in all cell is %u\n", max_cell_num);
    printf("Min particle numbers in all cell is %u\n", min_cell_num);

    //get homecell size
    uint32_t homecell_size = get_homecell_size(max_cell_num);
    printf("homecell size is 0x%x\n",homecell_size);

    *size = homecell_size;

clean_cell_particle_num:
    free(cell_particle_num);

out:
    return ret;

}

