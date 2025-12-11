`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2023 07:16:50 PM
// Design Name: 
// Module Name: Bond_ACC_TOP
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


module Bond_ACC_TOP(
  input                     Sys_Clk  ,
  input                     Sys_Rst_n, 
  
 input       [31:0]         B_Add_BUF           ,
 input       [31:0]         Dih_Add_BUF         ,
 input       [31:0]         Angle_Add_BUF       ,
 input       [31:0]         Impropers_Add_BUF   ,
 output wire  [31:0]        Bond_Force 
    );
    
     floating_point_ADD     U_FP_ADD_Bond_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (ADD_Bond_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (ADD_Bond_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (ADD_Bond_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (ADD_Bond_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (ADD_Bond_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (ADD_Bond_get_r)         // output wire [31 : 0] m_axis_result_tdata
);

 floating_point_ADD     U_FP_IM_ADD_DI_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (IM_ADD_DI_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (IM_ADD_DI_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (IM_ADD_DI_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (IM_ADD_DI_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (IM_ADD_DI_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (IM_ADD_DI_get_r)         // output wire [31 : 0] m_axis_result_tdata
);

 floating_point_ADD     U_FP_B_ADD_A_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (B_ADD_A_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (B_ADD_A_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (B_ADD_A_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (B_ADD_A_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (B_ADD_A_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (B_ADD_A_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
    
    
    
    
    
 Bond_ACC U_Bond_ACC(
.     Sys_Clk           (      Sys_Clk        ),
.     Sys_Rst_n         (      Sys_Rst_n      ), 
 
.     B_Add_BUF         (    B_Add_BUF        ) ,
.     Dih_Add_BUF       (    Dih_Add_BUF      ) ,
.     Angle_Add_BUF     (    Angle_Add_BUF    ) ,
.     Impropers_Add_BUF (    Impropers_Add_BUF) ,
 
.     ADD_Bond_A_out    ( ADD_Bond_A_out      ) ,
.     ADD_Bond_A_Vil    ( ADD_Bond_A_Vil      ) ,
.     ADD_Bond_B_Vil    ( ADD_Bond_B_Vil      ) ,
.     ADD_Bond_B_out    ( ADD_Bond_B_out      ) ,
.     ADD_Bond_get_r    ( ADD_Bond_get_r      ) ,
.     ADD_Bond_get_vil  ( ADD_Bond_get_vil    ) ,

.     IM_ADD_DI_A_out   ( IM_ADD_DI_A_out     )  ,
.     IM_ADD_DI_A_Vil   ( IM_ADD_DI_A_Vil     )  ,
.     IM_ADD_DI_B_Vil   ( IM_ADD_DI_B_Vil     )  ,
.     IM_ADD_DI_B_out   ( IM_ADD_DI_B_out     )  ,
.     IM_ADD_DI_get_r   ( IM_ADD_DI_get_r     )  ,
.     IM_ADD_DI_get_vil ( IM_ADD_DI_get_vil   ) ,

.     B_ADD_A_A_out     ( B_ADD_A_A_out       ),
.     B_ADD_A_A_Vil     ( B_ADD_A_A_Vil       ),
.     B_ADD_A_B_Vil     ( B_ADD_A_B_Vil       ),
.     B_ADD_A_B_out     ( B_ADD_A_B_out       ),
.     B_ADD_A_get_r     ( B_ADD_A_get_r       ),
.     B_ADD_A_get_vil   ( B_ADD_A_get_vil     ), 
.     Bond_Force        (    Bond_Force       )
    );
    
    
    
    
endmodule
