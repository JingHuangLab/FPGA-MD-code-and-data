#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "../include/base.h"
#include "../include/data_preprocess.h"
#include "../include/matrix.h"
#include "../include/multinomial.h"
#include "../include/coef.h"
#include "../include/board.h"

#define INTERPOLATION_TABLE_SIZE        1024
#define HOMECELL_ADDR                   0x0
#define HOMECELL_SIZE_ADDR              0x11E010
#define DATA_OVER_FLAG                  0x11E020
#define COEF_TABLE_ADDR                 0x100000
#define INTERPOLATION_TABLE_ADDR        0x0
#define MAX_TIME_OUT                    0x100000
#define FPGA_STATUS_ADDR                0x120000    //TODO
#define FPGA_RESULT_ADDR                0x200000    //TODO
#define VERLET_INTERGRATOR_DELAT        0.001



static int comp(const void *a, const void *b){
    return *(uint32_t *)a - *(uint32_t *)b;
}

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

//currently assign default value
int get_coef_table(coef_entry *table ){
    assert(table);

    int ret = OK;
    for(int i = 0; i<NUM_TYPES*NUM_TYPES;i++){
        table[i].combined_index = ((i/NUM_TYPES)<<5) + i % NUM_TYPES;
        table[i].a_coef = 1.0;
        table[i].b_coef = 1.0;
    } 

    return ret;

}



int get_homecell_array(HC *hc_buffer,CP_Info *cell_particle_info, Particle *p_particle, int homecell_size){

    int ret = OK;
    
    // fill particle information SEP_FLAG and END_FLAG for homecell
    for(int i=0; i<CELL_SIZE; ++i){
        HC *p_hc_buffer =(HC *)((uint8_t *)hc_buffer + i*homecell_size);
        memset(p_hc_buffer->sep, SEP_FLAG, WIDTH);
        Particle *p = p_hc_buffer->particle;
        uint32_t count = cell_particle_info[i].num;
        for(int j=0; j<count; ++j){
            uint32_t index = cell_particle_info[i].index[j];
            
            memcpy(p+j,p_particle+index,sizeof(Particle));
            (*(p+j)).info.u.index <<= 8;
            (*(p+j)).info.u.header.label = HC_FLAG;
        }
        memset(p+count,END_FLAG,WIDTH);     //set END_FLAG;
    }

    // check
    #ifdef __DEBUG__
    Particle *p = ((HC *)hc_buffer)->particle;
    uint32_t count = cell_particle_info[0].num;
    for(int j=0; j<count;++j){
        printf("Index : %d, Content: %p, Label: %x, sub_index: %x, sub_x: %d, sub_y: %d, sub_z: %d\n", cell_particle_info[0].index[j] ,(*(p+j)).info.Index, (*(p+j)).info.Label,(*(p+j)).info.Sub_index,
        (*(p+j)).info.sub_x,(*(p+j)).info.sub_y,(*(p+j)).info.sub_z);
    }
    #endif

    // fill neighbor cell information
    for(int i=0; i<CELL_SIZE; ++i){
        HC *p_hc_buffer =(HC *)((uint8_t *)hc_buffer + i*homecell_size);
        NC *p_nc = p_hc_buffer->nc;
        Particle *p = p_hc_buffer->particle;
        uint32_t cell_x = (*p).info.sub_x;
        uint32_t cell_y = (*p).info.sub_y;
        uint32_t cell_z = (*p).info.sub_z;

        //current cell, index =  0;
        p_nc->nc_info.label = NC_FLAG;
        p_nc->nc_info.sub_x = cell_x;
        p_nc->nc_info.sub_y = cell_y;
        p_nc->nc_info.sub_z = cell_z;
        p_nc->nc_info.cell_index = i;

        uint32_t index = 1;
        for(int z = -1; z <=1; ++z){
            for(int x = -1; x <= 1; ++x) {
                for(int y=-1; y <=1; ++y) {
                    if(y==0&&x==0&&z==0){
                        continue;
                    }
                    else{
                        (*(p_nc+index)).nc_info.label = NC_FLAG;
                        (*(p_nc+index)).nc_info.sub_x = NC_X(cell_x,x);
                        (*(p_nc+index)).nc_info.sub_y = NC_Y(cell_y,y);
                        (*(p_nc+index)).nc_info.sub_z = NC_Z(cell_z,z);
                        (*(p_nc+index)).nc_info.cell_index = Three2One(NC_X(cell_x,x),NC_Y(cell_y,y),NC_Z(cell_z,z));
                    }
                    ++index;
                }
            }
        }
    }

    #ifdef __DEBUG__
    //check neighbor cell information
    NC *p_nc = ((HC *)hc_buffer)->nc;
    for(int i = 0; i<NC_NUM;++i){
        printf("First 8 bytes: %p , label:%2x, sub_x: %2d, sub_y: %2d, sub_z: %2d, address: %x\n",(*((uint64_t *)(&((p_nc+i)->nc_info.label)))), (p_nc+i)->nc_info.label, 
                         (p_nc+i)->nc_info.sub_x,(p_nc+i)->nc_info.sub_y,(p_nc+i)->nc_info.sub_z,(p_nc+i)->nc_info.address);
    }
    #endif

    return ret;

}

