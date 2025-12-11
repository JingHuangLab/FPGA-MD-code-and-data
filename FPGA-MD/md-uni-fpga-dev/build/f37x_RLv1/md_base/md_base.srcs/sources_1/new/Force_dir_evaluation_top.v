`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 10:27:16 PM
// Design Name: 
// Module Name: Force_dir_evaluation_top
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


module Force_dir_evaluation_top(
input                      Sys_Clk               ,
 input                     Sys_Rst_n             ,
     
 input                     Sum_rr_done           ,
 input       [511:0]       ParaM_X_A             ,
                                            
 output wire [255:0]       M_AXIS_EnE_Force       ,
 output wire               one_Filter_to_cal_Done           
    );  
 
wire    [31:0]      ParaM_Aab      ;    
wire    [31:0]      ParaM_Bab      ;
wire    [31:0]      ParaM_QQab     ;
                                   
wire     [31:0]     ParaM_R_14_C1  ;      
wire     [31:0]     ParaM_R_14_C0  ;
                                   
wire     [31:0]     ParaM_R_8_C1   ;     
wire     [31:0]     ParaM_R_8_C0   ;
                                  
wire    [31:0]      ParaM_R_3_C1   ;      
wire    [31:0]      ParaM_R_3_C0   ;
 

   wire [31:0]    Root_R_A_out   ;
   wire           Root_R_A_Vil   ;   
   wire [31:0]    Root_R_get_r   ;
   wire           Root_R_get_vil ; // 1/r
  
   wire [31:0]    Re_R_A_out ;
   wire           Re_R_A_Vil ;   
   wire  [31:0]   Re_R_get_r;
   wire           Re_R_get_vil; // 1/r
  
   wire [31:0]    R3_Mul_A_out ;  
   wire           R3_Mul_A_Vil ;  
   wire           R3_Mul_B_Vil ;  
   wire [31:0]    R3_Mul_B_out ;  
   wire [31:0]    R3_Mul_get_r;    
   wire           R3_Mul_get_vil; 
    
   wire [31:0]    A_Re_R_A_Mul_out ;  
   wire           A_Re_R_A_Mul_Vil ;  
   wire           A_Re_R_B_Mul_Vil ;  
   wire [31:0]    A_Re_R_B_Mul_out ;  
   wire [31:0]    A_Re_R_get_r;  
   wire           A_Re_R_get_vil; 
   
   wire [31:0]     Re_R3_out ;        
   wire            Re_R3_Vil ;        
   wire  [31:0]    Re_R3_get_r;         
   wire            Re_R3_get_vil; // 1/r
  
   wire [31:0]    Re_R3_X_A_Mul_out ; 
   wire           Re_R3_X_A_Mul_Vil ; 
   wire           Re_R3_X_B_Mul_Vil ; 
   wire [31:0]    Re_R3_X_B_Mul_out ; 
   wire [31:0]    Re_R3_X_get_r   ;
   wire           Re_R3_X_get_vil ;
   
  wire [31:0]    Re_R3_Y_A_Mul_out ;  
  wire           Re_R3_Y_A_Mul_Vil ;  
  wire           Re_R3_Y_B_Mul_Vil ;  
  wire [31:0]    Re_R3_Y_B_Mul_out ;  
  wire [31:0]    Re_R3_Y_get_r   ;
  wire           Re_R3_Y_get_vil ;
     
  wire [31:0]    Re_R3_Z_A_Mul_out ;                    
  wire           Re_R3_Z_A_Mul_Vil ;                    
  wire           Re_R3_Z_B_Mul_Vil ;                    
  wire [31:0]    Re_R3_Z_B_Mul_out ;                    
  wire [31:0]    Re_R3_Z_get_r   ;                   
  wire           Re_R3_Z_get_vil ;                   
  
  wire [31:0]     A_Re_R3_X_A_Mul_out ;  
  wire            A_Re_R3_X_A_Mul_Vil ;  
  wire            A_Re_R3_X_B_Mul_Vil ;  
  wire [31:0]     A_Re_R3_X_B_Mul_out ;  
  wire [31:0]     A_Re_R3_X_get_r   ;   
  wire            A_Re_R3_X_get_vil ;   
  
  wire [31:0]     A_Re_R3_Y_A_Mul_out ;   
  wire            A_Re_R3_Y_A_Mul_Vil ;   
  wire            A_Re_R3_Y_B_Mul_Vil ;   
  wire [31:0]     A_Re_R3_Y_B_Mul_out ;   
  wire [31:0]     A_Re_R3_Y_get_r   ; 
  wire            A_Re_R3_Y_get_vil ; 
  
  wire [31:0]     A_Re_R3_Z_A_Mul_out ;   
  wire            A_Re_R3_Z_A_Mul_Vil ;   
  wire            A_Re_R3_Z_B_Mul_Vil ;   
  wire [31:0]     A_Re_R3_Z_B_Mul_out ;   
  wire [31:0]     A_Re_R3_Z_get_r   ;  
  wire            A_Re_R3_Z_get_vil ;  

 wire [31:0]    R4_Mul_A_out; 
 wire          R4_Mul_A_Vil; 
 wire          R4_Mul_B_Vil; 
 wire [31:0]   R4_Mul_B_out; 
 wire [31:0]   R4_Mul_get_r ; 
 wire          R4_Mul_get_vil;
                           
 wire [31:0]   R6_Mul_A_out ; 
 wire          R6_Mul_A_Vil ; 
 wire          R6_Mul_B_Vil ; 
 wire [31:0]   R6_Mul_B_out ; 
 wire [31:0]   R6_Mul_get_r;  
 wire          R6_Mul_get_vil; 
                              
 wire [31:0]   R12_Mul_A_out ;
 wire          R12_Mul_A_Vil ;
 wire          R12_Mul_B_Vil ;
 wire [31:0]   R12_Mul_B_out ;
 wire [31:0]   R12_Mul_get_r;  
 wire          R12_Mul_get_vil;
                              
 wire [31:0]   Re_R12_A_out ; 
 wire          Re_R12_A_Vil ; 
 wire [31:0]   Re_R12_get_r;   
 wire          Re_R12_get_vil ;
                              
 wire [31:0]   Re_R6_A_out ;  
 wire          Re_R6_A_Vil ;  
 wire [31:0]   Re_R6_get_r;   
 wire          Re_R6_get_vil; 
                           
 wire [31:0]   A_Re_R12_A_out ;
 wire          A_Re_R12_A_Vil ;
 wire          A_Re_R12_B_Vil ;
 wire [31:0]   A_Re_R12_B_out ;
 wire [31:0]   A_Re_R12_get_r;
 wire          A_Re_R12_get_vil;
                           
 wire [31:0]   B_Re_R6_A_out ;
 wire          B_Re_R6_A_Vil ;
 wire          B_Re_R6_B_Vil ;
 wire [31:0]   B_Re_R6_B_out ;
 wire [31:0]   B_Re_R6_get_r;  
 wire          B_Re_R6_get_vil;
                            
 wire [31:0]   Energy_A_out  ;   
 wire          Energy_A_Vil  ;   
 wire          Energy_B_Vil  ;   
 wire   [31:0] Energy_B_out  ;   
 wire   [31:0] Energy_get_r  ;  
 wire          Energy_get_vil;      
  
   wire   [31:0] R14_Mul_A_out  ;    //B 1/r14 to caculation mul unit   
   wire          R14_Mul_A_Vil  ;
   wire          R14_Mul_B_Vil  ;
   wire   [31:0] R14_Mul_B_out  ;
   wire  [31:0]  R14_Mul_get_r  ;  
   wire          R14_Mul_get_vil;
    
  wire    [31:0]   Re_R14_A_out  ; 
  wire             Re_R14_A_Vil  ; 
  wire    [31:0]   Re_R14_get_r  ;  
  wire             Re_R14_get_vil;
    
  wire      [31:0]   R8_Mul_A_out    ;       
  wire               R8_Mul_A_Vil    ;     
  wire               R8_Mul_B_Vil    ;     
  wire      [31:0]   R8_Mul_B_out    ;     
  wire      [31:0]   R8_Mul_get_r    ;     
  wire               R8_Mul_get_vil  ;
  
  wire       [31:0]   Re_R8_A_out    ; 
  wire                Re_R8_A_Vil    ; 
  wire       [31:0]   Re_R8_get_r    ;  
  wire                Re_R8_get_vil  ;
    
    
  wire      [31:0]   B_R8_Mul_A_out   ;    
  wire               B_R8_Mul_A_Vil   ;    
  wire               B_R8_Mul_B_Vil   ;    
  wire      [31:0]   B_R8_Mul_B_out   ;    
  wire      [31:0]   B_R8_Mul_get_r   ;      
  wire               B_R8_Mul_get_vil ;     
          
   wire      [31:0]   A_R14_Mul_A_out ;   
   wire               A_R14_Mul_A_Vil ;   
   wire               A_R14_Mul_B_Vil ;   
   wire      [31:0]   A_R14_Mul_B_out ;   
   wire      [31:0]   A_R14_Mul_get_r ;     
   wire               A_R14_Mul_get_vil ;        
    
    wire     [31:0]   R14_sub_R8_A_out ;  
    wire              R14_sub_R8_A_Vil ;  
    wire              R14_sub_R8_B_Vil ;  
    wire     [31:0]   R14_sub_R8_B_out ;  
    wire     [31:0]   R14_sub_R8_get_r ;   
    wire              R14_sub_R8_get_vil ; 
    
    wire     [31:0]   X_R8_R14_Mul_A_out ;  
    wire              X_R8_R14_Mul_A_Vil ;  
    wire              X_R8_R14_Mul_B_Vil ;  
    wire     [31:0]   X_R8_R14_Mul_B_out ;  
    wire     [31:0]   X_R8_R14_Mul_get_r ;     
    wire              X_R8_R14_Mul_get_vil ; 
                                             
    wire    [31:0]   Y_R8_R14_Mul_A_out ; 
    wire             Y_R8_R14_Mul_A_Vil ; 
    wire             Y_R8_R14_Mul_B_Vil ; 
    wire    [31:0]   Y_R8_R14_Mul_B_out ; 
    wire    [31:0]   Y_R8_R14_Mul_get_r  ;  
    wire             Y_R8_R14_Mul_get_vil ;
    
     wire    [31:0]   Z_R8_R14_Mul_A_out  ;   
     wire             Z_R8_R14_Mul_A_Vil  ;   
     wire             Z_R8_R14_Mul_B_Vil  ;  
     wire    [31:0]   Z_R8_R14_Mul_B_out  ;  
     wire    [31:0]   Z_R8_R14_Mul_get_r  ;   
     wire             Z_R8_R14_Mul_get_vil ;



floating_point_Root          U_FP_Root_R (
  .aclk                 (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid      (Root_R_A_Vil         )  ,            // input wire s_axis_a_tvalid
  .s_axis_a_tready      (                     ),            // output wire s_axis_a_tready
  .s_axis_a_tdata       (Root_R_A_out         ),              // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid (Root_R_get_vil       ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready (   1'b1              ),  // input wire m_axis_result_tready
  .m_axis_result_tdata  (Root_R_get_r         )    // output wire [31 : 0] m_axis_result_tdata
);


   floating_point_Re         U_FP_Re_R (
    .aclk                     (Sys_Clk),                                  // input wire aclk
    .s_axis_a_tvalid          (Re_R_A_Vil),            // input wire s_axis_a_tvalid
    .s_axis_a_tready          (   ),                   // output wire s_axis_a_tready
    .s_axis_a_tdata           (Re_R_A_out),              // input wire [31 : 0] s_axis_a_tdata
    .m_axis_result_tvalid     (Re_R_get_vil),  // output wire m_axis_result_tvalid
    .m_axis_result_tready     ( 1'b1),                   // input wire m_axis_result_tready
    .m_axis_result_tdata      (Re_R_get_r)    // output wire [31 : 0] m_axis_result_tdata
  ); 
   
 floating_point_MUL U_FP_R3_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (R3_Mul_A_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (R3_Mul_A_out),   
  .s_axis_b_tvalid       (R3_Mul_B_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (R3_Mul_B_out),   
  .m_axis_result_tvalid  (R3_Mul_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (R3_Mul_get_r)   
);

 floating_point_MUL U_FP_A_Re_R_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (A_Re_R_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (A_Re_R_A_Mul_out),   
  .s_axis_b_tvalid       (A_Re_R_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (A_Re_R_B_Mul_out),   
  .m_axis_result_tvalid  (A_Re_R_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (A_Re_R_get_r)   
);
    
 floating_point_Re       U_FP_Re_R3 (
    .aclk                     (Sys_Clk   ),                                  // input wire aclk
    .s_axis_a_tvalid          (Re_R3_Vil ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready          (          ),                   // output wire s_axis_a_tready
    .s_axis_a_tdata           (Re_R3_out ),              // input wire [31 : 0] s_axis_a_tdata
    .m_axis_result_tvalid     (Re_R3_get_vil),  // output wire m_axis_result_tvalid
    .m_axis_result_tready     ( 1'b1        ),                   // input wire m_axis_result_tready
    .m_axis_result_tdata      (Re_R3_get_r  )    // output wire [31 : 0] m_axis_result_tdata
  ); 
  
 floating_point_MUL U_FP_Re_R3_X_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Re_R3_X_A_Mul_Vil),   
  .s_axis_a_tready       ( ),         
  .s_axis_a_tdata        (Re_R3_X_A_Mul_out),   
  .s_axis_b_tvalid       (Re_R3_X_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Re_R3_X_B_Mul_out),   
  .m_axis_result_tvalid  (Re_R3_X_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Re_R3_X_get_r)   
);
    
floating_point_MUL     U_FP_Re_R3_Y_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Re_R3_Y_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Re_R3_Y_A_Mul_out),   
  .s_axis_b_tvalid       (Re_R3_Y_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Re_R3_Y_B_Mul_out),   
  .m_axis_result_tvalid  (Re_R3_Y_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Re_R3_Y_get_r)   
);
    
   floating_point_MUL      U_FP_Re_R3_Z_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (Re_R3_Z_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (Re_R3_Z_A_Mul_out),   
  .s_axis_b_tvalid       (Re_R3_Z_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (Re_R3_Z_B_Mul_out),   
  .m_axis_result_tvalid  (Re_R3_Z_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (Re_R3_Z_get_r)   
);
    
  floating_point_MUL     U_FP_A_Re_R3_X_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (A_Re_R3_X_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (A_Re_R3_X_A_Mul_out),   
  .s_axis_b_tvalid       (A_Re_R3_X_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (A_Re_R3_X_B_Mul_out),   
  .m_axis_result_tvalid  (A_Re_R3_X_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (A_Re_R3_X_get_r)   
);
                   
  floating_point_MUL      U_FP_A_Re_R3_Y_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (A_Re_R3_Y_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (A_Re_R3_Y_A_Mul_out),   
  .s_axis_b_tvalid       (A_Re_R3_Y_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (A_Re_R3_Y_B_Mul_out),   
  .m_axis_result_tvalid  (A_Re_R3_Y_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (A_Re_R3_Y_get_r)   
);                 
               
 floating_point_MUL       U_FP_A_Re_R3_Z_Mul (
  .aclk                  (Sys_Clk),       
  .s_axis_a_tvalid       (A_Re_R3_Z_A_Mul_Vil),   
  .s_axis_a_tready        ( ),         
  .s_axis_a_tdata        (A_Re_R3_Z_A_Mul_out),   
  .s_axis_b_tvalid       (A_Re_R3_Z_B_Mul_Vil),   
  .s_axis_b_tready       (  ),         
  .s_axis_b_tdata        (A_Re_R3_Z_B_Mul_out),   
  .m_axis_result_tvalid  (A_Re_R3_Z_get_vil), 
  .m_axis_result_tready  (  1'b1),           
  .m_axis_result_tdata   (A_Re_R3_Z_get_r)   
);    


floating_point_MUL       U_FP_Mul_R4 (
   .aclk                    (Sys_Clk),       
   .s_axis_a_tvalid         (R4_Mul_A_Vil),   
   .s_axis_a_tready   (  ),           
   .s_axis_a_tdata          (R4_Mul_A_out),   
   .s_axis_b_tvalid         (R4_Mul_B_Vil),   
   .s_axis_b_tready   ( ),         
   .s_axis_b_tdata          (R4_Mul_B_out),   
   .m_axis_result_tvalid    (R4_Mul_get_vil), 
   .m_axis_result_tready( 1'b1),           
   .m_axis_result_tdata     (R4_Mul_get_r)   
 );
 
  floating_point_MUL  U_FP_Mul_R6 (
   .aclk                    (Sys_Clk        ),       
   .s_axis_a_tvalid         (R6_Mul_A_Vil   ),   
   .s_axis_a_tready         (  ),          
   .s_axis_a_tdata          (R6_Mul_A_out   ),   
   .s_axis_b_tvalid         (R6_Mul_B_Vil   ),   
   .s_axis_b_tready         (   ),        
   .s_axis_b_tdata          (R6_Mul_B_out   ),   
   .m_axis_result_tvalid    (R6_Mul_get_vil ), 
   .m_axis_result_tready    ( 1'b1),         
   .m_axis_result_tdata     (R6_Mul_get_r   )   
 );
 
  floating_point_MUL  U_FP_Mul_R12 (
   .aclk                    (Sys_Clk),       
   .s_axis_a_tvalid         (R12_Mul_A_Vil),   
   .s_axis_a_tready   (  ),         
   .s_axis_a_tdata          (R12_Mul_A_out),   
   .s_axis_b_tvalid         (R12_Mul_B_Vil),   
   .s_axis_b_tready   (   ),       
   .s_axis_b_tdata          (R12_Mul_B_out),   
   .m_axis_result_tvalid    (R12_Mul_get_vil), 
   .m_axis_result_tready(1'b1 ),         
   .m_axis_result_tdata     (R12_Mul_get_r)   
 );
  
  floating_point_Re       U_FP_Re_R12 (
    .aclk                     (Sys_Clk),                                  // input wire aclk
    .s_axis_a_tvalid          (Re_R12_A_Vil),            // input wire s_axis_a_tvalid
    .s_axis_a_tready          (  ),                     // output wire s_axis_a_tready
    .s_axis_a_tdata           (Re_R12_A_out),              // input wire [31 : 0] s_axis_a_tdata
    .m_axis_result_tvalid     (Re_R12_get_vil),  // output wire m_axis_result_tvalid
    .m_axis_result_tready     (1'b1 ),                     // input wire m_axis_result_tready
    .m_axis_result_tdata      (Re_R12_get_r)    // output wire [31 : 0] m_axis_result_tdata
  ); 
 
   floating_point_Re      U_FP_Re_R6 (
    .aclk                     (Sys_Clk),                                  // input wire aclk
    .s_axis_a_tvalid          (Re_R6_A_Vil),            // input wire s_axis_a_tvalid
    .s_axis_a_tready          (   ),                   // output wire s_axis_a_tready
    .s_axis_a_tdata           (Re_R6_A_out),              // input wire [31 : 0] s_axis_a_tdata
    .m_axis_result_tvalid     (Re_R6_get_vil),  // output wire m_axis_result_tvalid
    .m_axis_result_tready     ( 1'b1),                   // input wire m_axis_result_tready
    .m_axis_result_tdata      (Re_R6_get_r)    // output wire [31 : 0] m_axis_result_tdata
  ); 
 
 
  
   floating_point_MUL  U_FP_Mul_A_Re_R12 (
   .aclk                    (Sys_Clk),       
   .s_axis_a_tvalid         (A_Re_R12_A_Vil),   
   .s_axis_a_tready         (              ),   
   .s_axis_a_tdata          (A_Re_R12_A_out),   
   .s_axis_b_tvalid         (A_Re_R12_B_Vil),   
   .s_axis_b_tready         (              ),   
   .s_axis_b_tdata          (A_Re_R12_B_out),   
   .m_axis_result_tvalid    (A_Re_R12_get_vil), 
   .m_axis_result_tready    (1'b1 ),  
   .m_axis_result_tdata     (A_Re_R12_get_r)   
 );
  
   floating_point_MUL  U_FP_Mul_B_Re_R6 (
   .aclk                    (Sys_Clk),       
   .s_axis_a_tvalid         (B_Re_R6_A_Vil),   
   .s_axis_a_tready   (   ),   
   .s_axis_a_tdata          (B_Re_R6_A_out),   
   .s_axis_b_tvalid         (B_Re_R6_B_Vil),   
   .s_axis_b_tready   (  ) ,    
   .s_axis_b_tdata          (B_Re_R6_B_out),   
   .m_axis_result_tvalid    (B_Re_R6_get_vil), 
   .m_axis_result_tready    (1'b1 ), 
   .m_axis_result_tdata     (B_Re_R6_get_r)   
 );
  
   floating_point_SUB        U_FP_R12_R6_Sub(
   .aclk                    (Sys_Clk),       
   .s_axis_a_tvalid         (Energy_A_Vil),   
   .s_axis_a_tready   (  ),   
   .s_axis_a_tdata          (Energy_A_out),   
   .s_axis_b_tvalid         (Energy_B_Vil),   
   .s_axis_b_tready   ( ),   
   .s_axis_b_tdata          (Energy_B_out),   
   .m_axis_result_tvalid    (Energy_get_vil), 
   .m_axis_result_tready( 1'b1),
   .m_axis_result_tdata     (Energy_get_r)   
 );

floating_point_Re       U_FP_Re_R14 (
  .aclk                 (Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid      (Re_R14_A_Vil         )  ,            // input wire s_axis_a_tvalid
  .s_axis_a_tready      (                    ),            // output wire s_axis_a_tready
  .s_axis_a_tdata       (Re_R14_A_out         ),              // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid (Re_R14_get_vil       ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready (   1'b1                   ),  // input wire m_axis_result_tready
  .m_axis_result_tdata  (Re_R14_get_r         )    // output wire [31 : 0] m_axis_result_tdata
);

  floating_point_Re      U_FP_Re_R8(
    .aclk                (Sys_Clk),                                  // input wire aclk
    .s_axis_a_tvalid     (Re_R8_A_Vil       ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready     (                  ),            // output wire s_axis_a_tready
    .s_axis_a_tdata      (Re_R8_A_out       ),              // input wire [31 : 0] s_axis_a_tdata
    .m_axis_result_tvalid(Re_R8_get_vil     ),  // output wire m_axis_result_tvalid
    .m_axis_result_tready(   1'b1               ),  // input wire m_axis_result_tready
    .m_axis_result_tdata (Re_R8_get_r       )    // output wire [31 : 0] m_axis_result_tdata
  );
  
  floating_point_MUL      U_FP_Mul_R8 (
    .aclk                (Sys_Clk         ),                                    // input wire aclk
    .s_axis_a_tvalid     (R8_Mul_A_Vil    ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready     (                ),            // output wire s_axis_a_tready
    .s_axis_a_tdata      (R8_Mul_A_out    ),              // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid     (R8_Mul_B_Vil    ),            // input wire s_axis_b_tvalid
    .s_axis_b_tready     (                ),            // output wire s_axis_b_tready
    .s_axis_b_tdata      (R8_Mul_B_out    ),              // input wire [31 : 0] s_axis_b_tdata
    .m_axis_result_tvalid(R8_Mul_get_vil  ),  // output wire m_axis_result_tvalid
    .m_axis_result_tready(   1'b1              ),  // input wire m_axis_result_tready
    .m_axis_result_tdata (R8_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
  );
  
 floating_point_MUL      U_FP_Mul_R14 (
    .aclk                (Sys_Clk         ),                                    // input wire aclk
    .s_axis_a_tvalid     (R14_Mul_A_Vil    ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready     (                ),            // output wire s_axis_a_tready
    .s_axis_a_tdata      (R14_Mul_A_out    ),              // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid     (R14_Mul_B_Vil    ),            // input wire s_axis_b_tvalid
    .s_axis_b_tready     (                ),            // output wire s_axis_b_tready
    .s_axis_b_tdata      (R14_Mul_B_out    ),              // input wire [31 : 0] s_axis_b_tdata
    .m_axis_result_tvalid(R14_Mul_get_vil  ),  // output wire m_axis_result_tvalid
    .m_axis_result_tready(    1'b1            ),  // input wire m_axis_result_tready
    .m_axis_result_tdata (R14_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
  );
  
 floating_point_MUL       U_FP_MUL_A_R14 (
    .aclk                (Sys_Clk         ),                                    // input wire aclk
    .s_axis_a_tvalid     (A_R14_Mul_A_Vil    ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready     (                ),            // output wire s_axis_a_tready
    .s_axis_a_tdata      (A_R14_Mul_A_out    ),              // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid     (A_R14_Mul_B_Vil    ),            // input wire s_axis_b_tvalid
    .s_axis_b_tready     (                ),            // output wire s_axis_b_tready
    .s_axis_b_tdata      (A_R14_Mul_B_out    ),              // input wire [31 : 0] s_axis_b_tdata
    .m_axis_result_tvalid(A_R14_Mul_get_vil  ),  // output wire m_axis_result_tvalid
    .m_axis_result_tready(   1'b1             ),  // input wire m_axis_result_tready
    .m_axis_result_tdata (A_R14_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
  );
  
  
 floating_point_MUL        U_FP_MUL_B_R8 (
    .aclk                (Sys_Clk         ),                                    // input wire aclk
    .s_axis_a_tvalid     (B_R8_Mul_A_Vil    ),            // input wire s_axis_a_tvalid
    .s_axis_a_tready     (                  ),            // output wire s_axis_a_tready
    .s_axis_a_tdata      (B_R8_Mul_A_out    ),              // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid     (B_R8_Mul_B_Vil    ),            // input wire s_axis_b_tvalid
    .s_axis_b_tready     (                  ),            // output wire s_axis_b_tready
    .s_axis_b_tdata      (B_R8_Mul_B_out    ),              // input wire [31 : 0] s_axis_b_tdata
    .m_axis_result_tvalid(B_R8_Mul_get_vil  ),  // output wire m_axis_result_tvalid
    .m_axis_result_tready(      1'b1            ),  // input wire m_axis_result_tready
    .m_axis_result_tdata (B_R8_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
  );
  
  
  floating_point_SUB               U_FP_R14_SUB_R8 (
  .aclk(Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid       (R14_sub_R8_A_Vil   ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready       (                   ),            // output wire s_axis_a_tready
  .s_axis_a_tdata        (R14_sub_R8_A_out   ),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid       (R14_sub_R8_B_Vil   ),            // input wire s_axis_b_tvalid
  .s_axis_b_tready       (                   ),            // output wire s_axis_b_tready
  .s_axis_b_tdata        (R14_sub_R8_B_out   ),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid  (R14_sub_R8_get_vil ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready  (       1'b1            ),  // input wire m_axis_result_tready
  .m_axis_result_tdata   (R14_sub_R8_get_r    )    // output wire [31 : 0] m_axis_result_tdata
);
  
 
   floating_point_MUL       U_X_R8_R14_Mul (
  .aclk(Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid       (X_R8_R14_Mul_A_Vil   ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready       (                   ),            // output wire s_axis_a_tready
  .s_axis_a_tdata        (X_R8_R14_Mul_A_out   ),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid       (X_R8_R14_Mul_B_Vil   ),            // input wire s_axis_b_tvalid
  .s_axis_b_tready       (                   ),            // output wire s_axis_b_tready
  .s_axis_b_tdata        (X_R8_R14_Mul_B_out   ),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid  (X_R8_R14_Mul_get_vil ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready  (      1'b1             ),  // input wire m_axis_result_tready
  .m_axis_result_tdata   (X_R8_R14_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
);
  
    floating_point_MUL      U_Y_R8_R14_Mul (
  .aclk(Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid       (Y_R8_R14_Mul_A_Vil   ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready       (                   ),            // output wire s_axis_a_tready
  .s_axis_a_tdata        (Y_R8_R14_Mul_A_out   ),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid       (Y_R8_R14_Mul_B_Vil   ),            // input wire s_axis_b_tvalid
  .s_axis_b_tready       (                   ),            // output wire s_axis_b_tready
  .s_axis_b_tdata        (Y_R8_R14_Mul_B_out   ),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid  (Y_R8_R14_Mul_get_vil ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready  (      1'b1             ),  // input wire m_axis_result_tready
  .m_axis_result_tdata   (Y_R8_R14_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
);  

 
    floating_point_MUL     U_Z_R8_R14_Mul (
  .aclk(Sys_Clk),                                  // input wire aclk
  .s_axis_a_tvalid       (Z_R8_R14_Mul_A_Vil   ),            // input wire s_axis_a_tvalid
  .s_axis_a_tready       (                     ),            // output wire s_axis_a_tready
  .s_axis_a_tdata        (Z_R8_R14_Mul_A_out   ),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid       (Z_R8_R14_Mul_B_Vil   ),            // input wire s_axis_b_tvalid
  .s_axis_b_tready       (                     ),            // output wire s_axis_b_tready
  .s_axis_b_tdata        (Z_R8_R14_Mul_B_out   ),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid  (Z_R8_R14_Mul_get_vil ),  // output wire m_axis_result_tvalid
  .m_axis_result_tready  (      1'b1               ),  // input wire m_axis_result_tready
  .m_axis_result_tdata   (Z_R8_R14_Mul_get_r    )    // output wire [31 : 0] m_axis_result_tdata
);


Col_dir_Moudle U_Col_dir_Moudle(
.Sys_Clk               ( Sys_Clk                  ) ,
.Sys_Rst_n             ( Sys_Rst_n                ) ,
 
. ParaM_X_A            ( ParaM_X_A                ) ,// X= rr      
. Sum_rr_done          ( Sum_rr_done              ) , 
 
. ParaM_Aab            (  ParaM_Aab               ) ,      
. ParaM_Bab            (  ParaM_Bab               ) , 
. ParaM_QQab           (  ParaM_QQab              ) ,
 
. ParaM_R_14_C1        (  ParaM_R_14_C1           ) ,      
. ParaM_R_14_C0        (  ParaM_R_14_C0           ) , 
 
. ParaM_R_8_C1         (  ParaM_R_8_C1            ) ,      
. ParaM_R_8_C0         (  ParaM_R_8_C0            ) ,
 
. ParaM_R_3_C1         (  ParaM_R_3_C1            ) ,      
. ParaM_R_3_C0         (  ParaM_R_3_C0            ) ,
.  one_Filter_to_cal_Done( one_Filter_to_cal_Done ) 

   
    );
    
    
Force_dir_evaluation U_Force_dir_evaluation(   
  .  Sys_Clk               (Sys_Clk             ),
  .  Sys_Rst_n             (Sys_Rst_n           ),
  .  Sum_rr_done           (Sum_rr_done         ),
  .  ParaM_X_A             (ParaM_X_A           ),// X= rr      

  .  M_AXIS_EnE_Force      ( M_AXIS_EnE_Force     ),
  .  one_Filter_to_cal_Done( one_Filter_to_cal_Done),

  .  ParaM_Aab            (  ParaM_Aab            ),      
  .  ParaM_Bab            (  ParaM_Bab            ), 
  .  ParaM_QQab           (  ParaM_QQab           ),
 
  .  ParaM_R_14_C1        (  ParaM_R_14_C1        ),      
  .  ParaM_R_14_C0        (  ParaM_R_14_C0        ), 
 
  .  ParaM_R_8_C1         (  ParaM_R_8_C1         ),      
  .  ParaM_R_8_C0         (  ParaM_R_8_C0         ),
 
  .  ParaM_R_3_C1         (  ParaM_R_3_C1         ) ,      
  .  ParaM_R_3_C0         (  ParaM_R_3_C0         ) ,
 

.Root_R_A_out        (Root_R_A_out        )  ,                          
.Root_R_A_Vil        (Root_R_A_Vil        )  ,                          
.Root_R_get_r        (Root_R_get_r        )  ,                           
.Root_R_get_vil      (Root_R_get_vil      )  , // 1/r                  
                 
.Re_R_A_out          (Re_R_A_out          )  ,                            
.Re_R_A_Vil          (Re_R_A_Vil          )  ,                            
.Re_R_get_r          (Re_R_get_r          )  ,                             
.Re_R_get_vil        (Re_R_get_vil        )  , // 1/r                    
                 
.R3_Mul_A_out        (R3_Mul_A_out        )  ,                          
.R3_Mul_A_Vil        (R3_Mul_A_Vil        )  ,                          
.R3_Mul_B_Vil        (R3_Mul_B_Vil        )  ,                          
.R3_Mul_B_out        (R3_Mul_B_out        )  ,                          
.R3_Mul_get_r        (R3_Mul_get_r        )  ,                           
.R3_Mul_get_vil      (R3_Mul_get_vil      )   ,                         
               
.A_Re_R_A_Mul_out    (A_Re_R_A_Mul_out    )    ,                      
.A_Re_R_A_Mul_Vil    (A_Re_R_A_Mul_Vil    )    ,                      
.A_Re_R_B_Mul_Vil    (A_Re_R_B_Mul_Vil    )    ,                      
.A_Re_R_B_Mul_out    (A_Re_R_B_Mul_out    )    ,                      
.A_Re_R_get_r        (A_Re_R_get_r        )    ,                           
.A_Re_R_get_vil      (A_Re_R_get_vil      )    ,                         
               
.Re_R3_out           (Re_R3_out           )     ,                             
.Re_R3_Vil           (Re_R3_Vil           )     ,                             
.Re_R3_get_r         (Re_R3_get_r         )     ,                            
.Re_R3_get_vil       (Re_R3_get_vil       )      , // 1/r                   
         
.Re_R3_X_A_Mul_out   (Re_R3_X_A_Mul_out   )      ,                     
.Re_R3_X_A_Mul_Vil   (Re_R3_X_A_Mul_Vil   )      ,                     
.Re_R3_X_B_Mul_Vil   (Re_R3_X_B_Mul_Vil   )      ,                     
.Re_R3_X_B_Mul_out   (Re_R3_X_B_Mul_out   )      ,                     
.Re_R3_X_get_r       (Re_R3_X_get_r       )      ,                       
.Re_R3_X_get_vil     (Re_R3_X_get_vil     )      ,                       
           
.Re_R3_Y_A_Mul_out   (Re_R3_Y_A_Mul_out   )       ,                     
.Re_R3_Y_A_Mul_Vil   (Re_R3_Y_A_Mul_Vil   )       ,                     
.Re_R3_Y_B_Mul_Vil   (Re_R3_Y_B_Mul_Vil   )       ,                     
.Re_R3_Y_B_Mul_out   (Re_R3_Y_B_Mul_out   )       ,                     
.Re_R3_Y_get_r       (Re_R3_Y_get_r       )       ,                       
.Re_R3_Y_get_vil     (Re_R3_Y_get_vil     )       ,                       
                
.Re_R3_Z_A_Mul_out   (Re_R3_Z_A_Mul_out   )       ,                     
.Re_R3_Z_A_Mul_Vil   (Re_R3_Z_A_Mul_Vil   )       ,                     
.Re_R3_Z_B_Mul_Vil   (Re_R3_Z_B_Mul_Vil   )       ,                     
.Re_R3_Z_B_Mul_out   (Re_R3_Z_B_Mul_out   )       ,                     
.Re_R3_Z_get_r       (Re_R3_Z_get_r       )        ,                       
.Re_R3_Z_get_vil     (Re_R3_Z_get_vil     )        ,                       
                 
.A_Re_R3_X_A_Mul_out (A_Re_R3_X_A_Mul_out )         ,                   
.A_Re_R3_X_A_Mul_Vil (A_Re_R3_X_A_Mul_Vil )         ,                   
.A_Re_R3_X_B_Mul_Vil (A_Re_R3_X_B_Mul_Vil )         ,                   
.A_Re_R3_X_B_Mul_out (A_Re_R3_X_B_Mul_out )         ,                   
.A_Re_R3_X_get_r     (A_Re_R3_X_get_r     )         ,                     
.A_Re_R3_X_get_vil   (A_Re_R3_X_get_vil   )         ,                     
                
.A_Re_R3_Y_A_Mul_out (A_Re_R3_Y_A_Mul_out )         ,                   
.A_Re_R3_Y_A_Mul_Vil (A_Re_R3_Y_A_Mul_Vil )         ,                   
.A_Re_R3_Y_B_Mul_Vil (A_Re_R3_Y_B_Mul_Vil )         ,                   
.A_Re_R3_Y_B_Mul_out (A_Re_R3_Y_B_Mul_out )         ,                   
.A_Re_R3_Y_get_r     (A_Re_R3_Y_get_r     )         ,                     
.A_Re_R3_Y_get_vil   (A_Re_R3_Y_get_vil   )         ,                     
                
.A_Re_R3_Z_A_Mul_out (A_Re_R3_Z_A_Mul_out )          ,                   
.A_Re_R3_Z_A_Mul_Vil (A_Re_R3_Z_A_Mul_Vil )          ,                   
.A_Re_R3_Z_B_Mul_Vil (A_Re_R3_Z_B_Mul_Vil )          ,                   
.A_Re_R3_Z_B_Mul_out (A_Re_R3_Z_B_Mul_out )          ,                   
.A_Re_R3_Z_get_r     (A_Re_R3_Z_get_r     )          ,                     
.A_Re_R3_Z_get_vil   (A_Re_R3_Z_get_vil   )          ,                     


.  R4_Mul_A_out  (R4_Mul_A_out   ),             
.  R4_Mul_A_Vil  (R4_Mul_A_Vil   ),              
.  R4_Mul_B_Vil  (R4_Mul_B_Vil   ),              
.  R4_Mul_B_out  (R4_Mul_B_out   ),              
.  R4_Mul_get_r  (R4_Mul_get_r   ) ,            
.  R4_Mul_get_vil(R4_Mul_get_vil ) ,            
                       
.  R6_Mul_A_out    (R6_Mul_A_out    ),             
.  R6_Mul_A_Vil    (R6_Mul_A_Vil    ),             
.  R6_Mul_B_Vil    (R6_Mul_B_Vil    ),             
.  R6_Mul_B_out    (R6_Mul_B_out    ),             
.  R6_Mul_get_r   ( R6_Mul_get_r   ),             
.  R6_Mul_get_vil ( R6_Mul_get_vil ),          
                           
.  R12_Mul_A_out  (R12_Mul_A_out  ),           
.  R12_Mul_A_Vil  (R12_Mul_A_Vil  ),           
.  R12_Mul_B_Vil  (R12_Mul_B_Vil  ),           
.  R12_Mul_B_out  (R12_Mul_B_out  ),           
.  R12_Mul_get_r  (R12_Mul_get_r  ),            
.  R12_Mul_get_vil(R12_Mul_get_vil),          
                        
.  Re_R12_A_out    (Re_R12_A_out   ),            
.  Re_R12_A_Vil    (Re_R12_A_Vil   ),            
.  Re_R12_get_r   ( Re_R12_get_r  ),            
.  Re_R12_get_vil ( Re_R12_get_vil),         
                          
.  Re_R6_A_out   (Re_R6_A_out   ),              
.  Re_R6_A_Vil   (Re_R6_A_Vil   ),              
.  Re_R6_get_r  ( Re_R6_get_r  ),              
.  Re_R6_get_vil( Re_R6_get_vil),            
                       
.  A_Re_R12_A_out   ( A_Re_R12_A_out   ),         
.  A_Re_R12_A_Vil   ( A_Re_R12_A_Vil   ),            
.  A_Re_R12_B_Vil   ( A_Re_R12_B_Vil  ),           
.  A_Re_R12_B_out   ( A_Re_R12_B_out  ),      
.  A_Re_R12_get_r   ( A_Re_R12_get_r ),       
.  A_Re_R12_get_vil ( A_Re_R12_get_vil),      
                           
.  B_Re_R6_A_out     (  B_Re_R6_A_out     ),          
.  B_Re_R6_A_Vil     (  B_Re_R6_A_Vil     ),          
.  B_Re_R6_B_Vil     (  B_Re_R6_B_Vil     ),          
.  B_Re_R6_B_out     (  B_Re_R6_B_out     ),          
.  B_Re_R6_get_r     (  B_Re_R6_get_r     ),       
.  B_Re_R6_get_vil   (  B_Re_R6_get_vil   ) ,
 
 .  Energy_A_out  (  Energy_A_out  ),
 .  Energy_A_Vil  (  Energy_A_Vil  ),
 .  Energy_B_Vil  (  Energy_B_Vil  ),
 .  Energy_B_out  (  Energy_B_out  ),
 .  Energy_get_r  (  Energy_get_r  ),
 .  Energy_get_vil(  Energy_get_vil),   
 
 .  R14_Mul_A_out    (R14_Mul_A_out  )   ,      //B 
 .  R14_Mul_A_Vil    (R14_Mul_A_Vil  )  ,          
 .  R14_Mul_B_Vil    (R14_Mul_B_Vil  )  ,         
 .  R14_Mul_B_out    (R14_Mul_B_out  )  ,         
 .  R14_Mul_get_r    (R14_Mul_get_r  )  ,          
 .  R14_Mul_get_vil  (R14_Mul_get_vil)  ,         
                         
 .  Re_R14_A_out          (Re_R14_A_out   ) ,         
 .  Re_R14_A_Vil          (Re_R14_A_Vil   ) ,         
 .  Re_R14_get_r          (Re_R14_get_r   ) ,          
 .  Re_R14_get_vil        (Re_R14_get_vil ) ,        
                         
  .R8_Mul_A_out         (R8_Mul_A_out   )  ,         
  .R8_Mul_A_Vil         (R8_Mul_A_Vil   )  ,         
  .R8_Mul_B_Vil         (R8_Mul_B_Vil   )  ,        
  .R8_Mul_B_out         (R8_Mul_B_out   )  ,        
  .R8_Mul_get_r         (R8_Mul_get_r   )  ,         
  .R8_Mul_get_vil       (R8_Mul_get_vil )    ,      
                         
  .Re_R8_A_out          (Re_R8_A_out   )   ,          
  .Re_R8_A_Vil          (Re_R8_A_Vil   )   ,          
  .Re_R8_get_r          (Re_R8_get_r   )   ,           
  .Re_R8_get_vil        (Re_R8_get_vil )   ,         
                        
                        
  .B_R8_Mul_A_out       (B_R8_Mul_A_out   ) ,       
  .B_R8_Mul_A_Vil       (B_R8_Mul_A_Vil   ) ,       
  .B_R8_Mul_B_Vil       (B_R8_Mul_B_Vil   )  ,      
  .B_R8_Mul_B_out       (B_R8_Mul_B_out   ) ,      
  .B_R8_Mul_get_r       (B_R8_Mul_get_r   ) ,       
  .B_R8_Mul_get_vil     (B_R8_Mul_get_vil )  ,     
                       
  .A_R14_Mul_A_out      (A_R14_Mul_A_out    )  ,      
  .A_R14_Mul_A_Vil      (A_R14_Mul_A_Vil    )  ,      
  .A_R14_Mul_B_Vil      (A_R14_Mul_B_Vil    )  ,     
  .A_R14_Mul_B_out      (A_R14_Mul_B_out    )  ,     
  .A_R14_Mul_get_r      (A_R14_Mul_get_r    )   ,      
  .A_R14_Mul_get_vil    (A_R14_Mul_get_vil  )   ,    
                        
  .R14_sub_R8_A_out     (R14_sub_R8_A_out   )   ,     
  .R14_sub_R8_A_Vil     (R14_sub_R8_A_Vil   )   ,     
  .R14_sub_R8_B_Vil     (R14_sub_R8_B_Vil   )  ,    
  .R14_sub_R8_B_out     (R14_sub_R8_B_out   )  ,    
  .R14_sub_R8_get_r     (R14_sub_R8_get_r   )  ,     
  .R14_sub_R8_get_vil   (R14_sub_R8_get_vil )   ,   
                       
  .X_R8_R14_Mul_A_out   (X_R8_R14_Mul_A_out   )   ,   
  .X_R8_R14_Mul_A_Vil   (X_R8_R14_Mul_A_Vil   )   ,   
  .X_R8_R14_Mul_B_Vil   (X_R8_R14_Mul_B_Vil   )   ,  
  .X_R8_R14_Mul_B_out   (X_R8_R14_Mul_B_out   )   ,  
  .X_R8_R14_Mul_get_r   (X_R8_R14_Mul_get_r   )    ,   
  .X_R8_R14_Mul_get_vil (X_R8_R14_Mul_get_vil )    , 
                        
 . Y_R8_R14_Mul_A_out   (Y_R8_R14_Mul_A_out  )    ,   
 . Y_R8_R14_Mul_A_Vil   (Y_R8_R14_Mul_A_Vil  )    ,   
 . Y_R8_R14_Mul_B_Vil   (Y_R8_R14_Mul_B_Vil  )   ,  
 . Y_R8_R14_Mul_B_out   (Y_R8_R14_Mul_B_out  )   ,  
 . Y_R8_R14_Mul_get_r   (Y_R8_R14_Mul_get_r  )   ,  
 . Y_R8_R14_Mul_get_vil (Y_R8_R14_Mul_get_vil)   , 
                        
 . Z_R8_R14_Mul_A_out    (Z_R8_R14_Mul_A_out   )    ,  
 . Z_R8_R14_Mul_A_Vil    (Z_R8_R14_Mul_A_Vil   )    ,  
 . Z_R8_R14_Mul_B_Vil    (Z_R8_R14_Mul_B_Vil   )    ,  
 . Z_R8_R14_Mul_B_out    (Z_R8_R14_Mul_B_out   )    ,  
 . Z_R8_R14_Mul_get_r    (Z_R8_R14_Mul_get_r   )    ,  
 . Z_R8_R14_Mul_get_vil  (Z_R8_R14_Mul_get_vil )       

  
  
  
  
          
     );
    
    
endmodule
