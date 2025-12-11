#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>


#define N  23358

typedef struct AtomInfo {
    uint32_t index;
    uint32_t ljtype_index;
    float    mass;
    float    charge;
    float    epsilon;
    float    sigma;
    float    x;
    float    y;
    float    z;
}AtomInfo;



int main(){

    int ret = 0;

    FILE *fp_position, *fp_charge, *fp_type, *fp_mass, *fp_sig_epsion;
    
    fp_position = fopen("position.data", "r");
    if(fp_position == NULL){
        printf("Error: Open position.data  failed\n");
        ret = -1;
        goto out;
    }

    fp_charge = fopen("charge_epsilon_sigma.data", "r");
    if(fp_charge == NULL){
        printf("Error: Open charge_epsilon_sigma.data  failed\n");
        ret = -1;
        goto close_fp_position;
    }

    fp_type = fopen("ljtype.data","r");
    if(fp_type == NULL){
        printf("Error:open ljtype.data failed\n");
        ret = -1;
        goto close_fp_charge;
    }

    fp_mass = fopen("mass_type.data","r");
    if(fp_mass == NULL){
        printf("Error:open mass_type.data failed\n");
        ret = -1;
        goto close_fp_type;
    }

    fp_sig_epsion = fopen("sigma_epsilon.data","r");
    if(fp_mass == NULL){
        printf("Error:open sigma_epsilon.data failed\n");
        ret = -1;
        goto close_fp_mass;
    }


    AtomInfo *data = (AtomInfo *)malloc(sizeof(AtomInfo)*N);
    memset(data, 0, sizeof(AtomInfo)*N);
    
    for(int i =0; i<N;i++){
        fscanf(fp_position,"%u %f %f %f",&(data[i].index), &(data[i].x),&(data[i].y),&(data[i].z));
    }
    printf("%u %f %f %f\n",data[0].index, data[0].x,data[0].y,data[0].z);

    for(int i =0; i<N;i++){
        fscanf(fp_charge,"%u %f %f %f",&(data[i].index), &(data[i].charge),&(data[i].sigma),&(data[i].epsilon));
    }

    for(int i =0; i<N;i++){
        fscanf(fp_sig_epsion,"%u %f %f",&(data[i].index),&(data[i].sigma),&(data[i].epsilon));
    }

    for(int i =0; i<N;i++){
        fscanf(fp_type,"%u %u",&(data[i].index), &(data[i].ljtype_index));
    }

    printf("%u %u\n",data[0].index,data[0].ljtype_index);
    printf("%u %u\n",data[1].index,data[1].ljtype_index);

    for(int i =0; i<N;i++){
        fscanf(fp_mass,"%u %f %*s",&(data[i].index), &(data[i].mass));
    }


    printf("%u %u\n",data[1].index,data[1].ljtype_index);

    FILE *fp_result = fopen("particle.data","w");
    for(int i =0; i<N;i++){
        fprintf(fp_result,"%u %u %f %f %f %f %f %f %f\n",data[i].index, data[i].ljtype_index,data[i].mass,data[i].charge,data[i].epsilon,data[i].sigma,data[i].x,data[i].y,data[i].z);
    }
    fclose(fp_result);


    free(data);

close_fp_sig_epsilon:
    fclose(fp_sig_epsion);
close_fp_mass:
    fclose(fp_mass);
close_fp_type:
    fclose(fp_type);

close_fp_charge:
    fclose(fp_charge);

close_fp_position:
    fclose(fp_position);

out:
    return ret;
}
