#ifndef __UTIL__
#define __UTIL__

#include <stdio.h>

int write_data_to_file(void *data, size_t size, char *file_name);
void dataSwap(uint8_t *data, uint32_t size);

#endif // __UTIL__