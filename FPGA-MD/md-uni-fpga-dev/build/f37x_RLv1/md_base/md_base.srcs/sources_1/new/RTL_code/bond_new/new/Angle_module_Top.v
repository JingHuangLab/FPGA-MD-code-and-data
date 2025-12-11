`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 01:37:41 AM
// Design Name: 
// Module Name: Angle_module_Top
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


module Angle_module_Top(
 input                       Sys_Clk  ,
 input                       Sys_Rst_n 

    );
    
     Angle_Cal_Top U_Angle_Cal_Top(
.      Sys_Clk         (     Sys_Clk         ),
.      Sys_Rst_n       (     Sys_Rst_n       ) 
);

     XYZ_Mod_Top U_XYZ_Mod_Top(
.      Sys_Clk         (     Sys_Clk         ),
.      Sys_Rst_n       (     Sys_Rst_n       ) 
);

     XYZ_Point_Mul_Top U_XYZ_Point_Mul_Top(
.      Sys_Clk         (     Sys_Clk         ),
.      Sys_Rst_n       (     Sys_Rst_n       ) 
);


     XYZ_Thate_Top U_XYZ_Thate_Top(
.      Sys_Clk         (     Sys_Clk         ),
.      Sys_Rst_n       (     Sys_Rst_n       ) 
);

endmodule
