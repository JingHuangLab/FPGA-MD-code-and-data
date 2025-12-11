`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 01:33:25 AM
// Design Name: 
// Module Name: Bond_module_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bond_module_Top(
 input                       Sys_Clk  ,
 input                       Sys_Rst_n,
 input       [31:0]          Root_R   ,
 input       [31:0]          B0       ,
 input       [31:0]          KB       ,
 output wire [31:0]          B_Add_BUF 
    );
    
        
Bond_cal_Top U_Bond_cal_Top (
.  Sys_Clk            (Sys_Clk             )   ,
.  Sys_Rst_n          (Sys_Rst_n           )   ,
.  R2_Root            (Root_R              )   ,
.  B0                 (B0                  )   ,
.  KB                 (KB                  )   ,
.  B_Add_BUF          (B_Add_BUF           ) 
    );
    
XYZ_R_TOP  U_XYZ_R_TOP(
.  Sys_Clk            (Sys_Clk             ) ,
.  Sys_Rst_n          (Sys_Rst_n           ) ,
                   
.  Index_bond_A_in    (Index_bond_A_in     ), 
.  Index_bond_B_in    (Index_bond_B_in     ),
.  Index_bond_A_en    (Index_bond_A_en     ), //enable
.  Index_bond_B_en    (Index_bond_B_en     ), //enable
.  R_cal_finish       (R_cal_finish        ), // all bond finish
.  Root_R             (Root_R              ) 
    );
    
endmodule
