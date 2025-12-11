`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:24:54 PM
// Design Name: 
// Module Name: Bond_cal_Top
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


module Bond_cal_Top(
 input                     Sys_Clk  ,
 input                     Sys_Rst_n,
 
 input     [31:0]            Filter_R2,
 input     [31:0]            B0,
 input     [31:0]            KB,
output wire  [31:0]          B_Add_BUF,
output wire [31:0]           R2_Root  
    );
   
 floating_point_ROOT     U_FP_R2_Root_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (R2_Root_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (R2_Root_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid     (R2_Root_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (R2_Root_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
    
 floating_point_SUB     U_FP_B_Sub_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (B_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (B_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (B_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (B_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (B_Sub_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready      (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (B_Sub_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
  floating_point_MUL     U_FP_Kb_MUl_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Kb_MUl_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Kb_MUl_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Kb_MUl_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Kb_MUl_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Kb_MUl_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Kb_MUl_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
         
 floating_point_ADD     U_FP_B_Add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (B_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (B_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (B_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (B_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (B_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (B_Add_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
     
     
     
  Bond_Cal(
.     Sys_Clk    (     Sys_Clk    ),
.     Sys_Rst_n  (     Sys_Rst_n  ),
    
.     Filter_R2  (     Filter_R2  ),
.     B0         (     B0         ),
.     KB         (     KB         ),
       
.     R2_Root    (     R2_Root    ),
          
. R2_Root_A_out  ( R2_Root_A_out  ),
. R2_Root_A_Vil  ( R2_Root_A_Vil  ),
. R2_Root_get_r  ( R2_Root_get_r  ),
. R2_Root_get_vil( R2_Root_get_vil),
        
. B_Sub_A_out    ( B_Sub_A_out    ),
. B_Sub_A_Vil    ( B_Sub_A_Vil    ),
. B_Sub_B_Vil    ( B_Sub_B_Vil    ),
. B_Sub_B_out    ( B_Sub_B_out    ),
. B_Sub_get_r    ( B_Sub_get_r    ),
. B_Sub_get_vil  ( B_Sub_get_vil  ),
         
. Kb_MUl_A_out   ( Kb_MUl_A_out   ),
. Kb_MUl_A_Vil   ( Kb_MUl_A_Vil   ),
. Kb_MUl_B_Vil   ( Kb_MUl_B_Vil   ),
. Kb_MUl_B_out   ( Kb_MUl_B_out   ),
. Kb_MUl_get_r   ( Kb_MUl_get_r   ),
. Kb_MUl_get_vil ( Kb_MUl_get_vil ),
            
. B_Add_A_out    ( B_Add_A_out    ),
. B_Add_A_Vil    ( B_Add_A_Vil    ),
. B_Add_B_Vil    ( B_Add_B_Vil    ),
. B_Add_B_out    ( B_Add_B_out    ),
. B_Add_get_r    ( B_Add_get_r    ),
. B_Add_get_vil  ( B_Add_get_vil  )
 

  
    );   
    
    
    
    
endmodule
