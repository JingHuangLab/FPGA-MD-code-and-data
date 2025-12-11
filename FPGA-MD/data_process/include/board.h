#ifndef __BOARD__
#define __BOARD__

#include <stdint.h>

/* ltoh: little endian to host */
/* htol: host to little endian */
#if __BYTE_ORDER == __LITTLE_ENDIAN
#define ltohl(x)       (x)
#define ltohs(x)       (x)
#define htoll(x)       (x)
#define htols(x)       (x)
#elif __BYTE_ORDER == __BIG_ENDIAN
#define ltohl(x)     __bswap_32(x)
#define ltohs(x)     __bswap_16(x)
#define htoll(x)     __bswap_32(x)
#define htols(x)     __bswap_16(x)
#endif

#define H2C_DEVICE_NAME  "/dev/xdma0_h2c_0"
#define C2H_DEVICE_NAME  "/dev/xdma0_c2h_0"
#define REG_DEVICE_NAME  "/dev/xdma0_user"
#define RW_MAX_SIZE      0x7ffff000

int write_device(uint64_t device_addr, void *host_buffer, uint64_t size );
int read_device(uint64_t device_addr, void *host_buffer, uint64_t size);
int write_reg(uint64_t reg_addr, void *host_buffer, uint64_t size );
int read_reg(uint64_t reg_addr, void *host_buffer, uint64_t size );

#endif 