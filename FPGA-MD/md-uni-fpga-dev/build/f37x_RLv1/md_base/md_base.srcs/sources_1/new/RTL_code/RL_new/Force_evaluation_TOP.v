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


module Force_evaluation_TOP(
 input                     Sys_Clk  ,
 input                     Sys_Rst_n ,
     
 input                     Sum_rr_done           ,
 input       [255:0]       M_AXIS_RR_data        ,
                                            
 output wire [255:0]       M_AXIS_EnE_Force,
 output wire               S_AXIS_Hom1Force_done           
    );  
    
    
floating_point_ADD U_FP_R_14_ADD_C0_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_14_ADD_C0_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (R_14_ADD_C0_A_out),   
  .s_axis_b_tvalid       (R_14_ADD_C0_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (R_14_ADD_C0_B_out),   
  .m_axis_result_tvalid  (R_14_ADD_C0_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (R_14_ADD_C0_get_r)   
);

floating_point_MUL U_FP_R_14_MUL_C1_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_14_MUL_C1_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (R_14_MUL_C1_A_out),   
  .s_axis_b_tvalid       (R_14_MUL_C1_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (R_14_MUL_C1_B_out),   
  .m_axis_result_tvalid  (R_14_MUL_C1_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (R_14_MUL_C1_get_r)   
);

floating_point_MUL U_FP_R_14_MUL_Aab_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_14_MUL_Aab_A_Vil),   
  .s_axis_a_tready       (  ),            
  .s_axis_a_tdata        (R_14_MUL_Aab_A_out),   
  .s_axis_b_tvalid       (R_14_MUL_Aab_B_Vil),   
  .s_axis_b_tready       (  ),           
  .s_axis_b_tdata        (R_14_MUL_Aab_B_out),   
  .m_axis_result_tvalid  (R_14_MUL_Aab_get_vil), 
  .m_axis_result_tready   ( 1'b1),           
  .m_axis_result_tdata   (R_14_MUL_Aab_get_r)   
);  
        
floating_point_ADD U_FP_R_8_ADD_C0_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_8_ADD_C0_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_8_ADD_C0_A_out),   
  .s_axis_b_tvalid       (R_8_ADD_C0_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_8_ADD_C0_B_out),   
  .m_axis_result_tvalid  (R_8_ADD_C0_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_8_ADD_C0_get_r)   
);
 
    


   
 floating_point_MUL U_FP_R_8_MUL_Bab_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_8_MUL_Bab_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_8_MUL_Bab_A_out),   
  .s_axis_b_tvalid       (R_8_MUL_Bab_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_8_MUL_Bab_B_out),   
  .m_axis_result_tvalid  (R_8_MUL_Bab_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_8_MUL_Bab_get_r)   
);
 
 floating_point_MUL U_FP_R_8_MUL_C1_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_8_MUL_C1_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_8_MUL_C1_A_out),   
  .s_axis_b_tvalid       (R_8_MUL_C1_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_8_MUL_C1_B_out),   
  .m_axis_result_tvalid  (R_8_MUL_C1_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_8_MUL_C1_get_r)   
);
   
  floating_point_ADD U_FP_R_3_ADD_C0_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_3_ADD_C0_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_3_ADD_C0_A_out),   
  .s_axis_b_tvalid       (R_3_ADD_C0_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_3_ADD_C0_B_out),   
  .m_axis_result_tvalid  (R_3_ADD_C0_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_3_ADD_C0_get_r)   
);
  
    
floating_point_MUL U_FP_R_3_MUL_C1_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_3_MUL_C1_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_3_MUL_C1_A_out),   
  .s_axis_b_tvalid       (R_3_MUL_C1_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_3_MUL_C1_B_out),   
  .m_axis_result_tvalid  (R_3_MUL_C1_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_3_MUL_C1_get_r)   
);
    
  floating_point_MUL U_FP_R_3_MUL_QQab_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R_3_MUL_QQab_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R_3_MUL_QQab_A_out),   
  .s_axis_b_tvalid       (R_3_MUL_QQab_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R_3_MUL_QQab_B_out),   
  .m_axis_result_tvalid  (R_3_MUL_QQab_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R_3_MUL_QQab_get_r)   
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
     
   
    floating_point_MUL U_FP_Force_ParaM_deltaX_MUL_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Force_ParaM_deltaX_MUL_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Force_ParaM_deltaX_MUL_A_out),   
  .s_axis_b_tvalid       (Force_ParaM_deltaX_MUL_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Force_ParaM_deltaX_MUL_B_out),   
  .m_axis_result_tvalid  (Force_ParaM_deltaX_MUL_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Force_ParaM_deltaX_MUL_get_r)   
); 
   
  floating_point_MUL U_FP_Force_ParaM_deltaY_MUL_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Force_ParaM_deltaY_MUL_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Force_ParaM_deltaY_MUL_A_out),   
  .s_axis_b_tvalid       (Force_ParaM_deltaY_MUL_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Force_ParaM_deltaY_MUL_B_out),   
  .m_axis_result_tvalid  (Force_ParaM_deltaY_MUL_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Force_ParaM_deltaY_MUL_get_r)   
);

  floating_point_MUL U_FP_Force_ParaM_deltaZ_MUL_Home (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Force_ParaM_deltaZ_MUL_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Force_ParaM_deltaZ_MUL_A_out),   
  .s_axis_b_tvalid       (Force_ParaM_deltaZ_MUL_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Force_ParaM_deltaZ_MUL_B_out),   
  .m_axis_result_tvalid  (Force_ParaM_deltaZ_MUL_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Force_ParaM_deltaZ_MUL_get_r)   
);   
   
