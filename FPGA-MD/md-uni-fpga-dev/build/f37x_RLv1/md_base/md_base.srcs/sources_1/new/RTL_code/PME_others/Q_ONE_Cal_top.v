`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 09:40:14 PM
// Design Name: 
// Module Name: Q_Cal_top
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


module Q_ONE_Cal_top(
   input                        Sys_Clk                ,
   input                        Sys_Rst_n              , 
     
   input           [31:0]       atomCoorn_Index_X_fix  ,   
   input           [31:0]       atomCoorn_Index_Y_fix  , 
   input           [31:0]       atomCoorn_Index_Z_fix  , 
    input          [31:0]       Ngrid_fix              ,
   
   output   wire   [31:0]      index                  ,
   
   input                        Q_Calculater_en        ,
   output   wire                Q_Calculater_Done,
   input           [31:0]       Q_KKK                  , 
   input                        thetaX_GetBspline_vil  ,
   input                        thetaY_GetBspline_vil  ,
   input                        thetaZ_GetBspline_vil  ,
   input           [31:0]       thetaX_GetBspline      , //bspline  
   input           [31:0]       thetaY_GetBspline      ,   
   input           [31:0]       thetaZ_GetBspline      ,
   
   output   wire   [31:0]       charge_on_grid         
         

    );
 
 wire  [31:0]       Q_KKK_float_A_out     ;
 wire               Q_KKK_float_A_Vil     ;
 wire  [31:0]       Q_KKK_float_get_r     ;
 wire               Q_KKK_float_get_vil   ;
 
wire [31:0]   thetaX_Q_Mul_A_out  ; 
wire          thetaX_Q_Mul_A_Vil  ; 
wire          thetaX_Q_Mul_B_Vil  ; 
wire [31:0]   thetaX_Q_Mul_B_out  ; 
wire [31:0]   thetaX_Q_Mul_Get_r  ; 
wire          thetaX_Q_Mul_Get_vil; 
 
wire [31:0]   thetaZ_Y_Mul_A_out  ; 
wire          thetaZ_Y_Mul_A_Vil  ; 
wire          thetaZ_Y_Mul_B_Vil  ; 
wire [31:0]   thetaZ_Y_Mul_B_out  ; 
wire [31:0]   thetaZ_Y_Mul_Get_r  ; 
wire          thetaZ_Y_Mul_Get_vil; 
 
wire [31:0]   thetaXYZ_Mul_A_out  ; 
wire          thetaXYZ_Mul_A_Vil  ; 
wire          thetaXYZ_Mul_B_Vil  ; 
wire [31:0]   thetaXYZ_Mul_B_out  ; 
wire [31:0]   thetaXYZ_Mul_Get_r  ; 
wire          thetaXYZ_Mul_Get_vil; 
 

 
  FP_fix_float U_FP_Q_KKK_float (
  .aclk                  (Sys_Clk          ),       
  .s_axis_a_tvalid       (Q_KKK_float_A_Vil),   
  .s_axis_a_tready       (                  ),            
  .s_axis_a_tdata        (Q_KKK_float_A_out),   
  .m_axis_result_tvalid  (Q_KKK_float_get_vil), 
  .m_axis_result_tready  ( 1'b1             ),           
  .m_axis_result_tdata   (Q_KKK_float_get_r)   
);
    
    
    
    floating_point_MUL U_FP_thetaX_Q_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (thetaX_Q_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (thetaX_Q_Mul_A_out), 
  .s_axis_b_tvalid       (thetaX_Q_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (thetaX_Q_Mul_B_out),      
  .m_axis_result_tvalid  (thetaX_Q_Mul_Get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (thetaX_Q_Mul_Get_r)   
);

    
      floating_point_MUL U_FP_thetaZ_Y_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (thetaZ_Y_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (thetaZ_Y_Mul_A_out), 
  .s_axis_b_tvalid       (thetaZ_Y_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (thetaZ_Y_Mul_B_out),      
  .m_axis_result_tvalid  (thetaZ_Y_Mul_Get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (thetaZ_Y_Mul_Get_r)   
);  
    
    
       floating_point_MUL U_FP_thetaXYZ_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (thetaXYZ_Mul_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (thetaXYZ_Mul_A_out), 
  .s_axis_b_tvalid       (thetaXYZ_Mul_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (thetaXYZ_Mul_B_out),      
  .m_axis_result_tvalid  (thetaXYZ_Mul_Get_vil), 
  .m_axis_result_tready  ( 1'b1),           
  .m_axis_result_tdata   (thetaXYZ_Mul_Get_r)   
); 
    
    
    
    
    
    
    
    
  Q_Calculater   U_Q_Calculater(
   
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n             ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index_X_fix   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index_Y_fix   ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index_Z_fix   ),
 .Ngrid_fix              (Ngrid_fix               ),
                         
.index                   (index                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done       ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (thetaX_GetBspline       ),
.thetaY_GetBspline       (thetaY_GetBspline       ),
.thetaZ_GetBspline       (thetaZ_GetBspline       ),
                        
. charge_on_grid         ( charge_on_grid         ) ,

.   Q_KKK_float_A_out    ( Q_KKK_float_A_out   ),
.   Q_KKK_float_A_Vil    ( Q_KKK_float_A_Vil   ),
.   Q_KKK_float_get_r    ( Q_KKK_float_get_r   ),
.   Q_KKK_float_get_vil  ( Q_KKK_float_get_vil ) ,

.  thetaX_Q_Mul_A_out     (thetaX_Q_Mul_A_out    ),
.  thetaX_Q_Mul_B_out     (thetaX_Q_Mul_B_out    ),
.  thetaX_Q_Mul_A_Vil     (thetaX_Q_Mul_A_Vil    ),
.  thetaX_Q_Mul_B_Vil     (thetaX_Q_Mul_B_Vil    ),
.  thetaX_Q_Mul_Get_r     (thetaX_Q_Mul_Get_r    ),
.  thetaX_Q_Mul_Get_vil   (thetaX_Q_Mul_Get_vil  ),
                        
.  thetaZ_Y_Mul_A_out     (thetaZ_Y_Mul_A_out    ),
.  thetaZ_Y_Mul_B_out     (thetaZ_Y_Mul_B_out    ),
.  thetaZ_Y_Mul_A_Vil     (thetaZ_Y_Mul_A_Vil    ),
.  thetaZ_Y_Mul_B_Vil     (thetaZ_Y_Mul_B_Vil    ),
.  thetaZ_Y_Mul_Get_r     (thetaZ_Y_Mul_Get_r    ),
.  thetaZ_Y_Mul_Get_vil   (thetaZ_Y_Mul_Get_vil  ),
                          
.  thetaXYZ_Mul_A_out     (thetaXYZ_Mul_A_out    ),
.  thetaXYZ_Mul_B_out     (thetaXYZ_Mul_B_out    ),
.  thetaXYZ_Mul_A_Vil     (thetaXYZ_Mul_A_Vil    ),
.  thetaXYZ_Mul_B_Vil     (thetaXYZ_Mul_B_Vil    ),
.  thetaXYZ_Mul_Get_r     (thetaXYZ_Mul_Get_r    ),
.  thetaXYZ_Mul_Get_vil   (thetaXYZ_Mul_Get_vil  ) 

);
    
    
    
endmodule
