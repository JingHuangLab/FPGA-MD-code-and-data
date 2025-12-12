# FPGA workflow 

data_process: C code for data_process and MD

md-uni-fpga-dev: hardware design code

## Instruction for F37X FPGA

 - Step1
    Insert the F37X into PCIe X8 or X16 slot according to the server's 
    relevant usage.
    Then check if the system has detected the board card by:
    ```bash
    lspci -vvd 1bd4
    ```
    If information is printed, it proves successful identification of the board card.
 - Step2
    Install the drivers:
    ```bash
    git clone https://github.com/Xilinx/dma_ip_drivers
    cd dma_ip_drivers/XDMA/linux-kernel/xdma
    # Configure the driver required for XDMA.
    sudo insmod xdma.ko
    ```
 - Step3
    Configure HBM2 in Vivado 2021.2 compilation environment and allocate a 512 MB region.
    The total HBM address space typically ranges from 0x0000_0000 to 0x8000_0000 (i.e., 0 to 32 GB). 
    This entire space is divided into 512 MB segments. 
    The hbm_ctrl_0/S_AXI interface is mapped to the first 512 MB segment, from address 0x0000_0000 to 0x2000_0000.
    

 - Step4
    Compile and programming the Verilog program.
    ```bash
        cd FPGA-MD\md-uni-fpga-dev\bitsteam
    ```
 - Step5
    ```bash
    export PARTICLE_FILE_NAME=./ar.xyz
    make md_sim
    ./md_sim
    ```

