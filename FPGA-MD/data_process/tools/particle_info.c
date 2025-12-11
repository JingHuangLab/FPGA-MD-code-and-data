#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "../src/data_preprocess.h"
#include "../src/util.h"

#ifdef SIM
 #include "../src/simulation.h"
#endif




int main(){

    int ret  = 0;

#ifdef SIM
    ret = launch_simulation();
    if(ret <=0) return ret;
#endif

    Particle *p_particle = NULL;
    HC  *p_hc = NULL; 
    CP_Info *p_cpinfo = NULL;
    uint32_t homecell_size = 0;


    ret = data_preprocess(&p_particle, &p_hc, &p_cpinfo, &homecell_size);
    if(ret < 0)
        goto out;

    //Get the number of particles in cell[9]
    uint32_t num = p_cpinfo[9].num;
    printf("The number of particles in cell[9] is : %u\n", num);    
    //write homecell[9] data to a file
    uint8_t *data = ((uint8_t *)p_hc) + 9 * homecell_size;
    write_data_to_file(data, homecell_size, "homecell_9.data");
    
#ifdef SIM

    //write homecell one by one
    for(int i=0; i<CELL_SIZE;++i){
        //swap
        uint8_t *p_homecell = ((uint8_t*)p_hc)+ i * homecell_size;
        dataSwap(p_homecell, homecell_size);
        ret = write_device(DeviceADDR,p_homecell,home_cell_size);
        if(ret < 0) 
            goto freeBuffer;
    }

    uint32_t home_buffer_size = homecell_size * CELL_SIZE;
    uint8_t *host_buffer = (uint8_t *)malloc(home_buffer_size);
    memset(host_buffer, 0, home_buffer_size);

    //read homecell one by one 
    for(int i=0; i<CELL_SIZE;++i){

        uint8_t *p_homecell = host_buffer+ i * homecell_size;
        ret = read_device(DeviceADDR,p_homecell,home_cell_size);
        if(ret < 0) 
            free(host_buffer);
            goto freeBuffer;
    }

    //write homecell[9] data to a file
    uint8_t *p_data = host_buffer + 9 * homecell_size;
    write_data_to_file(p_data, homecell_size, "homecell_9_from_fpga.data");

#endif


free:
    free(p_particle);
    free(p_hc);
    free(p_cpinfo);
out:
#ifdef SIM
    stop_simulation();
#endif
    return ret;

}
