`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2023 02:12:56 AM
// Design Name: 
// Module Name: Force_evaluation_TOP
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


module Homecell_ACC_TOP(
 input               Sys_Clk  ,
 input               Sys_Rst_n 
    );
    
Rd_cotr U_Rd_cotr(
   . Sys_Clk                (Sys_Clk                  )    ,
   . Sys_Rst_n              (Sys_Rst_n                )    ,              
                           
   . Rd_cotr_en             (Rd_cotr_en               )    ,//when new cell position updata
   . Home_Rd_finish         (Home_Rd_finish           )    ,
                            
   . M_AXIS_homeRam_rd_Addr (M_AXIS_homeRam_rd_Addr   )    ,
   . S_AXIS_homeRam_tData   (S_AXIS_homeRam_tData     )    ,                        
                           
   . M_AXIS_X_Pos_buf       (M_AXIS_X_Pos_buf         )    ,
   . M_AXIS_Y_Pos_buf       (M_AXIS_Y_Pos_buf         )    ,
   . M_AXIS_Z_Pos_buf       (M_AXIS_Z_Pos_buf         )    ,     
   . M_AXIS_Index_buf       (M_AXIS_Index_buf         )    ,              
                           
   . Get_XYZ                (Get_XYZ                  )     //                          
                                                            //  compare module ask xyz                                                                
    );
         
    floating_point_ADD     U_FP_Fx_Home_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fx_Home_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fx_Home_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fx_Home_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fx_Home_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fx_Home_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fx_Home_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

      floating_point_ADD     U_FP_Fy_Home_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fy_Home_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fy_Home_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fy_Home_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fy_Home_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fy_Home_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fy_Home_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
    floating_point_ADD     U_FP_Fz_Home_ADD (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fz_Home_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fz_Home_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fz_Home_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fz_Home_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fz_Home_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fz_Home_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
  
       
    
Homecell_ACC U_Homecell_ACC(
.     Sys_Clk              (Sys_Clk              )  ,
.     Sys_Rst_n            (Sys_Rst_n            )  ,
                    
.     Fx_Home_out          (Fx_Home_out          ) ,
.     Fy_Home_out          (Fy_Home_out          ) ,
.     Fz_Home_out          (Fz_Home_out          ) ,
                           
.     S_AXIS_ram_Rd_addr   (   S_AXIS_ram_Rd_addr) , 
.     S_AXIS_ram_rd_data   (   S_AXIS_ram_rd_data) ,
                     
.      Fx_home_A_out   (     Fx_home_A_out   )  ,
.      Fx_home_A_Vil   (     Fx_home_A_Vil   )  ,
.      Fx_home_B_Vil   (     Fx_home_B_Vil   )  ,
.      Fx_home_B_out   (     Fx_home_B_out   )  ,
.      Fx_home_get_r   (     Fx_home_get_r   )  ,
.      Fx_home_get_vil (     Fx_home_get_vil ) ,
                       
.      Fy_home_A_out   (     Fy_home_A_out   ) ,          
.      Fy_home_A_Vil   (     Fy_home_A_Vil   ) ,     
.      Fy_home_B_Vil   (     Fy_home_B_Vil   ) ,
.      Fy_home_B_out   (     Fy_home_B_out   ) ,
.      Fy_home_get_r   (     Fy_home_get_r   ) ,
.      Fy_home_get_vil (     Fy_home_get_vil ) ,
                      
.     Fz_home_A_out    (    Fz_home_A_out    ) ,
.     Fz_home_A_Vil    (    Fz_home_A_Vil    ) ,
.     Fz_home_B_Vil    (    Fz_home_B_Vil    ) ,
.     Fz_home_B_out    (    Fz_home_B_out    ) ,
.     Fz_home_get_r    (    Fz_home_get_r    ) ,
.     Fz_home_get_vil  (    Fz_home_get_vil  )
    );
    
    
    
endmodule
