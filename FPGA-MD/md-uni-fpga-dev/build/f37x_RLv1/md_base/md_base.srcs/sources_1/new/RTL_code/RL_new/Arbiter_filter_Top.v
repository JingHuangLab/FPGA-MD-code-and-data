`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 01:56:57 PM
// Design Name: 
// Module Name: Arbiter_filter_Top
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


module Arbiter_filter_Top(
      input                   Sys_Clk                   ,
      input                   Sys_Rst_n                 , 
      input                   Force_cal_finish          ,
      
      output wire   [31:0]    Filter_1_data_to_cal      ,  
      output wire   [31:0]    Filter_2_data_to_cal      ,  
      output wire   [31:0]    Filter_3_data_to_cal      ,  
      output wire   [31:0]    Filter_4_data_to_cal      ,   
      output wire   [31:0]    Filter_5_data_to_cal      ,  
      output wire   [31:0]    Filter_6_data_to_cal      ,  
      output wire   [31:0]    Filter_7_data_to_cal      ,  
      output wire   [31:0]    Filter_8_data_to_cal      ,   
          
      output wire             Filter_1_Ture,
      output wire             Filter_2_Ture,
      output wire             Filter_3_Ture,
      output wire             Filter_4_Ture,
      output wire             Filter_5_Ture,
      output wire             Filter_6_Ture,
      output wire             Filter_7_Ture,
      output wire             Filter_8_Ture,
      
      input         [31:0]    Filter_RC                 , 
      input         [31:0]    Filter_1_R2               , 
      input         [31:0]    Filter_2_R2               , 
      input         [31:0]    Filter_3_R2               , 
      input         [31:0]    Filter_4_R2               , 
      input         [31:0]    Filter_5_R2               , 
      input         [31:0]    Filter_6_R2               , 
      input         [31:0]    Filter_7_R2               , 
      input         [31:0]    Filter_8_R2                      
    );
    
     floating_point_COMP     U_FP_Filter_1_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_1_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_1_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_1_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_1_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_1_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_1_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

     floating_point_COMP     U_FP_Filter_2_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_2_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_2_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_2_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_2_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_2_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_2_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
     floating_point_COMP     U_FP_Filter_3_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_3_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_3_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_3_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_3_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_3_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_3_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

     floating_point_COMP     U_FP_Filter_4_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_4_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_4_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_4_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_4_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_4_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_4_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
     floating_point_COMP     U_FP_Filter_5_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_5_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_5_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_5_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_5_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_5_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_5_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

     floating_point_COMP     U_FP_Filter_6_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_6_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_6_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_6_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_6_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_6_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_6_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
     floating_point_COMP     U_FP_Filter_7_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_7_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_7_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_7_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_7_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_7_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_7_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

     floating_point_COMP     U_FP_Filter_8_comp_COMP (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Filter_8_comp_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Filter_8_comp_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Filter_8_comp_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready          (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Filter_8_comp_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Filter_8_comp_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready     (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Filter_8_comp_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
     Arbiter_filter  U_Arbiter_filter(
.        Sys_Clk             (     Sys_Clk             )              ,
.        Sys_Rst_n           (     Sys_Rst_n           )            ,
 .       Force_cal_finish    (    Force_cal_finish     ),
 .  Filter_1_comp_A_out  ( Filter_1_comp_A_out   )   ,
 .  Filter_1_comp_A_Vil  ( Filter_1_comp_A_Vil   )   ,
 .  Filter_1_comp_B_Vil  ( Filter_1_comp_B_Vil   )   ,
 .  Filter_1_comp_B_out  ( Filter_1_comp_B_out   )   ,
 .  Filter_1_comp_get_r  ( Filter_1_comp_get_r   )   ,
 .  Filter_1_comp_get_vil( Filter_1_comp_get_vil )   ,   

.   Filter_2_comp_A_out  (Filter_2_comp_A_out  ),
.   Filter_2_comp_A_Vil  (Filter_2_comp_A_Vil  ),
.   Filter_2_comp_B_Vil  (Filter_2_comp_B_Vil  ),
.   Filter_2_comp_B_out  (Filter_2_comp_B_out  ),
.   Filter_2_comp_get_r  (Filter_2_comp_get_r  ),
.   Filter_2_comp_get_vil(Filter_2_comp_get_vil),   

.  Filter_3_comp_A_out   (Filter_3_comp_A_out   )  ,
.  Filter_3_comp_A_Vil   (Filter_3_comp_A_Vil   )  ,
.  Filter_3_comp_B_Vil   (Filter_3_comp_B_Vil   )  ,
.  Filter_3_comp_B_out   (Filter_3_comp_B_out   )  ,
.  Filter_3_comp_get_r   (Filter_3_comp_get_r   )  ,
.  Filter_3_comp_get_vil (Filter_3_comp_get_vil )  ,   

.  Filter_4_comp_A_out  (Filter_4_comp_A_out  ) ,
.  Filter_4_comp_A_Vil  (Filter_4_comp_A_Vil  ) ,
.  Filter_4_comp_B_Vil  (Filter_4_comp_B_Vil  ) ,
.  Filter_4_comp_B_out  (Filter_4_comp_B_out  ) ,
.  Filter_4_comp_get_r  (Filter_4_comp_get_r  ) ,
.  Filter_4_comp_get_vil(Filter_4_comp_get_vil) ,         

.   Filter_5_comp_A_out  (Filter_5_comp_A_out  ),
.   Filter_5_comp_A_Vil  (Filter_5_comp_A_Vil  ),
.   Filter_5_comp_B_Vil  (Filter_5_comp_B_Vil  ),
.   Filter_5_comp_B_out  (Filter_5_comp_B_out  ),
.   Filter_5_comp_get_r  (Filter_5_comp_get_r  ),
.   Filter_5_comp_get_vil(Filter_5_comp_get_vil),   
        
.    Filter_6_comp_A_out  (  Filter_6_comp_A_out  ),
.    Filter_6_comp_A_Vil  (  Filter_6_comp_A_Vil  ),
.    Filter_6_comp_B_Vil  (  Filter_6_comp_B_Vil  ),
.    Filter_6_comp_B_out  (  Filter_6_comp_B_out  ),
.    Filter_6_comp_get_r  (  Filter_6_comp_get_r  ),
.    Filter_6_comp_get_vil(  Filter_6_comp_get_vil),      

.   Filter_7_comp_A_out  (Filter_7_comp_A_out  ),
.   Filter_7_comp_A_Vil  (Filter_7_comp_A_Vil  ),
.   Filter_7_comp_B_Vil  (Filter_7_comp_B_Vil  ),
.   Filter_7_comp_B_out  (Filter_7_comp_B_out  ),
.   Filter_7_comp_get_r  (Filter_7_comp_get_r  ),
.   Filter_7_comp_get_vil(Filter_7_comp_get_vil),   
           
.  Filter_8_comp_A_out     (Filter_8_comp_A_out    )  ,
.  Filter_8_comp_A_Vil     (Filter_8_comp_A_Vil    )  ,
.  Filter_8_comp_B_Vil     (Filter_8_comp_B_Vil    )  ,
.  Filter_8_comp_B_out     (Filter_8_comp_B_out    )  ,
.  Filter_8_comp_get_r     (Filter_8_comp_get_r    )   ,
.  Filter_8_comp_get_vil   (Filter_8_comp_get_vil  )  ,   
                   
.  Filter_1_data_to_cal    (Filter_1_data_to_cal   )  ,  
.  Filter_2_data_to_cal    (Filter_2_data_to_cal   )  ,  
.  Filter_3_data_to_cal    (Filter_3_data_to_cal   )  ,  
.  Filter_4_data_to_cal    (Filter_4_data_to_cal   )  ,   
.  Filter_5_data_to_cal    (Filter_5_data_to_cal   )  ,  
.  Filter_6_data_to_cal    (Filter_6_data_to_cal   )  ,  
.  Filter_7_data_to_cal    (Filter_7_data_to_cal   )  ,  
.  Filter_8_data_to_cal    (Filter_8_data_to_cal   )  ,   

.  Filter_RC         ( Filter_RC       )     , 
.  Filter_1_R2       ( Filter_1_R2     )      ,  //input       
.  Filter_2_R2       ( Filter_2_R2     )      ,  //input       
.  Filter_3_R2       ( Filter_3_R2     )      ,  //input       
.  Filter_4_R2       ( Filter_4_R2     )      ,  //input       
.  Filter_5_R2       ( Filter_5_R2     )      ,  //input       
.  Filter_6_R2       ( Filter_6_R2     )      ,  //input       
.  Filter_7_R2       ( Filter_7_R2     )      ,  //input       
.  Filter_8_R2       ( Filter_8_R2     )         //input       
    );
    
    
    
endmodule