int inter_compute(float start, float end, int num, int exp, int order, float *coef_lookup_table){

    assert(coef_lookup_table);

    int ret = OK;

    float *part_x = fun_partition(start,end,num);
    float *part_y = power_function(part_x,num,exp);
    float *part_yd = dhs(part_x,num,exp);
    
    float *result = (float *)malloc(sizeof(float)*(4));
    ON_ZERO_GOTO(result,clean_part,"alloc result buffer failed");
    memset(result,0,(4)*sizeof(float));
    
    for(int j=0;j<num;j++){
        get_polynominal_abcd(construct_a(order,part_x[j],part_x[j+1]),
                            construct_b(order,part_y[j],part_y[j+1],part_yd[j],part_yd[j+1]),result);

        for(int i = 0; i<=order;i++){
            *(coef_lookup_table+j*(4)+i) = result[i]; 
        }
    }

clean_part:
    free(part_x);
    free(part_y);
    free(part_yd);

    return ret;
}

int get_interpolation_table(float *table){

    assert(table);

    int ret = OK;

    float *r_7_table = (float *)malloc(sizeof(float)*INTERPOLATION_TABLE_SIZE*(4));
    ON_ZERO_GOTO(r_7_table,out,"alloc r_7_table failed");
    memset(r_7_table,0,INTERPOLATION_TABLE_SIZE*(4)*sizeof(float));

    float *r_4_table = (float *)malloc(sizeof(float)*INTERPOLATION_TABLE_SIZE*(4));
    ON_ZERO_GOTO(r_4_table,clean_r_7_table,"alloc r_4_table failed");
    memset(r_4_table,0,INTERPOLATION_TABLE_SIZE*(4)*sizeof(float));

    float *r_3_2_table = (float *)malloc(sizeof(float)*INTERPOLATION_TABLE_SIZE*(4));
    ON_ZERO_GOTO(r_3_2_table,clean_r_4_table,"alloc r_3_2_table failed");
    memset(r_3_2_table,0,INTERPOLATION_TABLE_SIZE*(4)*sizeof(float));

    ret = inter_compute(0.1,144,INTERPOLATION_TABLE_SIZE,-7,2,r_7_table);
    ON_NON_ZERO_GOTO(ret, clean_r_3_2_table,"create r^-7 interpolation table");
    
    ret = inter_compute(0.1,144,INTERPOLATION_TABLE_SIZE,-4,2,r_4_table);
    ON_NON_ZERO_GOTO(ret, clean_r_3_2_table,"create r^-4 interpolation table");
    
    ret = inter_compute(0.1,144,INTERPOLATION_TABLE_SIZE,-1.5,2,r_3_2_table);
    ON_NON_ZERO_GOTO(ret, clean_r_3_2_table,"create r^(-3/2) interpolation table");
    
    float data;
    for(int i=0; i<INTERPOLATION_TABLE_SIZE;i++){
        for(int j=0;j<12;j++){
            if(j<4)
                data = *(r_7_table+i*4+j);
            else if(j<8)
                data = *(r_4_table+i*4+(j-4));
            else
                data = *(r_3_2_table+i*4+(j-8));
            
            *(table+i*12+j) = data;
        }
    }

clean_r_3_2_table:
    free(r_3_2_table);

clean_r_4_table:
    free(r_4_table);

clean_r_7_table:
    free(r_7_table);
out:
    return ret;
    
}

