`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2023 02:50:21 PM
// Design Name: 
// Module Name: Filter_TOP
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


module Filter_TOP(

      input                Sys_Clk              ,
      input                Sys_Rst_n            ,
      input                Home0_cell_cal_finish,
      input                S_AXIS_COMP_Begin     ,   
      input                S_AXIS_COMP_2_Begin   ,      
     
      output wire          Sum_rr_done     ,
      output wire[95:0]    M_AXIS_RR_data   ,

      input [31:0]         X_Pos_buf_nei, 
      input [31:0]         Y_Pos_buf_nei, 
      input [31:0]         Z_Pos_buf_nei, 
  
      input [31:0]         X_Pos_buf,     
      input [31:0]         Y_Pos_buf,     
      input [31:0]         Z_Pos_buf,     
      input [159:0]        S_AXIS_home_Index_buf, 
      input [159:0]        S_AXIS_Index_buf                
          
      
    );
wire   [159:0]     Index_Pos_home  ;
wire   [159:0]     Index_Pos_nei   ;

wire   [31:0]      X_Mul_A_out  ;
wire               X_Mul_A_Vil  ;
wire               X_Mul_B_Vil  ;
wire   [31:0]      X_Mul_B_out  ;
wire   [31:0]      X_Mul_get_r  ;
wire               X_Mul_get_vil;

wire   [31:0]      ParaM_A_LJ;      
wire   [31:0]      ParaM_B_LJ;      
wire   [31:0]      ParaM_A_LJ_Force;      
wire   [31:0]      ParaM_B_LJ_Force;  

wire   [31:0]      ParaM_Ene_Col;     
wire   [31:0]      ParaM_Ene_Force;    

wire [31:0]     Y_Mul_A_out  ;
wire            Y_Mul_A_Vil  ;
wire            Y_Mul_B_Vil  ;
wire [31:0]     Y_Mul_B_out  ;
wire [31:0]     Y_Mul_get_r  ;
wire            Y_Mul_get_vil;

wire [31:0]     Z_Mul_A_out  ;
wire            Z_Mul_A_Vil  ;
wire            Z_Mul_B_Vil  ;
wire [31:0]     Z_Mul_B_out  ;
wire [31:0]     Z_Mul_get_r  ;
wire            Z_Mul_get_vil;

wire [31:0]     X_Sub_A_out   ;
wire            X_Sub_A_Vil   ;
wire            X_Sub_B_Vil   ;
wire [31:0]     X_Sub_B_out   ;
wire [31:0]     X_Sub_get_r   ;
wire            X_Sub_get_vil ;

wire [31:0]     Y_Sub_A_out   ;
wire            Y_Sub_A_Vil   ;
wire            Y_Sub_B_Vil   ;
wire [31:0]     Y_Sub_B_out   ;
wire [31:0]     Y_Sub_get_r   ;
wire            Y_Sub_get_vil ;

wire [31:0]     Z_Sub_A_out   ;
wire            Z_Sub_A_Vil   ;
wire            Z_Sub_B_Vil   ;
wire [31:0]     Z_Sub_B_out   ;
wire [31:0]     Z_Sub_get_r   ;
wire            Z_Sub_get_vil ;

wire [31:0]     X_Add_A_out    ;    
wire [31:0]     Y_Add_B_out    ;    
wire            X_Add_A_Vil    ;    
wire            Y_Add_B_Vil    ;  

wire [31:0]     XY_Add_C_out   ;
wire [31:0]     Z_Add_C_out    ;
wire            Z_Add_C_Vil    ;
wire            XY_Add_C_Vil   ;

wire [31:0]     RR_Add_get_XY_R; 
wire [31:0]     RR_Add_get_r   ; 

wire            XY_Add_get_vil ; 
wire            RR_Add_get_vil ; 
    
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
  .aclk                 (Sys_Clk),       
  .s_axis_a_tvalid       (Y_Mul_A_Vil),   
  .s_axis_a_tready    (  ),         
  .s_axis_a_tdata        (Y_Mul_A_out),   
  .s_axis_b_tvalid       (Y_Mul_B_Vil),   
  .s_axis_b_tready    (  ),         
  .s_axis_b_tdata        (Y_Mul_B_out),   
  .m_axis_result_tvalid  (Y_Mul_get_vil), 
  .m_axis_result_tready( 1'b1 ),           
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
     
     
Filter    U_Filter  (
     .   Sys_Clk                     ( Sys_Clk              )  ,
     .   Sys_Rst_n                   ( Sys_Rst_n            )  ,                
     .   Home0_cell_cal_finish       ( Home0_cell_cal_finish)   ,
     .   S_AXIS_COMP_Begin           ( S_AXIS_COMP_Begin    ) ,  //                            
     .   S_AXIS_COMP_2_Begin         ( S_AXIS_COMP_2_Begin  ),  

     .   S_AXIS_home_Index_buf       (S_AXIS_home_Index_buf), 
     .   S_AXIS_Index_buf            (S_AXIS_Index_buf),           

     .   Index_Pos_home              (Index_Pos_home )                    , 
     .   Index_Pos_nei               (Index_Pos_nei  )                    , 

      .  Sum_rr_done                 (Sum_rr_done    ),
      .  M_AXIS_RR_data              (M_AXIS_RR_data ),
    
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