Col_dir_Moudle U_Col_dir_Moudle(
.Sys_Clk               ( Sys_Clk               ) ,
.Sys_Rst_n             ( Sys_Rst_n             ) ,
 
. ParaM_X_A            ( ParaM_X_A            ) ,// X= rr      
. ParaM_A              ( ParaM_A              ) , 
 
. ParaM_Aab            ( ParaM_Aab            ) ,      
. ParaM_Bab            ( ParaM_Bab            ) , 
. ParaM_QQab           ( ParaM_QQab           ) ,
 
. ParaM_R_14_C1        ( ParaM_R_14_C1        ) ,      
. ParaM_R_14_C0        ( ParaM_R_14_C0        ) , 
 
. ParaM_R_8_C1         ( ParaM_R_8_C1         ) ,      
. ParaM_R_8_C0         ( ParaM_R_8_C0         ) ,
 
. ParaM_R_3_C1         ( ParaM_R_3_C1         ) ,      
. ParaM_R_3_C0         ( ParaM_R_3_C0         ) , 
. M_AXIS_Force_done    ( M_AXIS_Force_done    ) ,
. Home0_cell_cal_finish( Home0_cell_cal_finish) ,
 
. S_AXIS_COMP_Begin    ( S_AXIS_COMP_Begin    ) ,       //previous input, enable XYZ buf  
. S_AXIS_COMP_2_Begin  ( S_AXIS_COMP_2_Begin  ) ,       //previous input, enable XYZ buf  
 
. S_AXIS_home_Index_buf( S_AXIS_home_Index_buf) ,    
. S_AXIS_Index_buf     ( S_AXIS_Index_buf     )           
    );
    
    