int waiting_for_fpga(uint32_t timeout ){
    int ret = OK;
    uint32_t i = 0;
    for(i =0; i< timeout; i++){
        int status = 0;
        read_reg(FPGA_STATUS_ADDR, &status, 4);
        if(status == 1){ //what's the right condition, need determined.
            break;
        } 
    }
    if(i==timeout){
        ret = -1;
    }
    return ret;
}

int verlet_integrator(ResultParticle *result, Particle *particle_buffer ){
    assert(result);

    int ret = OK;
    Info *info = NULL; 
    RP_Info *rp_info = NULL;
    float invert_mass = 0.0;
    for(int i=0; i<N; i++){
        rp_info = &(result[i].Info);
        //caclulate new velocity and location
        invert_mass = 1.0 / (rp_info->mass);
        rp_info->Vx = rp_info->force_x * invert_mass * VERLET_INTERGRATOR_DELAT;
        rp_info->x = rp_info->x + rp_info->Vx*VERLET_INTERGRATOR_DELAT;
        rp_info->Vy = rp_info->force_y * invert_mass * VERLET_INTERGRATOR_DELAT;
        rp_info->y = rp_info->y + rp_info->Vy*VERLET_INTERGRATOR_DELAT;
        rp_info->Vz = rp_info->force_z * invert_mass * VERLET_INTERGRATOR_DELAT;
        rp_info->z = rp_info->z + rp_info->Vz*VERLET_INTERGRATOR_DELAT;

        //update
        info = &(particle_buffer[rp_info->index].info);
        info->Vx = rp_info->Vx;
        info->Vy = rp_info->Vy;
        info->Vz = rp_info->Vz;
        info->x = rp_info->x;
        info->y = rp_info->y;
        info->z = rp_info->z;
        
    }
    return ret;
}

int get_result_data(uint8_t *result, CP_Info *cell_particle_info, int homecell_size ){

    assert(result);
    assert(cell_particle_info);

    int ret = OK;
    int count = 0;

    uint8_t *full_data = (uint8_t *)malloc(homecell_size * CELL_SIZE);
    ON_ZERO_GOTO(full_data, out, "Allocate full_data buffer failed");
    memset(full_data,0,homecell_size*CELL_SIZE);

    ret = read_device(FPGA_RESULT_ADDR,full_data,homecell_size * CELL_SIZE);
    ON_NON_ZERO_GOTO(ret, clean_full_data, "Read result data from fpga failed");

    for(int i=0; i<CELL_SIZE;i++){
        uint8_t *head = full_data + i * homecell_size;
        CP_Info *cp_info = cell_particle_info + i;
        //Check
        uint32_t *last =(uint32_t *)((head + (cp_info->num-1)*WIDTH) +4); // energy field;
        ON_ZERO_GOTO(*last, clean_full_data, "Num of particles in one cell is less than expected value");

        uint8_t *end = head + cp_info->num * WIDTH;
        ON_NON_ZERO_GOTO(*end,clean_full_data,"Num of particles in one cell is greater than expected value");

        //Copy
        int num = (end-head) / WIDTH;
        if(count+num < N){
            memcpy(result+ count*WIDTH, head, num*WIDTH);
            count += num;
        }
        else{
            ret = -1;
            printf("Error:The total sum of particle number is greater than real value");
            goto clean_full_data;
        }

    }

    if(count < N){
        ret = -1;
        printf("Error:The total sum of particle number is less than real value");
    }

clean_full_data:
    free(full_data);

out:
    return ret;


}

