# Scripts and coordinates of input, results
For the `cpu_results`, `fpga_results`, `gpu_results_single` and `gpu_results`, 
calculation `inputs`, `force field files`, `outputs` are given.  
In the `md` folder, `inputs` for `gpu_sp`, `gpu_dp` and `fpga` are given.   
In the `md/results` folder, figures for total energy, kinetic energy and
potential energy as well as RMSD are given along with the plot scripts.  
In the `plot` folder, the scripts for ploting analytic (LJ) results are given.

```
├── cpu_results
│   └── energy_force_test
│       ├── analytical
│       ├── argon
│       └── dhfr_amber
├── fpga_results
│   └── energy_force_test
│       ├── analytical
│       ├── argon
│       └── dhfr_charmm
├── gpu_results
│   └── energy_force_test
│       ├── analytical
│       ├── argon
│       └── dhfr_amber
├── gpu_results_single
│   └── energy_force_test
│       ├── analytical
│       ├── argon
│       └── dhfr_amber
├── md
│   ├── dhfr.pdb
│   ├── fpga
│   ├── gpu_dp
│   ├── gpu_sp
│   └── results
└── plot
```
