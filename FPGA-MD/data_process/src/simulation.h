#ifndef __SIMULATION__
#define __SIMULATION__

#include "xrt.h"
#include "xrt_mem.h"

int lanuch_simulation();
void stop_simulation();
int write_device(uint64_t device_addr, void *host_buffer, uint64_t size );
int read_device(uint64_t device_addr, void *host_buffer, uint64_t size);
int write_reg(uint64_t reg_addr, void *host_buffer, uint64_t size );
int read_reg(uint64_t reg_addr, void *host_buffer, uint64_t size );

#endif //__SIMULATION__