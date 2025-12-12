# FPGA MD code and data
This repository holds the implementation and simulation inputs scripts as well 
as some results for the papar "Molecular Dynamics Simulations Accelerated on 
FPGA with High-Bandwidth Memory".

## Hardware Requirements
 - Inspur F37X FPGA card 

## OS Required & Software Dependencies
 - CentOS 7 (Kernal version 3.10.0)
 - Vivado 2021.2
 - GNU compiler >= 8.3.0
 - OpenMM >= 6.0.0
 - MDTraj
 - ...

## Build Instructions
### C code: Use the Makefile in the tools to build the code.

### VHDL and Verilog: Use Vivado to build the project.
...

## Simulation inputs and outputs 
Simulation inputs, outputs, analysis scripts are given in the `simulations` 
folder.   
Further descriptions of these files are given in the `README` there.  
Large size trajectories are provided at Zenodo:   
[MD Validation inputs and trajectories for "Molecular Dynamics Simulations Accelerated on FPGA with High-Bandwidth Memory"](https://doi.org/10.5281/zenodo.17796179)
.
