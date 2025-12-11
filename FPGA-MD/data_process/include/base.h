#ifndef __BASE_H__
#define __BASE_H__

#define OK              0

#define ON_NON_ZERO_GOTO(res, label, desc)     \
    do{                                     \
        if((res) != OK){                    \
            printf("Error: %s\n",desc);     \
            goto label;                     \
        }                                   \
    }while(0)


#define ON_ZERO_GOTO(res, label, desc)     \
    do{                                     \
        if((res) == NULL){                    \
            printf("Error: %s\n",desc);     \
            ret = -1;                       \
            goto label;                     \
        }                                   \
    }while(0)


#ifdef DEBUG
#define PRINT_FLOAT(data, length)   { \
    for(int i=0;i<=length;i++){ \
        printf("%10.10f   ", data[i]);   \
        if( i!=0 && i%10 == 0) printf("\n");\
    } \
    printf("\n");   \
}
#else
#define PRINT_FLOAT(data, length)
#endif  //DEBUG

 #endif //__BASE_H__