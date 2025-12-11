#include "simulation.h"

xclDeviceHandle d_handle;

int launch_simulation(){
    int ret = 0;

    int count = xclProbe();
	printf("found %d device\n",count);
    if(count <=0) return -1;

	d_handle = xclOpen(0,NULL,0);
	if(d_handle){
		printf("Success:open device\n");
	}
	else{
        ret = -1;
		printf("Failed: open device\n");
        goto out;
	}

	int result = xclLoadXclBin(d_handle, NULL);
	if(!result) {
		printf("Success: start Simulation\n");
	}
	else {
        ret = -1;
		printf("Failed: start simulation\n");
		goto close;
	}

    return ret;

close:
    xclClose(d_handle);
out:
    return ret;
}

void stop_simulation(){
    xclClose(d_handle);
}

int write_device(uint64_t device_addr, void *host_buffer, uint64_t size ){
    
    int ret  = 0;
    if(size == 0)
        return ret;
    ret = xclWrite(d_handle, XCL_ADDR_SPACE_DEVICE_RAM, device_addr, host_buffer, size);
	if(result ==size) {
		printf("Success: Write data to device %p\n", device_addr);
	}
	else
	{
        ret = -1;
		printf("Failed: Write data to device %p\n", device_addr);
	}
    return ret;
}

int read_device(uint64_t device_addr, void *host_buffer, uint64_t size ){
    
    int ret  = 0;
    if(size == 0)
        return ret;
    ret = xclRead(d_handle, XCL_ADDR_SPACE_DEVICE_RAM, device_addr, host_buffer, size);
	if(result ==size) {
		printf("Success: Read device %p data to host\n", device_addr);
	}
	else
	{
        ret = -1;
		printf("Failed: Read device %p data to host\n"), device_addr;
	}
    return ret;
}

int write_reg(uint64_t reg_addr, void *host_buffer, uint64_t size ){
    
    int ret  = 0;
    if(size == 0)
        return ret;
    ret = xclWrite(d_handle, XCL_ADDR_KERNEL_CTRL, reg_addr, host_buffer, size);
	if(result ==size) {
		printf("Success: Write data to reg %p\n", reg_addr);
	}
	else
	{
        ret = -1;
		printf("Failed: Write data to reg %p\n", reg_addr);
	}
    return ret;
}

int read_reg(uint64_t reg_addr, void *host_buffer, uint64_t size ){
    
    int ret  = 0;
    if(size == 0)
        return ret;
    ret = xclRead(d_handle, XCL_ADDR_KERNEL_CTRL, reg_addr, host_buffer, size);
	if(result ==size) {
		printf("Success: Read reg %p data to host\n",reg_addr);
	}
	else
	{
        ret = -1;
		printf("Failed: Read reg %p data to host\n", reg_addr);
	}
    return ret;
}

