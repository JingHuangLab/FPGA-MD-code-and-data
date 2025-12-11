#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

#include "../include/coef.h"

#define N       23358

int main(){

    int err = 0;
    FILE *fp, *fp_particle;
    fp = fopen("./coef_lines.data","rb");
    if(!fp){
        printf("Error: open coef_lines.data failed\n");
        err=-1;
        goto end;
    }

    fp_particle = fopen("./particle.data","r");
    if(!fp_particle){
        printf("Error: open particle.data failed\n");
        err=-1;
        goto close_file;
    }

    coef_entry *data = (coef_entry*)malloc(sizeof(coef_entry)* NUM_TYPES * NUM_TYPES);
    memset(data,0,sizeof(coef_entry)*NUM_TYPES*NUM_TYPES); 
    //TypeCharge *type_charge = (TypeCharge *)malloc(sizeof(TypeCharge)*NUM_TYPES);
    //memset(type_charge,0,sizeof(TypeCharge)*NUM_TYPES);

    uint32_t atom1_index = 0;
    uint32_t atom2_index = 0;

    for(int i=0;i<(2*NUM_TYPES*NUM_TYPES);i+=2){
        int j = i / 2;
        atom1_index = j / NUM_TYPES;
        atom2_index = j % NUM_TYPES;
        data[j].combined_index = (atom1_index << 5 ) + atom2_index;
        fscanf(fp,FOMAT_STRING,&(data[j].a_coef));
        fscanf(fp,FOMAT_STRING,&(data[j].b_coef));
    }

    /*
    int count = 0;
    int type_index;
    int temp_int;
    float temp_float;
    DATA_TYPE charge =0.0;

    for(int i=0; i<N;i++){
        fscanf(fp_particle,"%u %u %f %f %*f %*f %*f %*f %*f",&temp_int,&type_index,&temp_float,&charge);
        int j = type_index;
        if(type_charge[j].set == 0){
            type_charge[j].charge = charge;
            type_charge[j].set = 1;
            ++count;
        }
        else{
            if(((type_charge[j].charge - charge) > 0.1) | ((type_charge[j].charge - charge) < -0.1)){
                printf("%d %d %f %f\n",j,i,type_charge[j].charge,charge);
            }
        }
        //if(count == NUM_TYPES) break;
    }
    */

    //printf("Atom1_TypeIndex     Atom2_TypeIndex   CombinedIndex       A_coef                     B_coef                       QQ_ab\n");
    printf("CombinedIndex       A_coef                     B_coef                   \n");
    printf("------------------------------------------------------------------------------------------------------------------------\n");
    for(int i=0; i<NUM_TYPES*NUM_TYPES; i++){
     //   data[i].qq_ab = type_charge[data[i].atom1_index].charge * type_charge[data[i].atom2_index].charge;
        //printf("%8d  %15d %17d            %.14f            %.14f         %.14f\n",data[i].atom1_index,data[i].atom2_index,
        //data[i].combined_index,data[i].a_coef,data[i].b_coef, data[i].qq_ab);
        printf("%17d            %.14f            %.14f         \n",data[i].combined_index,data[i].a_coef,data[i].b_coef);
    }

    free(data);
    //free(type_charge);


close_file:
    fclose(fp);
end:
    return err;
}