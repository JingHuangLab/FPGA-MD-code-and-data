`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2023 09:39:19 AM
// Design Name: 
// Module Name: Neighbor_ACC_Top
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


module Neighbor_ACC_Top(
 input                   Sys_Clk  ,
 input                   Sys_Rst_n ,
 input   [31:0]          Refer_Index, 
 output   reg [159:0]    Fx_Nei_out  ,
 output   reg [159:0]    Fy_Nei_out  ,
 output   reg [159:0]    Fz_Nei_out   
 
    );
    floating_point_ADD     U_FP_Fx_Nei_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fx_Nei_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fx_Nei_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fx_Nei_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fx_Nei_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fx_Nei_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fx_Nei_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

      floating_point_ADD     U_FP_Fy_Nei_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fy_Nei_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fy_Nei_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fy_Nei_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fy_Nei_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fy_Nei_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fy_Nei_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
    floating_point_ADD     U_FP_Fz_Nei_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fz_Nei_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fz_Nei_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fz_Nei_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fz_Nei_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fz_Nei_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fz_Nei_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
  
    
    
    
    
    Neighbor_ACC U_Neighbor_ACC(
 
. Sys_Clk              (Sys_Clk              )  ,
. Sys_Rst_n            (Sys_Rst_n            )  ,
                
. Fx_Nei_out          (Fx_Nei_out          ) ,
. Fy_Nei_out          (Fy_Nei_out          ) ,
. Fz_Nei_out          (Fz_Nei_out          ) ,
                       
.    S_AXIS_ram_Rd_addr(   S_AXIS_ram_Rd_addr) , 
.    S_AXIS_ram_rd_data(   S_AXIS_ram_rd_data) ,
                     
.      Fx_Nei_A_out   (     Fx_Nei_A_out   )  ,
.      Fx_Nei_A_Vil   (     Fx_Nei_A_Vil   )  ,
.      Fx_Nei_B_Vil   (     Fx_Nei_B_Vil   )  ,
.      Fx_Nei_B_out   (     Fx_Nei_B_out   )  ,
.      Fx_Nei_get_r   (     Fx_Nei_get_r   )  ,
.      Fx_Nei_get_vil (     Fx_Nei_get_vil ) ,
                       
.      Fy_Nei_A_out   (     Fy_Nei_A_out   ) ,          
.      Fy_Nei_A_Vil   (     Fy_Nei_A_Vil   ) ,     
.      Fy_Nei_B_Vil   (     Fy_Nei_B_Vil   ) ,
.      Fy_Nei_B_out   (     Fy_Nei_B_out   ) ,
.      Fy_Nei_get_r   (     Fy_Nei_get_r   ) ,
.      Fy_Nei_get_vil (     Fy_Nei_get_vil ) ,
                      
.     Fz_Nei_A_out    (    Fz_Nei_A_out    ) ,
.     Fz_Nei_A_Vil    (    Fz_Nei_A_Vil    ) ,
.     Fz_Nei_B_Vil    (    Fz_Nei_B_Vil    ) ,
.     Fz_Nei_B_out    (    Fz_Nei_B_out    ) ,
.     Fz_Nei_get_r    (    Fz_Nei_get_r    ) ,
.     Fz_Nei_get_vil  (    Fz_Nei_get_vil  )
    );
    
    
   Rd_cotr U_Rd_cotr(
             . Sys_Clk                (Sys_Clk                  )    ,
             . Sys_Rst_n              (Sys_Rst_n                )    ,              
                                     
             . Rd_cotr_en             (Rd_cotr_en               )    ,//when new cell position updata
             . Home_Rd_finish         (Home_Rd_finish           )    ,
                                      
             . M_AXIS_NeiRam_rd_Addr (M_AXIS_NeiRam_rd_Addr   )    ,
             . S_AXIS_NeiRam_tData   (S_AXIS_NeiRam_tData     )    ,                        
                                     
             . M_AXIS_X_Pos_buf       (M_AXIS_X_Pos_buf         )    ,
             . M_AXIS_Y_Pos_buf       (M_AXIS_Y_Pos_buf         )    ,
             . M_AXIS_Z_Pos_buf       (M_AXIS_Z_Pos_buf         )    ,     
             . M_AXIS_Index_buf       (M_AXIS_Index_buf         )    ,              
                                     
             . Get_XYZ                (Get_XYZ                  )     //                          
                                                            //  compare module ask xyz                                                                
    );
         
    
    
endmodule
