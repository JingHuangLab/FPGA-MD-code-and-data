#include "multinomial.h"

MATRIX_TYPE *fun_partition(MATRIX_TYPE start, MATRIX_TYPE end, int num){
    MATRIX_TYPE delta = (end - start) / num;
    MATRIX_TYPE *data = (MATRIX_TYPE*)malloc(sizeof(MATRIX_TYPE)*(num+1));
    for(int i=0;i<=num;i++){
        data[i] = start + i*delta;
    }
    return data;
}

MATRIX_TYPE *power_function(MATRIX_TYPE *data, int num,int exp){
    MATRIX_TYPE *part_y = (MATRIX_TYPE*)malloc(sizeof(MATRIX_TYPE)*(num+1));
    for(int i=0;i<=num;i++){
        part_y[i] = pow(data[i],exp); 
    }
    return part_y;
}

MATRIX_TYPE *dhs(MATRIX_TYPE *data, int num,int exp){
    MATRIX_TYPE *part_yd = (MATRIX_TYPE*)malloc(sizeof(MATRIX_TYPE)*(num+1));
    for(int i=0;i<=num;i++){
        part_yd[i] = (exp)*pow(data[i],exp-1); 
    }
    return part_yd;
}


Matrix *construct_a(int order, MATRIX_TYPE x0, MATRIX_TYPE x1){

    if(order<=0 || order>3){
        printf("Error: Order only support 1,2,3\n");
        return NULL;
    }

    Matrix *a = M_Zeros(order+1,order+1);
    if(order == 3){
        a->data[0] = pow(x0,3);
        a->data[1] = pow(x0,2);
        a->data[2] = x0;
        a->data[3] = 1;
        a->data[4] = 3*pow(x0,2);
        a->data[5] = 2*x0;
        a->data[6] = 1;
        a->data[7] = 0;
        a->data[8] = pow(x1,3);
        a->data[9] = pow(x1,2);
        a->data[10] = x1;
        a->data[11] = 1;
        a->data[12] = 3*pow(x1,2);
        a->data[13] = 2*x1;
        a->data[14] = 1;
        a->data[15] = 0;
    }
    else if(order == 2){
        a->data[0] = pow(x0,2);
        a->data[1] = x0;
        a->data[2] = 1;
        a->data[3] = 2*x0;
        a->data[4] = 1;
        a->data[5] = 0;
        a->data[6] = pow(x1,2);
        a->data[7] = x1;
        a->data[8] = 1;
    }
    else{
        a->data[0] = x0;
        a->data[1] = 1;
        a->data[2] = 1;
        a->data[3] = 0;
    }
    return a;
}


Matrix *construct_b(int order,MATRIX_TYPE y0, MATRIX_TYPE y1, MATRIX_TYPE y2, MATRIX_TYPE y3){

    if(order<=0 || order>3){
        printf("Error: Order only support 1,2,3\n");
        return NULL;
    }

    Matrix *b = M_Zeros(1,order+1);
    if(order == 3){
        b->data[0] = y0;
        b->data[1] = y2;
        b->data[2] = y1;
        b->data[3] = y3;
    }
    else if(order == 2){
        b->data[0] = y0;
        b->data[1] = y2;
        b->data[2] = y1;
    }
    else{
        b->data[0] = y0;
        b->data[1] = y1;
    }
    
    return b;
}

void get_polynominal_abcd(Matrix *a, Matrix *b, MATRIX_TYPE *result){

    for(int i=0;i<a->column;++i){
        Matrix *a_copy = Matrix_copy(a);
        for(int j=0;j<a->row;++j){
            a_copy->data[j*(a->column) + i] = b->data[j];
        }
        
        result[i] = M_det(a_copy) / M_det(a);
        M_free(a_copy);
    }
    M_free(a);
    M_free(b);
}

