#ifndef __DATA_PREPROCESS_H__
#define __DATA_PREPROCESS_H__

#include <stdint.h>

#define WIDTH       64          //64B,512bit
#define N           18800      // num of particles
#define X           10          // length of X dimension
#define Y           10          // length of Y dimension
#define Z           10         // length of Z dimension
#define X_SIZE      10          // size of every lengh of X dimension
#define Y_SIZE      10          // size of every lengh of Y dimension
#define Z_SIZE      10          // size of every lengh of Z dimension
#define CELL_SIZE  (X*Y*Z)     
#define Three2One(a,b,c)        (a*Y*Z+b*Z+c)
#define NC_NUM      27
#define DeviceADDR  0           //device address for storing homecell information
#define HC_FLAG     0xAA
#define NC_FLAG     0xCC
#define SEP_FLAG    0xDD
#define END_FLAG    0xBB
//#define MAX_HC_NUM  (2*(N/CELL_SIZE+28))    //for convenience, max particle number of one homecell  is fixed value;
#define MAX_HC_NUM  200  //for convenience, max particle number of one homecell  is fixed value;
#define NC_X(a,b)   ((a+b+X) % X )
#define NC_Y(a,b)   ((a+b+Y) % Y )
#define NC_Z(a,b)   ((a+b+Z) % Z )

typedef struct particle_info {
    union {
        uint32_t     index;
        struct {
            uint32_t     label : 8;
            uint32_t     sub_index : 24;
        }header;
    }u;

    uint8_t     sub_x;
    uint8_t     sub_y;
    uint8_t     sub_z;
    uint8_t     ljtype_index;
    float       mass;
    float       x;
    float       y;
    float       z;
    float       Vx;
    float       Vy;
    float       Vz;
    float       charge;
    float       epsilon;
} __attribute__((packed)) Info;

#define Label       u.header.label
#define Index       u.index
#define Sub_index   u.header.sub_index

typedef union Particle {
    Info        info; 
    uint8_t     data[WIDTH];
}Particle __attribute__((aligned(64)));

typedef struct NeighborCellInfo{
    uint8_t     label;
    uint8_t     sub_x;
    uint8_t     sub_y;
    uint8_t     sub_z;
    uint32_t    cell_index;
}__attribute__((packed)) NC_Info;

typedef union NC {
    NC_Info     nc_info;
    uint8_t     data[WIDTH];
}NC __attribute__((aligned(64)));

typedef struct HomeCell {
    NC          nc[NC_NUM];
    uint8_t     sep[WIDTH];
    Particle    particle[0];
}__attribute__((packed)) HC;


typedef struct CellParticleInfo{
    uint32_t    num;
    uint32_t    index[MAX_HC_NUM];
}CP_Info;

typedef struct ResultParticleInfo{
    uint32_t    index;
    float       energy;
    float       force_x;
    float       force_y;
    float       force_z;
    float       Vx;
    float       Vy;
    float       Vz;
    float       x;
    float       y;
    float       z;
    float       mass;
    uint8_t     sub_x;
    uint8_t     sub_y;
    uint8_t     sub_z;
}__attribute__((packed))RP_Info;

typedef union ResultParticle{
    RP_Info     Info;
    uint8_t     data[WIDTH];  
}ResultParticle __attribute__((aligned(64)));


int data_preprocess(Particle **p_particle, HC  **p_hc, CP_Info **p_cpinfo, uint32_t *size);

#endif  //__DATA_PREPROCESS_H__