Force_evaluation U_Force_evaluation(
  .  Sys_Clk              (Sys_Clk        ),
  .  Sys_Rst_n            (Sys_Rst_n      ),
 
  .  ParaM_X_A            (M_AXIS_RR_data      ),// X= rr      
  .  ParaM_A              (ParaM_A        ), 

  .  ParaM_Aab            (ParaM_Aab      ),      
  .  ParaM_Bab            (ParaM_Bab      ), 
  .  ParaM_QQab           (ParaM_QQab     ),
 
  .  ParaM_R_14_C1        (ParaM_R_14_C1  ),      
  .  ParaM_R_14_C0        (ParaM_R_14_C0  ), 
 
  .  ParaM_R_8_C1         (ParaM_R_8_C1   ),      
  .  ParaM_R_8_C0         (ParaM_R_8_C0   ),
 
  .  ParaM_R_3_C1         (ParaM_R_3_C1   ) ,      
  .  ParaM_R_3_C0         (ParaM_R_3_C0   ) ,
 
  .  X_Add_A_out          ( X_Add_A_out   )   ,
  .  Y_Add_B_out          ( Y_Add_B_out   )   ,     
  .  X_Add_A_Vil          ( X_Add_A_Vil   )   ,
  .  Y_Add_B_Vil          ( Y_Add_B_Vil   )   ,           
  .  RR_Add_get_r         ( RR_Add_get_r  )   ,    
  .  RR_Add_get_vil       ( RR_Add_get_vil )   ,
 
  .  XY_Add_C_out         ( XY_Add_C_out         ), 
  .  XY_Add_C_Vil         ( XY_Add_C_Vil         ),      
  .  Z_Add_C_out          ( Z_Add_C_out          ), 
  .  Z_Add_C_Vil          ( Z_Add_C_Vil          ),
  .  XY_Add_get_vil       ( XY_Add_get_vil       ),
  .  RR_Add_get_XY_R      ( RR_Add_get_XY_R      ),    
                        
  .   R_14_ADD_C0_A_out   (  R_14_ADD_C0_A_out   ),
  .   R_14_ADD_C0_A_Vil   (  R_14_ADD_C0_A_Vil   ),
  .   R_14_ADD_C0_B_Vil   (  R_14_ADD_C0_B_Vil   ),
  .   R_14_ADD_C0_B_out   (  R_14_ADD_C0_B_out   ),
  .   R_14_ADD_C0_get_r   (  R_14_ADD_C0_get_r   ),
  .   R_14_ADD_C0_get_vil (  R_14_ADD_C0_get_vil ),
                         
  .   R_14_MUL_C1_A_out   (  R_14_MUL_C1_A_out   ),
  .   R_14_MUL_C1_A_Vil   (  R_14_MUL_C1_A_Vil   ),
  .   R_14_MUL_C1_B_Vil   (  R_14_MUL_C1_B_Vil   ),
  .   R_14_MUL_C1_B_out   (  R_14_MUL_C1_B_out   ),
  .   R_14_MUL_C1_get_r   (  R_14_MUL_C1_get_r   ),
  .   R_14_MUL_C1_get_vil (  R_14_MUL_C1_get_vil ),  
                          
  .   R_14_MUL_Aab_A_out  (  R_14_MUL_Aab_A_out  ),
  .   R_14_MUL_Aab_A_Vil  (  R_14_MUL_Aab_A_Vil  ),
  .   R_14_MUL_Aab_B_Vil  (  R_14_MUL_Aab_B_Vil  ),
  .   R_14_MUL_Aab_B_out  (  R_14_MUL_Aab_B_out  ),
  .   R_14_MUL_Aab_get_r  (  R_14_MUL_Aab_get_r  ),
  .   R_14_MUL_Aab_get_vil(  R_14_MUL_Aab_get_vil),    
                          
  .   R_8_ADD_C0_A_out    (  R_8_ADD_C0_A_out    ),
  .   R_8_ADD_C0_A_Vil    (  R_8_ADD_C0_A_Vil    ),
  .   R_8_ADD_C0_B_Vil    (  R_8_ADD_C0_B_Vil    ),
  .   R_8_ADD_C0_B_out    (  R_8_ADD_C0_B_out    ),
  .   R_8_ADD_C0_get_r    (  R_8_ADD_C0_get_r    ) ,
  .   R_8_ADD_C0_get_vil  (  R_8_ADD_C0_get_vil  ) ,
                        
  .   R_8_MUL_C1_A_out    (  R_8_MUL_C1_A_out    ) ,
  .   R_8_MUL_C1_A_Vil    (  R_8_MUL_C1_A_Vil    ) ,
  .   R_8_MUL_C1_B_Vil    (  R_8_MUL_C1_B_Vil    ) ,
  .   R_8_MUL_C1_B_out    (  R_8_MUL_C1_B_out    ) ,
  .   R_8_MUL_C1_get_r    (  R_8_MUL_C1_get_r    ) ,
  .   R_8_MUL_C1_get_vil  (  R_8_MUL_C1_get_vil  ) ,   
                          
  .   R_8_MUL_Bab_A_out   (  R_8_MUL_Bab_A_out   ) ,
  .   R_8_MUL_Bab_A_Vil   (  R_8_MUL_Bab_A_Vil   ) ,
  .   R_8_MUL_Bab_B_Vil   (  R_8_MUL_Bab_B_Vil   ) ,
  .   R_8_MUL_Bab_B_out   (  R_8_MUL_Bab_B_out   ) ,
  .   R_8_MUL_Bab_get_r   (  R_8_MUL_Bab_get_r   ) ,
  .   R_8_MUL_Bab_get_vil (  R_8_MUL_Bab_get_vil ) ,   
                          
  .   R_3_ADD_C1_A_out    (  R_3_ADD_C1_A_out    ) ,
  .   R_3_ADD_C1_A_Vil    (  R_3_ADD_C1_A_Vil    ) ,
  .   R_3_ADD_C1_B_Vil    (  R_3_ADD_C1_B_Vil    ) ,
  .   R_3_ADD_C1_B_out    (  R_3_ADD_C1_B_out    ) ,
  .   R_3_ADD_C1_get_r    (  R_3_ADD_C1_get_r    ) ,
  .   R_3_ADD_C1_get_vil  (  R_3_ADD_C1_get_vil  ) ,
                         
  .   R_3_MUL_C1_A_out    (  R_3_MUL_C1_A_out    ),
  .   R_3_MUL_C1_A_Vil    (  R_3_MUL_C1_A_Vil    ),
  .   R_3_MUL_C1_B_Vil    (  R_3_MUL_C1_B_Vil    ),
  .   R_3_MUL_C1_B_out    (  R_3_MUL_C1_B_out    ),
  .   R_3_MUL_C1_get_r    (  R_3_MUL_C1_get_r    ),
  .   R_3_MUL_C1_get_vil  (  R_3_MUL_C1_get_vil  ),
                          
  .   R_3_MUL_QQab_A_out  (  R_3_MUL_QQab_A_out  ),
  .   R_3_MUL_QQab_A_Vil  (  R_3_MUL_QQab_A_Vil  ),
  .   R_3_MUL_QQab_B_Vil  (  R_3_MUL_QQab_B_Vil  ),
  .   R_3_MUL_QQab_B_out  (  R_3_MUL_QQab_B_out  ),
  .   R_3_MUL_QQab_get_r  (  R_3_MUL_QQab_get_r  ),
  .   R_3_MUL_QQab_get_vil(  R_3_MUL_QQab_get_vil)        
     );
    
    
endmodule
