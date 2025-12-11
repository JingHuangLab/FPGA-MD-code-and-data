`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:27:09 PM
// Design Name: 
// Module Name: Angle_Cal_Top
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


module Angle_Cal_Top(
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
  
 input     [31:0]          KThate,
 input     [31:0]          Thate0,     
 
 input     [31:0]          R2_Root 
 
    );
    
 floating_point_SUB     U_FP_Thate_Sub_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Thate_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Thate_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Thate_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready           ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Thate_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Thate_Sub_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Thate_Sub_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
  floating_point_MUL    U_FP_KThate_MUl_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (KThate_MUl_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (KThate_MUl_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (KThate_MUl_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (KThate_MUl_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (KThate_MUl_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (KThate_MUl_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
         
 floating_point_ADD     U_FP_Angle_Add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Angle_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Angle_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Angle_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Angle_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Angle_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Angle_Add_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
     
        
    
    
 Angle_Cal(
.      Sys_Clk         (     Sys_Clk         ),
.      Sys_Rst_n       (     Sys_Rst_n       ),
 
.       KThate         (      KThate         ),
.       Thate0         (      Thate0         ),     
 
.       R2_Root        (      R2_Root        ),

.   Thate_Sub_A_out    (  Thate_Sub_A_out    ),
.   Thate_Sub_A_Vil    (  Thate_Sub_A_Vil    ),
.   Thate_Sub_B_Vil    (  Thate_Sub_B_Vil    ),
.   Thate_Sub_B_out    (  Thate_Sub_B_out    ),
.   Thate_Sub_get_r    (  Thate_Sub_get_r    ),
.   Thate_Sub_get_vil  (  Thate_Sub_get_vil  ),

.   KThate_MUl_A_out   (  KThate_MUl_A_out   ),
.   KThate_MUl_A_Vil   (  KThate_MUl_A_Vil   ),
.   KThate_MUl_B_Vil   (  KThate_MUl_B_Vil   ),
.   KThate_MUl_B_out   (  KThate_MUl_B_out   ),
.   KThate_MUl_get_r   (  KThate_MUl_get_r   ),
.   KThate_MUl_get_vil (  KThate_MUl_get_vil ),

.   Angle_Add_A_out    (  Angle_Add_A_out    ),
.   Angle_Add_A_Vil    (  Angle_Add_A_Vil    ),
.   Angle_Add_B_Vil    (  Angle_Add_B_Vil    ),
.   Angle_Add_B_out    (  Angle_Add_B_out    ),
.   Angle_Add_get_r    (  Angle_Add_get_r    ),
.   Angle_Add_get_vil  (  Angle_Add_get_vil  )
 
    );   
endmodule
