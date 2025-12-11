#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "../include/base.h"
#include "../include/data_preprocess.h"

#define  L          100
#define HALF_L      (L/2)
#define A_COFF      40000
#define B_COFF      50000
#define R_CUTOFF    144

int main(){

    int ret = OK;
    float energy = 0.0;
    float dx = 0.0;
    float dy = 0.0;
    float dz = 0.0;
    float r = 0.0;

    //1.Read file and get particle data

    Particle *particle_buffer = (Particle *)malloc(sizeof(Particle) * N);
    ON_ZERO_GOTO(particle_buffer,out,"Allocate particle buffer failed");
    memset(particle_buffer, 0, sizeof(Particle)*N);

    ret = get_particle_data(particle_buffer);
    ON_NON_ZERO_GOTO(ret,clean_particle_buffer,"Get particle data failed");

    float *lj_energy = (float*)malloc(sizeof(float)*N);
    ON_ZERO_GOTO(lj_energy,clean_particle_buffer,"Allocate lj_energy buffer failed");
    memset(lj_energy,0,sizeof(float)*N);

    for(int i=0;i<N;i++){
        energy = 0.0;
        for(int j=0;j<N;j++){

            if(i == j) continue;

            dx = particle_buffer[i].info.x - particle_buffer[j].info.x;
            dy = particle_buffer[i].info.y - particle_buffer[j].info.y;
            dz = particle_buffer[i].info.z - particle_buffer[j].info.z;

            if(dx > HALF_L) dx -=L;
            else if (dx < -HALF_L) dx+=L;

            if(dy > HALF_L) dy -=L;
            else if (dy < -HALF_L) dy+=L;

            if(dz > HALF_L) dz -=L;
            else if (dz < -HALF_L) dz+=L;

            r = dx*dx + dy*dy + dz*dz;

            if(r > R_CUTOFF) continue;

            energy += A_COFF*pow(r,-12) - B_COFF*pow(r,-6);
        }
        lj_energy[i] = energy;
    }

    PRINT_FLOAT(lj_energy,N);

clean_lj_energy:
    free(lj_energy);

clean_particle_buffer:
    free(particle_buffer);

out:
    return ret;
}