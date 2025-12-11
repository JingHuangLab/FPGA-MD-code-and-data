`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:54:34 PM
// Design Name: 
// Module Name: Impropers_Cal_Top
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


module Impropers_Cal_Top(
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
  
 input     [31:0]          Komiga,
 input     [31:0]          Omiga0,     
  output reg [31:0]        Impropers_Add_BUF,
 input     [31:0]          R2_Root 
    );
       
 floating_point_SUB     U_FP_Omiga_Sub_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Omiga_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Omiga_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Omiga_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready           ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Omiga_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Omiga_Sub_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Omiga_Sub_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
  floating_point_MUL     U_FP_KOmiga_MUl_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (KOmiga_MUl_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (KOmiga_MUl_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (KOmiga_MUl_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (KOmiga_MUl_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (KOmiga_MUl_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (KOmiga_MUl_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
         
 floating_point_ADD     U_FP_Impropers_Add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Impropers_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Impropers_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Impropers_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Impropers_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Impropers_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Impropers_Add_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
      
 Impropers_Cal(
.     Sys_Clk            (    Sys_Clk            ) ,
.     Sys_Rst_n          (    Sys_Rst_n          ) ,
 
.      Komiga            (     Komiga            ) ,
.      Omiga0            (     Omiga0            ) ,     
 
.      R2_Root           (     R2_Root           ) ,
 
.  Omiga_Sub_A_out       ( Omiga_Sub_A_out       ) ,
.  Omiga_Sub_A_Vil       ( Omiga_Sub_A_Vil       ) ,
.  Omiga_Sub_B_Vil       ( Omiga_Sub_B_Vil       ) ,
.  Omiga_Sub_B_out       ( Omiga_Sub_B_out       ) ,
.  Omiga_Sub_get_r       ( Omiga_Sub_get_r       ) ,
.  Omiga_Sub_get_vil     ( Omiga_Sub_get_vil     ) ,
 
.  KOmiga_MUl_A_out      ( KOmiga_MUl_A_out      ) ,
.  KOmiga_MUl_A_Vil      ( KOmiga_MUl_A_Vil      ) ,
.  KOmiga_MUl_B_Vil      ( KOmiga_MUl_B_Vil      ) ,
.  KOmiga_MUl_B_out      ( KOmiga_MUl_B_out      ) ,
.  KOmiga_MUl_get_r      ( KOmiga_MUl_get_r      ) ,
.  KOmiga_MUl_get_vil    ( KOmiga_MUl_get_vil    ) ,
 
.  Impropers_Add_A_out   ( Impropers_Add_A_out   ) ,
.  Impropers_Add_A_Vil   ( Impropers_Add_A_Vil   ) ,
.  Impropers_Add_B_Vil   ( Impropers_Add_B_Vil   ) ,
.  Impropers_Add_B_out   ( Impropers_Add_B_out   ) ,
.  Impropers_Add_get_r   ( Impropers_Add_get_r   ) ,
.  Impropers_Add_get_vil ( Impropers_Add_get_vil ) 
 
    );   
    
    
endmodule
