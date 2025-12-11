#ifndef __COEF_H__
#define __COEF_H__

#include <stdint.h>


#define NUM_TYPES   27
//#define DATA_TYPE   double
//#define FOMAT_STRING "%lf"

#define DATA_TYPE   float
#define FOMAT_STRING "%f"

typedef struct TypeCharge{
    uint32_t  set;
    float    charge;
}TypeCharge;


typedef struct coef_entry {
    uint32_t combined_index;
    DATA_TYPE   a_coef;
    DATA_TYPE   b_coef; 
    //DATA_TYPE   qq_ab;
}coef_entry;

#endif  //__COEF_H__