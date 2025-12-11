#ifndef _MULTINOMIA_H_
#define _MULTINOMIA_H_

#include "./matrix.h"

MATRIX_TYPE *fun_partition(MATRIX_TYPE start, MATRIX_TYPE end, int num);
MATRIX_TYPE *power_function(MATRIX_TYPE *data, int num,int exp);
MATRIX_TYPE *dhs(MATRIX_TYPE *data, int num,int exp);
Matrix *construct_a(int order, MATRIX_TYPE x0, MATRIX_TYPE x1);
Matrix *construct_b(int order,MATRIX_TYPE y0, MATRIX_TYPE y1, MATRIX_TYPE y2, MATRIX_TYPE y3);
void get_polynominal_abcd(Matrix *a, Matrix *b, MATRIX_TYPE *result);

#endif
