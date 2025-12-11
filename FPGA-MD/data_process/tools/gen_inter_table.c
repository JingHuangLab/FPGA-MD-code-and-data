#include <stdio.h>
#include <math.h>
#include "../src/multinomial.h"


void print_coef(MATRIX_TYPE *data, int num, int order){
    for(int i=0;i<num;i++){
        for(int j=0;j<=order;j++){
            printf("%10.12f ", *(data + i*(order+1)+j));
        }
        printf("\n");
    }
}

void inter_compute(MATRIX_TYPE start, MATRIX_TYPE end, int num, int exp, int order){
    MATRIX_TYPE *part_x = fun_partition(start,end,num);
    MATRIX_TYPE *part_y = power_function(part_x,num,exp);
    MATRIX_TYPE *part_yd = dhs(part_x,num,exp);

    //PRINT(part_x,num);
    //PRINT(part_y, num);
    //PRINT(part_yd, num);


    MATRIX_TYPE *coef_lookup_table = (MATRIX_TYPE *)malloc(sizeof(MATRIX_TYPE)*num*(order+1));
    if(!coef_lookup_table) {
        printf("Error: alloc coef_lookup_table failed\n");
        goto free_part1;
    }

    memset(coef_lookup_table,0,num*(order+1)*sizeof(MATRIX_TYPE));

    MATRIX_TYPE *result = (MATRIX_TYPE *)malloc(sizeof(MATRIX_TYPE)*(order+1));

    memset(result,0,(order+1)*sizeof(MATRIX_TYPE));
    
    for(int j=0;j<num;j++){
        get_polynominal_abcd(construct_a(order,part_x[j],part_x[j+1]),
                            construct_b(order,part_y[j],part_y[j+1],part_yd[j],part_yd[j+1]),result);

        for(int i = 0; i<=order;i++){
        *(coef_lookup_table+j*(order+1)+i) = result[i]; 
        }
    }

    printf("系数表：\n");
    print_coef(coef_lookup_table,num,order);

free_part:
    free(coef_lookup_table);
free_part1:
    free(part_x);
    free(part_y);
    free(part_yd);
}


int main(){

   
    // printf("x^-7 function interpolation table: x[0.1,144]\n");
    // inter_compute(0.1,144,8*128,-7,2);

    printf("x^-4 function interpolation table: x[0.1,144]\n");
    inter_compute(0.1,144,8*128,-4,2);

    // printf("x^-1.5 function interpolation table: x[0.1,144]\n");
    // inter_compute(0.1,144,8*128,-1.5,2);


    return 0;
    
}