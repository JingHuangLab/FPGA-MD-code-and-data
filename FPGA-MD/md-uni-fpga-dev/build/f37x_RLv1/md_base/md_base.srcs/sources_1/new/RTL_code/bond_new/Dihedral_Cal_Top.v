`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:54:34 PM
// Design Name: 
// Module Name: Dihedral_Cal
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


module Dihedral_Cal_Top (
 input                     Sys_Clk  ,
 input                     Sys_Rst_n,
 input     [31:0]          N,
 input     [31:0]          Fai,     
 input     [31:0]          R2_Root,
 input     [31:0]          KThate,
 input     [31:0]          Sigma 
    );
 
 
  floating_point_MUL    U_FP_N_Mul_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (N_Mul_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (N_Mul_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (N_Mul_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (N_Mul_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (N_Mul_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (N_Mul_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
 
   floating_point_SUB    U_FP_Sigma_Sub_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Sigma_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Sigma_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Sigma_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Sigma_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Sigma_Sub_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Sigma_Sub_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
 
cordic_COS U_cordic_COS (
  .aclk(aclk),                                // input wire aclk
  .s_axis_phase_tvalid(nsubsigma_Cos_A_Vil),  // input wire s_axis_phase_tvalid
  .s_axis_phase_tdata (nsubsigma_Cos_A_out ),    // input wire [31 : 0] s_axis_phase_tdata
  .m_axis_dout_tvalid(nsubsigma_Cos_get_vil ),    // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(nsubsigma_Cos_get_r)      // output wire [63 : 0] m_axis_dout_tdata
);


   floating_point_ADD    U_FP_one_Add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (one_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (one_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (one_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (one_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (one_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (one_Add_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
  
 
   floating_point_MUL    U_FP_Kthate_Mul_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Kthate_Mul_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Kthate_Mul_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Kthate_Mul_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Kthate_Mul_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Kthate_Mul_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Kthate_Mul_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
  
     floating_point_ADD    U_FP_Dih_Add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Dih_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (Dih_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Dih_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Dih_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Dih_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (Dih_Add_get_r)         // output wire [31 : 0] m_axis_result_tdata
);
      
Dihedral_Cal (
 .     Sys_Clk           (     Sys_Clk          ) ,
 .     Sys_Rst_n         (     Sys_Rst_n        ) ,
 .      N                (      N               ) ,
 .      Fai              (      Fai             ) ,     
 .      R2_Root          (      R2_Root         ) ,
 .      KThate           (      KThate          ) ,
 .      Sigma            (      Sigma           ) ,
 
 
 .  N_Mul_A_out          (  N_Mul_A_out         ) , //n * fai
 .  N_Mul_A_Vil          (  N_Mul_A_Vil         ) ,
 .  N_Mul_B_Vil          (  N_Mul_B_Vil         ) ,
 .  N_Mul_B_out          (  N_Mul_B_out         ) ,
 .  N_Mul_get_r          (  N_Mul_get_r         ) ,
 .  N_Mul_get_vil        (  N_Mul_get_vil       ) ,
 
 
 .  Sigma_Sub_A_out      (  Sigma_Sub_A_out     ) , //n * fai -sigma
 .  Sigma_Sub_A_Vil      (  Sigma_Sub_A_Vil     ) ,
 .  Sigma_Sub_B_Vil      (  Sigma_Sub_B_Vil     ) ,
 .  Sigma_Sub_B_out      (  Sigma_Sub_B_out     ) ,
 .  Sigma_Sub_get_r      (  Sigma_Sub_get_r     ) ,
 .  Sigma_Sub_get_vil    (  Sigma_Sub_get_vil   ) ,
 
 .  nsubsigma_Cos_A_out  (  nsubsigma_Cos_A_out ) ,  //cos(n * fai -sigma) 
 .  nsubsigma_Cos_A_Vil  (  nsubsigma_Cos_A_Vil ) ,   
 .  nsubsigma_Cos_get_r  (  nsubsigma_Cos_get_r ) ,  
 .  nsubsigma_Cos_get_vil(  nsubsigma_Cos_get_vil) ,
 
 .  one_Add_A_out        (  one_Add_A_out       ) , //1+cos(n * fai -sigma)  
 .  one_Add_A_Vil        (  one_Add_A_Vil       ) ,
 .  one_Add_B_Vil        (  one_Add_B_Vil       ) ,
 .  one_Add_B_out        (  one_Add_B_out       ) ,
 .  one_Add_get_r        (  one_Add_get_r       ) ,
 .  one_Add_get_vil      (  one_Add_get_vil     ) ,
 
 .  Kthate_Mul_A_out     (  Kthate_Mul_A_out    ) ,//kthate(1+cos(n * fai -sigma) )
 .  Kthate_Mul_A_Vil     (  Kthate_Mul_A_Vil    ) ,
 .  Kthate_Mul_B_Vil     (  Kthate_Mul_B_Vil    ) ,
 .  Kthate_Mul_B_out     (  Kthate_Mul_B_out    ) ,
 .  Kthate_Mul_get_r     (  Kthate_Mul_get_r    ) ,
 .  Kthate_Mul_get_vil   (  Kthate_Mul_get_vil  ) ,
 
 .  Dih_Add_A_out        (  Dih_Add_A_out       ) , //1+cos(n * fai -sigma)  
 .  Dih_Add_A_Vil        (  Dih_Add_A_Vil       ) ,
 .  Dih_Add_B_Vil        (  Dih_Add_B_Vil       ) ,
 .  Dih_Add_B_out        (  Dih_Add_B_out       ) ,
 .  Dih_Add_get_r        (  Dih_Add_get_r       ) ,
 .  Dih_Add_get_vil      (  Dih_Add_get_vil     ) );
endmodule
