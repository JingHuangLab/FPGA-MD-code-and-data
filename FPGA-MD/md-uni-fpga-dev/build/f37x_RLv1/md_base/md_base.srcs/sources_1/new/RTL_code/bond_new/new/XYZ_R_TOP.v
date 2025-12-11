`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 12:05:20 AM
// Design Name: 
// Module Name: XYZ_R_TOP
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


module XYZ_R_TOP(
 input                  Sys_Clk  ,
 input                  Sys_Rst_n ,

                   
input    [95:0]         Index_bond_A_in,
input    [95:0]         Index_bond_B_in,
input                   Index_bond_A_en, //enable
input                   Index_bond_B_en, //enable

  input                  R_cal_finish, // all bond finish
  output wire [31:0]      Root_R 
    );
          
 
floating_point_MUL U_FP_X_Mul_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (X_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (X_Mul_A_out),   
  .s_axis_b_tvalid       (X_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (X_Mul_B_out),   
  .m_axis_result_tvalid  (X_Mul_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (X_Mul_get_r)   
);

floating_point_MUL U_FP_Y_Mul_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Y_Mul_A_Vil),   
  .s_axis_a_tready       (  ),         
  .s_axis_a_tdata        (Y_Mul_A_out),   
  .s_axis_b_tvalid       (Y_Mul_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Y_Mul_B_out),   
  .m_axis_result_tvalid  (Y_Mul_get_vil), 
  .m_axis_result_tready  ( 1'b1 ),           
  .m_axis_result_tdata   (Y_Mul_get_r)   
);

floating_point_MUL U_FP_Z_Mul_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Z_Mul_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Z_Mul_A_out),   
  .s_axis_b_tvalid       (Z_Mul_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Z_Mul_B_out),   
  .m_axis_result_tvalid  (Z_Mul_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Z_Mul_get_r)   
);


floating_point_SUB     U_FP_X_SUB_Home (
  .aclk                 (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid      (X_Sub_A_Vil),              // input wire s_axis_a_tvalid
  .s_axis_a_tready     (  ),                         // output wire s_axis_a_tready
  .s_axis_a_tdata       (X_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid      (X_Sub_B_Vil),              // input wire s_axis_b_tvalid
  .s_axis_b_tready     (   ),                         // output wire s_axis_b_tready
  .s_axis_b_tdata       (X_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid (X_Sub_get_vil),            // output wire m_axis_result_tvalid
  .m_axis_result_tready( 1'b1 ),                         // input wire m_axis_result_tready
  .m_axis_result_tdata   (X_Sub_get_r)               // output wire [31 : 0] m_axis_result_tdata
);

floating_point_SUB      U_FP_Y_SUB_Home (
  .aclk                 (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid      (Y_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),           // output wire s_axis_a_tready
  .s_axis_a_tdata       (Y_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid      (Y_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (   ),           // output wire s_axis_b_tready
  .s_axis_b_tdata       (Y_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid (Y_Sub_get_vil),  // output wire m_axis_result_tvalid
  .m_axis_result_tready (  1'b1), // input wire m_axis_result_tready
  .m_axis_result_tdata  (Y_Sub_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
    
floating_point_SUB      U_FP_Z_SUB_Home (
  .aclk                 (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid      (Z_Sub_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),           // output wire s_axis_a_tready
  .s_axis_a_tdata       (Z_Sub_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid      (Z_Sub_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      ( ),           // output wire s_axis_b_tready
  .s_axis_b_tdata       (Z_Sub_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid (Z_Sub_get_vil),  // output wire m_axis_result_tvalid
  .m_axis_result_tready ( 1'b1), // input wire m_axis_result_tready
  .m_axis_result_tdata  (Z_Sub_get_r)    // output wire [31 : 0] m_axis_result_tdata
);


floating_point_ADD     U_FP_XYZ_add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (XY_Add_C_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (XY_Add_C_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Z_Add_C_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Z_Add_C_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (RR_Add_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (RR_Add_get_r)    // output wire [31 : 0] m_axis_result_tdata
);

 floating_point_ADD     U_FP_XY_add_Home (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (X_Add_A_Vil),            // input wire s_axis_a_tvalid
  .s_axis_a_tready          ( ),                          // output wire s_axis_a_tready
  .s_axis_a_tdata           (X_Add_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Y_Add_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready           ( ),                           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Y_Add_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (XY_Add_get_vil),          // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1),                              // input wire m_axis_result_tready
  .m_axis_result_tdata      (RR_Add_get_XY_R)         // output wire [31 : 0] m_axis_result_tdata
);
     
     
XYZ_R    U_XYZ_R  (
     .   Sys_Clk                     ( Sys_Clk              )  ,
     .   Sys_Rst_n                   ( Sys_Rst_n            )  ,                

                   
.Index_bond_A_in   (Index_bond_A_in), 
. Index_bond_B_in  (Index_bond_B_in),
.Index_bond_A_en    (Index_bond_A_en), //enable
.Index_bond_B_en     (Index_bond_B_en), //enable

. R_cal_finish     (R_cal_finish), // all bond finish
.  Root_R         (Root_R),

    
      .   X_Pos_buf_nei              (X_Pos_buf_nei)  , 
      .   Y_Pos_buf_nei              (Y_Pos_buf_nei)  , 
      .   Z_Pos_buf_nei              (Z_Pos_buf_nei)  , 
                        
      .   X_Pos_buf                  (X_Pos_buf),     
      .   Y_Pos_buf                  (Y_Pos_buf),     
      .   Z_Pos_buf                  (Z_Pos_buf),     
          
     . X_Add_A_out                   (X_Add_A_out   ), 
     . Y_Add_B_out                   (Y_Add_B_out   ), 
     . X_Add_A_Vil                   (X_Add_A_Vil   ),
     . Y_Add_B_Vil                   (Y_Add_B_Vil   ),    
    
     . XY_Add_C_out                  (XY_Add_C_out)  ,
     . XY_Add_C_Vil                  (XY_Add_C_Vil)  ,
     . Z_Add_C_out                   (Z_Add_C_out )  ,
     . Z_Add_C_Vil                   (Z_Add_C_Vil )  ,
   
     . RR_Add_get_r                  (RR_Add_get_r  ),
     . RR_Add_get_vil                (RR_Add_get_vil),
     . RR_Add_get_XY_R               (RR_Add_get_XY_R   ),
     . XY_Add_get_vil                (XY_Add_get_vil    ),        
                                   //X to caculation mul unit 
     . X_Mul_A_out                   (X_Mul_A_out  ),
     . X_Mul_A_Vil                   (X_Mul_A_Vil  ),
     . X_Mul_B_Vil                   (X_Mul_B_Vil  ),
     . X_Mul_B_out                   (X_Mul_B_out  ),
     . X_Mul_get_r                   (X_Mul_get_r  ),
     . X_Mul_get_vil                 (X_Mul_get_vil),
                                 //X to caculation sub unit 
     . X_Sub_A_out                   (X_Sub_A_out  ),
     . X_Sub_A_Vil                   (X_Sub_A_Vil  ),
     . X_Sub_B_Vil                   (X_Sub_B_Vil  ),
     . X_Sub_B_out                   (X_Sub_B_out  ),
     . X_Sub_get_r                   (X_Sub_get_r  ),
     . X_Sub_get_vil                 (X_Sub_get_vil),                   
                         //Y to caculation mul unit 
     . Y_Mul_A_out                   (Y_Mul_A_out  ),
     . Y_Mul_A_Vil                   (Y_Mul_A_Vil  ),
     . Y_Mul_B_Vil                   (Y_Mul_B_Vil  ),
     . Y_Mul_B_out                   (Y_Mul_B_out  ),
     . Y_Mul_get_r                   (Y_Mul_get_r  ),
     . Y_Mul_get_vil                 (Y_Mul_get_vil),
                           //Y to caculation sub unit 
     .Y_Sub_A_out                    (Y_Sub_A_out  ),
     .Y_Sub_A_Vil                    (Y_Sub_A_Vil  ),
     .Y_Sub_B_Vil                    (Y_Sub_B_Vil  ),
     .Y_Sub_B_out                    (Y_Sub_B_out  ),
     .Y_Sub_get_r                    (Y_Sub_get_r  ),
     .Y_Sub_get_vil                  (Y_Sub_get_vil),                     
                                               //Z to caculation mul unit 
     .Z_Mul_A_out                    (Z_Mul_A_out  ),
     .Z_Mul_A_Vil                    (Z_Mul_A_Vil  ),
     .Z_Mul_B_Vil                    (Z_Mul_B_Vil  ),
     .Z_Mul_B_out                    (Z_Mul_B_out  ),
     .Z_Mul_get_r                    (Z_Mul_get_r  ),
     .Z_Mul_get_vil                  (Z_Mul_get_vil),
                                                //Z to caculation sub unit 
     .Z_Sub_A_out                    (Z_Sub_A_out  ),
     .Z_Sub_A_Vil                    (Z_Sub_A_Vil  ),
     .Z_Sub_B_Vil                    (Z_Sub_B_Vil  ),
     .Z_Sub_B_out                    (Z_Sub_B_out  ),
     .Z_Sub_get_r                    (Z_Sub_get_r  ),
     .Z_Sub_get_vil                  (Z_Sub_get_vil)
     );  
          
         
    
endmodule
