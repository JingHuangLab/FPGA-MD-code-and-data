`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 12:13:29 AM
// Design Name: 
// Module Name: XYZ_Thate_Top
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


module XYZ_Thate_Top(

    );
    
     XYZ_Thate U_XYZ_Thate(
.    Sys_Clk               ( Sys_Clk               ) ,
.    Sys_Rst_n             ( Sys_Rst_n             ) ,
.    XYZ_Cos_done          ( XYZ_Cos_done          ) , 
 
.    Index_bond_A_in       ( Index_bond_A_in       ) ,
.    Index_bond_A_en       ( Index_bond_A_en       ) ,
.    Index_bond_B_in       ( Index_bond_B_in       ) ,
.    Index_bond_B_en       ( Index_bond_B_en       ) ,
.    Index_bond_C_in       ( Index_bond_C_in       ) ,
.    Index_bond_C_en       ( Index_bond_C_en       ) ,
 
.    Home0_cell_cal_finish ( Home0_cell_cal_finish )  ,
.    XYZ_Cos               ( XYZ_Cos               )  ,
 
.   Point_MUL_A_out        (Point_MUL_A_out        )  ,
.   Point_MUL_A_Vil        (Point_MUL_A_Vil        )  ,
.   Point_MUL_B_Vil        (Point_MUL_B_Vil        )  ,
.   Point_MUL_B_out        (Point_MUL_B_out        )  ,
.   Point_MUL_get_r        (Point_MUL_get_r        )  ,
.   Point_MUL_get_vil      (Point_MUL_get_vil      )    ,
 
.   Cos_DIR_A_out          (Cos_DIR_A_out          )   ,
.   Cos_DIR_A_Vil          (Cos_DIR_A_Vil          )   ,
.   Cos_DIR_B_Vil          (Cos_DIR_B_Vil          )   ,
.   Cos_DIR_B_out          (Cos_DIR_B_out          )   ,
.   Cos_DIR_get_r          (Cos_DIR_get_r          )   ,
.   Cos_DIR_get_vil        (Cos_DIR_get_vil        )   ,
 
.   XYZ_Cos_A_out          (XYZ_Cos_A_out          )  ,  //cos(n * fai -sigma) 
.   XYZ_Cos_A_Vil          (XYZ_Cos_A_Vil          )  ,   
.   XYZ_Cos_get_r          (XYZ_Cos_get_r          )  ,  
.   XYZ_Cos_get_vil        (XYZ_Cos_get_vil        )
 

     );
     // ---------------------------------------- ---
endmodule
