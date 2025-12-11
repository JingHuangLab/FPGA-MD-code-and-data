`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2022 10:32:37 PM
// Design Name: 
// Module Name: Comp_XYZ
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


module Comp_XYZ

(
 input               Sys_Clk  ,
 input               Sys_Rst_n,
 input               Home0_cell_cal_finish ,
 //to next caculation unit  
 input               S_AXIS_COMP_Begin     ,       //previous input, enable XYZ buf  
 input               S_AXIS_COMP_2_Begin   ,       //previous input, enable XYZ buf  
 output reg          M_AXIS_Force_done     ,
 output reg          M_AXIS_col_Force_done  ,
  
 output reg[255:0]   M_AXIS_LJ_EnE_Force   ,
 output reg[255:0]   M_AXIS_Col_EnE_Force   ,
             
 input    [31:0]     ParaM_A_LJ,      
 input    [31:0]     ParaM_B_LJ,      
 input    [31:0]     ParaM_A_LJ_Force,      
 input    [31:0]     ParaM_B_LJ_Force,  
 
 input    [31:0]     ParaM_Ene_Col,      
 input    [31:0]     ParaM_Ene_Force,    
      
 input    [31:0]     X_Pos_buf_nei,
 input    [31:0]     Y_Pos_buf_nei,
 input    [31:0]     Z_Pos_buf_nei,  
    
  // from  Fifo module home
 input    [31:0]      X_Pos_buf,
 input    [31:0]      Y_Pos_buf,
 input    [31:0]      Z_Pos_buf,  
 
 input        [159:0]  S_AXIS_home_Index_buf,    
 input        [159:0]  S_AXIS_Index_buf,  
 output   reg [159:0] Index_Pos_home  ,
  output  reg [159:0] Index_Pos_nei  ,
          
  //sum to caculation Add unit 
 output reg [31:0]    X_Add_A_out , 
 output reg [31:0]    Y_Add_B_out ,     
 output reg           X_Add_A_Vil ,
 output reg           Y_Add_B_Vil ,           
 input      [31:0]    RR_Add_get_r   ,    
 input                RR_Add_get_vil ,
 
 output reg [31:0]    XY_Add_C_out , 
 output reg           XY_Add_C_Vil ,      
 output reg [31:0]    Z_Add_C_out   , 
 output reg           Z_Add_C_Vil   ,
 input                XY_Add_get_vil ,
 input      [31:0]    RR_Add_get_XY_R,    
 //X to caculation mul unit 
 output reg [31:0]     X_Mul_A_out ,
 output reg            X_Mul_A_Vil ,
 output reg            X_Mul_B_Vil ,
 output reg [31:0]     X_Mul_B_out ,
 input      [31:0]     X_Mul_get_r ,
 input                 X_Mul_get_vil,
     //X to caculation sub unit 
 output reg [31:0]     X_Sub_A_out ,
 output reg            X_Sub_A_Vil ,
 output reg            X_Sub_B_Vil ,
 output reg [31:0]     X_Sub_B_out ,
 input      [31:0]     X_Sub_get_r,
 input                 X_Sub_get_vil,   
      //Y to caculation mul unit 
 output reg [31:0]     Y_Mul_A_out ,
 output reg            Y_Mul_A_Vil ,
 output reg            Y_Mul_B_Vil ,
 output reg [31:0]     Y_Mul_B_out ,
 input      [31:0]     Y_Mul_get_r,
 input                 Y_Mul_get_vil,
     //Y to caculation sub unit 
 output reg [31:0]     Y_Sub_A_out ,
 output reg            Y_Sub_A_Vil ,
 output reg            Y_Sub_B_Vil ,
 output reg [31:0]     Y_Sub_B_out ,
 input      [31:0]     Y_Sub_get_r,
 input                 Y_Sub_get_vil,   

   //Z to caculation mul unit 
 output reg [31:0]     Z_Mul_A_out ,
 output reg            Z_Mul_A_Vil ,
 output reg            Z_Mul_B_Vil ,
 output reg [31:0]     Z_Mul_B_out ,
 input      [31:0]     Z_Mul_get_r,
 input                 Z_Mul_get_vil,
     //Z to caculation sub unit 
 output reg [31:0]     Z_Sub_A_out ,
 output reg            Z_Sub_A_Vil ,
 output reg            Z_Sub_B_Vil ,
 output reg [31:0]     Z_Sub_B_out ,
 input      [31:0]     Z_Sub_get_r,
 input                 Z_Sub_get_vil,      
 
  output reg [31:0]    Root_R_A_out ,
  output reg           Root_R_A_Vil ,   
  input      [31:0]    Root_R_get_r,
  input                Root_R_get_vil, // 1/r
  
  output reg [31:0]    Re_R_A_out ,
  output reg           Re_R_A_Vil ,   
  input      [31:0]    Re_R_get_r,
  input                Re_R_get_vil, // 1/r
  
   output reg [31:0]   R3_Mul_A_out ,  
   output reg          R3_Mul_A_Vil ,  
   output reg          R3_Mul_B_Vil ,  
   output reg [31:0]   R3_Mul_B_out ,  
   input      [31:0]   R3_Mul_get_r,     
   input               R3_Mul_get_vil, 
    
   output reg [31:0]   A_Re_R_A_Mul_out ,  
   output reg          A_Re_R_A_Mul_Vil ,  
   output reg          A_Re_R_B_Mul_Vil ,  
   output reg [31:0]   A_Re_R_B_Mul_out ,  
   input      [31:0]   A_Re_R_get_r,   
   input               A_Re_R_get_vil, 
   
  output reg [31:0]    Re_R3_out ,        
  output reg           Re_R3_Vil ,        
  input      [31:0]    Re_R3_get_r,         
  input                Re_R3_get_vil, // 1/r
  
   output reg [31:0]   Re_R3_X_A_Mul_out , 
   output reg          Re_R3_X_A_Mul_Vil , 
   output reg          Re_R3_X_B_Mul_Vil , 
   output reg [31:0]   Re_R3_X_B_Mul_out , 
   input      [31:0]   Re_R3_X_get_r   ,
   input               Re_R3_X_get_vil ,
   
  output reg [31:0]    Re_R3_Y_A_Mul_out ,  
  output reg           Re_R3_Y_A_Mul_Vil ,  
  output reg           Re_R3_Y_B_Mul_Vil ,  
  output reg [31:0]    Re_R3_Y_B_Mul_out ,  
  input      [31:0]    Re_R3_Y_get_r   ,
  input                Re_R3_Y_get_vil ,
     
  output reg [31:0]    Re_R3_Z_A_Mul_out ,                     
  output reg           Re_R3_Z_A_Mul_Vil ,                     
  output reg           Re_R3_Z_B_Mul_Vil ,                     
  output reg [31:0]    Re_R3_Z_B_Mul_out ,                     
  input      [31:0]    Re_R3_Z_get_r   ,                    
  input                Re_R3_Z_get_vil ,                    
  
  output reg [31:0]    A_Re_R3_X_A_Mul_out ,  
  output reg           A_Re_R3_X_A_Mul_Vil ,  
  output reg           A_Re_R3_X_B_Mul_Vil ,  
  output reg [31:0]    A_Re_R3_X_B_Mul_out ,  
  input      [31:0]    A_Re_R3_X_get_r   ,    
  input                A_Re_R3_X_get_vil ,    
  
  output reg [31:0]    A_Re_R3_Y_A_Mul_out ,    
  output reg           A_Re_R3_Y_A_Mul_Vil ,    
  output reg           A_Re_R3_Y_B_Mul_Vil ,    
  output reg [31:0]    A_Re_R3_Y_B_Mul_out ,    
  input      [31:0]    A_Re_R3_Y_get_r   ,  
  input                A_Re_R3_Y_get_vil ,  
  
  output reg [31:0]    A_Re_R3_Z_A_Mul_out ,    
  output reg           A_Re_R3_Z_A_Mul_Vil ,    
  output reg           A_Re_R3_Z_B_Mul_Vil ,    
  output reg [31:0]    A_Re_R3_Z_B_Mul_out ,    
  input      [31:0]    A_Re_R3_Z_get_r   ,  
  input                A_Re_R3_Z_get_vil ,  
                                                   //RR to caculation mul unit 
  output reg [31:0]    R4_Mul_A_out ,
  output reg           R4_Mul_A_Vil ,
  output reg           R4_Mul_B_Vil ,
  output reg [31:0]    R4_Mul_B_out ,
  input      [31:0]    R4_Mul_get_r ,
  input                R4_Mul_get_vil,
                                                  //R6 to caculation mul unit 
  output reg [31:0]    R6_Mul_A_out ,
  output reg           R6_Mul_A_Vil ,
  output reg           R6_Mul_B_Vil ,
  output reg [31:0]    R6_Mul_B_out ,
  input [31:0]         R6_Mul_get_r,
  input                R6_Mul_get_vil,
                                                   //R12 to caculation mul unit 
  output reg [31:0]    R12_Mul_A_out ,
  output reg           R12_Mul_A_Vil ,
  output reg           R12_Mul_B_Vil ,
  output reg [31:0]    R12_Mul_B_out ,
  input [31:0]         R12_Mul_get_r,
  input                R12_Mul_get_vil,
                                                //1/r12 to caculation mul unit 
  output reg [31:0]    Re_R12_A_out ,
  output reg           Re_R12_A_Vil ,
  input [31:0]         Re_R12_get_r,
  input                Re_R12_get_vil,
                                                  //1/r6 to caculation mul unit 
  output reg [31:0]    Re_R6_A_out ,
  output reg           Re_R6_A_Vil ,   
  input [31:0]         Re_R6_get_r,
  input                Re_R6_get_vil,
                                                //A 1/r12 to caculation mul unit 
  output reg [31:0]    A_Re_R12_A_out ,
  output reg           A_Re_R12_A_Vil ,
  output reg           A_Re_R12_B_Vil ,
  output reg [31:0]    A_Re_R12_B_out ,
  input [31:0]         A_Re_R12_get_r,
  input                A_Re_R12_get_vil,
                                                   //B 1/r6 to caculation mul unit 
  output reg [31:0]    B_Re_R6_A_out ,
  output reg           B_Re_R6_A_Vil ,
  output reg           B_Re_R6_B_Vil ,
  output reg [31:0]    B_Re_R6_B_out ,
  input [31:0]         B_Re_R6_get_r,
  input                B_Re_R6_get_vil,
                                                 //B 1/r6 to caculation mul unit 
  output reg [31:0]    Energy_A_out  ,
  output reg           Energy_A_Vil  ,
  output reg           Energy_B_Vil  ,
  output reg [31:0]    Energy_B_out  ,
  input      [31:0]    Energy_get_r  ,
  input                Energy_get_vil,
   
  output reg [31:0]    R14_Mul_A_out ,            //B 1/r14 to caculation mul unit   
  output reg           R14_Mul_A_Vil , 
  output reg           R14_Mul_B_Vil  , 
  output reg [31:0]    R14_Mul_B_out  , 
  input      [31:0]    R14_Mul_get_r ,  
  input                R14_Mul_get_vil,
  
  output reg [31:0]   Re_R14_A_out , 
  output reg          Re_R14_A_Vil , 
  input      [31:0]   Re_R14_get_r,  
  input               Re_R14_get_vil,
  
  output reg [31:0]   R8_Mul_A_out ,         
  output reg          R8_Mul_A_Vil ,       
  output reg          R8_Mul_B_Vil  ,      
  output reg [31:0]   R8_Mul_B_out  ,      
  input      [31:0]   R8_Mul_get_r ,       
  input               R8_Mul_get_vil  ,
  
  output reg [31:0]   Re_R8_A_out , 
  output reg          Re_R8_A_Vil , 
  input      [31:0]   Re_R8_get_r,  
  input               Re_R8_get_vil,
  
  output reg [31:0]   B_R8_Mul_A_out ,       
  output reg          B_R8_Mul_A_Vil ,       
  output reg          B_R8_Mul_B_Vil  ,      
  output reg [31:0]   B_R8_Mul_B_out  ,      
  input      [31:0]   B_R8_Mul_get_r ,       
  input               B_R8_Mul_get_vil ,      
             
  output reg [31:0]   A_R14_Mul_A_out   ,     
  output reg          A_R14_Mul_A_Vil   ,     
  output reg          A_R14_Mul_B_Vil   ,    
  output reg [31:0]   A_R14_Mul_B_out   ,    
  input      [31:0]   A_R14_Mul_get_r   ,     
  input               A_R14_Mul_get_vil ,        
  
  output reg [31:0]   R14_sub_R8_A_out   ,   
  output reg          R14_sub_R8_A_Vil   ,   
  output reg          R14_sub_R8_B_Vil   ,  
  output reg [31:0]   R14_sub_R8_B_out   ,  
  input      [31:0]   R14_sub_R8_get_r   ,   
  input               R14_sub_R8_get_vil , 
  
  output reg [31:0]   X_R8_R14_Mul_A_out   ,     
  output reg          X_R8_R14_Mul_A_Vil   ,     
  output reg          X_R8_R14_Mul_B_Vil   ,    
  output reg [31:0]   X_R8_R14_Mul_B_out   ,    
  input      [31:0]   X_R8_R14_Mul_get_r   ,     
  input               X_R8_R14_Mul_get_vil , 
  
  output reg [31:0]   Y_R8_R14_Mul_A_out   ,   
  output reg          Y_R8_R14_Mul_A_Vil   ,   
  output reg          Y_R8_R14_Mul_B_Vil   ,  
  output reg [31:0]   Y_R8_R14_Mul_B_out   ,  
  input      [31:0]   Y_R8_R14_Mul_get_r   ,   
  input               Y_R8_R14_Mul_get_vil , 
  
  output reg [31:0]   Z_R8_R14_Mul_A_out   ,   
  output reg          Z_R8_R14_Mul_A_Vil   ,   
  output reg          Z_R8_R14_Mul_B_Vil   ,  
  output reg [31:0]   Z_R8_R14_Mul_B_out   ,  
  input      [31:0]   Z_R8_R14_Mul_get_r   ,   
  input               Z_R8_R14_Mul_get_vil    

     
    );
// ---------------------------------------- -----------------------       
//  --state
reg [7:0]         Home_flow_cnt_State    ;
reg [7:0]         Nei_flow_cnt_State     ;
reg [7:0]         X_Mul_flow_cnt_State;
reg [7:0]         X_Sub_flow_cnt_State;
reg [7:0]         Y_Mul_flow_cnt_State;
reg [7:0]         Y_Sub_flow_cnt_State;
reg [7:0]         Z_Mul_flow_cnt_State;
reg [7:0]         Z_Sub_flow_cnt_State;
reg [7:0]         Sqr_RR_flow_cnt_State;

reg [31:0]        X_Pos_home;              
reg [31:0]        Y_Pos_home;              
reg [31:0]        Z_Pos_home;    
reg [31:0]        X_Pos_nei;  
reg [31:0]        Y_Pos_nei;  
reg [31:0]        Z_Pos_nei;  
reg [31:0]        DertaX; 
reg [31:0]        DertaY; 
reg [31:0]        DertaZ;  
reg [31:0]        Sqr_DertaX;
reg [31:0]        Sqr_DertaY;
reg [31:0]        Sqr_DertaZ;           
   
reg [31:0]        M_AXIS_RR_data;  

reg               X_Sub_en            ;  
reg               X_Mul_en            ;  
reg               Sum_rr              ;  
reg               Y_Sub_en            ; 
reg               Y_Mul_en            ; 
reg               Z_Sub_en            ; 
reg               Z_Mul_en            ; 
reg               Get_XYZ_delta_en    ;
reg               sub_done            ;
reg               Mul_done            ;
reg               Sum_rr_done         ;
reg               RR_Root_en          ;        // 1
reg               Re_R_en             ;        // 2
reg               R3_Mul_en           ;        // 2
reg               A_Re_R_Mul_en       ;        // 3
reg               Re_R3_en            ;        // 3 
reg               Re_R3_X_Mul_en      ;        // 4
reg               Re_R3_Y_Mul_en      ;        // 4 
reg               Re_R3_Z_Mul_en      ;        // 4 
reg               A_Re_R3_X_Mul_en    ;        // 5 
reg               A_Re_R3_Y_Mul_en    ;        // 5 
reg               A_Re_R3_Z_Mul_en    ;        // 5 

reg [4:0]         X_Sub_CNT           ;  
reg [4:0]         Y_Sub_CNT           ;  
reg [4:0]         Z_Sub_CNT           ;  
reg [4:0]         X_Mul_CNT           ;  
reg [4:0]         Y_Mul_CNT           ;  
reg [4:0]         Z_Mul_CNT           ;  
reg [4:0]         XY_Add_CNT          ;
reg [4:0]         RR_Add_CNT          ;
reg [4:0]         R8_Mul_CNT         ;
reg [5:0]         Re_R14_CNT         ;
reg [4:0]         R14_Mul_CNT;
reg [4:0]         Re_R8_CNT          ;
reg [4:0]         B_R8_Mul_CNT       ;
reg [4:0]         A_R14_Mul_CNT      ;
reg [4:0]         X_R8_R14_Mul_CNT   ;
reg [4:0]         Y_R8_R14_Mul_CNT   ;
reg [4:0]         Z_R8_R14_Mul_CNT   ;
reg [4:0]         R14_sub_R8_CNT     ;
reg [4:0]         R4_Mul_CNT        ;
reg [4:0]         R6_Mul_CNT        ;
reg [4:0]         R12_Mul_CNT       ;
reg [4:0]         Re_R6_CNT         ;
reg [4:0]         Re_R12_CNT        ;
reg [4:0]         A_Re_R12_CNT     ;
reg [4:0]         B_Re_R6_CNT       ;
reg [4:0]         Energy_Sub_CNT    ; 
reg [4:0]         Root_R_CNT        ;
reg [4:0]         Re_R_CNT          ;
reg [4:0]         R3_Mul_CNT       ;
reg [4:0]         A_Re_R_CNT       ;
reg [4:0]         Re_R3_CNT          ;
reg [4:0]         Re_R3_X_Mul_CNT   ;
reg [4:0]         Re_R3_Y_Mul_CNT   ;
reg [4:0]         Re_R3_Z_Mul_CNT   ;
reg [4:0]         A_Re_R3_X_Mul_CNT ;
reg [4:0]         A_Re_R3_Y_Mul_CNT ;
reg [4:0]         A_Re_R3_Z_Mul_CNT ;

reg [7:0]         R4_Mul_flow_cnt_State    ;
reg [7:0]         R6_Mul_flow_cnt_State    ;
reg [7:0]         R12_Mul_flow_cnt_State   ;
reg [7:0]         Re_R6_flow_cnt_State     ;
reg [7:0]         Re_R12_flow_cnt_State    ;
reg [7:0]         A_Re_R12_flow_cnt_State  ;
reg [7:0]         B_Re_R6_flow_cnt_State   ;
reg [7:0]         Energy_Sub_flow_cnt_State;
reg [7:0]         R14_Mul_flow_cnt_State   ;    
reg [7:0]         Re_R14_flow_cnt_State    ;    
reg [7:0]         Re_R8_flow_cnt_State     ;   
reg [7:0]         R8_Mul_flow_cnt_State    ;  
reg [7:0]         B_R8_Mul_flow_cnt_State          ; 
reg [7:0]         A_R14_Mul_flow_cnt_State         ; 
reg [7:0]         R14_sub_R8_flow_cnt_State       ; 
reg [7:0]         X_R8_R14_Mul_flow_cnt_State     ; 
reg [7:0]         Y_R8_R14_Mul_flow_cnt_State     ; 
reg [7:0]         Z_R8_R14_Mul_flow_cnt_State     ; 
//reg [7:0]         Force_LJ_flow_cnt_State        ;

reg  [7:0]        Root_R_flow_cnt_State         ;         // 1
reg  [7:0]        Re_R_flow_cnt_State           ;        // 2
reg  [7:0]        R3_Mul_flow_cnt_State         ;        // 2
reg  [7:0]        A_Re_R_flow_cnt_State         ;            // 3
reg  [7:0]        Re_R3_flow_cnt_State          ;        // 3 
reg  [7:0]        Re_R3_X_Mul_flow_cnt_State    ;        // 4
reg  [7:0]        Re_R3_Y_Mul_flow_cnt_State    ;        // 4 
reg  [7:0]        Re_R3_Z_Mul_flow_cnt_State    ;        // 4 
reg  [7:0]        A_Re_R3_X_Mul_flow_cnt_State  ;        // 5 
reg  [7:0]        A_Re_R3_Y_Mul_flow_cnt_State  ;        // 5 
reg  [7:0]        A_Re_R3_Z_Mul_flow_cnt_State  ;        // 5 


//reg [3:0]         Col_dir_flow_cnt_State ;
//reg [3:0]         Cal_flow_cnt_State;
reg [31:0]        R4;
reg [31:0]        R6;
reg [31:0]        R12 ;
reg [31:0]        Re_R12;
reg [31:0]        Re_R6;
reg [31:0]        A_Re_R12;
reg [31:0]        B_Re_R6;

reg [31:0]        R14              ;
reg [31:0]        R8               ;
reg [31:0]        Re_R14           ;
reg [31:0]        Re_R8            ;
reg [31:0]        B_R8         ;
reg [31:0]        A_R14        ;
reg [31:0]        Force_para   ;
  
reg [31:0]        M_AXIS_LJ_Energy ;   
reg [31:0]        M_AXIS_LJ_Force_X;  
reg [31:0]        M_AXIS_LJ_Force_Y;  
reg [31:0]        M_AXIS_LJ_Force_Z;  

reg [31:0]        Root_R     ;        // 1
reg [31:0]        Re_R       ;        // 2
reg [31:0]        R3         ;        // 2
reg [31:0]        A_Re_R     ;        // 3
reg [31:0]        Re_R3      ;        // 3 
reg [31:0]        Re_R3_X    ;        // 4
reg [31:0]        Re_R3_Y    ;        // 4 
reg [31:0]        Re_R3_Z    ;        // 4 
reg [31:0]        A_Re_R3_X  ;        // 5 
reg [31:0]        A_Re_R3_Y  ;        // 5 
reg [31:0]        A_Re_R3_Z  ;        // 5 

reg               Force_Sub_Done      ;  
reg               R8_Mul_Done         ;
reg               Re_R14_Done         ;
reg               Re_R8_Done          ;
reg               B_R8_Mul_Done       ;
reg               A_R14_Mul_Done      ;
reg               X_R8_R14_Mul_Done   ;
reg               Y_R8_R14_Mul_Done   ;
reg               Z_R8_R14_Mul_Done   ;
reg               R14_sub_R8_Done     ;
reg               R4_Mul_Done        ;
reg               R6_Mul_Done        ;
reg               R12_Mul_Done       ;
reg               Re_R6_Done         ;
reg               Re_R12_Done        ;
reg               A_Re_R12_Done      ;
reg               B_Re_R6_Done       ;
reg               Energy_Sub_Done    ; 
reg               Root_R_Done        ;
reg               Re_R_Done          ;
reg               R3_Mul_Done        ;
reg               A_Re_R_Done        ;
reg               Re_R3_Done         ;
reg               Re_R3_X_Mul_Done   ;
reg               Re_R3_Y_Mul_Done   ;
reg               Re_R3_Z_Mul_Done   ;
reg               A_Re_R3_X_Mul_Done ;
reg               A_Re_R3_Y_Mul_Done ;
reg               A_Re_R3_Z_Mul_Done ;
reg               Col_dir_Done;

reg               R8_Mul_en           ;
reg               R14_Mul_en          ;
reg               A_R14_Mul_en        ;
reg               R14_sub_R8_en       ;
reg               B_R8_Mul_en         ;
reg               R14_Mul_Done        ;
reg               R4_Mul_en          ;  
reg               R6_Mul_en          ;  
reg               R12_Mul_en         ;  
reg               Re_R6_en           ;  
reg               Re_R12_en          ;  
reg               A_Re_R12_en        ;  
reg               B_Re_R6_en         ;  
reg               Energy_Sub_en      ;
reg               Re_R14_en          ;
reg               Re_R8_en           ;
reg               X_R8_R14_Mul_en    ;      
reg               Y_R8_R14_Mul_en    ;
reg               Z_R8_R14_Mul_en    ;


 reg [31:0]       Z_Pos_home_buf    ;
 reg [31:0]       Z_Pos_nei_buf      ;


  //---------------------------------------------------------------   
 //    get  po.j and po.i position  
 //---------------------------------------------------------------   

 localparam [3:0]
           Home_flow_cnt_RST   = 4'b0001	,
           Home_flow_cnt_IDLE  = 4'b0010	,
           Home_flow_cnt_BEGIN = 4'b0100	,
           Home_flow_cnt_END   = 4'b1000	;
           
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Home_flow_cnt_State <= Home_flow_cnt_RST;
     end 
      else begin 
           case( Home_flow_cnt_State)  
            Home_flow_cnt_RST :
                begin
                      Home_flow_cnt_State  <=Home_flow_cnt_IDLE;
                end 
            Home_flow_cnt_IDLE:
                begin
                  if (S_AXIS_COMP_Begin)
                      Home_flow_cnt_State <=Home_flow_cnt_BEGIN;
                  else
                      Home_flow_cnt_State <=Home_flow_cnt_IDLE;
                  end 
            Home_flow_cnt_BEGIN:
                 begin
                     if ( Z_Pos_home_buf  !=  Z_Pos_buf)
                       Home_flow_cnt_State <=Home_flow_cnt_END;
                     else
                       Home_flow_cnt_State <=Home_flow_cnt_BEGIN;
                 end 
 
            Home_flow_cnt_END:
                 begin        
                     if ( Home0_cell_cal_finish  )
                        Home_flow_cnt_State <=Home_flow_cnt_IDLE;
                     else                     
                        Home_flow_cnt_State <=Home_flow_cnt_END;
                 end     
                 
       default:       Home_flow_cnt_State <=Home_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Z_Pos_home_buf        <=  32'd0;  
      else if (S_AXIS_COMP_Begin )
              Z_Pos_home_buf    <=  Z_Pos_buf   ;   
      else if(  Home0_cell_cal_finish   )      
              Z_Pos_home_buf        <=  32'd0;              
      end 

    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_home        <=  32'd0;  
      else if (  S_AXIS_COMP_Begin)
              X_Pos_home         <=  X_Pos_buf    ;   
      else if(  Home0_cell_cal_finish  )      
              X_Pos_home        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_home        <=  32'd0;  
      else if ( S_AXIS_COMP_Begin )
              Y_Pos_home         <=  Y_Pos_buf    ;   
      else if(  Home0_cell_cal_finish  )      
              Y_Pos_home        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_home        <=  32'd0;  
      else if (  S_AXIS_COMP_Begin )
              Z_Pos_home         <=  Z_Pos_buf    ;   
      else if( Home0_cell_cal_finish    )      
              Z_Pos_home        <=  32'd0;              
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Index_Pos_home        <=  160'd0;  
      else if (  S_AXIS_COMP_Begin )
              Index_Pos_home     <=   S_AXIS_home_Index_buf ;   
      else if(  Home0_cell_cal_finish )      
              Index_Pos_home        <=  160'd0;              
      end 
  //---------------------------------------------------------------      
   localparam [3:0]
           Nei_flow_cnt_RST   = 4'b0001	,
           Nei_flow_cnt_IDLE  = 4'b0010	,
           Nei_flow_cnt_BEGIN = 4'b0100	,
           Nei_flow_cnt_END   = 4'b1000	;
           
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei_flow_cnt_State <= Nei_flow_cnt_RST;
     end 
      else begin 
           case( Nei_flow_cnt_State)  
            Nei_flow_cnt_RST :
                begin
                      Nei_flow_cnt_State  <=Nei_flow_cnt_IDLE;
                end 
            Nei_flow_cnt_IDLE:
                begin
                  if (S_AXIS_COMP_2_Begin)
                      Nei_flow_cnt_State <=Nei_flow_cnt_BEGIN;
                  else
                      Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
                  end 
            Nei_flow_cnt_BEGIN:
                 begin
                     if ( Z_Pos_nei_buf  !=  Z_Pos_buf_nei)
                       Nei_flow_cnt_State <=Nei_flow_cnt_END;
                     else
                       Nei_flow_cnt_State <=Nei_flow_cnt_BEGIN;
                 end 
 
            Nei_flow_cnt_END:
                 begin        
                     if ( Force_Sub_Done)
                      Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
                      
                     else
                       Nei_flow_cnt_State <=Nei_flow_cnt_END;
                 end     
                 
       default:       Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Z_Pos_nei_buf        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin )
              Z_Pos_nei_buf  <=  Z_Pos_buf_nei ;  
      else if(Force_Sub_Done  )      
              Z_Pos_nei_buf        <=  32'd0;              
      end 
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_nei        <=  32'd0;  
      else if (  S_AXIS_COMP_2_Begin )
             X_Pos_nei       <=  X_Pos_buf_nei     ;   
      else if( Force_Sub_Done   )      
              X_Pos_nei        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_nei        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin  )
               Y_Pos_nei       <=  Y_Pos_buf_nei ;   
      else if( Force_Sub_Done  )      
              Y_Pos_nei        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_nei        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin  )
              Z_Pos_nei         <= Z_Pos_buf_nei   ;   
      else if( Force_Sub_Done  )      
              Z_Pos_nei        <=  32'd0;              
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Index_Pos_nei        <=  160'd0;  
      else if (S_AXIS_COMP_2_Begin )
              Index_Pos_nei   <=  S_AXIS_Index_buf  ;   
      else if( Force_Sub_Done  )      
              Index_Pos_nei        <=  160'd0;              
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
            Get_XYZ_delta_en  <= 1'b0;
      else if ( S_AXIS_COMP_2_Begin )
            Get_XYZ_delta_en  <= 1'b1; 
      else     
            Get_XYZ_delta_en  <= 1'b0;              
      end 
 
 
 
 //---------------------------------------------------------------  
 //            main state machine
 //---------------------------------------------------------------  
//  localparam [5:0]
//           Cal_COMP_flow_cnt_RST   = 5'b00001	,
//           Cal_COMP_flow_cnt_IDLE  = 5'b00010	,
//           Cal_COMP_flow_cnt_ONE   = 5'b00100	,
//           Cal_COMP_flow_cnt_TWO   = 5'b01000	, 
//           Cal_COMP_flow_cnt_END   = 5'b10000	; 
 
           
//  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n) begin   
//       Cal_COMP_flow_cnt_State <= Cal_COMP_flow_cnt_RST;
//     end 
//      else begin 
//           case( Cal_COMP_flow_cnt_State)  
//            Cal_COMP_flow_cnt_RST :
//                begin
//                      Cal_COMP_flow_cnt_State  <=Cal_COMP_flow_cnt_IDLE;
//                end 
//            Cal_COMP_flow_cnt_IDLE:
//                begin
//                  if ( Get_XYZ_delta_en)
//                      Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_ONE;
//                  else
//                      Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_IDLE;
//                  end 
//            Cal_COMP_flow_cnt_ONE:
//                 begin
//                     if ( sub_done )
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_TWO;
//                     else
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_ONE;
//                 end 
//            Cal_COMP_flow_cnt_TWO:
//                 begin
//                     if ( Mul_done )
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_END;
//                     else
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_TWO;
//                 end 
//            Cal_COMP_flow_cnt_END:
//                 begin
//                     if ( Sum_rr_done )
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_IDLE;
//                     else
//                       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_END;
//                 end 
   
                 
//       default:       Cal_COMP_flow_cnt_State <=Cal_COMP_flow_cnt_IDLE;
//     endcase
//   end 
// end   
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              X_Sub_en      <= 1'b1;  
      else 
              X_Sub_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              Y_Sub_en      <= 1'b1;  
      else 
              Y_Sub_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              Z_Sub_en      <= 1'b1;  
      else 
              Z_Sub_en      <= 1'b0;               
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Mul_en      <= 1'b0;  
      else if (sub_done )
              X_Mul_en      <= 1'b1;  
      else 
              X_Mul_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Mul_en      <= 1'b0;  
      else if (sub_done )
              Y_Mul_en      <= 1'b1;  
      else 
              Y_Mul_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Mul_en      <= 1'b0;  
      else if (sub_done )
              Z_Mul_en      <= 1'b1;  
      else 
              Z_Mul_en      <= 1'b0;               
      end 
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Sum_rr            <= 1'b0;  
      else if (Mul_done )
               Sum_rr            <= 1'b1;     
      else 
               Sum_rr            <= 1'b0;               
      end 
 
 
  //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------
    
//  localparam [7:0]
//           Cal_flow_cnt_RST   = 8'b00000001	,
//           Cal_flow_cnt_IDLE  = 8'b00000010	,
//           Cal_flow_cnt_ONE   = 8'b00000100	,
//           Cal_flow_cnt_TWO   = 8'b00001000	, 
//           Cal_flow_cnt_TH    = 8'b00010000	, 
//           Cal_flow_cnt_FOUR  = 8'b00100000	,
//           Cal_flow_cnt_FIVE  = 8'b01000000	,    
//           Cal_flow_cnt_END   = 8'b10000000	;
           
//  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n) begin   
//       Cal_flow_cnt_State <= Cal_flow_cnt_RST;
//     end 
//      else begin 
//           case( Cal_flow_cnt_State)  
//            Cal_flow_cnt_RST :
//                begin
//                      Cal_flow_cnt_State  <=Cal_flow_cnt_IDLE;
//                end 
//            Cal_flow_cnt_IDLE:
//                begin
//                  if ( Sum_rr_done)
//                      Cal_flow_cnt_State <=Cal_flow_cnt_ONE;
//                  else
//                      Cal_flow_cnt_State <=Cal_flow_cnt_IDLE;
//                  end 
//            Cal_flow_cnt_ONE:
//                 begin
//                     if ( R4_Mul_Done )
//                       Cal_flow_cnt_State <=Cal_flow_cnt_TWO;
//                     else
//                       Cal_flow_cnt_State <=Cal_flow_cnt_ONE;
//                 end 
//            Cal_flow_cnt_TWO:
//                 begin
//                     if ( R6_Mul_Done )
//                       Cal_flow_cnt_State <=Cal_flow_cnt_TH;
//                     else
//                       Cal_flow_cnt_State <=Cal_flow_cnt_TWO;
//                 end 
//            Cal_flow_cnt_TH:
//                 begin
//                     if ( R12_Mul_Done )
//                       Cal_flow_cnt_State <=Cal_flow_cnt_FOUR;
//                     else
//                       Cal_flow_cnt_State <=Cal_flow_cnt_TH;
//                 end 
//            Cal_flow_cnt_FOUR:
//                 begin
//                     if ( Re_R12_Done )
//                       Cal_flow_cnt_State <=Cal_flow_cnt_FIVE;
//                     else
//                       Cal_flow_cnt_State <=Cal_flow_cnt_FOUR;
//                 end   
//           Cal_flow_cnt_FIVE:
//                 begin
//                     if ( A_Re_R12_Done )
//                       Cal_flow_cnt_State <=Cal_flow_cnt_END;
//                     else
//                       Cal_flow_cnt_State <=Cal_flow_cnt_FIVE;
//                 end    
                       
//            Cal_flow_cnt_END:
//                 begin        
//                     if ( Energy_Sub_Done)
//                       Cal_flow_cnt_State <=Cal_flow_cnt_IDLE;
//                     else
                      
//                        Cal_flow_cnt_State <=Cal_flow_cnt_END;
//                 end     
                 
//       default:       Cal_flow_cnt_State <=Cal_flow_cnt_IDLE;
//     endcase
//   end 
// end   
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R4_Mul_en      <= 1'b0;   
      else if (Sum_rr_done )
              R4_Mul_en      <= 1'b1;  
      else 
              R4_Mul_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R6_Mul_en      <= 1'b0;  
      else if (R4_Mul_Done )
              R6_Mul_en      <= 1'b1;  
      else 
              R6_Mul_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R12_Mul_en      <= 1'b0;  
      else if (R6_Mul_Done )
              R12_Mul_en      <= 1'b1;  
      else 
              R12_Mul_en      <= 1'b0;               
      end        
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R6_en      <= 1'b0;  
      else if (R12_Mul_Done )
              Re_R6_en      <= 1'b1;  
      else 
              Re_R6_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R12_en      <= 1'b0;  
      else if (R12_Mul_Done )
              Re_R12_en      <= 1'b1;  
      else 
              Re_R12_en      <= 1'b0;               
      end 

      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              A_Re_R12_en      <= 1'b0;  
      else if (Re_R12_Done )
              A_Re_R12_en      <= 1'b1;  
      else 
              A_Re_R12_en      <= 1'b0;               
      end 
 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              B_Re_R6_en      <= 1'b0;  
      else if (Re_R12_Done )
              B_Re_R6_en      <= 1'b1;  
      else 
              B_Re_R6_en      <= 1'b0;               
      end 
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Energy_Sub_en       <= 1'b0;  
      else if (A_Re_R12_Done )
              Energy_Sub_en       <= 1'b1;     
      else 
              Energy_Sub_en       <= 1'b0;               
      end 
 

 //-------------------------------------------------------

// localparam [7:0]
//           Force_LJ_flow_cnt_RST   = 8'b00000001	,
//           Force_LJ_flow_cnt_IDLE  = 8'b00000010	,
//           Force_LJ_flow_cnt_ONE   = 8'b00000100	,
//           Force_LJ_flow_cnt_TWO   = 8'b00001000	, 
//           Force_LJ_flow_cnt_TH    = 8'b00010000	, 
//           Force_LJ_flow_cnt_FOUR  = 8'b00100000	,
//           Force_LJ_flow_cnt_END   = 8'b01000000	;
           
//  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n) begin   
//       Force_LJ_flow_cnt_State <= Force_LJ_flow_cnt_RST;
//     end 
//      else begin 
//           case( Force_LJ_flow_cnt_State)  
//            Force_LJ_flow_cnt_RST :
//                begin
//                      Force_LJ_flow_cnt_State  <=Force_LJ_flow_cnt_IDLE;
//                end 
//            Force_LJ_flow_cnt_IDLE:
//                begin
//                  if ( Energy_Sub_Done)
//                      Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_ONE;
//                  else
//                      Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_IDLE;
//                  end 
//            Force_LJ_flow_cnt_ONE:
//                 begin
//                     if ( R14_Mul_Done )
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_TWO;
//                     else
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_ONE;
//                 end 
//            Force_LJ_flow_cnt_TWO:
//                 begin
//                     if ( Re_R14_Done )
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_TH;
//                     else
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_TWO;
//                 end 
//            Force_LJ_flow_cnt_TH:
//                 begin
//                     if ( A_R14_Mul_Done )
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_FOUR;
//                     else
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_TH;
//                 end 
//            Force_LJ_flow_cnt_FOUR:
//                 begin
//                     if ( R14_sub_R8_Done )
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_END;
//                     else
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_FOUR;
//                 end   
//           Force_LJ_flow_cnt_END:
//                 begin
//                     if ( X_R8_R14_Mul_Done )
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_IDLE;
//                     else
//                       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_END;
//                 end    
                       

                 
//       default:       Force_LJ_flow_cnt_State <=Force_LJ_flow_cnt_IDLE;
//     endcase
//   end 
// end   
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R8_Mul_en       <= 1'b0;   
      else if (Energy_Sub_Done )
              R8_Mul_en      <= 1'b1;  
      else 
              R8_Mul_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R14_Mul_en      <= 1'b0;  
      else if (Energy_Sub_Done )
              R14_Mul_en      <= 1'b1;  
      else 
              R14_Mul_en      <= 1'b0;               
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R14_en      <= 1'b0;  
      else if (R14_Mul_Done )
              Re_R14_en      <= 1'b1;  
      else 
              Re_R14_en      <= 1'b0;               
      end        
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R8_en      <= 1'b0;  
      else if (R14_Mul_Done )
              Re_R8_en      <= 1'b1;  
      else 
              Re_R8_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              A_R14_Mul_en      <= 1'b0;  
      else if (Re_R14_Done )
              A_R14_Mul_en      <= 1'b1;  
      else 
              A_R14_Mul_en      <= 1'b0;               
      end 
     
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              B_R8_Mul_en      <= 1'b0;  
      else if (Re_R14_Done )
              B_R8_Mul_en      <= 1'b1;  
      else 
              B_R8_Mul_en      <= 1'b0;               
      end 
 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R14_sub_R8_en      <= 1'b0;  
      else if (  A_R14_Mul_Done)
              R14_sub_R8_en      <= 1'b1;  
      else 
              R14_sub_R8_en      <= 1'b0;               
      end 

      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_R8_R14_Mul_en  <= 1'b0;  
      else if ( R14_sub_R8_Done )
              X_R8_R14_Mul_en  <= 1'b1;     
      else 
              X_R8_R14_Mul_en  <= 1'b0;               
      end 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_R8_R14_Mul_en   <= 1'b0;  
      else if ( R14_sub_R8_Done )
              Y_R8_R14_Mul_en    <= 1'b1;     
      else 
              Y_R8_R14_Mul_en     <= 1'b0;               
      end 
 
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_R8_R14_Mul_en  <= 1'b0;  
      else if ( R14_sub_R8_Done )
              Z_R8_R14_Mul_en       <= 1'b1;     
      else 
              Z_R8_R14_Mul_en            <= 1'b0;               
      end 

 //-------------------------------------------------------
 //  col
  //-------------------------------------------------------


// localparam [6:0]
//           Col_dir_flow_cnt_RST   = 7'b0000001	,
//           Col_dir_flow_cnt_IDLE  = 7'b0000010	,
//           Col_dir_flow_cnt_ONE   = 7'b0000100	,
//           Col_dir_flow_cnt_TWO   = 7'b0001000	, 
//           Col_dir_flow_cnt_TH    = 7'b0010000	, 
//           Col_dir_flow_cnt_THR   = 7'b0100000	, 
//           Col_dir_flow_cnt_END   = 7'b1000000	;
           
//  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n) begin   
//       Col_dir_flow_cnt_State <= Col_dir_flow_cnt_RST;
//     end 
//      else begin 
//           case( Col_dir_flow_cnt_State)  
//            Col_dir_flow_cnt_RST :
//                begin
//                      Col_dir_flow_cnt_State  <=Col_dir_flow_cnt_IDLE;
//                end 
//            Col_dir_flow_cnt_IDLE:
//                begin
//                  if ( Sum_rr_done)
//                      Col_dir_flow_cnt_State <=Col_dir_flow_cnt_ONE;
//                  else
//                      Col_dir_flow_cnt_State <=Col_dir_flow_cnt_IDLE;
//                  end 
//            Col_dir_flow_cnt_ONE:
//                 begin
//                     if ( Root_R_Done )
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_TWO;
//                     else
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_ONE;
//                 end 
//            Col_dir_flow_cnt_TWO:
//                 begin
//                     if ( Re_R_Done )
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_TH;
//                     else
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_TWO;
//                 end 
//            Col_dir_flow_cnt_TH:
//                 begin
//                     if ( Re_R3_Done )
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_THR;
//                     else
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_TH;
//                 end 
//            Col_dir_flow_cnt_THR:
//                begin 
//                  if ( Re_R3_X_Mul_Done )                                      
//                    Col_dir_flow_cnt_State <=Col_dir_flow_cnt_END;       
//                  else                                                   
//                    Col_dir_flow_cnt_State <=Col_dir_flow_cnt_TH;       
//                      end
//            Col_dir_flow_cnt_END:
//                 begin        
//                     if ( A_Re_R3_X_Mul_Done)
//                        Col_dir_flow_cnt_State <=Col_dir_flow_cnt_IDLE;
//                     else
                      
//                       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_END;
//                 end     
                 
//       default:       Col_dir_flow_cnt_State <=Col_dir_flow_cnt_IDLE;
//     endcase
//   end 
// end   
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              RR_Root_en      <= 1'b0;  
      else if ( Sum_rr_done )
              RR_Root_en      <= 1'b1;  
      else 
              RR_Root_en      <= 1'b0;               
      end  
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R_en      <= 1'b0;  
      else if ( Root_R_Done )
              Re_R_en      <= 1'b1;  
      else 
              Re_R_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R3_Mul_en      <= 1'b0;  
      else if ( Root_R_Done )
              R3_Mul_en      <= 1'b1;  
      else 
              R3_Mul_en      <= 1'b0;               
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              A_Re_R_Mul_en      <= 1'b0;  
      else if ( Re_R_Done )
              A_Re_R_Mul_en      <= 1'b1;  
      else 
              A_Re_R_Mul_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R3_en      <= 1'b0;  
      else if ( Re_R_Done )
              Re_R3_en      <= 1'b1;  
      else 
              Re_R3_en      <= 1'b0;               
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Re_R3_X_Mul_en      <= 1'b0;  
      else if ( Re_R3_Done )
              Re_R3_X_Mul_en      <= 1'b1;  
      else 
              Re_R3_X_Mul_en      <= 1'b0;               
      end 
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Re_R3_Y_Mul_en            <= 1'b0;  
      else if ( Re_R3_Done )
               Re_R3_Y_Mul_en            <= 1'b1;     
      else 
               Re_R3_Y_Mul_en            <= 1'b0;               
      end 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Re_R3_Z_Mul_en            <= 1'b0;  
      else if ( Re_R3_Done )
               Re_R3_Z_Mul_en            <= 1'b1;     
      else 
               Re_R3_Z_Mul_en            <= 1'b0;               
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              A_Re_R3_X_Mul_en      <= 1'b0;  
      else if ( Re_R3_X_Mul_Done )
              A_Re_R3_X_Mul_en      <= 1'b1;  
      else 
              A_Re_R3_X_Mul_en      <= 1'b0;               
      end 
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               A_Re_R3_Y_Mul_en            <= 1'b0;  
      else if ( Re_R3_X_Mul_Done )
               A_Re_R3_Y_Mul_en            <= 1'b1;     
      else 
               A_Re_R3_Y_Mul_en            <= 1'b0;               
      end 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               A_Re_R3_Z_Mul_en            <= 1'b0;  
      else if ( Re_R3_X_Mul_Done )
               A_Re_R3_Z_Mul_en            <= 1'b1;     
      else 
               A_Re_R3_Z_Mul_en            <= 1'b0;               
      end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
       if (!Sys_Rst_n)    
               Col_dir_Done            <= 1'b0;  
      else if ( A_Re_R3_X_Mul_Done )
               Col_dir_Done            <= 1'b1;     
      else 
               Col_dir_Done            <= 1'b0;               
      end 
 
 
//-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           X_Sub_flow_cnt_RST   = 5'b00001	,
           X_Sub_flow_cnt_IDLE  = 5'b00010	,
           X_Sub_flow_cnt_BEGIN = 5'b00100	,
           X_Sub_flow_cnt_CHK   = 5'b01000	,
           X_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       X_Sub_flow_cnt_State <= X_Sub_flow_cnt_RST;
     end 
      else begin 
           case( X_Sub_flow_cnt_State)  
            X_Sub_flow_cnt_RST :
                begin
                      X_Sub_flow_cnt_State  <=X_Sub_flow_cnt_IDLE;
                end 
            X_Sub_flow_cnt_IDLE:
                begin
                  if (X_Sub_en)
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_BEGIN;
                  else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
                  end 
            X_Sub_flow_cnt_BEGIN:
                 begin
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_CHK;
                 end 
            X_Sub_flow_cnt_CHK:
                  begin
                     if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_END;
                     else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_CHK;
                   end 
            X_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
                      else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_END;
                 end     
                 
       default:       X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_A_out  <=  32'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)      
            X_Sub_A_out  <= X_Pos_home    ;
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)      
            X_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_B_out  <=  32'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_B_out  <= X_Pos_nei    ;
      else   if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)           
            X_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_A_Vil  <= 1'b0;          
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_A_Vil <= 1'b1;  
      else  if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)            
            X_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_B_Vil <= 1'b0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_B_Vil <= 1'b1;  
      else  if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)                      
            X_Sub_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaX             <=  32'd0;          
      else if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
            DertaX             <=  X_Sub_get_r;
      else   if (  X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)          
            DertaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            sub_done           <= 1'b0;            
      else if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
            sub_done           <= 1'b1;       
      else     
            sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_CNT  <=  5'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_CHK)      
            X_Sub_CNT  <= X_Sub_CNT + 5'd1  ;
      else 
            X_Sub_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           X_Mul_flow_cnt_RST   = 5'b00001	,
           X_Mul_flow_cnt_IDLE  = 5'b00010	,
           X_Mul_flow_cnt_BEGIN = 5'b00100	,
           X_Mul_flow_cnt_CHK   = 5'b01000	,
           X_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       X_Mul_flow_cnt_State <= X_Mul_flow_cnt_RST;
     end 
      else begin 
           case( X_Mul_flow_cnt_State)  
            X_Mul_flow_cnt_RST :
                begin
                      X_Mul_flow_cnt_State  <=X_Mul_flow_cnt_IDLE;
                end 
            X_Mul_flow_cnt_IDLE:
                begin
                  if (X_Mul_en)
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_BEGIN;
                  else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
                  end 
            X_Mul_flow_cnt_BEGIN:
                 begin
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_CHK;
                 end 
            X_Mul_flow_cnt_CHK:
                  begin
                     if ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_END;
                     else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_CHK;
                   end 
            X_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
                      else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_END;
                 end     
                 
       default:       X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_A_out  <=  32'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)      
            X_Mul_A_out  <= DertaX    ;
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)      
            X_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_B_out  <=  32'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_B_out  <= DertaX    ;
      else   if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)           
            X_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_A_Vil  <= 1'b0;          
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_A_Vil <= 1'b1;  
      else  if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)            
            X_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_B_Vil <= 1'b0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_B_Vil <= 1'b1;  
      else  if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)            
            X_Mul_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaX            <=  32'd0;          
      else if  ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
            Sqr_DertaX             <=  X_Mul_get_r;
      else   if (  X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)          
            Sqr_DertaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Mul_done           <= 1'b0;            
      else if  ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
            Mul_done           <= 1'b1;       
      else        
            Mul_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_CNT  <=  5'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_CHK)      
            X_Mul_CNT  <= X_Mul_CNT + 5'd1  ;
      else  
            X_Mul_CNT   <=  5'd0;              
      end     
      
      
//-----------------------------------------------------------------------
//                Y  - *  -> Delat Y^2
//-----------------------------------------------------------------------
 
localparam [4:0]
           Y_Sub_flow_cnt_RST   = 5'b00001	,
           Y_Sub_flow_cnt_IDLE  = 5'b00010	,
           Y_Sub_flow_cnt_BEGIN = 5'b00100	,
           Y_Sub_flow_cnt_CHK   = 5'b01000	,
           Y_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y_Sub_flow_cnt_State <= Y_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Y_Sub_flow_cnt_State)  
            Y_Sub_flow_cnt_RST :
                begin
                      Y_Sub_flow_cnt_State  <=Y_Sub_flow_cnt_IDLE;
                end 
            Y_Sub_flow_cnt_IDLE:
                begin
                  if (Y_Sub_en)
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_BEGIN;
                  else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
                  end 
            Y_Sub_flow_cnt_BEGIN:
                 begin
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_CHK;
                 end 
            Y_Sub_flow_cnt_CHK:
                  begin
                     if ( Y_Sub_get_vil &&Y_Sub_CNT== 5'd12)
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_END;
                     else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_CHK;
                   end 
            Y_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
                      else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_END;
                 end     
                 
       default:       Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_A_out  <=  32'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)      
            Y_Sub_A_out  <= Y_Pos_home    ;
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)      
            Y_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_B_out  <=  32'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_B_out  <= Y_Pos_nei    ;
      else   if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)           
            Y_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_A_Vil  <= 1'b0;          
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_A_Vil <= 1'b1;  
      else  if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)            
            Y_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_B_Vil <= 1'b0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_B_Vil <= 1'b1;  
      else  if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)            
            Y_Sub_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaY            <=  32'd0;          
      else if ( Y_Sub_get_vil &&Y_Sub_CNT== 5'd12)
            DertaY             <=  Y_Sub_get_r;
      else   if (  Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)          
            DertaY             <= 32'd0;       
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_CNT  <=  5'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_CHK)      
            Y_Sub_CNT  <= Y_Sub_CNT + 5'd1  ;
      else      
            Y_Sub_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           Y_Mul_flow_cnt_RST   = 5'b00001	,
           Y_Mul_flow_cnt_IDLE  = 5'b00010	,
           Y_Mul_flow_cnt_BEGIN = 5'b00100	,
           Y_Mul_flow_cnt_CHK   = 5'b01000	,
           Y_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y_Mul_flow_cnt_State <= Y_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Y_Mul_flow_cnt_State)  
            Y_Mul_flow_cnt_RST :
                begin
                      Y_Mul_flow_cnt_State  <=Y_Mul_flow_cnt_IDLE;
                end 
            Y_Mul_flow_cnt_IDLE:
                begin
                  if (Y_Mul_en)
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_BEGIN;
                  else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
                  end 
            Y_Mul_flow_cnt_BEGIN:
                 begin
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_CHK;
                 end 
            Y_Mul_flow_cnt_CHK:
                  begin
                     if ( Y_Mul_get_vil && Y_Mul_CNT == 5'd10 )
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_END;
                     else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_CHK;
                   end 
            Y_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
                      else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_END;
                 end     
                 
       default:       Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_A_out  <=  32'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)      
            Y_Mul_A_out  <= DertaY    ;
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)      
            Y_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_B_out  <=  32'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_B_out  <= DertaY    ;
      else   if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)           
            Y_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_A_Vil  <= 1'b0;          
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_A_Vil <= 1'b1;  
      else  if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)            
            Y_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_B_Vil <= 1'b0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_B_Vil <= 1'b1;  
      else  if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)            
            Y_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaY            <=  32'd0;          
      else if  ( Y_Mul_get_vil && Y_Mul_CNT == 5'd10 )
            Sqr_DertaY            <=  Y_Mul_get_r;
      else   if (  Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)          
            Sqr_DertaY             <= 32'd0;       
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_CNT  <=  5'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_CHK)      
            Y_Mul_CNT  <= Y_Mul_CNT + 5'd1  ;
      else   
            Y_Mul_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//                Z  - *  -> Delat Z^2
//-----------------------------------------------------------------------

 
localparam [4:0]
           Z_Sub_flow_cnt_RST   = 5'b00001	,
           Z_Sub_flow_cnt_IDLE  = 5'b00010	,
           Z_Sub_flow_cnt_BEGIN = 5'b00100	,
           Z_Sub_flow_cnt_CHK   = 5'b01000	,
           Z_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Z_Sub_flow_cnt_State <= Z_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Z_Sub_flow_cnt_State)  
            Z_Sub_flow_cnt_RST :
                begin
                      Z_Sub_flow_cnt_State  <=Z_Sub_flow_cnt_IDLE;
                end 
            Z_Sub_flow_cnt_IDLE:
                begin
                  if (Z_Sub_en)
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_BEGIN;
                  else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
                  end 
            Z_Sub_flow_cnt_BEGIN:
                 begin
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_CHK;
                 end 
            Z_Sub_flow_cnt_CHK:
                  begin
                     if ( Z_Sub_get_vil && Z_Sub_CNT == 5'd12)
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_END;
                     else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_CHK;
                   end 
            Z_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
                      else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_END;
                 end     
                 
       default:       Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_A_out  <=  32'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)      
            Z_Sub_A_out  <= Z_Pos_home    ;
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)      
            Z_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_B_out  <=  32'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_B_out  <= Z_Pos_nei    ;
      else   if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)           
            Z_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_A_Vil  <= 1'b0;          
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_A_Vil <= 1'b1;  
      else  if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)            
            Z_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_B_Vil <= 1'b0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_B_Vil <= 1'b1;  
      else  if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)            
            Z_Sub_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaZ            <=  32'd0;          
      else if  ( Z_Sub_get_vil && Z_Sub_CNT == 5'd12)
            DertaZ             <=  Z_Sub_get_r;
      else   if (  Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)          
            DertaZ             <= 32'd0;       
      end 

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_CNT   <=  5'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_CHK)      
            Z_Sub_CNT   <= Z_Sub_CNT + 5'd1  ;
      else  
            Z_Sub_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           Z_Mul_flow_cnt_RST   = 5'b00001	,
           Z_Mul_flow_cnt_IDLE  = 5'b00010	,
           Z_Mul_flow_cnt_BEGIN = 5'b00100	,
           Z_Mul_flow_cnt_CHK   = 5'b01000	,
           Z_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Z_Mul_flow_cnt_State <= Z_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Z_Mul_flow_cnt_State)  
            Z_Mul_flow_cnt_RST :
                begin
                      Z_Mul_flow_cnt_State  <=Z_Mul_flow_cnt_IDLE;
                end 
            Z_Mul_flow_cnt_IDLE:
                begin
                  if (Z_Mul_en)
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_BEGIN;
                  else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
                  end 
            Z_Mul_flow_cnt_BEGIN:
                 begin
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_CHK;
                 end 
            Z_Mul_flow_cnt_CHK:
                  begin
                     if ( Z_Mul_get_vil && Z_Mul_CNT   ==  5'd10)
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_END;
                     else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_CHK;
                   end 
            Z_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
                      else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_END;
                 end     
                 
       default:       Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_A_out  <=  32'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)      
            Z_Mul_A_out  <= DertaZ    ;
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)      
            Z_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_B_out  <=  32'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_B_out  <= DertaZ    ;
      else   if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)           
            Z_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_A_Vil  <= 1'b0;          
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_A_Vil <= 1'b1;  
      else  if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)            
            Z_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_B_Vil <= 1'b0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_B_Vil <= 1'b1;  
      else  if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)            
            Z_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaZ            <=  32'd0;          
      else if ( Z_Mul_get_vil && Z_Mul_CNT   ==  5'd10)
            Sqr_DertaZ            <=  Z_Mul_get_r;
      else    if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)                
            Sqr_DertaZ             <= 32'd0;       
      end 
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_CNT  <=  5'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_CHK)      
            Z_Mul_CNT  <= Z_Mul_CNT + 5'd1  ;
      else     
            Z_Mul_CNT   <=  5'd0;              
      end 
      
//-----------------------------------------------------------------------
//                  Z^2 + y^2 +x^2
//-----------------------------------------------------------------------
 

 localparam [6:0]
           Sqr_RR_flow_cnt_RST      = 7'b0000001	,
           Sqr_RR_flow_cnt_IDLE     = 7'b0000010	,
           Sqr_RR_flow_cnt_BEGIN    = 7'b0000100	,
           Sqr_RR_flow_cnt_CHK      = 7'b0001000	,
           Sqr_RR_flow_cnt_XYZ      = 7'b0010000	,
           Sqr_RR_flow_cnt_CHKXYZ   = 7'b0100000	,
           Sqr_RR_flow_cnt_END      = 7'b1000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Sqr_RR_flow_cnt_State <= Sqr_RR_flow_cnt_RST;
     end 
      else begin 
           case( Sqr_RR_flow_cnt_State)  
            Sqr_RR_flow_cnt_RST :
                begin
                      Sqr_RR_flow_cnt_State  <=Sqr_RR_flow_cnt_IDLE;
                end 
            Sqr_RR_flow_cnt_IDLE:
                begin
                  if (Sum_rr)
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_BEGIN;
                  else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
                  end 
            Sqr_RR_flow_cnt_BEGIN:
                 begin
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHK;
                 end 
            Sqr_RR_flow_cnt_CHK:
                  begin
                     if ( XY_Add_get_vil && XY_Add_CNT ==  5'd13 )
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_XYZ;
                     else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHK;
                   end 
            Sqr_RR_flow_cnt_XYZ:
                  begin                               
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHKXYZ;
                   end          
            Sqr_RR_flow_cnt_CHKXYZ:
                  begin
                     if ( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_END;
                     else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHKXYZ;
                   end        
                   
                   
            Sqr_RR_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
                      else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_END;
                 end     
                 
       default:       Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Add_A_out  <=  32'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)      
            X_Add_A_out  <= Sqr_DertaX    ;
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)      
            X_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Add_B_out  <=  32'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            Y_Add_B_out  <= Sqr_DertaY   ;
      else   if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)           
            Y_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Add_A_Vil  <= 1'b0;          
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            X_Add_A_Vil  <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            X_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Add_B_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            Y_Add_B_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            Y_Add_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_C_out            <=  32'd0;          
      else if ( XY_Add_get_vil && XY_Add_CNT ==  5'd13 )
            XY_Add_C_out       <= RR_Add_get_XY_R; 
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            XY_Add_C_out             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Add_C_out            <=  32'd0;          
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ )
            Z_Add_C_out        <= Sqr_DertaZ;  
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            Z_Add_C_out             <= 32'd0;       
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_C_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ)
            XY_Add_C_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            XY_Add_C_Vil  <= 1'b0;             
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Add_C_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ)
            Z_Add_C_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            Z_Add_C_Vil  <= 1'b0;             
      end 
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_RR_data            <=  32'd0;          
      else if ( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
            M_AXIS_RR_data     <=  RR_Add_get_r; 
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            M_AXIS_RR_data             <= 32'd0;       
      end 
         
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Sum_rr_done        <=  1'b0;     
      else if( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
           Sum_rr_done        <=  1'b1;  
      else           
           Sum_rr_done        <=  1'b0; 
      end   
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_CNT  <=  5'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_CHK)      
            XY_Add_CNT  <= XY_Add_CNT + 5'd1  ;
      else     
            XY_Add_CNT   <=  5'd0;              
      end       
       
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            RR_Add_CNT  <=  5'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_CHKXYZ)      
            RR_Add_CNT  <= RR_Add_CNT + 5'd1  ;
      else     
            RR_Add_CNT   <=  5'd0;              
      end       
            
       
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    
localparam [4:0]
           Root_R_flow_cnt_RST   = 5'b00001	,
           Root_R_flow_cnt_IDLE  = 5'b00010	,
           Root_R_flow_cnt_BEGIN = 5'b00100	,
           Root_R_flow_cnt_CHK   = 5'b01000	,
           Root_R_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Root_R_flow_cnt_State <= Root_R_flow_cnt_RST;
     end 
      else begin 
           case( Root_R_flow_cnt_State)  
            Root_R_flow_cnt_RST :
                begin
                      Root_R_flow_cnt_State  <=Root_R_flow_cnt_IDLE;
                end 
            Root_R_flow_cnt_IDLE:
                begin
                  if (RR_Root_en)
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_BEGIN;
                  else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
                  end 
            Root_R_flow_cnt_BEGIN:
                 begin
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_CHK;
                 end 
            Root_R_flow_cnt_CHK:
                  begin
                     if ( Root_R_get_vil && Root_R_CNT == 5'd30)
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_END;
                     else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_CHK;
                   end 
            Root_R_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
                      else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_END;
                 end     
                 
       default:       Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_A_out  <=  32'd0;         
      else if ( Root_R_flow_cnt_State ==Root_R_flow_cnt_BEGIN)      
            Root_R_A_out  <=  M_AXIS_RR_data ;
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)
            Root_R_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_A_Vil  <=  1'b0;         
      else if ( Root_R_flow_cnt_State ==Root_R_flow_cnt_BEGIN)      
            Root_R_A_Vil  <=  1'b1;  
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)     
            Root_R_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Root_R  <=  32'd0;         
      else if ( Root_R_get_vil && Root_R_CNT == 5'd30)
             Root_R  <=  Root_R_get_r; 
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)
             Root_R  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_Done    <=  1'b0;     
      else if ( Root_R_get_vil && Root_R_CNT == 5'd30)
            Root_R_Done    <=  1'b1;  
      else      
            Root_R_Done    <=  1'b0;       
      end 
       
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_CNT    <=  5'b0;     
      else if (Root_R_get_vil&& Root_R_flow_cnt_State ==Root_R_flow_cnt_CHK)      
            Root_R_CNT    <= Root_R_CNT + 1'b1;  
      else      
            Root_R_CNT    <=  5'b0;       
      end  

 //---------------------------------------------------------------    
 //---------------------------------------------------------------    

localparam [4:0]
           Re_R_flow_cnt_RST   = 5'b00001	,
           Re_R_flow_cnt_IDLE  = 5'b00010	,
           Re_R_flow_cnt_BEGIN = 5'b00100	,
           Re_R_flow_cnt_CHK   = 5'b01000	,
           Re_R_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R_flow_cnt_State <= Re_R_flow_cnt_RST;
     end 
      else begin 
           case( Re_R_flow_cnt_State)  
            Re_R_flow_cnt_RST :
                begin
                      Re_R_flow_cnt_State  <=Re_R_flow_cnt_IDLE;
                end 
            Re_R_flow_cnt_IDLE:
                begin
                  if ( Re_R_en )
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_BEGIN;
                  else
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_IDLE;
                  end 
            Re_R_flow_cnt_BEGIN:
                 begin
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_CHK;
                 end 
            Re_R_flow_cnt_CHK:
                  begin
                     if ( Re_R_get_vil && Re_R_CNT == 5'd31 )
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_END;
                     else
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_CHK;
                   end 
            Re_R_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_IDLE;
                      else
                      Re_R_flow_cnt_State <=Re_R_flow_cnt_END;
                 end     
                 
       default:       Re_R_flow_cnt_State <=Re_R_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R_A_out  <=  32'd0;         
      else if ( Re_R_flow_cnt_State ==Re_R_flow_cnt_BEGIN)      
            Re_R_A_out  <=  M_AXIS_RR_data ;
      else  if (   Re_R_flow_cnt_State ==Re_R_flow_cnt_IDLE)    
            Re_R_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R_A_Vil  <=  1'b0;         
      else if ( Re_R_flow_cnt_State ==Re_R_flow_cnt_BEGIN)      
            Re_R_A_Vil  <=  1'b1;  
      else  if (   Re_R_flow_cnt_State ==Re_R_flow_cnt_IDLE)         
            Re_R_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R  <=  32'd0;         
      else if  ( Re_R_get_vil && Re_R_CNT == 5'd31 )
             Re_R  <=  Re_R_get_r; 
      else  if (   Re_R_flow_cnt_State ==Re_R_flow_cnt_IDLE)    
             Re_R  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R_Done    <=  1'b0;     
      else if ( Re_R_get_vil && Re_R_CNT == 5'd31 ) 
            Re_R_Done    <=  1'b1;  
      else      
            Re_R_Done    <=  1'b0;       
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R_CNT    <=  5'd0;     
      else if (Re_R_get_vil &&  Re_R_flow_cnt_State ==Re_R_flow_cnt_CHK)      
            Re_R_CNT    <= Re_R_CNT+ 1'b1;  
      else      
            Re_R_CNT    <=  5'b0;       
      end  
//---------------------------------------------------------------    
//---------------------------------------------------------------    
 localparam [4:0]
           R3_Mul_flow_cnt_RST   = 5'b00001	,
           R3_Mul_flow_cnt_IDLE  = 5'b00010	,
           R3_Mul_flow_cnt_BEGIN = 5'b00100	,
           R3_Mul_flow_cnt_CHK   = 5'b01000	,
           R3_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R3_Mul_flow_cnt_State <= R3_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R3_Mul_flow_cnt_State)  
            R3_Mul_flow_cnt_RST :
                begin
                      R3_Mul_flow_cnt_State  <=R3_Mul_flow_cnt_IDLE;
                end 
            R3_Mul_flow_cnt_IDLE:
                begin
                  if (R3_Mul_en)
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_BEGIN;
                  else
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_IDLE;
                  end 
            R3_Mul_flow_cnt_BEGIN:
                 begin
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_CHK;
                 end 
            R3_Mul_flow_cnt_CHK:
                  begin
                     if ( R3_Mul_get_vil &&R3_Mul_CNT==  5'd10)
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_END;
                     else
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_CHK;
                   end 
            R3_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_IDLE;
                      else
                      R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_END;
                 end     
                 
       default:       R3_Mul_flow_cnt_State <=R3_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R3_Mul_A_out  <=  32'd0;         
      else if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_BEGIN)      
            R3_Mul_A_out  <= M_AXIS_RR_data    ;
      else if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_IDLE)      
            R3_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R3_Mul_B_out  <=  32'd0;         
      else if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_BEGIN)
            R3_Mul_B_out  <= Root_R    ;
      else   if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_IDLE)           
            R3_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R3_Mul_A_Vil  <= 1'b0;          
      else if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_BEGIN)
            R3_Mul_A_Vil <= 1'b1;  
      else  if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_IDLE)            
            R3_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R3_Mul_B_Vil <= 1'b0;         
      else if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_BEGIN)
            R3_Mul_B_Vil <= 1'b1;  
      else  if ( R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_IDLE)            
            R3_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R3            <=  32'd0;          
      else if  ( R3_Mul_get_vil &&R3_Mul_CNT==  5'd10)
            R3            <=  R3_Mul_get_r;
      else   if (  R3_Mul_flow_cnt_State  ==R3_Mul_flow_cnt_IDLE)          
            R3             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R3_Mul_Done     <=  1'b0;          
      else if  ( R3_Mul_get_vil &&R3_Mul_CNT==  5'd10)
           R3_Mul_Done     <=  1'b1;
      else        
           R3_Mul_Done     <=  1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R3_Mul_CNT     <=  5'd0;          
      else if ( R3_Mul_get_vil && R3_Mul_flow_cnt_State ==R3_Mul_flow_cnt_CHK )
           R3_Mul_CNT     <= R3_Mul_CNT + 5'b1;
      else        
           R3_Mul_CNT     <=  5'd0; 
      end 
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    


localparam [4:0]
           A_Re_R_flow_cnt_RST   = 5'b00001	,
           A_Re_R_flow_cnt_IDLE  = 5'b00010	,
           A_Re_R_flow_cnt_BEGIN = 5'b00100	,
           A_Re_R_flow_cnt_CHK   = 5'b01000	,
           A_Re_R_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_Re_R_flow_cnt_State <= A_Re_R_flow_cnt_RST;
     end 
      else begin 
           case( A_Re_R_flow_cnt_State)  
            A_Re_R_flow_cnt_RST :
                begin
                      A_Re_R_flow_cnt_State  <=A_Re_R_flow_cnt_IDLE;
                end 
            A_Re_R_flow_cnt_IDLE:
                begin
                  if (A_Re_R_Mul_en)
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_BEGIN;
                  else
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_IDLE;
                  end 
            A_Re_R_flow_cnt_BEGIN:
                 begin
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_CHK;
                 end 
            A_Re_R_flow_cnt_CHK:
                  begin
                     if ( A_Re_R_get_vil && A_Re_R_CNT == 5'd10)
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_END;
                     else
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_CHK;
                   end 
            A_Re_R_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_IDLE;
                      else
                      A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_END;
                 end     
                 
       default:       A_Re_R_flow_cnt_State <=A_Re_R_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R_A_Mul_out  <=  32'd0;         
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_BEGIN)      
            A_Re_R_A_Mul_out  <= Re_R    ;
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_IDLE)      
            A_Re_R_A_Mul_out  <= 32'd0;             
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R_A_Mul_Vil  <= 1'b0;          
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_BEGIN)
            A_Re_R_A_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_IDLE)            
            A_Re_R_A_Mul_Vil  <= 1'b0;               
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R_B_Mul_out  <=  32'd0;         
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_BEGIN)      
            A_Re_R_B_Mul_out  <= ParaM_A_LJ    ;
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_IDLE)      
            A_Re_R_B_Mul_out  <= 32'd0;             
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R_B_Mul_Vil  <= 1'b0;          
      else if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_BEGIN)
            A_Re_R_B_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_IDLE)            
            A_Re_R_B_Mul_Vil  <= 1'b0;               
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R           <=  32'd0;          
      else if ( A_Re_R_get_vil && A_Re_R_CNT == 5'd10)
           A_Re_R            <=  A_Re_R_get_r;
      else   if (  A_Re_R_flow_cnt_State  ==A_Re_R_flow_cnt_IDLE)          
            A_Re_R             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R_Done     <=  1'b0;          
      else if ( A_Re_R_get_vil && A_Re_R_CNT == 5'd10)
           A_Re_R_Done     <=  1'b1;
      else          
           A_Re_R_Done     <=  1'b0; 
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R_CNT     <=  5'b0;          
      else if ( A_Re_R_get_vil && A_Re_R_flow_cnt_State ==A_Re_R_flow_cnt_CHK )
           A_Re_R_CNT     <=  A_Re_R_CNT +1'b1;
      else          
           A_Re_R_CNT     <=  5'b0; 
      end 


 //---------------------------------------------------------------    
 //---------------------------------------------------------------    

localparam [4:0]
           Re_R3_flow_cnt_RST   = 5'b00001	,
           Re_R3_flow_cnt_IDLE  = 5'b00010	,
           Re_R3_flow_cnt_BEGIN = 5'b00100	,
           Re_R3_flow_cnt_CHK   = 5'b01000	,
           Re_R3_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R3_flow_cnt_State <= Re_R3_flow_cnt_RST;
     end 
      else begin 
           case( Re_R3_flow_cnt_State)  
            Re_R3_flow_cnt_RST :
                begin
                      Re_R3_flow_cnt_State  <=Re_R3_flow_cnt_IDLE;
                end 
            Re_R3_flow_cnt_IDLE:
                begin
                  if ( Re_R3_en)
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_BEGIN;
                  else
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_IDLE;
                  end 
            Re_R3_flow_cnt_BEGIN:
                 begin
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_CHK;
                 end 
            Re_R3_flow_cnt_CHK:
                  begin
                     if ( Re_R3_get_vil && Re_R3_CNT == 5'd10)
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_END;
                     else
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_CHK;
                   end 
            Re_R3_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_IDLE;
                      else
                      Re_R3_flow_cnt_State <=Re_R3_flow_cnt_END;
                 end     
                 
       default:       Re_R3_flow_cnt_State <=Re_R3_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_out  <=  32'd0;         
      else if ( Re_R3_flow_cnt_State ==Re_R3_flow_cnt_BEGIN)      
            Re_R3_out  <=  R3 ;
      else if    (  Re_R3_flow_cnt_State ==Re_R3_flow_cnt_IDLE) 
            Re_R3_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Vil  <=  1'b0;         
      else if ( Re_R3_flow_cnt_State ==Re_R3_flow_cnt_BEGIN)      
            Re_R3_Vil  <=  1'b1;  
      else  if    (  Re_R3_flow_cnt_State ==Re_R3_flow_cnt_IDLE)     
            Re_R3_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R3  <=  32'd0;         
      else if ( Re_R3_get_vil && Re_R3_CNT == 5'd10)
             Re_R3  <=  Re_R3_get_r; 
      else  if    (  Re_R3_flow_cnt_State ==Re_R3_flow_cnt_IDLE) 
             Re_R3  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Done    <=  1'b0;     
      else if  ( Re_R3_get_vil && Re_R3_CNT == 5'd10)
            Re_R3_Done    <=  1'b1;  
      else      
            Re_R3_Done    <=  1'b0;       
      end  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_CNT    <=  5'b0;     
      else if (Re_R3_get_vil &&  Re_R3_flow_cnt_State ==Re_R3_flow_cnt_CHK)      
            Re_R3_CNT    <=  Re_R3_CNT +1'b1;  
      else      
            Re_R3_CNT    <=  5'b0;       
      end       
      
//---------------------------------------------------------------    
 //---------------------------------------------------------------    

localparam [4:0]
           Re_R3_X_Mul_flow_cnt_RST   = 5'b00001	,
           Re_R3_X_Mul_flow_cnt_IDLE  = 5'b00010	,
           Re_R3_X_Mul_flow_cnt_BEGIN = 5'b00100	,
           Re_R3_X_Mul_flow_cnt_CHK   = 5'b01000	,
           Re_R3_X_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R3_X_Mul_flow_cnt_State <= Re_R3_X_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Re_R3_X_Mul_flow_cnt_State)  
            Re_R3_X_Mul_flow_cnt_RST :
                begin
                      Re_R3_X_Mul_flow_cnt_State  <=Re_R3_X_Mul_flow_cnt_IDLE;
                end 
            Re_R3_X_Mul_flow_cnt_IDLE:
                begin
                  if (Re_R3_X_Mul_en)
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_BEGIN;
                  else
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_IDLE;
                  end 
            Re_R3_X_Mul_flow_cnt_BEGIN:
                 begin
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_CHK;
                 end 
            Re_R3_X_Mul_flow_cnt_CHK:
                  begin
                     if ( Re_R3_X_get_vil && Re_R3_X_Mul_CNT == 5'd10)
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_END;
                     else
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_CHK;
                   end 
            Re_R3_X_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_IDLE;
                      else
                      Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_END;
                 end     
                 
       default:       Re_R3_X_Mul_flow_cnt_State <=Re_R3_X_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_X_A_Mul_out  <=  32'd0;         
      else if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_BEGIN)      
            Re_R3_X_A_Mul_out  <=   Re_R3   ;
      else if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_IDLE)      
            Re_R3_X_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_X_B_Mul_out  <=  32'd0;         
      else if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_BEGIN)
            Re_R3_X_B_Mul_out  <=    DertaX  ;
      else   if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_IDLE)           
            Re_R3_X_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_X_A_Mul_Vil  <= 1'b0;          
      else if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_BEGIN)
            Re_R3_X_A_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_IDLE)            
            Re_R3_X_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_X_B_Mul_Vil <= 1'b0;         
      else if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_BEGIN)
            Re_R3_X_B_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_IDLE)            
            Re_R3_X_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_X            <=  32'd0;          
      else if ( Re_R3_X_get_vil && Re_R3_X_Mul_CNT == 5'd10)
            Re_R3_X            <=  Re_R3_X_get_r;
      else   if (  Re_R3_X_Mul_flow_cnt_State  ==Re_R3_X_Mul_flow_cnt_IDLE)          
            Re_R3_X             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_X_Mul_Done     <=  1'b0;          
      else if( Re_R3_X_get_vil && Re_R3_X_Mul_CNT == 5'd10)
           Re_R3_X_Mul_Done     <=  1'b1;
      else            
           Re_R3_X_Mul_Done     <=  1'b0; 
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_X_Mul_CNT     <=  5'b0;          
      else if ( Re_R3_X_get_vil&& Re_R3_X_Mul_flow_cnt_State ==Re_R3_X_Mul_flow_cnt_CHK )
           Re_R3_X_Mul_CNT     <= Re_R3_X_Mul_CNT + 1'b1;
      else            
           Re_R3_X_Mul_CNT     <=  5'b0; 
      end   
      
      
//---------------------------------------------------------------    
 //---------------------------------------------------------------    
  localparam [4:0]
           Re_R3_Y_Mul_flow_cnt_RST   = 5'b00001	,
           Re_R3_Y_Mul_flow_cnt_IDLE  = 5'b00010	,
           Re_R3_Y_Mul_flow_cnt_BEGIN = 5'b00100	,
           Re_R3_Y_Mul_flow_cnt_CHK   = 5'b01000	,
           Re_R3_Y_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R3_Y_Mul_flow_cnt_State <= Re_R3_Y_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Re_R3_Y_Mul_flow_cnt_State)  
            Re_R3_Y_Mul_flow_cnt_RST :
                begin
                      Re_R3_Y_Mul_flow_cnt_State  <=Re_R3_Y_Mul_flow_cnt_IDLE;
                end 
            Re_R3_Y_Mul_flow_cnt_IDLE:
                begin
                  if (Re_R3_Y_Mul_en)
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_BEGIN;
                  else
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_IDLE;
                  end 
            Re_R3_Y_Mul_flow_cnt_BEGIN:
                 begin
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_CHK;
                 end 
            Re_R3_Y_Mul_flow_cnt_CHK:
                  begin
                     if ( Re_R3_Y_get_vil && Re_R3_Y_Mul_CNT == 5'd10)
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_END;
                     else
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_CHK;
                   end 
            Re_R3_Y_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_IDLE;
                      else
                      Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_END;
                 end     
                 
       default:       Re_R3_Y_Mul_flow_cnt_State <=Re_R3_Y_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Y_A_Mul_out  <=  32'd0;         
      else if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_BEGIN)      
            Re_R3_Y_A_Mul_out  <=   Re_R3   ;
      else if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_IDLE)      
            Re_R3_Y_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Y_B_Mul_out  <=  32'd0;         
      else if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_BEGIN)
            Re_R3_Y_B_Mul_out  <=   DertaY   ;
      else   if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_IDLE)           
            Re_R3_Y_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Y_A_Mul_Vil  <= 1'b0;          
      else if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_BEGIN)
            Re_R3_Y_A_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_IDLE)            
            Re_R3_Y_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Y_B_Mul_Vil <= 1'b0;         
      else if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_BEGIN)
            Re_R3_Y_B_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_IDLE)            
            Re_R3_Y_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Y            <=  32'd0;          
      else if  ( Re_R3_Y_get_vil && Re_R3_Y_Mul_CNT == 5'd10)
            Re_R3_Y            <=  Re_R3_Y_get_r;
      else   if (  Re_R3_Y_Mul_flow_cnt_State  ==Re_R3_Y_Mul_flow_cnt_IDLE)          
            Re_R3_Y             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_Y_Mul_Done     <=  1'b0;          
      else if  ( Re_R3_Y_get_vil && Re_R3_Y_Mul_CNT == 5'd10)
           Re_R3_Y_Mul_Done     <=  1'b1;
      else           
           Re_R3_Y_Mul_Done     <=  1'b0; 
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_Y_Mul_CNT     <=  5'b0;          
      else if ( Re_R3_Y_get_vil && Re_R3_Y_Mul_flow_cnt_State ==Re_R3_Y_Mul_flow_cnt_CHK)
           Re_R3_Y_Mul_CNT     <= Re_R3_Y_Mul_CNT + 1'b1;
      else           
           Re_R3_Y_Mul_CNT     <=  5'b0; 
      end      
      
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    
   localparam [4:0]
           Re_R3_Z_Mul_flow_cnt_RST   = 5'b00001	,
           Re_R3_Z_Mul_flow_cnt_IDLE  = 5'b00010	,
           Re_R3_Z_Mul_flow_cnt_BEGIN = 5'b00100	,
           Re_R3_Z_Mul_flow_cnt_CHK   = 5'b01000	,
           Re_R3_Z_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R3_Z_Mul_flow_cnt_State <= Re_R3_Z_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Re_R3_Z_Mul_flow_cnt_State)  
            Re_R3_Z_Mul_flow_cnt_RST :
                begin
                      Re_R3_Z_Mul_flow_cnt_State  <=Re_R3_Z_Mul_flow_cnt_IDLE;
                end 
            Re_R3_Z_Mul_flow_cnt_IDLE:
                begin
                  if (Re_R3_Z_Mul_en)
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_BEGIN;
                  else
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_IDLE;
                  end 
            Re_R3_Z_Mul_flow_cnt_BEGIN:
                 begin
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_CHK;
                 end 
            Re_R3_Z_Mul_flow_cnt_CHK:
                  begin
                     if ( Re_R3_Z_get_vil&& Re_R3_Z_Mul_CNT== 5'd10 )
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_END;
                     else
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_CHK;
                   end 
            Re_R3_Z_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_IDLE;
                      else
                      Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_END;
                 end     
                 
       default:       Re_R3_Z_Mul_flow_cnt_State <=Re_R3_Z_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Z_A_Mul_out  <=  32'd0;         
      else if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_BEGIN)      
            Re_R3_Z_A_Mul_out  <=    Re_R3  ;
      else if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_IDLE)      
            Re_R3_Z_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Z_B_Mul_out  <=  32'd0;         
      else if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_BEGIN)
            Re_R3_Z_B_Mul_out  <=   DertaZ   ;
      else   if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_IDLE)           
            Re_R3_Z_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Z_A_Mul_Vil  <= 1'b0;          
      else if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_BEGIN)
            Re_R3_Z_A_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_IDLE)            
            Re_R3_Z_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Z_B_Mul_Vil <= 1'b0;         
      else if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_BEGIN)
            Re_R3_Z_B_Mul_Vil <= 1'b1;  
      else  if ( Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_IDLE)            
            Re_R3_Z_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R3_Z            <=  32'd0;          
      else if  ( Re_R3_Z_get_vil&& Re_R3_Z_Mul_CNT== 5'd10 )
            Re_R3_Z            <=  Re_R3_Z_get_r;
      else   if (  Re_R3_Z_Mul_flow_cnt_State  ==Re_R3_Z_Mul_flow_cnt_IDLE)          
            Re_R3_Z             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_Z_Mul_Done     <=  1'b0;          
      else if ( Re_R3_Z_get_vil&& Re_R3_Z_Mul_CNT== 5'd10 )
           Re_R3_Z_Mul_Done     <=  1'b1;
      else         
           Re_R3_Z_Mul_Done     <=  1'b0; 
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Re_R3_Z_Mul_CNT     <=   5'b0;          
      else if ( Re_R3_Z_get_vil &&  Re_R3_Z_Mul_flow_cnt_State ==Re_R3_Z_Mul_flow_cnt_CHK)
           Re_R3_Z_Mul_CNT     <=Re_R3_Z_Mul_CNT+  5'b1;
      else         
           Re_R3_Z_Mul_CNT     <=  5'b0; 
      end      
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    

      localparam [4:0]
           A_Re_R3_X_Mul_flow_cnt_RST   = 5'b00001	,
           A_Re_R3_X_Mul_flow_cnt_IDLE  = 5'b00010	,
           A_Re_R3_X_Mul_flow_cnt_BEGIN = 5'b00100	,
           A_Re_R3_X_Mul_flow_cnt_CHK   = 5'b01000	,
           A_Re_R3_X_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_Re_R3_X_Mul_flow_cnt_State <= A_Re_R3_X_Mul_flow_cnt_RST;
     end 
      else begin 
           case( A_Re_R3_X_Mul_flow_cnt_State)  
            A_Re_R3_X_Mul_flow_cnt_RST :
                begin
                      A_Re_R3_X_Mul_flow_cnt_State  <=A_Re_R3_X_Mul_flow_cnt_IDLE;
                end 
            A_Re_R3_X_Mul_flow_cnt_IDLE:
                begin
                  if (A_Re_R3_X_Mul_en)
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_BEGIN;
                  else
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_IDLE;
                  end 
            A_Re_R3_X_Mul_flow_cnt_BEGIN:
                 begin
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_CHK;
                 end 
            A_Re_R3_X_Mul_flow_cnt_CHK:
                  begin
                     if ( A_Re_R3_X_get_vil &&A_Re_R3_X_Mul_CNT== 5'd10 )
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_END;
                     else
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_CHK;
                   end 
            A_Re_R3_X_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_IDLE;
                      else
                      A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_END;
                 end     
                 
       default:       A_Re_R3_X_Mul_flow_cnt_State <=A_Re_R3_X_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_X_A_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_BEGIN)      
            A_Re_R3_X_A_Mul_out  <= Re_R3_X    ;
      else if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_IDLE)      
            A_Re_R3_X_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_X_B_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_BEGIN)
            A_Re_R3_X_B_Mul_out  <= ParaM_Ene_Force    ;
      else   if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_IDLE)           
            A_Re_R3_X_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_X_A_Mul_Vil  <= 1'b0;          
      else if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_BEGIN)
            A_Re_R3_X_A_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_IDLE)            
            A_Re_R3_X_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_X_B_Mul_Vil <= 1'b0;         
      else if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_BEGIN)
            A_Re_R3_X_B_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_IDLE)            
            A_Re_R3_X_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_X            <=  32'd0;          
      else if( A_Re_R3_X_get_vil &&A_Re_R3_X_Mul_CNT== 5'd10 )
            A_Re_R3_X              <=  A_Re_R3_X_get_r;
      else   if (  A_Re_R3_X_Mul_flow_cnt_State  ==A_Re_R3_X_Mul_flow_cnt_IDLE)          
            A_Re_R3_X             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_X_Mul_Done     <=  1'b0;          
      else if ( A_Re_R3_X_get_vil &&A_Re_R3_X_Mul_CNT== 5'd10 )
           A_Re_R3_X_Mul_Done     <=  1'b1;
      else        
           A_Re_R3_X_Mul_Done     <=  1'b0; 
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_X_Mul_CNT    <=  5'b0;          
      else if ( A_Re_R3_X_get_vil &&  A_Re_R3_X_Mul_flow_cnt_State ==A_Re_R3_X_Mul_flow_cnt_CHK )
           A_Re_R3_X_Mul_CNT     <= A_Re_R3_X_Mul_CNT +  1'b1;
      else        
           A_Re_R3_X_Mul_CNT     <=  5'b0; 
      end 
         
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    

      localparam [4:0]
           A_Re_R3_Y_Mul_flow_cnt_RST   = 5'b00001	,
           A_Re_R3_Y_Mul_flow_cnt_IDLE  = 5'b00010	,
           A_Re_R3_Y_Mul_flow_cnt_BEGIN = 5'b00100	,
           A_Re_R3_Y_Mul_flow_cnt_CHK   = 5'b01000	,
           A_Re_R3_Y_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_Re_R3_Y_Mul_flow_cnt_State <= A_Re_R3_Y_Mul_flow_cnt_RST;
     end 
      else begin 
           case( A_Re_R3_Y_Mul_flow_cnt_State)  
            A_Re_R3_Y_Mul_flow_cnt_RST :
                begin
                      A_Re_R3_Y_Mul_flow_cnt_State  <=A_Re_R3_Y_Mul_flow_cnt_IDLE;
                end 
            A_Re_R3_Y_Mul_flow_cnt_IDLE:
                begin
                  if (A_Re_R3_Y_Mul_en)
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_BEGIN;
                  else
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_IDLE;
                  end 
            A_Re_R3_Y_Mul_flow_cnt_BEGIN:
                 begin
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_CHK;
                 end 
            A_Re_R3_Y_Mul_flow_cnt_CHK:
                  begin
                     if ( A_Re_R3_Y_get_vil && A_Re_R3_Y_Mul_CNT == 5'd10)
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_END;
                     else
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_CHK;
                   end 
            A_Re_R3_Y_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_IDLE;
                      else
                      A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_END;
                 end     
                 
       default:       A_Re_R3_Y_Mul_flow_cnt_State <=A_Re_R3_Y_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Y_A_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_BEGIN)      
            A_Re_R3_Y_A_Mul_out  <=  Re_R3_Y    ;
      else if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_IDLE)      
            A_Re_R3_Y_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Y_B_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_BEGIN)
            A_Re_R3_Y_B_Mul_out  <= ParaM_Ene_Force    ;
      else   if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_IDLE)           
            A_Re_R3_Y_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Y_A_Mul_Vil  <= 1'b0;          
      else if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_BEGIN)
            A_Re_R3_Y_A_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_IDLE)            
            A_Re_R3_Y_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Y_B_Mul_Vil <= 1'b0;         
      else if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_BEGIN)
            A_Re_R3_Y_B_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_IDLE)            
            A_Re_R3_Y_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Y            <=  32'd0;          
      else if ( A_Re_R3_Y_get_vil && A_Re_R3_Y_Mul_CNT == 5'd10)
            A_Re_R3_Y              <=  A_Re_R3_Y_get_r;
      else    if ( A_Re_R3_Y_Mul_flow_cnt_State  ==A_Re_R3_Y_Mul_flow_cnt_IDLE)         
            A_Re_R3_Y             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_Y_Mul_Done     <=  1'b0;          
      else if  ( A_Re_R3_Y_get_vil && A_Re_R3_Y_Mul_CNT == 5'd10)
           A_Re_R3_Y_Mul_Done     <=  1'b1;
      else        
           A_Re_R3_Y_Mul_Done     <=  1'b0; 
      end 
   

        
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_Y_Mul_CNT     <=  5'b0;          
      else if ( A_Re_R3_Y_get_vil &&   A_Re_R3_Y_Mul_flow_cnt_State ==A_Re_R3_Y_Mul_flow_cnt_CHK )
           A_Re_R3_Y_Mul_CNT     <= A_Re_R3_Y_Mul_CNT + 1'b1;
      else        
           A_Re_R3_Y_Mul_CNT     <=  5'b0; 
      end 
        

  //---------------------------------------------------------------    
 //---------------------------------------------------------------    
  localparam [6:0]
           A_Re_R3_Z_Mul_flow_cnt_RST     = 6'b000001	,
           A_Re_R3_Z_Mul_flow_cnt_IDLE    = 6'b000010	,
           A_Re_R3_Z_Mul_flow_cnt_BEGIN   = 6'b000100	,
           A_Re_R3_Z_Mul_flow_cnt_CHK     = 6'b001000	,
           A_Re_R3_Z_Mul_flow_cnt_CHK_buf = 6'b010000	,
           A_Re_R3_Z_Mul_flow_cnt_END     = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_Re_R3_Z_Mul_flow_cnt_State <= A_Re_R3_Z_Mul_flow_cnt_RST;
     end 
      else begin 
           case( A_Re_R3_Z_Mul_flow_cnt_State)  
            A_Re_R3_Z_Mul_flow_cnt_RST :
                begin
                      A_Re_R3_Z_Mul_flow_cnt_State  <=A_Re_R3_Z_Mul_flow_cnt_IDLE;
                end 
            A_Re_R3_Z_Mul_flow_cnt_IDLE:
                begin
                  if (A_Re_R3_Z_Mul_en)
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_BEGIN;
                  else
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_IDLE;
                  end 
            A_Re_R3_Z_Mul_flow_cnt_BEGIN:
                 begin
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_CHK;
                 end 
            A_Re_R3_Z_Mul_flow_cnt_CHK:
                  begin
                     if ( A_Re_R3_Z_get_vil && A_Re_R3_Z_Mul_CNT == 5'd10)
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_CHK_buf;
                     else
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_CHK;
                   end 
           A_Re_R3_Z_Mul_flow_cnt_CHK_buf:
                  begin
               
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_END;
                   end         
                   
                   
            A_Re_R3_Z_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_IDLE;
                      else
                      A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_END;
                 end     
                 
       default:       A_Re_R3_Z_Mul_flow_cnt_State <=A_Re_R3_Z_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Z_A_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_BEGIN)      
            A_Re_R3_Z_A_Mul_out  <=    Re_R3_Z  ;
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)      
            A_Re_R3_Z_A_Mul_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Z_B_Mul_out  <=  32'd0;         
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_BEGIN)
            A_Re_R3_Z_B_Mul_out  <= ParaM_Ene_Force    ;
      else   if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)           
            A_Re_R3_Z_B_Mul_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Z_A_Mul_Vil  <= 1'b0;          
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_BEGIN)
            A_Re_R3_Z_A_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)            
            A_Re_R3_Z_A_Mul_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Z_B_Mul_Vil <= 1'b0;         
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_BEGIN)
            A_Re_R3_Z_B_Mul_Vil <= 1'b1;  
      else  if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)            
            A_Re_R3_Z_B_Mul_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R3_Z              <=  32'd0;          
      else if  ( A_Re_R3_Z_get_vil && A_Re_R3_Z_Mul_CNT == 5'd10)
            A_Re_R3_Z              <=  A_Re_R3_Z_get_r;
      else   if (  A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)          
            A_Re_R3_Z              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_Z_Mul_Done     <=  1'b0;          
      else if  ( A_Re_R3_Z_get_vil && A_Re_R3_Z_Mul_CNT == 5'd10)
           A_Re_R3_Z_Mul_Done     <=  1'b1;
      else          
           A_Re_R3_Z_Mul_Done     <=  1'b0; 
      end 
      
      
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Col_EnE_Force     <=  256'd0;          
      else if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_CHK_buf )
           M_AXIS_Col_EnE_Force   <= {Index_Pos_home[159:144],Index_Pos_home[63:32],16'HFF,Index_Pos_nei[159:144],Index_Pos_nei[63:32],16'HFF,A_Re_R,A_Re_R3_X,A_Re_R3_Y,A_Re_R3_Z };
      else  if ( A_Re_R3_Z_Mul_flow_cnt_State  ==A_Re_R3_Z_Mul_flow_cnt_IDLE)          
           M_AXIS_Col_EnE_Force     <=  256'd0;
      end  
      

 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R3_Z_Mul_CNT     <=  5'b0;          
      else if ( A_Re_R3_Z_get_vil && A_Re_R3_Z_Mul_flow_cnt_State ==A_Re_R3_Z_Mul_flow_cnt_CHK)
           A_Re_R3_Z_Mul_CNT     <=  A_Re_R3_Z_Mul_CNT + 1'b1;
      else          
           A_Re_R3_Z_Mul_CNT     <=  5'b0; 
      end      
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    
   
 localparam [4:0]
           R4_Mul_flow_cnt_RST   = 5'b00001	,
           R4_Mul_flow_cnt_IDLE  = 5'b00010	,
           R4_Mul_flow_cnt_BEGIN = 5'b00100	,
           R4_Mul_flow_cnt_CHK   = 5'b01000	,
           R4_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R4_Mul_flow_cnt_State <= R4_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R4_Mul_flow_cnt_State)  
            R4_Mul_flow_cnt_RST :
                begin
                      R4_Mul_flow_cnt_State  <=R4_Mul_flow_cnt_IDLE;
                end 
            R4_Mul_flow_cnt_IDLE:
                begin
                  if (R4_Mul_en)
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_BEGIN;
                  else
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_IDLE;
                  end 
            R4_Mul_flow_cnt_BEGIN:
                 begin
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_CHK;
                 end 
            R4_Mul_flow_cnt_CHK:
                  begin
                     if ( R4_Mul_get_vil && R4_Mul_CNT == 5'd10 )
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_END;
                     else
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_CHK;
                   end 
            R4_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_IDLE;
                      else
                      R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_END;
                 end     
                 
       default:       R4_Mul_flow_cnt_State <=R4_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R4_Mul_A_out  <=  32'd0;         
      else if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_BEGIN)      
            R4_Mul_A_out  <= M_AXIS_RR_data    ;
      else if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_IDLE)      
            R4_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R4_Mul_B_out  <=  32'd0;         
      else if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_BEGIN)
            R4_Mul_B_out  <= M_AXIS_RR_data    ;
      else   if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_IDLE)           
            R4_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R4_Mul_A_Vil  <= 1'b0;          
      else if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_BEGIN)
            R4_Mul_A_Vil <= 1'b1;  
      else  if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_IDLE)            
            R4_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R4_Mul_B_Vil <= 1'b0;         
      else if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_BEGIN)
            R4_Mul_B_Vil <= 1'b1;  
      else  if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_IDLE)            
            R4_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R4              <=  32'd0;          
      else if ( R4_Mul_get_vil && R4_Mul_CNT == 5'd10 )
            R4              <=  R4_Mul_get_r;
      else  if ( R4_Mul_flow_cnt_State  ==R4_Mul_flow_cnt_IDLE)           
            R4              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R4_Mul_Done     <=  1'b0;          
      else if ( R4_Mul_get_vil && R4_Mul_CNT == 5'd10 )
           R4_Mul_Done     <=  1'b1;
      else   
           R4_Mul_Done    <=  1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R4_Mul_CNT     <=  5'b0;          
      else if ( R4_Mul_get_vil  &&R4_Mul_flow_cnt_State ==R4_Mul_flow_cnt_CHK)
           R4_Mul_CNT     <=  R4_Mul_CNT + 1'b1;
      else   
           R4_Mul_CNT    <=  5'b0; 
      end 

   
  //---------------------------------------------------------------    
   
 localparam [4:0]
           R6_Mul_flow_cnt_RST   = 5'b00001	,
           R6_Mul_flow_cnt_IDLE  = 5'b00010	,
           R6_Mul_flow_cnt_BEGIN = 5'b00100	,
           R6_Mul_flow_cnt_CHK   = 5'b01000	,
           R6_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R6_Mul_flow_cnt_State <= R6_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R6_Mul_flow_cnt_State)  
            R6_Mul_flow_cnt_RST :
                begin
                      R6_Mul_flow_cnt_State  <=R6_Mul_flow_cnt_IDLE;
                end 
            R6_Mul_flow_cnt_IDLE:
                begin
                  if (R6_Mul_en)
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_BEGIN;
                  else
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_IDLE;
                  end 
            R6_Mul_flow_cnt_BEGIN:
                 begin
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_CHK;
                 end 
            R6_Mul_flow_cnt_CHK:
                  begin
                     if ( R6_Mul_get_vil && R6_Mul_CNT == 5'd10)
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_END;
                     else
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_CHK;
                   end 
            R6_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_IDLE;
                      else
                      R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_END;
                 end     
                 
       default:       R6_Mul_flow_cnt_State <=R6_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R6_Mul_A_out  <=  32'd0;         
      else if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_BEGIN)      
            R6_Mul_A_out  <= R4    ;
      else if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_IDLE)      
            R6_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R6_Mul_B_out  <=  32'd0;         
      else if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_BEGIN)
            R6_Mul_B_out  <= M_AXIS_RR_data    ;
      else   if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_IDLE)           
            R6_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R6_Mul_A_Vil  <= 1'b0;          
      else if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_BEGIN)
            R6_Mul_A_Vil <= 1'b1;  
      else  if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_IDLE)            
            R6_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R6_Mul_B_Vil <= 1'b0;         
      else if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_BEGIN)
            R6_Mul_B_Vil <= 1'b1;  
      else  if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_IDLE)            
            R6_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R6              <=  32'd0;          
      else if ( R6_Mul_get_vil && R6_Mul_CNT == 5'd10)
            R6              <=  R6_Mul_get_r;
      else  if ( R6_Mul_flow_cnt_State  ==R6_Mul_flow_cnt_IDLE)                 
            R6              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R6_Mul_Done     <=  1'b0;          
      else if  ( R6_Mul_get_vil && R6_Mul_CNT == 5'd10)
           R6_Mul_Done     <=  1'b1;
      else   
           R6_Mul_Done    <=  1'b0; 
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R6_Mul_CNT     <=  5'b0;          
      else if ( R6_Mul_get_vil && R6_Mul_flow_cnt_State ==R6_Mul_flow_cnt_CHK)
           R6_Mul_CNT     <= R6_Mul_CNT +  5'b1;
      else   
           R6_Mul_CNT    <=  5'b0; 
      end     
       //---------------------------------------------------------------    
     
 localparam [4:0]
           R12_Mul_flow_cnt_RST   = 5'b00001	,
           R12_Mul_flow_cnt_IDLE  = 5'b00010	,
           R12_Mul_flow_cnt_BEGIN = 5'b00100	,
           R12_Mul_flow_cnt_CHK   = 5'b01000	,
           R12_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R12_Mul_flow_cnt_State <= R12_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R12_Mul_flow_cnt_State)  
            R12_Mul_flow_cnt_RST :
                begin
                      R12_Mul_flow_cnt_State  <=R12_Mul_flow_cnt_IDLE;
                end 
            R12_Mul_flow_cnt_IDLE:
                begin
                  if (R12_Mul_en)
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_BEGIN;
                  else
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_IDLE;
                  end 
            R12_Mul_flow_cnt_BEGIN:
                 begin
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_CHK;
                 end 
            R12_Mul_flow_cnt_CHK:
                  begin
                     if ( R12_Mul_get_vil && R12_Mul_CNT == 5'd10 )
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_END;
                     else
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_CHK;
                   end 
            R12_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_IDLE;
                      else
                      R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_END;
                 end     
                 
       default:       R12_Mul_flow_cnt_State <=R12_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R12_Mul_A_out  <=  32'd0;         
      else if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_BEGIN)      
            R12_Mul_A_out  <= R6    ;
      else if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_IDLE)      
            R12_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R12_Mul_B_out  <=  32'd0;         
      else if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_BEGIN)
            R12_Mul_B_out  <= R6    ;
      else   if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_IDLE)           
            R12_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R12_Mul_A_Vil  <= 1'b0;          
      else if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_BEGIN)
            R12_Mul_A_Vil <= 1'b1;  
      else  if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_IDLE)            
            R12_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R12_Mul_B_Vil <= 1'b0;         
      else if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_BEGIN)
            R12_Mul_B_Vil <= 1'b1;  
      else  if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_IDLE)            
            R12_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R12              <=  32'd0;          
      else if ( R12_Mul_get_vil && R12_Mul_CNT == 5'd10 )
            R12              <=  R12_Mul_get_r;
      else   if ( R12_Mul_flow_cnt_State  ==R12_Mul_flow_cnt_IDLE)          
            R12              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R12_Mul_Done     <=  1'b0;          
      else if  ( R12_Mul_get_vil && R12_Mul_CNT == 5'd10 )
           R12_Mul_Done     <=  1'b1;
      else          
           R12_Mul_Done    <=  1'b0; 
      end   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R12_Mul_CNT     <=  5'b0;          
      else if ( R12_Mul_get_vil&& R12_Mul_flow_cnt_State ==R12_Mul_flow_cnt_CHK )
           R12_Mul_CNT     <= R12_Mul_CNT + 1'b1;
      else          
           R12_Mul_CNT    <=  5'b0; 
      end        
//---------------------------------------------------------------    
//---------------------------------------------------------------    

localparam [4:0]
           Re_R6_flow_cnt_RST   = 5'b00001	,
           Re_R6_flow_cnt_IDLE  = 5'b00010	,
           Re_R6_flow_cnt_BEGIN = 5'b00100	,
           Re_R6_flow_cnt_CHK   = 5'b01000	,
           Re_R6_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R6_flow_cnt_State <= Re_R6_flow_cnt_RST;
     end 
      else begin 
           case( Re_R6_flow_cnt_State)  
            Re_R6_flow_cnt_RST :
                begin
                      Re_R6_flow_cnt_State  <=Re_R6_flow_cnt_IDLE;
                end 
            Re_R6_flow_cnt_IDLE:
                begin
                  if (Re_R6_en)
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_BEGIN;
                  else
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_IDLE;
                  end 
            Re_R6_flow_cnt_BEGIN:
                 begin
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_CHK;
                 end 
            Re_R6_flow_cnt_CHK:
                  begin
                     if ( Re_R6_get_vil && Re_R6_CNT == 5'd30)
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_END;
                     else
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_CHK;
                   end 
            Re_R6_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_IDLE;
                      else
                      Re_R6_flow_cnt_State <=Re_R6_flow_cnt_END;
                 end     
                 
       default:       Re_R6_flow_cnt_State <=Re_R6_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R6_A_out  <=  32'd0;         
      else if ( Re_R6_flow_cnt_State ==Re_R6_flow_cnt_BEGIN)      
            Re_R6_A_out  <=  R6 ;
      else if (   Re_R6_flow_cnt_State == Re_R6_flow_cnt_IDLE)    
            Re_R6_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R6_A_Vil  <=  1'b0;         
      else if ( Re_R6_flow_cnt_State ==Re_R6_flow_cnt_BEGIN)      
            Re_R6_A_Vil  <=  1'b1;  
      else if (   Re_R6_flow_cnt_State == Re_R6_flow_cnt_IDLE)         
            Re_R6_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R6  <=  32'd0;         
      else if ( Re_R6_get_vil && Re_R6_CNT == 5'd30)
             Re_R6  <=  Re_R6_get_r; 
      else if (   Re_R6_flow_cnt_State == Re_R6_flow_cnt_IDLE)    
             Re_R6  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R6_Done    <=  1'b0;     
      else if ( Re_R6_get_vil && Re_R6_CNT == 5'd30)   
            Re_R6_Done    <=  1'b1;  
      else      
            Re_R6_Done    <=  1'b0;       
      end  
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R6_CNT    <=  5'b0;     
      else if (Re_R6_get_vil &&Re_R6_flow_cnt_State ==Re_R6_flow_cnt_CHK)      
            Re_R6_CNT    <= Re_R6_CNT + 1'b1;  
      else      
            Re_R6_CNT    <=  5'b0;       
      end  

 //---------------------------------------------------------------    
 //---------------------------------------------------------------    
   localparam [4:0]
           Re_R12_flow_cnt_RST   = 5'b00001	,
           Re_R12_flow_cnt_IDLE  = 5'b00010	,
           Re_R12_flow_cnt_BEGIN = 5'b00100	,
           Re_R12_flow_cnt_CHK   = 5'b01000	,
           Re_R12_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R12_flow_cnt_State <= Re_R12_flow_cnt_RST;
     end 
      else begin 
           case( Re_R12_flow_cnt_State)  
            Re_R12_flow_cnt_RST :
                begin
                      Re_R12_flow_cnt_State  <=Re_R12_flow_cnt_IDLE;
                end 
            Re_R12_flow_cnt_IDLE:
                begin
                  if (Re_R12_en)
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_BEGIN;
                  else
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_IDLE;
                  end 
            Re_R12_flow_cnt_BEGIN:
                 begin
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_CHK;
                 end 
            Re_R12_flow_cnt_CHK:
                  begin
                     if ( Re_R12_get_vil && Re_R12_CNT == 5'd30 )
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_END;
                     else
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_CHK;
                   end 
            Re_R12_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_IDLE;
                      else
                      Re_R12_flow_cnt_State <=Re_R12_flow_cnt_END;
                 end     
                 
       default:       Re_R12_flow_cnt_State <=Re_R12_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R12_A_out  <=  32'd0;         
      else if ( Re_R12_flow_cnt_State ==Re_R12_flow_cnt_BEGIN)      
            Re_R12_A_out  <=  R12 ;
      else  if(  Re_R12_flow_cnt_State ==Re_R12_flow_cnt_IDLE )    
            Re_R12_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R12_A_Vil  <=  1'b0;         
      else if ( Re_R12_flow_cnt_State ==Re_R12_flow_cnt_BEGIN)      
            Re_R12_A_Vil  <=  1'b1;  
      else   if(  Re_R12_flow_cnt_State ==Re_R12_flow_cnt_IDLE )        
            Re_R12_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R12  <=  32'd0;         
      else if( Re_R12_get_vil && Re_R12_CNT == 5'd30 )   
             Re_R12  <=  Re_R12_get_r; 
      else  if(  Re_R12_flow_cnt_State ==Re_R12_flow_cnt_IDLE )    
             Re_R12  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R12_Done    <=  1'b0;     
      else if ( Re_R12_get_vil && Re_R12_CNT == 5'd30 )    
            Re_R12_Done    <=  1'b1;  
      else      
            Re_R12_Done    <=  1'b0;       
      end   
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R12_CNT    <=  5'b0;     
      else if (Re_R12_get_vil &&  Re_R12_flow_cnt_State ==Re_R12_flow_cnt_CHK)      
            Re_R12_CNT    <= Re_R12_CNT + 1'b1;  
      else      
            Re_R12_CNT    <=  5'b0;       
      end      
                  
  //---------------------------------------------------------------    

 localparam [4:0]
           A_Re_R12_flow_cnt_RST   = 5'b00001	,
           A_Re_R12_flow_cnt_IDLE  = 5'b00010	,
           A_Re_R12_flow_cnt_BEGIN = 5'b00100	,
           A_Re_R12_flow_cnt_CHK   = 5'b01000	,
           A_Re_R12_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_Re_R12_flow_cnt_State <= A_Re_R12_flow_cnt_RST;
     end 
      else begin 
           case( A_Re_R12_flow_cnt_State)  
            A_Re_R12_flow_cnt_RST :
                begin
                      A_Re_R12_flow_cnt_State  <=A_Re_R12_flow_cnt_IDLE;
                end 
            A_Re_R12_flow_cnt_IDLE:
                begin
                  if (A_Re_R12_en)
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_BEGIN;
                  else
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_IDLE;
                  end 
            A_Re_R12_flow_cnt_BEGIN:
                 begin
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_CHK;
                 end 
            A_Re_R12_flow_cnt_CHK:
                  begin
                     if ( A_Re_R12_get_vil && A_Re_R12_CNT == 5'd10 )
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_END;
                     else
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_CHK;
                   end 
            A_Re_R12_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_IDLE;
                      else
                      A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_END;
                 end     
                 
       default:       A_Re_R12_flow_cnt_State <=A_Re_R12_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R12_A_out  <=  32'd0;         
      else if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_BEGIN)      
            A_Re_R12_A_out  <= ParaM_A_LJ    ;
      else if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_IDLE)      
            A_Re_R12_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R12_B_out  <=  32'd0;         
      else if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_BEGIN)
            A_Re_R12_B_out  <= Re_R12    ;
      else   if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_IDLE)           
            A_Re_R12_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R12_A_Vil  <= 1'b0;          
      else if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_BEGIN)
            A_Re_R12_A_Vil <= 1'b1;  
      else  if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_IDLE)            
            A_Re_R12_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R12_B_Vil <= 1'b0;         
      else if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_BEGIN)
            A_Re_R12_B_Vil <= 1'b1;  
      else  if ( A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_IDLE)            
            A_Re_R12_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_Re_R12              <=  32'd0;          
      else if ( A_Re_R12_get_vil && A_Re_R12_CNT == 5'd10 )
            A_Re_R12              <=  A_Re_R12_get_r;
      else   if (  A_Re_R12_flow_cnt_State  ==A_Re_R12_flow_cnt_IDLE)          
            A_Re_R12              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R12_Done     <=  1'b0;          
      else if ( A_Re_R12_get_vil && A_Re_R12_CNT == 5'd10 )
           A_Re_R12_Done     <=  1'b1;
      else        
           A_Re_R12_Done    <=  1'b0; 
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_Re_R12_CNT     <=  5'b0;          
      else if ( A_Re_R12_get_vil &&   A_Re_R12_flow_cnt_State ==A_Re_R12_flow_cnt_CHK)
           A_Re_R12_CNT     <=  A_Re_R12_CNT + 1'b1;
      else        
           A_Re_R12_CNT    <=  5'b0; 
      end 
 //---------------------------------------------------------------    
         
localparam [4:0]
           B_Re_R6_flow_cnt_RST   = 5'b00001	,
           B_Re_R6_flow_cnt_IDLE  = 5'b00010	,
           B_Re_R6_flow_cnt_BEGIN = 5'b00100	,
           B_Re_R6_flow_cnt_CHK   = 5'b01000	,
           B_Re_R6_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       B_Re_R6_flow_cnt_State <= B_Re_R6_flow_cnt_RST;
     end 
      else begin 
           case( B_Re_R6_flow_cnt_State)  
            B_Re_R6_flow_cnt_RST :
                begin
                      B_Re_R6_flow_cnt_State  <=B_Re_R6_flow_cnt_IDLE;
                end 
            B_Re_R6_flow_cnt_IDLE:
                begin
                  if (B_Re_R6_en)
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_BEGIN;
                  else
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_IDLE;
                  end 
            B_Re_R6_flow_cnt_BEGIN:
                 begin
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_CHK;
                 end 
            B_Re_R6_flow_cnt_CHK:
                  begin
                     if ( B_Re_R6_get_vil && B_Re_R6_CNT== 5'd10 )
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_END;
                     else
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_CHK;
                   end 
            B_Re_R6_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_IDLE;
                      else
                      B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_END;
                 end     
                 
       default:       B_Re_R6_flow_cnt_State <=B_Re_R6_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Re_R6_A_out  <=  32'd0;         
      else if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_BEGIN)      
            B_Re_R6_A_out  <= ParaM_B_LJ   ;
      else if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_IDLE)      
            B_Re_R6_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Re_R6_B_out  <=  32'd0;         
      else if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_BEGIN)
            B_Re_R6_B_out  <= Re_R6   ;
      else   if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_IDLE)           
            B_Re_R6_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Re_R6_A_Vil  <= 1'b0;          
      else if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_BEGIN)
            B_Re_R6_A_Vil <= 1'b1;  
      else  if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_IDLE)            
            B_Re_R6_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Re_R6_B_Vil <= 1'b0;         
      else if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_BEGIN)
            B_Re_R6_B_Vil <= 1'b1;  
      else  if ( B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_IDLE)            
            B_Re_R6_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Re_R6              <=  32'd0;          
      else if  ( B_Re_R6_get_vil && B_Re_R6_CNT== 5'd10 )
            B_Re_R6          <=  B_Re_R6_get_r;
      else   if (  B_Re_R6_flow_cnt_State  ==B_Re_R6_flow_cnt_IDLE)          
            B_Re_R6              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           B_Re_R6_Done     <=  1'b0;          
      else if  ( B_Re_R6_get_vil && B_Re_R6_CNT== 5'd10 )
           B_Re_R6_Done     <=  1'b1;
      else   
           B_Re_R6_Done    <=  1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           B_Re_R6_CNT     <=  5'b0;          
      else if ( B_Re_R6_get_vil &&    B_Re_R6_flow_cnt_State ==B_Re_R6_flow_cnt_CHK)
           B_Re_R6_CNT     <= B_Re_R6_CNT + 1'b1;
      else   
           B_Re_R6_CNT    <=  5'b0; 
      end 

//----------------------------------------------------------------
//----------------------------------------------------------------

localparam [4:0]
           Energy_Sub_flow_cnt_RST   = 5'b00001	,
           Energy_Sub_flow_cnt_IDLE  = 5'b00010	,
           Energy_Sub_flow_cnt_BEGIN = 5'b00100	,
           Energy_Sub_flow_cnt_CHK   = 5'b01000	,
           Energy_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Energy_Sub_flow_cnt_State <= Energy_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Energy_Sub_flow_cnt_State)  
            Energy_Sub_flow_cnt_RST :
                begin
                      Energy_Sub_flow_cnt_State  <=Energy_Sub_flow_cnt_IDLE;
                end 
            Energy_Sub_flow_cnt_IDLE:
                begin
                  if (Energy_Sub_en)
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_BEGIN;
                  else
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_IDLE;
                  end 
            Energy_Sub_flow_cnt_BEGIN:
                 begin
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_CHK;
                 end 
            Energy_Sub_flow_cnt_CHK:
                  begin
                     if ( Energy_get_vil && Energy_Sub_CNT== 5'd13)
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_END;
                     else
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_CHK;
                   end 
            Energy_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_IDLE;
                      else
                      Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_END;
                 end     
                 
       default:       Energy_Sub_flow_cnt_State <=Energy_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_A_out  <=  32'd0;         
      else if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_BEGIN)      
            Energy_A_out  <= A_Re_R12    ;
      else if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_IDLE)      
            Energy_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_B_out  <=  32'd0;         
      else if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_BEGIN)
            Energy_B_out  <= B_Re_R6    ;
      else   if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_IDLE)           
            Energy_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_A_Vil  <= 1'b0;          
      else if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_BEGIN)
            Energy_A_Vil <= 1'b1;  
      else  if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_IDLE)            
            Energy_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_B_Vil <= 1'b0;         
      else if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_BEGIN)
            Energy_B_Vil <= 1'b1;  
      else  if ( Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_IDLE)            
            Energy_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_LJ_Energy            <=  32'd0;          
      else if ( Energy_get_vil && Energy_Sub_CNT== 5'd13)
            M_AXIS_LJ_Energy             <=  Energy_get_r;
      else   if (  Energy_Sub_flow_cnt_State  ==Energy_Sub_flow_cnt_IDLE)          
            M_AXIS_LJ_Energy             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_Sub_Done           <= 1'b0;            
      else if ( Energy_get_vil && Energy_Sub_CNT== 5'd13)
            Energy_Sub_Done           <= 1'b1;       
      else   
            Energy_Sub_Done           <= 1'b0;              
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Energy_Sub_CNT           <= 5'b0;            
      else if ( Energy_get_vil &&  Energy_Sub_flow_cnt_State ==Energy_Sub_flow_cnt_CHK)
            Energy_Sub_CNT           <=  Energy_Sub_CNT +1'b1;       
      else   
            Energy_Sub_CNT           <= 5'b0;              
      end 
//----------------------------------------------------------------
//----------------------------------------------------------------

    
 localparam [4:0]
           R14_Mul_flow_cnt_RST   = 5'b00001	,
           R14_Mul_flow_cnt_IDLE  = 5'b00010	,
           R14_Mul_flow_cnt_BEGIN = 5'b00100	,
           R14_Mul_flow_cnt_CHK   = 5'b01000	,
           R14_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R14_Mul_flow_cnt_State <= R14_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R14_Mul_flow_cnt_State)  
            R14_Mul_flow_cnt_RST :
                begin
                      R14_Mul_flow_cnt_State  <=R14_Mul_flow_cnt_IDLE;
                end 
            R14_Mul_flow_cnt_IDLE:
                begin
                  if (R14_Mul_en)
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_BEGIN;
                  else
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_IDLE;
                  end 
            R14_Mul_flow_cnt_BEGIN:
                 begin
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_CHK;
                 end 
            R14_Mul_flow_cnt_CHK:
                  begin
                     if ( R14_Mul_get_vil && R14_Mul_CNT == 5'd10  )
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_END;
                     else
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_CHK;
                   end 
            R14_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_IDLE;
                      else
                      R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_END;
                 end     
                 
       default:       R14_Mul_flow_cnt_State <=R14_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_Mul_A_out  <=  32'd0;         
      else if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_BEGIN)      
            R14_Mul_A_out  <= R12    ;
      else if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_IDLE)      
            R14_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_Mul_B_out  <=  32'd0;         
      else if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_BEGIN)
            R14_Mul_B_out  <= M_AXIS_RR_data    ;
      else   if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_IDLE)           
            R14_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_Mul_A_Vil  <= 1'b0;          
      else if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_BEGIN)
            R14_Mul_A_Vil <= 1'b1;  
      else  if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_IDLE)            
            R14_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_Mul_B_Vil <= 1'b0;         
      else if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_BEGIN)
            R14_Mul_B_Vil <= 1'b1;  
      else  if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_IDLE)            
            R14_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14              <=  32'd0;          
      else if ( R14_Mul_get_vil && R14_Mul_CNT == 5'd10  )
            R14              <=  R14_Mul_get_r;
      else  if ( R14_Mul_flow_cnt_State  ==R14_Mul_flow_cnt_IDLE)      
            R14              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R14_Mul_Done     <=  1'b0;          
      else if( R14_Mul_get_vil && R14_Mul_CNT == 5'd10  )
           R14_Mul_Done     <=  1'b1;
      else   
           R14_Mul_Done    <=  1'b0; 
      end   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R14_Mul_CNT     <= 5'b0;          
      else if ( R14_Mul_get_vil && R14_Mul_flow_cnt_State ==R14_Mul_flow_cnt_CHK)
           R14_Mul_CNT     <= R14_Mul_CNT + 1'b1;
      else   
           R14_Mul_CNT    <=  5'b0; 
      end   
//----------------------------------------------------------------
//----------------------------------------------------------------


 localparam [4:0]
           R8_Mul_flow_cnt_RST   = 5'b00001	,
           R8_Mul_flow_cnt_IDLE  = 5'b00010	,
           R8_Mul_flow_cnt_BEGIN = 5'b00100	,
           R8_Mul_flow_cnt_CHK   = 5'b01000	,
           R8_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R8_Mul_flow_cnt_State <= R8_Mul_flow_cnt_RST;
     end 
      else begin 
           case( R8_Mul_flow_cnt_State)  
            R8_Mul_flow_cnt_RST :
                begin
                      R8_Mul_flow_cnt_State  <=R8_Mul_flow_cnt_IDLE;
                end 
            R8_Mul_flow_cnt_IDLE:
                begin
                  if (R8_Mul_en)
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_BEGIN;
                  else
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_IDLE;
                  end 
            R8_Mul_flow_cnt_BEGIN:
                 begin
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_CHK;
                 end 
            R8_Mul_flow_cnt_CHK:
                  begin
                     if ( R8_Mul_get_vil && R8_Mul_CNT== 5'd10 )
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_END;
                     else
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_CHK;
                   end 
            R8_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_IDLE;
                      else
                      R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_END;
                 end     
                 
       default:       R8_Mul_flow_cnt_State <=R8_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R8_Mul_A_out  <=  32'd0;         
      else if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_BEGIN)      
            R8_Mul_A_out  <= R6    ;
      else if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_IDLE)      
            R8_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R8_Mul_B_out  <=  32'd0;         
      else if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_BEGIN)
            R8_Mul_B_out  <= M_AXIS_RR_data    ;
      else   if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_IDLE)           
            R8_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R8_Mul_A_Vil  <= 1'b0;          
      else if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_BEGIN)
            R8_Mul_A_Vil <= 1'b1;  
      else  if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_IDLE)            
            R8_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R8_Mul_B_Vil <= 1'b0;         
      else if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_BEGIN)
            R8_Mul_B_Vil <= 1'b1;  
      else  if ( R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_IDLE)            
            R8_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R8              <=  32'd0;          
      else if ( R8_Mul_get_vil && R8_Mul_CNT== 5'd10 )
            R8              <=  R8_Mul_get_r;
      else   if (  R8_Mul_flow_cnt_State  ==R8_Mul_flow_cnt_IDLE)          
            R8              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R8_Mul_Done     <=  1'b0;          
      else if ( R8_Mul_get_vil && R8_Mul_CNT== 5'd10 )
           R8_Mul_Done     <=  1'b1;
      else            
           R8_Mul_Done    <=  1'b0; 
      end   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R8_Mul_CNT     <=  5'b0;          
      else if ( R8_Mul_get_vil &&  R8_Mul_flow_cnt_State ==R8_Mul_flow_cnt_CHK)
           R8_Mul_CNT     <= R8_Mul_CNT + 1'b1;
      else            
           R8_Mul_CNT    <=  5'b0; 
      end   
//----------------------------------------------------------------
//----------------------------------------------------------------
localparam [4:0]
           Re_R14_flow_cnt_RST   = 5'b00001	,
           Re_R14_flow_cnt_IDLE  = 5'b00010	,
           Re_R14_flow_cnt_BEGIN = 5'b00100	,
           Re_R14_flow_cnt_CHK   = 5'b01000	,
           Re_R14_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R14_flow_cnt_State <= Re_R14_flow_cnt_RST;
     end 
      else begin 
           case( Re_R14_flow_cnt_State)  
            Re_R14_flow_cnt_RST :
                begin
                      Re_R14_flow_cnt_State  <=Re_R14_flow_cnt_IDLE;
                end 
            Re_R14_flow_cnt_IDLE:
                begin
                  if (Re_R14_en)
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_BEGIN;
                  else
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_IDLE;
                  end 
            Re_R14_flow_cnt_BEGIN:
                 begin
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_CHK;
                 end 
            Re_R14_flow_cnt_CHK:
                  begin
                     if ( Re_R14_get_vil && Re_R14_CNT == 5'd30   )
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_END;
                     else
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_CHK;
                   end 
            Re_R14_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_IDLE;
                      else
                      Re_R14_flow_cnt_State <=Re_R14_flow_cnt_END;
                 end     
                 
       default:       Re_R14_flow_cnt_State <=Re_R14_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R14_A_out  <=  32'd0;         
      else if ( Re_R14_flow_cnt_State ==Re_R14_flow_cnt_BEGIN)      
            Re_R14_A_out  <=  R14 ;
      else  if  (   Re_R14_flow_cnt_State ==Re_R14_flow_cnt_IDLE)     
            Re_R14_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R14_A_Vil  <=  1'b0;         
      else if ( Re_R14_flow_cnt_State ==Re_R14_flow_cnt_BEGIN)      
            Re_R14_A_Vil  <=  1'b1;  
      else   if  (   Re_R14_flow_cnt_State ==Re_R14_flow_cnt_IDLE)         
            Re_R14_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R14  <=  32'd0;         
      else if  ( Re_R14_get_vil && Re_R14_CNT == 5'd30   )     
             Re_R14  <=  Re_R14_get_r; 
      else if  (   Re_R14_flow_cnt_State ==Re_R14_flow_cnt_IDLE)     
             Re_R14  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R14_Done    <=  1'b0;     
      else if ( Re_R14_get_vil && Re_R14_CNT == 5'd30   )     
            Re_R14_Done    <=  1'b1;  
      else      
            Re_R14_Done    <=  1'b0;       
      end  
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R14_CNT    <=  5'b0;     
      else if (Re_R14_get_vil&&  Re_R14_flow_cnt_State ==Re_R14_flow_cnt_CHK)      
            Re_R14_CNT    <=  Re_R14_CNT + 1'b1;  
      else      
            Re_R14_CNT    <=  5'b0;       
      end  

//----------------------------------------------------------------
//----------------------------------------------------------------
localparam [4:0]
           Re_R8_flow_cnt_RST   = 5'b00001	,
           Re_R8_flow_cnt_IDLE  = 5'b00010	,
           Re_R8_flow_cnt_BEGIN = 5'b00100	,
           Re_R8_flow_cnt_CHK   = 5'b01000	,
           Re_R8_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Re_R8_flow_cnt_State <= Re_R8_flow_cnt_RST;
     end 
      else begin 
           case( Re_R8_flow_cnt_State)  
            Re_R8_flow_cnt_RST :
                begin
                      Re_R8_flow_cnt_State  <=Re_R8_flow_cnt_IDLE;
                end 
            Re_R8_flow_cnt_IDLE:
                begin
                  if (Re_R8_en)
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_BEGIN;
                  else
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_IDLE;
                  end 
            Re_R8_flow_cnt_BEGIN:
                 begin
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_CHK;
                 end 
            Re_R8_flow_cnt_CHK:
                  begin
                     if ( Re_R8_get_vil&& Re_R8_CNT == 5'd30   )
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_END;
                     else
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_CHK;
                   end 
            Re_R8_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_IDLE;
                      else
                      Re_R8_flow_cnt_State <=Re_R8_flow_cnt_END;
                 end     
                 
       default:       Re_R8_flow_cnt_State <=Re_R8_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R8_A_out  <=  32'd0;         
      else if ( Re_R8_flow_cnt_State ==Re_R8_flow_cnt_BEGIN)      
            Re_R8_A_out  <=  R8 ;
      else if (  Re_R8_flow_cnt_State ==Re_R8_flow_cnt_IDLE )     
            Re_R8_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R8_A_Vil  <=  1'b0;         
      else if ( Re_R8_flow_cnt_State ==Re_R8_flow_cnt_BEGIN)      
            Re_R8_A_Vil  <=  1'b1;  
      else if (  Re_R8_flow_cnt_State ==Re_R8_flow_cnt_IDLE )          
            Re_R8_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Re_R8  <=  32'd0;         
      else if ( Re_R8_get_vil&& Re_R8_CNT == 5'd30   )  
             Re_R8  <=  Re_R8_get_r; 
      else if (  Re_R8_flow_cnt_State ==Re_R8_flow_cnt_IDLE )     
             Re_R8  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R8_Done    <=  1'b0;     
      else if  ( Re_R8_get_vil&& Re_R8_CNT == 5'd30   )     
            Re_R8_Done    <=  1'b1;  
      else      
            Re_R8_Done    <=  1'b0;       
      end  
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Re_R8_CNT    <=  5'b0;     
      else if (Re_R8_get_vil&&  Re_R8_flow_cnt_State ==Re_R8_flow_cnt_CHK)      
            Re_R8_CNT    <=Re_R8_CNT +  1'b1;  
      else      
            Re_R8_CNT    <=  5'b0;       
      end     
//----------------------------------------------------------------
//----------------------------------------------------------------
 
localparam [4:0]
           B_R8_Mul_flow_cnt_RST   = 5'b00001	,
           B_R8_Mul_flow_cnt_IDLE  = 5'b00010	,
           B_R8_Mul_flow_cnt_BEGIN = 5'b00100	,
           B_R8_Mul_flow_cnt_CHK   = 5'b01000	,
           B_R8_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       B_R8_Mul_flow_cnt_State <= B_R8_Mul_flow_cnt_RST;
     end 
      else begin 
           case( B_R8_Mul_flow_cnt_State)  
            B_R8_Mul_flow_cnt_RST :
                begin
                      B_R8_Mul_flow_cnt_State  <=B_R8_Mul_flow_cnt_IDLE;
                end 
            B_R8_Mul_flow_cnt_IDLE:
                begin
                  if (B_R8_Mul_en )
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_BEGIN;
                  else
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_IDLE;
                  end 
            B_R8_Mul_flow_cnt_BEGIN:
                 begin
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_CHK;
                 end 
            B_R8_Mul_flow_cnt_CHK:
                  begin
                     if ( B_R8_Mul_get_vil && B_R8_Mul_CNT ==5'd10)
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_END;
                     else
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_CHK;
                   end 
            B_R8_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_IDLE;
                      else
                      B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_END;
                 end     
                 
       default:       B_R8_Mul_flow_cnt_State <=B_R8_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_R8_Mul_A_out  <=  32'd0;         
      else if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_BEGIN)      
            B_R8_Mul_A_out  <= ParaM_B_LJ_Force    ;
      else if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_IDLE)      
            B_R8_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_R8_Mul_B_out  <=  32'd0;         
      else if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_BEGIN)
            B_R8_Mul_B_out  <= Re_R8   ;
      else   if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_IDLE)           
            B_R8_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_R8_Mul_A_Vil  <= 1'b0;          
      else if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_BEGIN)
            B_R8_Mul_A_Vil <= 1'b1;  
      else  if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_IDLE)            
            B_R8_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_R8_Mul_B_Vil <= 1'b0;         
      else if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_BEGIN)
            B_R8_Mul_B_Vil <= 1'b1;  
      else  if ( B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_IDLE)            
            B_R8_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             B_R8              <=  32'd0;          
      else if ( B_R8_Mul_get_vil && B_R8_Mul_CNT ==5'd10)
             B_R8              <=  B_R8_Mul_get_r;
      else   if (  B_R8_Mul_flow_cnt_State  ==B_R8_Mul_flow_cnt_IDLE)          
             B_R8              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           B_R8_Mul_Done     <=  1'b0;          
      else if ( B_R8_Mul_get_vil && B_R8_Mul_CNT ==5'd10)
           B_R8_Mul_Done     <=  1'b1;
      else            
           B_R8_Mul_Done     <=  1'b0; 
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           B_R8_Mul_CNT     <=  5'b0;          
      else if ( B_R8_Mul_get_vil && B_R8_Mul_flow_cnt_State ==B_R8_Mul_flow_cnt_CHK )
           B_R8_Mul_CNT     <= B_R8_Mul_CNT + 1'b1;
      else            
           B_R8_Mul_CNT     <=  5'b0; 
      end 

//----------------------------------------------------------------
//----------------------------------------------------------------
 

localparam [4:0]
           A_R14_Mul_flow_cnt_RST   = 5'b00001	,
           A_R14_Mul_flow_cnt_IDLE  = 5'b00010	,
           A_R14_Mul_flow_cnt_BEGIN = 5'b00100	,
           A_R14_Mul_flow_cnt_CHK   = 5'b01000	,
           A_R14_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       A_R14_Mul_flow_cnt_State <= A_R14_Mul_flow_cnt_RST;
     end 
      else begin 
           case( A_R14_Mul_flow_cnt_State)  
            A_R14_Mul_flow_cnt_RST :
                begin
                      A_R14_Mul_flow_cnt_State  <=A_R14_Mul_flow_cnt_IDLE;
                end 
            A_R14_Mul_flow_cnt_IDLE:
                begin
                  if ( A_R14_Mul_en)
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_BEGIN;
                  else
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_IDLE;
                  end 
            A_R14_Mul_flow_cnt_BEGIN:
                 begin
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_CHK;
                 end 
            A_R14_Mul_flow_cnt_CHK:
                  begin
                     if ( A_R14_Mul_get_vil && A_R14_Mul_CNT==5'd10)
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_END;
                     else
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_CHK;
                   end 
            A_R14_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_IDLE;
                      else
                      A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_END;
                 end     
                 
       default:       A_R14_Mul_flow_cnt_State <=A_R14_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_R14_Mul_A_out  <=  32'd0;         
      else if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_BEGIN)      
            A_R14_Mul_A_out  <= ParaM_A_LJ_Force    ;
      else if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_IDLE)      
            A_R14_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_R14_Mul_B_out  <=  32'd0;         
      else if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_BEGIN)
            A_R14_Mul_B_out  <= Re_R14   ;
      else   if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_IDLE)           
            A_R14_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_R14_Mul_A_Vil  <= 1'b0;          
      else if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_BEGIN)
            A_R14_Mul_A_Vil <= 1'b1;  
      else  if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_IDLE)            
            A_R14_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            A_R14_Mul_B_Vil <= 1'b0;         
      else if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_BEGIN)
            A_R14_Mul_B_Vil <= 1'b1;  
      else  if ( A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_IDLE)            
            A_R14_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             A_R14              <=  32'd0;          
      else if( A_R14_Mul_get_vil && A_R14_Mul_CNT==5'd10)
             A_R14              <=  A_R14_Mul_get_r;
      else   if (  A_R14_Mul_flow_cnt_State  ==A_R14_Mul_flow_cnt_IDLE)          
             A_R14              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_R14_Mul_Done     <=  1'b0;          
      else if ( A_R14_Mul_get_vil && A_R14_Mul_CNT==5'd10)
           A_R14_Mul_Done     <=  1'b1;
      else   
           A_R14_Mul_Done     <=  1'b0; 
      end 
  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           A_R14_Mul_CNT     <=  5'b0;          
      else if ( A_R14_Mul_get_vil  &&A_R14_Mul_flow_cnt_State ==A_R14_Mul_flow_cnt_CHK)
           A_R14_Mul_CNT     <=  A_R14_Mul_CNT + 1'b1;
      else   
           A_R14_Mul_CNT     <=  5'b0; 
      end 
          
//----------------------------------------------------------------
//----------------------------------------------------------------
 

localparam [4:0]
           R14_sub_R8_flow_cnt_RST   = 5'b00001	,
           R14_sub_R8_flow_cnt_IDLE  = 5'b00010	,
           R14_sub_R8_flow_cnt_BEGIN = 5'b00100	,
           R14_sub_R8_flow_cnt_CHK   = 5'b01000	,
           R14_sub_R8_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R14_sub_R8_flow_cnt_State <= R14_sub_R8_flow_cnt_RST;
     end 
      else begin 
           case( R14_sub_R8_flow_cnt_State)  
            R14_sub_R8_flow_cnt_RST :
                begin
                      R14_sub_R8_flow_cnt_State  <=R14_sub_R8_flow_cnt_IDLE;
                end 
            R14_sub_R8_flow_cnt_IDLE:
                begin
                  if (R14_sub_R8_en)
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_BEGIN;
                  else
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_IDLE;
                  end 
            R14_sub_R8_flow_cnt_BEGIN:
                 begin
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_CHK;
                 end 
            R14_sub_R8_flow_cnt_CHK:
                  begin
                     if ( R14_sub_R8_get_vil && R14_sub_R8_CNT == 5'd13 )
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_END;
                     else
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_CHK;
                   end 
            R14_sub_R8_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_IDLE;
                      else
                      R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_END;
                 end     
                 
       default:       R14_sub_R8_flow_cnt_State <=R14_sub_R8_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_A_out  <=  32'd0;         
      else if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_BEGIN)      
            R14_sub_R8_A_out  <= B_R8    ;
      else if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_IDLE)      
            R14_sub_R8_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_B_out  <=  32'd0;         
      else if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_BEGIN)
            R14_sub_R8_B_out  <= A_R14    ;
      else   if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_IDLE)           
            R14_sub_R8_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_A_Vil  <= 1'b0;          
      else if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_BEGIN)
            R14_sub_R8_A_Vil <= 1'b1;  
      else  if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_IDLE)            
            R14_sub_R8_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_B_Vil <= 1'b0;         
      else if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_BEGIN)
            R14_sub_R8_B_Vil <= 1'b1;  
      else  if ( R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_IDLE)            
            R14_sub_R8_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_para            <=  32'd0;          
      else if ( R14_sub_R8_get_vil && R14_sub_R8_CNT == 5'd13 )
            Force_para          <=  R14_sub_R8_get_r;
      else   if (  R14_sub_R8_flow_cnt_State  ==R14_sub_R8_flow_cnt_IDLE)          
            Force_para             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_Done           <= 1'b0;            
      else if ( R14_sub_R8_get_vil && R14_sub_R8_CNT == 5'd13 )
            R14_sub_R8_Done           <= 1'b1;       
      else    
            R14_sub_R8_Done           <= 1'b0;              
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R14_sub_R8_CNT           <= 5'b0;            
      else if ( R14_sub_R8_get_vil &&  R14_sub_R8_flow_cnt_State ==R14_sub_R8_flow_cnt_CHK)
            R14_sub_R8_CNT           <= R14_sub_R8_CNT + 1'b1;       
      else    
            R14_sub_R8_CNT           <= 5'b0;              
      end 

//----------------------------------------------------------------
//----------------------------------------------------------------

localparam [4:0]
           X_R8_R14_Mul_flow_cnt_RST   = 5'b00001	,
           X_R8_R14_Mul_flow_cnt_IDLE  = 5'b00010	,
           X_R8_R14_Mul_flow_cnt_BEGIN = 5'b00100	,
           X_R8_R14_Mul_flow_cnt_CHK   = 5'b01000	,
           X_R8_R14_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       X_R8_R14_Mul_flow_cnt_State <= X_R8_R14_Mul_flow_cnt_RST;
     end 
      else begin 
           case( X_R8_R14_Mul_flow_cnt_State)  
            X_R8_R14_Mul_flow_cnt_RST :
                begin
                      X_R8_R14_Mul_flow_cnt_State  <=X_R8_R14_Mul_flow_cnt_IDLE;
                end 
            X_R8_R14_Mul_flow_cnt_IDLE:
                begin
                  if (X_R8_R14_Mul_en)
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_BEGIN;
                  else
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_IDLE;
                  end 
            X_R8_R14_Mul_flow_cnt_BEGIN:
                 begin
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_CHK;
                 end 
            X_R8_R14_Mul_flow_cnt_CHK:
                  begin
                     if ( X_R8_R14_Mul_get_vil && X_R8_R14_Mul_CNT ==   5'd10)
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_END;
                     else
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_CHK;
                   end 
            X_R8_R14_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_IDLE;
                      else
                      X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_END;
                 end     
                 
       default:       X_R8_R14_Mul_flow_cnt_State <=X_R8_R14_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_R8_R14_Mul_A_out  <=  32'd0;         
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_BEGIN)      
            X_R8_R14_Mul_A_out  <= DertaX    ;
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_IDLE)      
            X_R8_R14_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_R8_R14_Mul_B_out  <=  32'd0;         
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_BEGIN)
            X_R8_R14_Mul_B_out  <= Force_para   ;
      else   if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_IDLE)           
            X_R8_R14_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_R8_R14_Mul_A_Vil  <= 1'b0;          
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_BEGIN)
            X_R8_R14_Mul_A_Vil <= 1'b1;  
      else  if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_IDLE)            
            X_R8_R14_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_R8_R14_Mul_B_Vil <= 1'b0;         
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_BEGIN)
            X_R8_R14_Mul_B_Vil <= 1'b1;  
      else  if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_IDLE)            
            X_R8_R14_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_LJ_Force_X              <=  32'd0;          
      else if  ( X_R8_R14_Mul_get_vil && X_R8_R14_Mul_CNT ==   5'd10)
             M_AXIS_LJ_Force_X              <=  X_R8_R14_Mul_get_r;
      else if ( X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_IDLE)          
             M_AXIS_LJ_Force_X              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_R8_R14_Mul_Done     <=  1'b0;          
      else if ( X_R8_R14_Mul_get_vil && X_R8_R14_Mul_CNT ==   5'd10)
           X_R8_R14_Mul_Done     <=  1'b1;
      else          
           X_R8_R14_Mul_Done     <=  1'b0; 
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_R8_R14_Mul_CNT     <=  5'b0;          
      else if ( X_R8_R14_Mul_get_vil && X_R8_R14_Mul_flow_cnt_State  ==X_R8_R14_Mul_flow_cnt_CHK  )
           X_R8_R14_Mul_CNT     <=  X_R8_R14_Mul_CNT + 1'b1;
      else          
           X_R8_R14_Mul_CNT     <=  5'b0; 
      end 


//----------------------------------------------------------------
//----------------------------------------------------------------

localparam [4:0]
           Y_R8_R14_Mul_flow_cnt_RST   = 5'b00001	,
           Y_R8_R14_Mul_flow_cnt_IDLE  = 5'b00010	,
           Y_R8_R14_Mul_flow_cnt_BEGIN = 5'b00100	,
           Y_R8_R14_Mul_flow_cnt_CHK   = 5'b01000	,
           Y_R8_R14_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y_R8_R14_Mul_flow_cnt_State <= Y_R8_R14_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Y_R8_R14_Mul_flow_cnt_State)  
            Y_R8_R14_Mul_flow_cnt_RST :
                begin
                      Y_R8_R14_Mul_flow_cnt_State  <=Y_R8_R14_Mul_flow_cnt_IDLE;
                end 
            Y_R8_R14_Mul_flow_cnt_IDLE:
                begin
                  if (Y_R8_R14_Mul_en)
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_BEGIN;
                  else
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_IDLE;
                  end 
            Y_R8_R14_Mul_flow_cnt_BEGIN:
                 begin
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_CHK;
                 end 
            Y_R8_R14_Mul_flow_cnt_CHK:
                  begin
                     if ( Y_R8_R14_Mul_get_vil && Y_R8_R14_Mul_CNT ==   5'd10)
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_END;
                     else
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_CHK;
                   end 
            Y_R8_R14_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_IDLE;
                      else
                      Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_END;
                 end     
                 
       default:       Y_R8_R14_Mul_flow_cnt_State <=Y_R8_R14_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_R8_R14_Mul_A_out  <=  32'd0;         
      else if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_BEGIN)      
            Y_R8_R14_Mul_A_out  <= DertaY    ;
      else if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_IDLE)      
            Y_R8_R14_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_R8_R14_Mul_B_out  <=  32'd0;         
      else if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_BEGIN)
            Y_R8_R14_Mul_B_out  <= Force_para   ;
      else   if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_IDLE)           
            Y_R8_R14_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_R8_R14_Mul_A_Vil  <= 1'b0;          
      else if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_BEGIN)
            Y_R8_R14_Mul_A_Vil <= 1'b1;  
      else  if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_IDLE)            
            Y_R8_R14_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_R8_R14_Mul_B_Vil <= 1'b0;         
      else if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_BEGIN)
            Y_R8_R14_Mul_B_Vil <= 1'b1;  
      else  if ( Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_IDLE)            
            Y_R8_R14_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_LJ_Force_Y              <=  32'd0;          
      else if  ( Y_R8_R14_Mul_get_vil && Y_R8_R14_Mul_CNT ==   5'd10)
             M_AXIS_LJ_Force_Y              <=  Y_R8_R14_Mul_get_r;
      else   if (  Y_R8_R14_Mul_flow_cnt_State  ==Y_R8_R14_Mul_flow_cnt_IDLE)          
             M_AXIS_LJ_Force_Y              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y_R8_R14_Mul_Done     <=  1'b0;          
      else if  ( Y_R8_R14_Mul_get_vil && Y_R8_R14_Mul_CNT ==   5'd10)
           Y_R8_R14_Mul_Done     <=  1'b1;
      else      
           Y_R8_R14_Mul_Done     <=  1'b0; 
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y_R8_R14_Mul_CNT     <=  5'b0;          
      else if ( Y_R8_R14_Mul_get_vil &&  Y_R8_R14_Mul_flow_cnt_State ==Y_R8_R14_Mul_flow_cnt_CHK)
           Y_R8_R14_Mul_CNT     <= Y_R8_R14_Mul_CNT  +1'b1;
      else      
           Y_R8_R14_Mul_CNT     <=  5'b0; 
      end    
      
//----------------------------------------------------------------
//----------------------------------------------------------------


localparam [5:0]
           Z_R8_R14_Mul_flow_cnt_RST     = 6'b000001	,
           Z_R8_R14_Mul_flow_cnt_IDLE    = 6'b000010	,
           Z_R8_R14_Mul_flow_cnt_BEGIN   = 6'b000100	,
           Z_R8_R14_Mul_flow_cnt_CHK     = 6'b001000	,
           Z_R8_R14_Mul_flow_cnt_CHK_Buf = 6'b010000	, 
           Z_R8_R14_Mul_flow_cnt_END     = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Z_R8_R14_Mul_flow_cnt_State <= Z_R8_R14_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Z_R8_R14_Mul_flow_cnt_State)  
            Z_R8_R14_Mul_flow_cnt_RST :
                begin
                      Z_R8_R14_Mul_flow_cnt_State  <=Z_R8_R14_Mul_flow_cnt_IDLE;
                end 
            Z_R8_R14_Mul_flow_cnt_IDLE:
                begin
                  if (Z_R8_R14_Mul_en)
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_BEGIN;
                  else
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_IDLE;
                  end 
            Z_R8_R14_Mul_flow_cnt_BEGIN:
                 begin
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_CHK;
                 end 
            Z_R8_R14_Mul_flow_cnt_CHK:
                  begin
                     if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_CNT == 5'd10)
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_CHK_Buf;
                     else
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_CHK;
                   end 
                   
            Z_R8_R14_Mul_flow_cnt_CHK_Buf:  
                 begin
                  Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_END; 
                  end          
            Z_R8_R14_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_IDLE;
                      else
                      Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_END;
                 end     
                 
       default:       Z_R8_R14_Mul_flow_cnt_State <=Z_R8_R14_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_R8_R14_Mul_A_out  <=  32'd0;         
      else if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_BEGIN)      
            Z_R8_R14_Mul_A_out  <= DertaZ    ;
      else if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)      
            Z_R8_R14_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_R8_R14_Mul_B_out  <=  32'd0;         
      else if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_BEGIN)
            Z_R8_R14_Mul_B_out  <= Force_para   ;
      else   if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)           
            Z_R8_R14_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_R8_R14_Mul_A_Vil  <= 1'b0;          
      else if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_BEGIN)
            Z_R8_R14_Mul_A_Vil <= 1'b1;  
      else  if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)            
            Z_R8_R14_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_R8_R14_Mul_B_Vil <= 1'b0;         
      else if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_BEGIN)
            Z_R8_R14_Mul_B_Vil <= 1'b1;  
      else  if ( Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)            
            Z_R8_R14_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_LJ_Force_Z              <=  32'd0;          
      else if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_CNT == 5'd10)
             M_AXIS_LJ_Force_Z              <=  Z_R8_R14_Mul_get_r;
      else   if (  Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)          
             M_AXIS_LJ_Force_Z              <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Z_R8_R14_Mul_Done     <=  1'b0;          
      else if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_CNT == 5'd10)
           Z_R8_R14_Mul_Done     <=  1'b1;
      else   if (  Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)          
           Z_R8_R14_Mul_Done     <=  1'b0; 
      end 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Z_R8_R14_Mul_CNT     <=  5'b0;          
      else if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_flow_cnt_State ==Z_R8_R14_Mul_flow_cnt_CHK )
           Z_R8_R14_Mul_CNT     <= Z_R8_R14_Mul_CNT + 1'b1;
      else             
           Z_R8_R14_Mul_CNT     <=  5'b0; 
      end     
      
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_LJ_EnE_Force     <=   256'd0;       
      else if (  Z_R8_R14_Mul_flow_cnt_State ==Z_R8_R14_Mul_flow_cnt_CHK_Buf )
           M_AXIS_LJ_EnE_Force   <=  {Index_Pos_home[159:144],Index_Pos_home[63:32],16'd0,Index_Pos_nei[159:144],Index_Pos_nei[63:32],16'd0,Energy_get_r,X_R8_R14_Mul_get_r,Y_R8_R14_Mul_get_r,Z_R8_R14_Mul_get_r};
      else   if (  Z_R8_R14_Mul_flow_cnt_State  ==Z_R8_R14_Mul_flow_cnt_IDLE)          
           M_AXIS_LJ_EnE_Force     <=    256'd0;     
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Force_done     <=  1'b0;          
      else if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_CNT == 5'd10)
           M_AXIS_Force_done     <=  1'b1;
      else          
           M_AXIS_Force_done     <=  1'b0; 
      end 
                  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_col_Force_done     <=  1'b0;          
      else  if ( Z_R8_R14_Mul_get_vil && Z_R8_R14_Mul_CNT == 5'd10)
           M_AXIS_col_Force_done     <=  1'b1;
      else          
           M_AXIS_col_Force_done     <=  1'b0; 
      end 
 
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Force_Sub_Done     <=  1'b0;          
      else if (Z_R8_R14_Mul_flow_cnt_State ==Z_R8_R14_Mul_flow_cnt_END)
           Force_Sub_Done     <=  1'b1;
      else          
           Force_Sub_Done     <=  1'b0; 
      end 
endmodule
