`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 01:56:57 PM
// Design Name: 
// Module Name: 
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


module Motion_update_TOP(
      input                Sys_Clk              ,
      input                Sys_Rst_n             
    );
    
    floating_point_MUL    U_FP_Fx_MUL_InvM (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fx_MUL_InvM_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fx_MUL_InvM_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fx_MUL_InvM_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fx_MUL_InvM_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fx_MUL_InvM_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fx_MUL_InvM_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
    
     floating_point_MUL    U_FP_Fy_MUL_InvM (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fy_MUL_InvM_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fy_MUL_InvM_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fy_MUL_InvM_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fy_MUL_InvM_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fy_MUL_InvM_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fy_MUL_InvM_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
       
    
     floating_point_MUL    U_FP_Fz_MUL_InvM (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Fz_MUL_InvM_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Fz_MUL_InvM_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Fz_MUL_InvM_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Fz_MUL_InvM_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Fz_MUL_InvM_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Fz_MUL_InvM_get_r)    // output wire [31 : 0] m_axis_result_tdata
);
       
      floating_point_MULA    U_FP_Ax_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Ax_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Ax_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Ax_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Ax_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Ax_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Ax_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);   
    
       floating_point_MULA    U_FP_Ay_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Ay_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Ay_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Ay_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Ay_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Ay_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Ay_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);   
 
 
        floating_point_MULA    U_FP_Az_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Az_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Az_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Az_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Az_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Az_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Az_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);         
 
        
      floating_point_MULA    U_FP_Vx_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Vx_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Vx_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Vx_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Vx_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Vx_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Vx_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);   
    
       floating_point_MULA    U_FP_Vy_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Vy_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Vy_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Vy_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Vy_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Vy_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Vy_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);   
 
 
        floating_point_MULA    U_FP_Vz_MULA_T (
  .aclk                     (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid          (Vz_MULA_T_A_Vil ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready      ( ),            // output wire s_axis_a_tready
  .s_axis_a_tdata           (Vz_MULA_T_A_out),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid          (Vz_MULA_T_B_Vil),            // input wire s_axis_b_tvalid
  .s_axis_b_tready      (  ),           // output wire s_axis_b_tready
  .s_axis_b_tdata           (Vz_MULA_T_B_out),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid     (Vz_MULA_T_get_vil),    // output wire m_axis_result_tvalid
  .m_axis_result_tready (1'b1) ,             // input wire m_axis_result_tready
  .m_axis_result_tdata      (Vz_MULA_T_get_r)    // output wire [31 : 0] m_axis_result_tdata
);         
 
    
Motion_update  U_Motion_update(
 
. Sys_Clk       ( Sys_Clk       ),
. Sys_Rst_n     ( Sys_Rst_n     ),
 
. Fx_Home_in    ( Fx_Home_in    ),
. Fy_Home_in    ( Fy_Home_in    ),
. Fz_Home_in    ( Fz_Home_in    ),
 
. Fx_Home_Mass  ( Fx_Home_Mass  ),
. Fy_Home_Mass  ( Fy_Home_Mass  ),
. Fz_Home_Mass  ( Fz_Home_Mass  ),
 
. time_step     ( time_step     ),
 
. Vx_Home_in    ( Vx_Home_in    ),
. Vy_Home_in    ( Vy_Home_in    ),
. Vz_Home_in    ( Vz_Home_in    ),
 
. Rx_Home_in    ( Rx_Home_in    ),
. Ry_Home_in    ( Ry_Home_in    ),
. Rz_Home_in    ( Rz_Home_in    ),  
 
. Vx_Home_out   ( Vx_Home_out   ),
. Vy_Home_out   ( Vy_Home_out   ),
. Vz_Home_out   ( Vz_Home_out   ),
 
.Rx_Home_out    (Rx_Home_out    ),
.Ry_Home_out    (Ry_Home_out    ),
.Rz_Home_out    (Rz_Home_out    ),  
 
 .Fx_MUL_InvM_A_out        (Fx_MUL_InvM_A_out   )     ,
 .Fx_MUL_InvM_A_Vil        (Fx_MUL_InvM_A_Vil   )     ,
 .Fx_MUL_InvM_B_Vil        (Fx_MUL_InvM_B_Vil   )     ,
 .Fx_MUL_InvM_B_out        (Fx_MUL_InvM_B_out   )     ,
 .Fx_MUL_InvM_get_r        (Fx_MUL_InvM_get_r   )     ,
 .Fx_MUL_InvM_get_vil      (Fx_MUL_InvM_get_vil )     ,  
 
 .Fy_MUL_InvM_A_out        (Fy_MUL_InvM_A_out   )     ,
 .Fy_MUL_InvM_A_Vil        (Fy_MUL_InvM_A_Vil   )     ,
 .Fy_MUL_InvM_B_Vil        (Fy_MUL_InvM_B_Vil   )     ,
 .Fy_MUL_InvM_B_out        (Fy_MUL_InvM_B_out   )     ,
 .Fy_MUL_InvM_get_r        (Fy_MUL_InvM_get_r   )     ,
 .Fy_MUL_InvM_get_vil      (Fy_MUL_InvM_get_vil )     ,  
 
 .Fz_MUL_InvM_A_out        (Fz_MUL_InvM_A_out   )     ,
 .Fz_MUL_InvM_A_Vil        (Fz_MUL_InvM_A_Vil   )     ,
 .Fz_MUL_InvM_B_Vil        (Fz_MUL_InvM_B_Vil   )     ,
 .Fz_MUL_InvM_B_out        (Fz_MUL_InvM_B_out   )     ,
 .Fz_MUL_InvM_get_r        (Fz_MUL_InvM_get_r   )     ,
 .Fz_MUL_InvM_get_vil      (Fz_MUL_InvM_get_vil )     ,  
 
 .Ax_MULA_T_A_out          (Ax_MULA_T_A_out     )     ,
 .Ax_MULA_T_A_Vil          (Ax_MULA_T_A_Vil     )     ,
 .Ax_MULA_T_B_Vil          (Ax_MULA_T_B_Vil     )     ,
 .Ax_MULA_T_B_out          (Ax_MULA_T_B_out     )     ,
 .Ax_MULA_Vx_C_Vil         (Ax_MULA_Vx_C_Vil    )     ,
 .Ax_MULA_Vx_C_out         (Ax_MULA_Vx_C_out    )     ,
 .Ax_MULA_T_get_r          (Ax_MULA_T_get_r     )     ,
 .Ax_MULA_T_get_vil        (Ax_MULA_T_get_vil   )     ,  
 
 .Ay_MULA_T_A_out          (Ay_MULA_T_A_out     )     ,
 .Ay_MULA_T_A_Vil          (Ay_MULA_T_A_Vil     )     ,
 .Ay_MULA_T_B_Vil          (Ay_MULA_T_B_Vil     )     ,
 .Ay_MULA_T_B_out          (Ay_MULA_T_B_out     )     ,
 .Ay_MULA_Vy_C_Vil         (Ay_MULA_Vy_C_Vil    )     ,
 .Ay_MULA_Vy_C_out         (Ay_MULA_Vy_C_out    )     ,
 .Ay_MULA_T_get_r          (Ay_MULA_T_get_r     )     ,
 .Ay_MULA_T_get_vil        (Ay_MULA_T_get_vil   )     ,  
 
 .Az_MULA_T_A_out          (Az_MULA_T_A_out     )     ,
 .Az_MULA_T_A_Vil          (Az_MULA_T_A_Vil     )     ,
 .Az_MULA_T_B_Vil          (Az_MULA_T_B_Vil     )     ,
 .Az_MULA_T_B_out          (Az_MULA_T_B_out     )     ,
 .Az_MULA_Vz_C_Vil         (Az_MULA_Vz_C_Vil    )     ,
 .Az_MULA_Vz_C_out         (Az_MULA_Vz_C_out    )     ,
 .Az_MULA_T_get_r          (Az_MULA_T_get_r     )     ,
 .Az_MULA_T_get_vil        (Az_MULA_T_get_vil   )     ,  
 
 .Vx_MULA_T_A_out          (Vx_MULA_T_A_out     )     ,
 .Vx_MULA_T_A_Vil          (Vx_MULA_T_A_Vil     )     ,
 .Vx_MULA_T_B_Vil          (Vx_MULA_T_B_Vil     )     ,
 .Vx_MULA_T_B_out          (Vx_MULA_T_B_out     )     ,
 .Vx_MULA_Rx_C_Vil         (Vx_MULA_Rx_C_Vil    )     ,
 .Vx_MULA_Rx_C_out         (Vx_MULA_Rx_C_out    )     ,
 .Vx_MULA_T_get_r          (Vx_MULA_T_get_r     )     ,
 .Vx_MULA_T_get_vil        (Vx_MULA_T_get_vil   )     ,  
 
 .Vy_MULA_T_A_out          (Vy_MULA_T_A_out     )     ,
 .Vy_MULA_T_A_Vil          (Vy_MULA_T_A_Vil     )     ,
 .Vy_MULA_T_B_Vil          (Vy_MULA_T_B_Vil     )     ,
 .Vy_MULA_T_B_out          (Vy_MULA_T_B_out     )     ,
 .Vy_MULA_Ry_C_Vil         (Vy_MULA_Ry_C_Vil    )     ,
 .Vy_MULA_Ry_C_out         (Vy_MULA_Ry_C_out    )     ,
 .Vy_MULA_T_get_r          (Vy_MULA_T_get_r     )     ,
 .Vy_MULA_T_get_vil        (Vy_MULA_T_get_vil   )     ,  
 
 .Vz_MULA_T_A_out          (Vz_MULA_T_A_out     )     ,
 .Vz_MULA_T_A_Vil          (Vz_MULA_T_A_Vil     )     ,
 .Vz_MULA_T_B_Vil          (Vz_MULA_T_B_Vil     )     ,
 .Vz_MULA_T_B_out          (Vz_MULA_T_B_out     )     ,
 .Vz_MULA_Rz_C_Vil         (Vz_MULA_Rz_C_Vil    )     ,
 .Vz_MULA_Rz_C_out         (Vz_MULA_Rz_C_out    )     ,
 .Vz_MULA_T_get_r          (Vz_MULA_T_get_r     )     ,
 .Vz_MULA_T_get_vil        (Vz_MULA_T_get_vil   )        

      );
 
    
    
    
endmodule
