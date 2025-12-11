#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <ctype.h>

#include <sys/types.h>
#include <sys/mman.h>

#include "../include/board.h"

int write_device(uint64_t device_addr, void *host_buffer, uint64_t size )
{
    int fpga_fd = open(H2C_DEVICE_NAME,O_RDWR);
printf("h2c_device_name:%s\n",H2C_DEVICE_NAME);
    if(fpga_fd < 0)
    {
        fprintf(stderr, "%s unable to open device %s\n", __func__, H2C_DEVICE_NAME);
        return -1;
    }

    char *buf= (char*)host_buffer;
    uint64_t offset = device_addr;
    uint64_t count = 0;
    ssize_t rc;
    int err = 0;

    while(count < size){
        uint64_t bytes = size - count;
        if(bytes > RW_MAX_SIZE)
            bytes = RW_MAX_SIZE;

        if(offset){
            rc = lseek(fpga_fd,offset,SEEK_SET);
            if(rc != offset){
                fprintf(stderr, "%s %s, seek off 0x%lx != 0x%lx.\n", __func__,H2C_DEVICE_NAME,rc,offset);
                err = -1;
                goto err_close;
            }
        }

        rc = write(fpga_fd, buf, bytes);
        if (rc < 0) {
			fprintf(stderr, "%s, write 0x%lx @ 0x%lx failed %ld.\n",
				__func__, bytes, offset, rc);
			err = -1;
            goto err_close;

		}

		count += rc;
		if (rc != bytes) {
			fprintf(stderr, "%s, write underflow 0x%lx/0x%lx @ 0x%lx.\n",
				__func__, rc, bytes, offset);
			break;
		}
		buf += bytes;
		offset += bytes;
    }

    if(count != size){
        fprintf(stderr, "%s, write underflow 0x%lx/0x%lx.\n",
				__func__, count, size);
		err = -1;
        goto err_close;
    }

err_close:
    close(fpga_fd);
    return err;
}
int read_device(uint64_t device_addr, void *host_buffer, uint64_t size )
{
    int fpga_fd = open(C2H_DEVICE_NAME,O_RDWR);
    if(fpga_fd < 0)
    {
        fprintf(stderr, "%s unable to open device %s\n", __func__, C2H_DEVICE_NAME);
        return -1;
    }

    char *buf= (char*)host_buffer;
    uint64_t offset = device_addr;
    uint64_t count = 0;
    ssize_t rc;
    int err = 0;

    while(count < size){
        uint64_t bytes = size - count;
        if(bytes > RW_MAX_SIZE)
            bytes = RW_MAX_SIZE;

        if(offset){
            rc = lseek(fpga_fd,offset,SEEK_SET);
            if(rc != offset){
                fprintf(stderr, "%s %s, seek off 0x%lx != 0x%lx.\n", __func__,C2H_DEVICE_NAME,rc,offset);
                err = -1;
                goto err_close;
            }
        }

        rc = read(fpga_fd, buf, bytes);
        if (rc < 0) {
			fprintf(stderr, "%s, write 0x%lx @ 0x%lx failed %ld.\n",
				__func__, bytes, offset, rc);
			err = -1;
            goto err_close;

		}

		count += rc;
		if (rc != bytes) {
			fprintf(stderr, "%s, write underflow 0x%lx/0x%lx @ 0x%lx.\n",
				__func__, rc, bytes, offset);
			break;
		}
		buf += bytes;
		offset += bytes;
    }

    if(count != size){
        fprintf(stderr, "%s, write underflow 0x%lx/0x%lx.\n",
				__func__, count, size);
		err = -1;
        goto err_close;
    }

err_close:
    close(fpga_fd);
    return err;
}
int write_reg(uint64_t reg_addr, void *host_buffer, uint64_t size )
{
    if(size > 4){
        printf("Error: The max length for writing register is 4B\n");
        return -1;
    } 

    int fd = open(REG_DEVICE_NAME,O_RDWR | O_SYNC);
    if(fd < 0 ){
        printf("%s, open device %s failed\n", __func__,REG_DEVICE_NAME);
        return -1;
    }

    int err = 0;
    uint64_t pgsz = sysconf(_SC_PAGE_SIZE);
    uint64_t offset = reg_addr & (pgsz - 1 );
    uint64_t target_aligned = reg_addr & (~(pgsz - 1));
    void *map;

    map = mmap(NULL, offset+4, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target_aligned);
    if (map == (void *)-1) {
		printf("%s Memory 0x%lx mapped failed\n",
			__func__,reg_addr);
		err = -1;
		goto err_close;
	}
   map +=  offset;
    uint32_t value = *(uint32_t *)host_buffer;
    switch(size) {
        case 1:
			printf("Write 8-bits value 0x%02x to 0x%lx (0x%p)\n",
			       value, reg_addr, map);
			*((uint8_t *) map) = value;
			break;
		case 2:
			printf("Write 16-bits value 0x%04x to 0x%lx (0x%p)\n",
			       value, reg_addr, map);
			/* swap 16-bit endianess if host is not little-endian */
			value = htols(value);
			*((uint16_t *) map) = value;
			break;
		case 4:
			printf("Write 32-bits value 0x%08x to 0x%lx (0x%p)\n",
			       value, reg_addr, map);
			/* swap 32-bit endianess if host is not little-endian */
			value = htoll(value);
			*((uint32_t *) map) = value;
			break;
		default:
			fprintf(stderr, "Illegal data length %lu.\n",
				size);
			err = -1;
			goto err_unmap;
    }

err_unmap:
    map -= offset;
    if(munmap(map,offset+4) == -1){
        printf("%s Memory 0x%lx mapped failed.\n",__func__,reg_addr);
    }
err_close:
    close(fd);
    return err;
}
int read_reg(uint64_t reg_addr, void *host_buffer, uint64_t size )
{
    if(size > 4){
        printf("Error: The max length for writing register is 4B\n");
        return -1;
    } 

    int fd = open(REG_DEVICE_NAME,O_RDWR | O_SYNC);
    if(fd < 0 ){
        printf("%s, open device %s failed\n", __func__,REG_DEVICE_NAME);
        return -1;
    }

    int err = 0;
    uint64_t pgsz = sysconf(_SC_PAGE_SIZE);
    uint64_t offset = reg_addr & (pgsz - 1 );
    uint64_t target_aligned = reg_addr & (~(pgsz - 1));
    void *map;

    map = mmap(NULL, offset+4, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target_aligned);
    if (map == (void *)-1) {
		printf("%s Memory 0x%lx mapped failed\n",
			__func__,reg_addr);
		err = -1;
		goto err_close;
	}
    map += offset;
    uint32_t read_result;
    switch(size) {
        case 1:
            read_result = *((uint8_t *) map);
			printf("Read 8-bits value at address 0x%lx (%p): 0x%02x\n",
			     reg_addr, map, read_result);
			break;
		case 2:
			read_result = *((uint16_t *) map);
			/* swap 16-bit endianess if host is not little-endian */
			read_result = ltohs(read_result);
			printf
			    ("Read 16-bit value at address 0x%lx (%p): 0x%04x\n",
			     reg_addr, map, read_result);
			break;
		case 4:
			read_result = *((uint32_t *) map);
			/* swap 32-bit endianess if host is not little-endian */
			read_result = ltohl(read_result);
			printf
			    ("Read 32-bit value at address 0x%lx (%p): 0x%08x\n",
			     reg_addr, map, read_result);
			break;
		default:
			fprintf(stderr, "Illegal data length %lu.\n",
				size);
			err = -1;
			goto err_unmap;
    }

    *(uint32_t *)host_buffer = read_result;

err_unmap:
    map -= offset;
    if(munmap(map,offset+4) == -1){
        printf("%s Memory 0x%lx mapped failed.\n",__func__,reg_addr);
    }
err_close:
    close(fd);
    return err;
}