int main(int argc, char *argv[]){

    int ret = OK;

    //1.Read file and get particle data

    Particle *particle_buffer = (Particle *)malloc(sizeof(Particle) * N);
    ON_ZERO_GOTO(particle_buffer,out,"Allocate particle buffer failed");
    memset(particle_buffer, 0, sizeof(Particle)*N);

    ret = get_particle_data(particle_buffer);
    ON_NON_ZERO_GOTO(ret,clean_particle_buffer,"Get particle data failed");

    //2.Prepare coef table
    coef_entry *coef_table =(coef_entry*)malloc(sizeof(coef_entry)*NUM_TYPES*NUM_TYPES);
    ON_ZERO_GOTO(coef_table,clean_particle_buffer,"Allocate coef_table failed");

    ret = get_coef_table(coef_table);
    ON_NON_ZERO_GOTO(ret,clean_coef_table,"Get coef table failed");

    /*
    //write coef table -> BAR 0 +  COEF_TABLE_ADDR
    for(int i =0; i<NUM_TYPES*NUM_TYPES;i++){
        write_reg(COEF_TABLE_ADDR+coef_table[i].combined_index*8,&(coef_table[i].a_coef),4);
        write_reg(COEF_TABLE_ADDR+coef_table[i].combined_index*8+4,&(coef_table[i].b_coef),4);
    }
    */


    //3.Prepare interpolation table
    float *interpolation_table = (float*)malloc(sizeof(float)*INTERPOLATION_TABLE_SIZE*12);
    ON_ZERO_GOTO(interpolation_table,clean_coef_table,"Allocate interpolation table failed");
        
    ret = get_interpolation_table(interpolation_table);
    ON_NON_ZERO_GOTO(ret,clean_interpolation_table,"Get interpolation_table failed");

    /*
    //write interpolation table -> BAR 0 +  INTERPOLATION_TABLE_ADDR
    for(int i =0; i<INTERPOLATION_TABLE_SIZE;i++){
        for(int j=0; j<12;j++){
            write_reg(INTERPOLATION_TABLE_ADDR+i*12*4+j,interpolation_table+i*12+j,4);
        }
    }
    */

    //4.Analyze particle data and get particle information of homecell;
    CP_Info *cell_particle_info =(CP_Info *)malloc(sizeof(CP_Info) * CELL_SIZE);
    ON_ZERO_GOTO(cell_particle_info,clean_interpolation_table,"Allocate cell_particle_info buffer failed");
    memset(cell_particle_info, 0, sizeof(CP_Info)*CELL_SIZE);

    uint32_t homecell_size = 0;
    ret = get_homecell_info(particle_buffer,cell_particle_info,&homecell_size);
    ON_NON_ZERO_GOTO(ret,clean_cell_particle_info,"Get homecell information failed");

    //5.Based on particle information of homecell and get homecell array; 
    HC  *hc_buffer = (HC*) malloc(homecell_size * CELL_SIZE);
    ON_ZERO_GOTO(hc_buffer,clean_cell_particle_info,"Allocate homecell buffer failed");
    memset(hc_buffer, 0, homecell_size * CELL_SIZE);

printf("before get  homecell array\n");
    ret = get_homecell_array(hc_buffer,cell_particle_info,particle_buffer,homecell_size);
    ON_NON_ZERO_GOTO(ret, clean_hc_buffer,"Get homecell array failed");

printf("before write homecell array\n");
    //write homecell array to HBM 
    write_device(HOMECELL_ADDR,hc_buffer,homecell_size*CELL_SIZE);
printf("Before write homecell size\n");
    //write homecell size to REG
    write_reg(HOMECELL_SIZE_ADDR,&homecell_size,4);
    //write 0xAA to indicate the data is well prepared;
    uint8_t flag = 0xAA;
    write_reg(DATA_OVER_FLAG,&flag,1);

printf("before waiting_for_fpga\n");

    //6.Polling whether fpga computing has finished;
   ret = waiting_for_fpga(MAX_TIME_OUT);
    ON_NON_ZERO_GOTO(ret, clean_hc_buffer, "Timeout");

    //7.Get the result data
   
    ResultParticle *result = (ResultParticle*)malloc(sizeof(ResultParticle)*N);
    ON_ZERO_GOTO(result,clean_hc_buffer,"Allocate result buffer failed");

    ret = get_result_data(result,cell_particle_info,homecell_size);
    ON_NON_ZERO_GOTO(ret, clean_result,"Get result data failed");

    //8.Feed into verlet-integrator and update location and velocity;
    ret = verlet_integrator(result,particle_buffer);


clean_result:
    free(result);

clean_hc_buffer:
    free(hc_buffer);

clean_cell_particle_info:
    free(cell_particle_info);

clean_interpolation_table:
    free(interpolation_table);

clean_coef_table:
    free(coef_table);

clean_particle_buffer:
    free(particle_buffer);
out:
    return ret;

}

