`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 10:24:03 PM
// Design Name: 
// Module Name: Pme_Index_Fraction_Top
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


module Pme_Index_Fraction_Top(

    input                   Sys_Clk      ,
    input                   Sys_Rst_n    ,  
    
    output  wire            Pme_Index_Fraction_Done,
    input                   Pme_Index_Fraction_en,
    input        [31:0]     atomCoorn                , // xyz
    input        [31:0]     RecipBoxVector           , // xyz
    input        [31:0]     Ngrid                    , // xyz
    input        [31:0]     Ngrid_HEX                    , // xyz
    output  wire  [31:0]     atomCoorn_Index          , // xyz
    output  wire  [31:0]     atomCoorn_Fraction         // xyz 

    );
   
wire [31:0]   Coord_ReBox_Mul_A_out  ;
wire          Coord_ReBox_Mul_A_Vil  ;
wire          Coord_ReBox_Mul_B_Vil  ;
wire [31:0]   Coord_ReBox_Mul_B_out  ;
wire [31:0]   Coord_ReBox_Mul_get_r  ;
wire          Coord_ReBox_Mul_get_vil;
 
wire [31:0]   T_floor_fix_A_out  ;
wire          T_floor_fix_A_Vil  ;
wire [31:0]   T_floor_fix_get_r  ;
wire          T_floor_fix_get_vil;
     
wire [31:0]   T_Third_Mul_A_out  ;
wire          T_Third_Mul_A_Vil  ;
wire          T_Third_Mul_B_Vil  ;
wire [31:0]   T_Third_Mul_B_out  ;
wire [31:0]   T_Third_Mul_get_r  ;
wire          T_Third_Mul_get_vil;

wire [31:0]   T_floor_float_A_out  ;
wire          T_floor_float_A_Vil  ;
wire [31:0]   T_floor_float_get_r  ;
wire          T_floor_float_get_vil;

wire [31:0]   T_T_floor_SUB_A_out  ;
wire          T_T_floor_SUB_A_Vil  ;
wire          T_T_floor_SUB_B_Vil  ;
wire [31:0]   T_T_floor_SUB_B_out  ;
wire [31:0]   T_T_floor_SUB_get_r  ;
wire          T_T_floor_SUB_get_vil;

wire [31:0]   T_int_fix_A_out  ;
wire          T_int_fix_A_Vil  ;
wire [31:0]   T_int_fix_get_r  ;
wire          T_int_fix_get_vil;

wire [31:0]   T_int_float_A_out  ;
wire          T_int_float_A_Vil  ;
wire [31:0]   T_int_float_get_r  ;
wire          T_int_float_get_vil;

wire [31:0]   atomCoorn_Fraction_SUB_A_out  ;
wire          atomCoorn_Fraction_SUB_A_Vil  ;
wire          atomCoorn_Fraction_SUB_B_Vil  ;
wire [31:0]   atomCoorn_Fraction_SUB_B_out  ;
wire [31:0]   atomCoorn_Fraction_SUB_get_r  ;
wire          atomCoorn_Fraction_SUB_get_vil;


floating_point_MUL U_FP_Coord_ReBox_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Coord_ReBox_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (Coord_ReBox_Mul_A_out),   
  .s_axis_b_tvalid       (Coord_ReBox_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (Coord_ReBox_Mul_B_out),  
  .m_axis_result_tvalid  (Coord_ReBox_Mul_get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (Coord_ReBox_Mul_get_r)   
);


floating_point_FIX U_FP_T_floor_fix (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_floor_fix_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_floor_fix_A_out),    
  .m_axis_result_tvalid  (T_floor_fix_get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (T_floor_fix_get_r)   
);

floating_point_MUL U_FP_T_Third_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_Third_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_Third_Mul_A_out), 
  .s_axis_b_tvalid       (T_Third_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (T_Third_Mul_B_out),      
  .m_axis_result_tvalid  (T_Third_Mul_get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (T_Third_Mul_get_r)   
);

floating_point_FLOAT U_FP_T_floor_float (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_floor_float_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_floor_float_A_out),   
  .m_axis_result_tvalid  (T_floor_float_get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (T_floor_float_get_r)   
);



floating_point_SUB U_FP_T_T_floor_SUB (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_T_floor_SUB_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_T_floor_SUB_A_out),   
  .s_axis_b_tvalid       (T_T_floor_SUB_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (T_T_floor_SUB_B_out),   
  .m_axis_result_tvalid  (T_T_floor_SUB_get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (T_T_floor_SUB_get_r)   
);


floating_point_FIX U_FP_T_int_fix (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_int_fix_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_int_fix_A_out),    
  .m_axis_result_tvalid  (T_int_fix_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (T_int_fix_get_r)   
);

floating_point_FLOAT U_FP_T_int_float (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (T_int_float_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (T_int_float_A_out),   
  .m_axis_result_tvalid  (T_int_float_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (T_int_float_get_r)   
);

floating_point_SUB U_FP_atomCoorn_Fraction_SUB (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (atomCoorn_Fraction_SUB_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (atomCoorn_Fraction_SUB_A_out),   
  .s_axis_b_tvalid       (atomCoorn_Fraction_SUB_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (atomCoorn_Fraction_SUB_B_out),   
  .m_axis_result_tvalid  (atomCoorn_Fraction_SUB_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (atomCoorn_Fraction_SUB_get_r)   
);



    
     Pme_Index_Fraction U_Pme_Index_Fraction(
.    Sys_Clk                       (Sys_Clk                       )  ,
.    Sys_Rst_n                     (Sys_Rst_n                     )  ,  
           
.    Pme_Index_Fraction_en         (Pme_Index_Fraction_en         ) ,
.    atomCoorn                     (atomCoorn                     ) , //x
.    RecipBoxVector                (RecipBoxVector                ) , //x
.    Ngrid                         (Ngrid                         ) , //x
.    Ngrid_HEX                     (Ngrid_HEX                     ),
.    atomCoorn_Index               (atomCoorn_Index               ) , //x
.    atomCoorn_Fraction            (atomCoorn_Fraction            ) ,  //x
.    Pme_Index_Fraction_Done       (Pme_Index_Fraction_Done),   
                         
.    Coord_ReBox_Mul_A_out         (Coord_ReBox_Mul_A_out         ) ,
.    Coord_ReBox_Mul_B_out         (Coord_ReBox_Mul_B_out         ) ,
.    Coord_ReBox_Mul_A_Vil         (Coord_ReBox_Mul_A_Vil         ) ,
.    Coord_ReBox_Mul_B_Vil         (Coord_ReBox_Mul_B_Vil         ) ,
.    Coord_ReBox_Mul_get_r         (Coord_ReBox_Mul_get_r         ) ,
.    Coord_ReBox_Mul_get_vil       (Coord_ReBox_Mul_get_vil       ) ,            
                              
.    T_floor_fix_A_out             (T_floor_fix_A_out             ) ,
.    T_floor_fix_A_Vil             (T_floor_fix_A_Vil             ) ,
.    T_floor_fix_get_r             (T_floor_fix_get_r             ) ,
.    T_floor_fix_get_vil           (T_floor_fix_get_vil           ) ,
                      
.    T_floor_float_A_out           (T_floor_float_A_out           ) ,
.    T_floor_float_A_Vil           (T_floor_float_A_Vil           ) ,
.    T_floor_float_get_r           (T_floor_float_get_r           ) ,
.    T_floor_float_get_vil         (T_floor_float_get_vil         ) ,  
                   
.    T_T_floor_SUB_A_out           (T_T_floor_SUB_A_out           ) ,
.    T_T_floor_SUB_B_out           (T_T_floor_SUB_B_out           ) ,
.    T_T_floor_SUB_A_Vil           (T_T_floor_SUB_A_Vil           ) ,
.    T_T_floor_SUB_B_Vil           (T_T_floor_SUB_B_Vil           ) ,
.    T_T_floor_SUB_get_r           (T_T_floor_SUB_get_r           ) ,
.    T_T_floor_SUB_get_vil         (T_T_floor_SUB_get_vil         ) ,
                                 
.    T_Third_Mul_A_out             (T_Third_Mul_A_out             ) ,
.    T_Third_Mul_B_out             (T_Third_Mul_B_out             ) ,
.    T_Third_Mul_A_Vil             (T_Third_Mul_A_Vil             ) ,
.    T_Third_Mul_B_Vil             (T_Third_Mul_B_Vil             ) ,
.    T_Third_Mul_get_r             (T_Third_Mul_get_r             ) ,
.    T_Third_Mul_get_vil           (T_Third_Mul_get_vil           )  ,
                       
.    T_int_fix_A_out               (T_int_fix_A_out               ) ,
.    T_int_fix_A_Vil               (T_int_fix_A_Vil               ) ,
.    T_int_fix_get_r               (T_int_fix_get_r               ) ,
.    T_int_fix_get_vil             (T_int_fix_get_vil             )  ,
                           
.    T_int_float_A_out             (T_int_float_A_out             ) ,
.    T_int_float_A_Vil             (T_int_float_A_Vil             ) ,
.    T_int_float_get_r             (T_int_float_get_r             ) ,
.    T_int_float_get_vil           (T_int_float_get_vil           )  ,   
                          
.    atomCoorn_Fraction_SUB_A_out  (atomCoorn_Fraction_SUB_A_out  ) ,
.    atomCoorn_Fraction_SUB_B_out  (atomCoorn_Fraction_SUB_B_out  ) ,
.    atomCoorn_Fraction_SUB_A_Vil  (atomCoorn_Fraction_SUB_A_Vil  ) ,
.    atomCoorn_Fraction_SUB_B_Vil  (atomCoorn_Fraction_SUB_B_Vil  ) ,
.    atomCoorn_Fraction_SUB_get_r  (atomCoorn_Fraction_SUB_get_r  ) ,
.    atomCoorn_Fraction_SUB_get_vil(atomCoorn_Fraction_SUB_get_vil) 

    
    );
  
endmodule
