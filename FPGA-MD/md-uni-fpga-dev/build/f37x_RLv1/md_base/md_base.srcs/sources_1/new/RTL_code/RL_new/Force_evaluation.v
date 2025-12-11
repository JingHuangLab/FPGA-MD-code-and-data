`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2023 05:19:33 PM
// Design Name: 
// Module Name: Force_evaluation
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


module Force_evaluation(
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
              
 input       [255:0]      ParaM_X_A,// X= rr      
 input       [31:0]       ParaM_A, 

 input       [31:0]       ParaM_Aab,      
 input       [31:0]       ParaM_Bab, 
 input       [31:0]       ParaM_QQab,

 input       [31:0]       ParaM_R_14_C1,      
 input       [31:0]       ParaM_R_14_C0, 

 input       [31:0]       ParaM_R_8_C1,      
 input       [31:0]       ParaM_R_8_C0,

 input       [31:0]       ParaM_R_3_C1,      
 input       [31:0]       ParaM_R_3_C0 ,
 
 output reg [255:0]       M_AXIS_EnE_Force,
 output reg               S_AXIS_Hom1Force_done,

 
     //sum to caculation Add unit 
 output reg [31:0]     X_Add_A_out , 
 output reg [31:0]     Y_Add_B_out ,     
 output reg            X_Add_A_Vil ,
 output reg            Y_Add_B_Vil ,           
 input      [31:0]     RR_Add_get_r   ,    
 input                 RR_Add_get_vil ,
 
 output reg [31:0]     XY_Add_C_out , 
 output reg            XY_Add_C_Vil ,      
 output reg [31:0]     Z_Add_C_out   , 
 output reg            Z_Add_C_Vil   ,
 input                 XY_Add_get_vil ,
 input      [31:0]     RR_Add_get_XY_R,    
 //X to caculation mul unit 
 output reg [31:0]     R_14_ADD_C0_A_out ,
 output reg            R_14_ADD_C0_A_Vil ,
 output reg            R_14_ADD_C0_B_Vil ,
 output reg [31:0]     R_14_ADD_C0_B_out ,
 input      [31:0]     R_14_ADD_C0_get_r ,
 input                 R_14_ADD_C0_get_vil,
     //X to caculation sub unit 
 output reg [31:0]     R_14_MUL_C1_A_out ,
 output reg            R_14_MUL_C1_A_Vil ,
 output reg            R_14_MUL_C1_B_Vil ,
 output reg [31:0]     R_14_MUL_C1_B_out ,
 input      [31:0]     R_14_MUL_C1_get_r,
 input                 R_14_MUL_C1_get_vil,  
 
 output reg [31:0]     R_14_MUL_Aab_A_out ,
 output reg            R_14_MUL_Aab_A_Vil ,
 output reg            R_14_MUL_Aab_B_Vil ,
 output reg [31:0]     R_14_MUL_Aab_B_out ,
 input      [31:0]     R_14_MUL_Aab_get_r,
 input                 R_14_MUL_Aab_get_vil,    
      //Y to caculation mul unit 
 output reg [31:0]     R_8_ADD_C0_A_out ,
 output reg            R_8_ADD_C0_A_Vil ,
 output reg            R_8_ADD_C0_B_Vil ,
 output reg [31:0]     R_8_ADD_C0_B_out ,
 input      [31:0]     R_8_ADD_C0_get_r,
 input                 R_8_ADD_C0_get_vil,
     //Y to caculation sub unit 
 output reg [31:0]     R_8_MUL_C1_A_out ,
 output reg            R_8_MUL_C1_A_Vil ,
 output reg            R_8_MUL_C1_B_Vil ,
 output reg [31:0]     R_8_MUL_C1_B_out ,
 input      [31:0]     R_8_MUL_C1_get_r ,
 input                 R_8_MUL_C1_get_vil,   

 output reg [31:0]     R_8_MUL_Bab_A_out ,
 output reg            R_8_MUL_Bab_A_Vil ,
 output reg            R_8_MUL_Bab_B_Vil ,
 output reg [31:0]     R_8_MUL_Bab_B_out ,
 input      [31:0]     R_8_MUL_Bab_get_r,
 input                 R_8_MUL_Bab_get_vil,   
   //Z to caculation mul unit 
 output reg [31:0]     R_3_ADD_C0_A_out ,
 output reg            R_3_ADD_C0_A_Vil ,
 output reg            R_3_ADD_C0_B_Vil ,
 output reg [31:0]     R_3_ADD_C0_B_out ,
 input      [31:0]     R_3_ADD_C0_get_r,
 input                 R_3_ADD_C0_get_vil,
     //Z to caculation sub unit 
 output reg [31:0]     R_3_MUL_C1_A_out ,
 output reg            R_3_MUL_C1_A_Vil ,
 output reg            R_3_MUL_C1_B_Vil ,
 output reg [31:0]     R_3_MUL_C1_B_out ,
 input      [31:0]     R_3_MUL_C1_get_r ,
 input                 R_3_MUL_C1_get_vil  ,
 
 output reg [31:0]     R_3_MUL_Qab_A_out ,
 output reg            R_3_MUL_Qab_A_Vil ,
 output reg            R_3_MUL_Qab_B_Vil ,
 output reg [31:0]     R_3_MUL_Qab_B_out ,
 input      [31:0]     R_3_MUL_Qab_get_r ,
 input                 R_3_MUL_Qab_get_vil ,
 
 output reg [31:0]     Force_ParaM_deltaX_MUL_A_out ,
 output reg            Force_ParaM_deltaX_MUL_A_Vil ,
 output reg            Force_ParaM_deltaX_MUL_B_Vil ,
 output reg [31:0]     Force_ParaM_deltaX_MUL_B_out ,
 input      [31:0]     Force_ParaM_deltaX_MUL_get_r ,
 input                 Force_ParaM_deltaX_MUL_get_vil,       
 
 output reg [31:0]     Force_ParaM_deltaY_MUL_A_out ,
 output reg            Force_ParaM_deltaY_MUL_A_Vil ,
 output reg            Force_ParaM_deltaY_MUL_B_Vil ,
 output reg [31:0]     Force_ParaM_deltaY_MUL_B_out ,
 input      [31:0]     Force_ParaM_deltaY_MUL_get_r ,
 input                 Force_ParaM_deltaY_MUL_get_vil,       
 
 output reg [31:0]     Force_ParaM_deltaZ_MUL_A_out ,
 output reg            Force_ParaM_deltaZ_MUL_A_Vil ,
 output reg            Force_ParaM_deltaZ_MUL_B_Vil ,
 output reg [31:0]     Force_ParaM_deltaZ_MUL_B_out ,
 input      [31:0]     Force_ParaM_deltaZ_MUL_get_r ,
 input                 Force_ParaM_deltaZ_MUL_get_vil       
 
 
        
     );
    
 
     // ---------------------------------------- -----------------------       
//  --state

reg [7:0]         R_14_ADD_C0_flow_cnt_State;
reg [7:0]         R_14_MUL_C1_flow_cnt_State;
reg [7:0]         R_14_MUL_Aab_flow_cnt_State;
reg [7:0]         R_8_ADD_C0_flow_cnt_State;
reg [7:0]         R_8_MUL_C1_flow_cnt_State;
reg [7:0]         R_8_MUL_Bab_flow_cnt_State;
reg [7:0]         R_3_ADD_C0_flow_cnt_State;
reg [7:0]         R_3_MUL_C1_flow_cnt_State;
reg [7:0]         R_3_MUL_Qab_flow_cnt_State;
reg [7:0]         Sqr_RR_flow_cnt_State;
reg [7:0]         Force_ParaM_deltaX_MUL_flow_cnt_State;
reg [7:0]         Force_ParaM_deltaY_MUL_flow_cnt_State;
reg [7:0]         Force_ParaM_deltaZ_MUL_flow_cnt_State;

reg [31:0]        R_14_MUL_C1;
reg [31:0]        R_14_ADD_C0; 
reg [31:0]        R_14_MUL_Aab; 
reg [31:0]        R_8_MUL_C1;  
reg [31:0]        R_8_ADD_C0;
reg [31:0]        R_8_MUL_Bab; 
reg [31:0]        R_3_MUL_C1;           
reg [31:0]        R_3_ADD_C0;   
reg [31:0]        R_3_MUL_Qab; 
reg [31:0]        Force_ParaM_deltaX;
reg [31:0]        Force_ParaM_deltaY;
reg [31:0]        Force_ParaM_deltaZ;
reg [31:0]        Force_ParaM;  

reg               R_14_MUL_C1_en            ;  
reg               R_14_ADD_C0_en            ; 
reg               R_14_MUL_Aab_en  ;
reg               R_8_MUL_C1_en            ; 
reg               R_8_ADD_C0_en            ; 
reg               R_8_MUL_Bab_en            ; 
reg               R_3_MUL_C1_en            ; 
reg               R_3_ADD_C0_en            ; 
reg               R_3_MUL_Qab_en            ; 
reg               Force_ParaM_deltaX_MUL_en;
reg               Force_ParaM_deltaY_MUL_en;
reg               Force_ParaM_deltaZ_MUL_en;

reg               R_14_MUL_Aab_done;
reg               R_8_MUL_Bab_done           ; 
reg               R_3_MUL_Qab_done           ; 

reg               third_order_done            ;//aqb
reg               second_order_done            ;//c1
reg               Frist_order_done            ; //c0
reg               Get_RR_en;

reg [4:0]         R_14_MUL_C1_CNT           ;  
reg [4:0]         R_8_MUL_C1_CNT           ;  
reg [4:0]         R_3_MUL_C1_CNT           ;  
reg [4:0]         R_14_ADD_C0_CNT           ;  
reg [4:0]         R_8_ADD_C0_CNT           ;  
reg [4:0]         R_3_ADD_C0_CNT           ;  
reg [4:0]         R_14_MUL_Aab_CNT          ;
reg [4:0]         R_8_MUL_Bab_CNT;
reg [4:0]         R_3_MUL_Qab_CNT;
reg [4:0]         RR_Add_CNT          ;   
reg [4:0]         XY_Add_CNT;
reg [4:0]         Force_ParaM_deltaX_MUL_CNT;
reg [4:0]         Force_ParaM_deltaY_MUL_CNT;
reg [4:0]         Force_ParaM_deltaZ_MUL_CNT;

reg               Sum_rr;
reg               Sum_rr_done;
reg               Force_second_order_done      ;  
reg               Force_ADD_Done;
reg               Force_ParaM_deltaX_MUL_done;
reg               Force_ParaM_deltaY_MUL_done;
reg               Force_ParaM_deltaZ_MUL_done;

 reg [31:0]       Z_Pos_home_buf     ;
 reg [31:0]       Z_Pos_nei_buf      ;

   //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------    
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_14_MUL_C1_en      <= 1'b0;  
      else if (Get_RR_en )
              R_14_MUL_C1_en      <= 1'b1;  
      else 
              R_14_MUL_C1_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_8_MUL_C1_en      <= 1'b0;  
      else if (Get_RR_en )
              R_8_MUL_C1_en      <= 1'b1;  
      else 
              R_8_MUL_C1_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_3_MUL_C1_en      <= 1'b0;  
      else if (Get_RR_en )
              R_3_MUL_C1_en      <= 1'b1;  
      else 
              R_3_MUL_C1_en      <= 1'b0;               
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_14_ADD_C0_en      <= 1'b0;  
      else if (Frist_order_done )
              R_14_ADD_C0_en      <= 1'b1;  
      else 
              R_14_ADD_C0_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_8_ADD_C0_en      <= 1'b0;  
      else if (Frist_order_done )
              R_8_ADD_C0_en      <= 1'b1;  
      else 
              R_8_ADD_C0_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_3_ADD_C0_en      <= 1'b0;  
      else if (Frist_order_done )
              R_3_ADD_C0_en      <= 1'b1;  
      else 
              R_3_ADD_C0_en      <= 1'b0;               
      end 
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_14_MUL_Aab_en      <= 1'b0;  
      else if (second_order_done )
              R_14_MUL_Aab_en      <= 1'b1;  
      else 
              R_14_MUL_Aab_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_8_MUL_Bab_en      <= 1'b0;  
      else if (second_order_done )
              R_8_MUL_Bab_en      <= 1'b1;  
      else 
              R_8_MUL_Bab_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              R_3_MUL_Qab_en      <= 1'b0;  
      else if (second_order_done )
              R_3_MUL_Qab_en      <= 1'b1;  
      else 
              R_3_MUL_Qab_en      <= 1'b0;               
      end 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Sum_rr      <= 1'b0;  
      else if (third_order_done )
              Sum_rr      <= 1'b1;  
      else 
              Sum_rr      <= 1'b0;               
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Force_ParaM_deltaX_MUL_en      <= 1'b0;  
      else if (Sum_rr_done )
              Force_ParaM_deltaX_MUL_en      <= 1'b1;  
      else 
              Force_ParaM_deltaX_MUL_en      <= 1'b0;               
      end 
       
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Force_ParaM_deltaY_MUL_en      <= 1'b0;  
      else if (Sum_rr_done )
              Force_ParaM_deltaY_MUL_en      <= 1'b1;  
      else 
              Force_ParaM_deltaY_MUL_en      <= 1'b0;               
      end   
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Force_ParaM_deltaZ_MUL_en      <= 1'b0;  
      else if (Sum_rr_done )
              Force_ParaM_deltaZ_MUL_en      <= 1'b1;  
      else 
              Force_ParaM_deltaZ_MUL_en      <= 1'b0;               
      end   
//-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           R_14_MUL_C1_flow_cnt_RST   = 5'b00001	,
           R_14_MUL_C1_flow_cnt_IDLE  = 5'b00010	,
           R_14_MUL_C1_flow_cnt_BEGIN = 5'b00100	,
           R_14_MUL_C1_flow_cnt_CHK   = 5'b01000	,
           R_14_MUL_C1_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_14_MUL_C1_flow_cnt_State <= R_14_MUL_C1_flow_cnt_RST;
     end 
      else begin 
           case( R_14_MUL_C1_flow_cnt_State)  
            R_14_MUL_C1_flow_cnt_RST :
                begin
                      R_14_MUL_C1_flow_cnt_State  <=R_14_MUL_C1_flow_cnt_IDLE;
                end 
            R_14_MUL_C1_flow_cnt_IDLE:
                begin
                  if (R_14_MUL_C1_en)
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_BEGIN;
                  else
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_IDLE;
                  end 
            R_14_MUL_C1_flow_cnt_BEGIN:
                 begin
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_CHK;
                 end 
            R_14_MUL_C1_flow_cnt_CHK:
                  begin
                     if ( R_14_MUL_C1_get_vil &&( R_14_MUL_C1_CNT == 5'd12))
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_END;
                     else
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_CHK;
                   end 
            R_14_MUL_C1_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_IDLE;
                      else
                      R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_END;
                 end     
                 
       default:       R_14_MUL_C1_flow_cnt_State <=R_14_MUL_C1_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1_A_out  <=  32'd0;         
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_BEGIN)      
            R_14_MUL_C1_A_out  <= ParaM_X_A    ;
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_IDLE)      
            R_14_MUL_C1_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1_B_out  <=  32'd0;         
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_BEGIN)
            R_14_MUL_C1_B_out  <= ParaM_R_14_C1    ;
      else   if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_IDLE)           
            R_14_MUL_C1_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1_A_Vil  <= 1'b0;          
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_BEGIN)
            R_14_MUL_C1_A_Vil <= 1'b1;  
      else  if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_IDLE)            
            R_14_MUL_C1_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1_B_Vil <= 1'b0;         
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_BEGIN)
            R_14_MUL_C1_B_Vil <= 1'b1;  
      else              
            R_14_MUL_C1_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1             <=  32'd0;          
      else if ( R_14_MUL_C1_get_vil &&(R_14_MUL_C1_CNT == 5'd12))
            R_14_MUL_C1             <=  R_14_MUL_C1_get_r;
      else   if (  R_14_MUL_C1_get_vil  ==R_14_MUL_C1_flow_cnt_IDLE)          
            R_14_MUL_C1             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            second_order_done           <= 1'b0;            
      else if ( R_14_MUL_C1_get_vil &&( R_14_MUL_C1_CNT == 5'd12))
            second_order_done           <= 1'b1;       
      else     
            second_order_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_C1_CNT  <=  5'd0;         
      else if ( R_14_MUL_C1_flow_cnt_State  ==R_14_MUL_C1_flow_cnt_CHK)      
            R_14_MUL_C1_CNT  <= R_14_MUL_C1_CNT + 5'd1  ;
      else 
            R_14_MUL_C1_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           R_14_ADD_C0_flow_cnt_RST   = 5'b00001	,
           R_14_ADD_C0_flow_cnt_IDLE  = 5'b00010	,
           R_14_ADD_C0_flow_cnt_BEGIN = 5'b00100	,
           R_14_ADD_C0_flow_cnt_CHK   = 5'b01000	,
           R_14_ADD_C0_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_14_ADD_C0_flow_cnt_State <= R_14_ADD_C0_flow_cnt_RST;
     end 
      else begin 
           case( R_14_ADD_C0_flow_cnt_State)  
            R_14_ADD_C0_flow_cnt_RST :
                begin
                      R_14_ADD_C0_flow_cnt_State  <=R_14_ADD_C0_flow_cnt_IDLE;
                end 
            R_14_ADD_C0_flow_cnt_IDLE:
                begin
                  if (R_14_ADD_C0_en)
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_BEGIN;
                  else
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_IDLE;
                  end 
            R_14_ADD_C0_flow_cnt_BEGIN:
                 begin
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_CHK;
                 end 
            R_14_ADD_C0_flow_cnt_CHK:
                  begin
                     if ( R_14_ADD_C0_get_vil && R_14_ADD_C0_CNT ==   5'd10    )
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_END;
                     else
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_CHK;
                   end 
            R_14_ADD_C0_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_IDLE;
                      else
                      R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_END;
                 end     
                 
       default:       R_14_ADD_C0_flow_cnt_State <=R_14_ADD_C0_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0_A_out  <=  32'd0;         
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_BEGIN)      
            R_14_ADD_C0_A_out  <= R_14_MUL_C1    ;
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_IDLE)      
            R_14_ADD_C0_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0_B_out  <=  32'd0;         
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_BEGIN)
            R_14_ADD_C0_B_out  <= ParaM_R_14_C0    ;
      else   if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_IDLE)           
            R_14_ADD_C0_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0_A_Vil  <= 1'b0;          
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_BEGIN)
            R_14_ADD_C0_A_Vil <= 1'b1;  
      else  if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_IDLE)            
            R_14_ADD_C0_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0_B_Vil <= 1'b0;         
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_BEGIN)
            R_14_ADD_C0_B_Vil <= 1'b1;  
      else  if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_IDLE)            
            R_14_ADD_C0_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0            <=  32'd0;          
      else if  ( R_14_ADD_C0_get_vil && R_14_ADD_C0_CNT ==   5'd10    )
            R_14_ADD_C0             <=  R_14_ADD_C0_get_r;
      else   if (  R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_IDLE)          
            R_14_ADD_C0             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Frist_order_done           <= 1'b0;            
      else if  ( R_14_ADD_C0_get_vil && R_14_ADD_C0_CNT ==   5'd10    )
            Frist_order_done           <= 1'b1;       
      else        
            Frist_order_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_ADD_C0_CNT  <=  5'd0;         
      else if ( R_14_ADD_C0_flow_cnt_State  ==R_14_ADD_C0_flow_cnt_CHK)      
            R_14_ADD_C0_CNT  <= R_14_ADD_C0_CNT + 5'd1  ;
      else  
            R_14_ADD_C0_CNT   <=  5'd0;              
      end     
      
   
 
  localparam [4:0]
           R_14_MUL_Aab_flow_cnt_RST   = 5'b00001	,
           R_14_MUL_Aab_flow_cnt_IDLE  = 5'b00010	,
           R_14_MUL_Aab_flow_cnt_BEGIN = 5'b00100	,
           R_14_MUL_Aab_flow_cnt_CHK   = 5'b01000	,
           R_14_MUL_Aab_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_14_MUL_Aab_flow_cnt_State <= R_14_MUL_Aab_flow_cnt_RST;
     end 
      else begin 
           case( R_14_MUL_Aab_flow_cnt_State)  
            R_14_MUL_Aab_flow_cnt_RST :
                begin
                      R_14_MUL_Aab_flow_cnt_State  <=R_14_MUL_Aab_flow_cnt_IDLE;
                end 
            R_14_MUL_Aab_flow_cnt_IDLE:
                begin
                  if (R_14_MUL_Aab_en)
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_BEGIN;
                  else
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_IDLE;
                  end 
            R_14_MUL_Aab_flow_cnt_BEGIN:
                 begin
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_CHK;
                 end 
            R_14_MUL_Aab_flow_cnt_CHK:
                  begin
                     if ( R_14_MUL_Aab_get_vil && R_14_MUL_Aab_CNT ==   5'd10    )
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_END;
                     else
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_CHK;
                   end 
            R_14_MUL_Aab_flow_cnt_END:
                 begin        
                    if  ( third_order_done )        
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_IDLE;
                      else
                      R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_END;
                 end     
                 
       default:       R_14_MUL_Aab_flow_cnt_State <=R_14_MUL_Aab_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_A_out  <=  32'd0;         
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_BEGIN)      
            R_14_MUL_Aab_A_out  <= R_14_ADD_C0    ;
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_IDLE)      
            R_14_MUL_Aab_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_B_out  <=  32'd0;         
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_BEGIN)
            R_14_MUL_Aab_B_out  <= ParaM_Aab    ;
      else   if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_IDLE)           
            R_14_MUL_Aab_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_A_Vil  <= 1'b0;          
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_BEGIN)
            R_14_MUL_Aab_A_Vil <= 1'b1;  
      else  if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_IDLE)            
            R_14_MUL_Aab_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_B_Vil <= 1'b0;         
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_BEGIN)
            R_14_MUL_Aab_B_Vil <= 1'b1;  
      else  if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_IDLE)            
            R_14_MUL_Aab_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab            <=  32'd0;          
      else if  ( R_14_MUL_Aab_get_vil && R_14_MUL_Aab_CNT ==   5'd10    )
            R_14_MUL_Aab             <=  R_14_MUL_Aab_get_r;
      else   if (  R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_IDLE)          
            R_14_MUL_Aab             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_done           <= 1'b0;            
      else if  ( R_14_MUL_Aab_get_vil && R_14_MUL_Aab_CNT ==   5'd10    )
            R_14_MUL_Aab_done           <= 1'b1;       
      else        
            R_14_MUL_Aab_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_14_MUL_Aab_CNT  <=  5'd0;         
      else if ( R_14_MUL_Aab_flow_cnt_State  ==R_14_MUL_Aab_flow_cnt_CHK)      
            R_14_MUL_Aab_CNT  <= R_14_MUL_Aab_CNT + 5'd1  ;
      else  
            R_14_MUL_Aab_CNT   <=  5'd0;              
      end     

//-----------------------------------------------------------------------
//                Y  - *  -> Delat Y^2
//-----------------------------------------------------------------------
 
localparam [4:0]
           R_8_MUL_C1_flow_cnt_RST   = 5'b00001	,
           R_8_MUL_C1_flow_cnt_IDLE  = 5'b00010	,
           R_8_MUL_C1_flow_cnt_BEGIN = 5'b00100	,
           R_8_MUL_C1_flow_cnt_CHK   = 5'b01000	,
           R_8_MUL_C1_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_8_MUL_C1_flow_cnt_State <= R_8_MUL_C1_flow_cnt_RST;
     end 
      else begin 
           case( R_8_MUL_C1_flow_cnt_State)  
            R_8_MUL_C1_flow_cnt_RST :
                begin
                      R_8_MUL_C1_flow_cnt_State  <=R_8_MUL_C1_flow_cnt_IDLE;
                end 
            R_8_MUL_C1_flow_cnt_IDLE:
                begin
                  if (R_8_MUL_C1_en)
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_BEGIN;
                  else
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_IDLE;
                  end 
            R_8_MUL_C1_flow_cnt_BEGIN:
                 begin
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_CHK;
                 end 
            R_8_MUL_C1_flow_cnt_CHK:
                  begin
                     if ( R_8_MUL_C1_get_vil &&R_8_MUL_C1_CNT== 5'd12)
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_END;
                     else
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_CHK;
                   end 
            R_8_MUL_C1_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_IDLE;
                      else
                      R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_END;
                 end     
                 
       default:       R_8_MUL_C1_flow_cnt_State <=R_8_MUL_C1_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1_A_out  <=  32'd0;         
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_BEGIN)      
            R_8_MUL_C1_A_out  <= ParaM_X_A    ;
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_IDLE)      
            R_8_MUL_C1_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1_B_out  <=  32'd0;         
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_BEGIN)
            R_8_MUL_C1_B_out  <= ParaM_R_8_C1    ;
      else   if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_IDLE)           
            R_8_MUL_C1_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1_A_Vil  <= 1'b0;          
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_BEGIN)
            R_8_MUL_C1_A_Vil <= 1'b1;  
      else  if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_IDLE)            
            R_8_MUL_C1_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1_B_Vil <= 1'b0;         
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_BEGIN)
            R_8_MUL_C1_B_Vil <= 1'b1;  
      else  if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_IDLE)            
            R_8_MUL_C1_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1            <=  32'd0;          
      else if ( R_8_MUL_C1_get_vil &&R_8_MUL_C1_CNT== 5'd12)
            R_8_MUL_C1             <=  R_8_MUL_C1_get_r;
      else   if (  R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_IDLE)          
            R_8_MUL_C1             <= 32'd0;       
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_C1_CNT  <=  5'd0;         
      else if ( R_8_MUL_C1_flow_cnt_State  ==R_8_MUL_C1_flow_cnt_CHK)      
            R_8_MUL_C1_CNT  <= R_8_MUL_C1_CNT + 5'd1  ;
      else      
            R_8_MUL_C1_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           R_8_ADD_C0_flow_cnt_RST   = 5'b00001	,
           R_8_ADD_C0_flow_cnt_IDLE  = 5'b00010	,
           R_8_ADD_C0_flow_cnt_BEGIN = 5'b00100	,
           R_8_ADD_C0_flow_cnt_CHK   = 5'b01000	,
           R_8_ADD_C0_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_8_ADD_C0_flow_cnt_State <= R_8_ADD_C0_flow_cnt_RST;
     end 
      else begin 
           case( R_8_ADD_C0_flow_cnt_State)  
            R_8_ADD_C0_flow_cnt_RST :
                begin
                      R_8_ADD_C0_flow_cnt_State  <=R_8_ADD_C0_flow_cnt_IDLE;
                end 
            R_8_ADD_C0_flow_cnt_IDLE:
                begin
                  if (R_8_ADD_C0_en)
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_BEGIN;
                  else
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_IDLE;
                  end 
            R_8_ADD_C0_flow_cnt_BEGIN:
                 begin
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_CHK;
                 end 
            R_8_ADD_C0_flow_cnt_CHK:
                  begin
                     if ( R_8_ADD_C0_get_vil && R_8_ADD_C0_CNT == 5'd10 )
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_END;
                     else
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_CHK;
                   end 
            R_8_ADD_C0_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_IDLE;
                      else
                      R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_END;
                 end     
                 
       default:       R_8_ADD_C0_flow_cnt_State <=R_8_ADD_C0_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0_A_out  <=  32'd0;         
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_BEGIN)      
            R_8_ADD_C0_A_out  <= R_8_MUL_C1    ;
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_IDLE)      
            R_8_ADD_C0_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0_B_out  <=  32'd0;         
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_BEGIN)
            R_8_ADD_C0_B_out  <= ParaM_R_8_C0    ;
      else   if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_IDLE)           
            R_8_ADD_C0_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0_A_Vil  <= 1'b0;          
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_BEGIN)
            R_8_ADD_C0_A_Vil <= 1'b1;  
      else  if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_IDLE)            
            R_8_ADD_C0_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0_B_Vil <= 1'b0;         
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_BEGIN)
            R_8_ADD_C0_B_Vil <= 1'b1;  
      else  if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_IDLE)            
            R_8_ADD_C0_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0            <=  32'd0;          
      else if  ( R_8_ADD_C0_get_vil && R_8_ADD_C0_CNT == 5'd10 )
            R_8_ADD_C0            <=  R_8_ADD_C0_get_r;
      else   if (  R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_IDLE)          
            R_8_ADD_C0             <= 32'd0;       
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_ADD_C0_CNT  <=  5'd0;         
      else if ( R_8_ADD_C0_flow_cnt_State  ==R_8_ADD_C0_flow_cnt_CHK)      
            R_8_ADD_C0_CNT  <= R_8_ADD_C0_CNT + 5'd1  ;
      else   
            R_8_ADD_C0_CNT   <=  5'd0;              
      end    
      
      
 localparam [4:0]
           R_8_MUL_Bab_flow_cnt_RST   = 5'b00001	,
           R_8_MUL_Bab_flow_cnt_IDLE  = 5'b00010	,
           R_8_MUL_Bab_flow_cnt_BEGIN = 5'b00100	,
           R_8_MUL_Bab_flow_cnt_CHK   = 5'b01000	,
           R_8_MUL_Bab_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_8_MUL_Bab_flow_cnt_State <= R_8_MUL_Bab_flow_cnt_RST;
     end 
      else begin 
           case( R_8_MUL_Bab_flow_cnt_State)  
            R_8_MUL_Bab_flow_cnt_RST :
                begin
                      R_8_MUL_Bab_flow_cnt_State  <=R_8_MUL_Bab_flow_cnt_IDLE;
                end 
            R_8_MUL_Bab_flow_cnt_IDLE:
                begin
                  if (R_8_MUL_Bab_en)
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_BEGIN;
                  else
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_IDLE;
                  end 
            R_8_MUL_Bab_flow_cnt_BEGIN:
                 begin
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_CHK;
                 end 
            R_8_MUL_Bab_flow_cnt_CHK:
                  begin
                     if ( R_8_MUL_Bab_get_vil && R_8_MUL_Bab_CNT ==   5'd10    )
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_END;
                     else
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_CHK;
                   end 
            R_8_MUL_Bab_flow_cnt_END:
                 begin        
                    if  ( third_order_done )        
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_IDLE;
                      else
                      R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_END;
                 end     
                 
       default:       R_8_MUL_Bab_flow_cnt_State <=R_8_MUL_Bab_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_A_out  <=  32'd0;         
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_BEGIN)      
            R_8_MUL_Bab_A_out  <=  ParaM_Bab    ;
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_IDLE)      
            R_8_MUL_Bab_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_B_out  <=  32'd0;         
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_BEGIN)
            R_8_MUL_Bab_B_out  <=    R_8_ADD_C0  ;
      else   if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_IDLE)           
            R_8_MUL_Bab_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_A_Vil  <= 1'b0;          
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_BEGIN)
            R_8_MUL_Bab_A_Vil <= 1'b1;  
      else  if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_IDLE)            
            R_8_MUL_Bab_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_B_Vil <= 1'b0;         
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_BEGIN)
            R_8_MUL_Bab_B_Vil <= 1'b1;  
      else  if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_IDLE)            
            R_8_MUL_Bab_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab            <=  32'd0;          
      else if  ( R_8_MUL_Bab_get_vil && R_8_MUL_Bab_CNT ==   5'd10    )
            R_8_MUL_Bab             <=  R_8_MUL_Bab_get_r;
      else   if (  R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_IDLE)          
            R_8_MUL_Bab             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_done           <= 1'b0;            
      else if  ( R_8_MUL_Bab_get_vil && R_8_MUL_Bab_CNT ==   5'd10    )
            R_8_MUL_Bab_done           <= 1'b1;       
      else        
            R_8_MUL_Bab_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_8_MUL_Bab_CNT  <=  5'd0;         
      else if ( R_8_MUL_Bab_flow_cnt_State  ==R_8_MUL_Bab_flow_cnt_CHK)      
            R_8_MUL_Bab_CNT  <= R_8_MUL_Bab_CNT + 5'd1  ;
      else  
            R_8_MUL_Bab_CNT   <=  5'd0;              
      end          
      

//-----------------------------------------------------------------------
//               
//-----------------------------------------------------------------------

 
localparam [4:0]
           R_3_MUL_C1_flow_cnt_RST   = 5'b00001	,
           R_3_MUL_C1_flow_cnt_IDLE  = 5'b00010	,
           R_3_MUL_C1_flow_cnt_BEGIN = 5'b00100	,
           R_3_MUL_C1_flow_cnt_CHK   = 5'b01000	,
           R_3_MUL_C1_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_3_MUL_C1_flow_cnt_State <= R_3_MUL_C1_flow_cnt_RST;
     end 
      else begin 
           case( R_3_MUL_C1_flow_cnt_State)  
            R_3_MUL_C1_flow_cnt_RST :
                begin
                      R_3_MUL_C1_flow_cnt_State  <=R_3_MUL_C1_flow_cnt_IDLE;
                end 
            R_3_MUL_C1_flow_cnt_IDLE:
                begin
                  if (R_3_MUL_C1_en)
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_BEGIN;
                  else
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_IDLE;
                  end 
            R_3_MUL_C1_flow_cnt_BEGIN:
                 begin
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_CHK;
                 end 
            R_3_MUL_C1_flow_cnt_CHK:
                  begin
                     if ( R_3_MUL_C1_get_vil && R_3_MUL_C1_CNT == 5'd12)
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_END;
                     else
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_CHK;
                   end 
            R_3_MUL_C1_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_IDLE;
                      else
                      R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_END;
                 end     
                 
       default:       R_3_MUL_C1_flow_cnt_State <=R_3_MUL_C1_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_C1_A_out  <=  32'd0;         
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_BEGIN)      
            R_3_MUL_C1_A_out  <= ParaM_X_A    ;
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_IDLE)      
            R_3_MUL_C1_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_C1_B_out  <=  32'd0;         
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_BEGIN)
            R_3_MUL_C1_B_out  <= ParaM_R_3_C1    ;
      else   if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_IDLE)           
            R_3_MUL_C1_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_C1_A_Vil  <= 1'b0;          
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_BEGIN)
            R_3_MUL_C1_A_Vil <= 1'b1;  
      else  if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_IDLE)            
            R_3_MUL_C1_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_C1_B_Vil <= 1'b0;         
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_BEGIN)
            R_3_MUL_C1_B_Vil <= 1'b1;  
      else  if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_IDLE)            
            R_3_MUL_C1_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R_3_MUL_C1            <=  32'd0;          
      else if  ( R_3_MUL_C1_get_vil && R_3_MUL_C1_CNT == 5'd12)
            R_3_MUL_C1             <=  R_3_MUL_C1_get_r;
      else   if (  R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_IDLE)          
            R_3_MUL_C1             <= 32'd0;       
      end 

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_C1_CNT   <=  5'd0;         
      else if ( R_3_MUL_C1_flow_cnt_State  ==R_3_MUL_C1_flow_cnt_CHK)      
            R_3_MUL_C1_CNT   <= R_3_MUL_C1_CNT + 5'd1  ;
      else  
            R_3_MUL_C1_CNT   <=  5'd0;              
      end 
 
  localparam [4:0]
           R_3_ADD_C0_flow_cnt_RST   = 5'b00001	,
           R_3_ADD_C0_flow_cnt_IDLE  = 5'b00010	,
           R_3_ADD_C0_flow_cnt_BEGIN = 5'b00100	,
           R_3_ADD_C0_flow_cnt_CHK   = 5'b01000	,
           R_3_ADD_C0_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_3_ADD_C0_flow_cnt_State <= R_3_ADD_C0_flow_cnt_RST;
     end 
      else begin 
           case( R_3_ADD_C0_flow_cnt_State)  
            R_3_ADD_C0_flow_cnt_RST :
                begin
                      R_3_ADD_C0_flow_cnt_State  <=R_3_ADD_C0_flow_cnt_IDLE;
                end 
            R_3_ADD_C0_flow_cnt_IDLE:
                begin
                  if (R_3_ADD_C0_en)
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_BEGIN;
                  else
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_IDLE;
                  end 
            R_3_ADD_C0_flow_cnt_BEGIN:
                 begin
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_CHK;
                 end 
            R_3_ADD_C0_flow_cnt_CHK:
                  begin
                     if ( R_3_ADD_C0_get_vil && R_3_ADD_C0_CNT   ==  5'd10)
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_END;
                     else
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_CHK;
                   end 
            R_3_ADD_C0_flow_cnt_END:
                 begin        
                    if  ( Force_second_order_done )        
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_IDLE;
                      else
                      R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_END;
                 end     
                 
       default:       R_3_ADD_C0_flow_cnt_State <=R_3_ADD_C0_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0_A_out  <=  32'd0;         
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_BEGIN)      
            R_3_ADD_C0_A_out  <=    ParaM_R_3_C0  ;
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_IDLE)      
            R_3_ADD_C0_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0_B_out  <=  32'd0;         
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_BEGIN)
            R_3_ADD_C0_B_out  <=    R_3_MUL_C1  ;
      else   if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_IDLE)           
            R_3_ADD_C0_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0_A_Vil  <= 1'b0;          
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_BEGIN)
            R_3_ADD_C0_A_Vil <= 1'b1;  
      else  if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_IDLE)            
            R_3_ADD_C0_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0_B_Vil <= 1'b0;         
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_BEGIN)
            R_3_ADD_C0_B_Vil <= 1'b1;  
      else  if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_IDLE)            
            R_3_ADD_C0_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0            <=  32'd0;          
      else if ( R_3_ADD_C0_get_vil && R_3_ADD_C0_CNT   ==  5'd10)
            R_3_ADD_C0            <=  R_3_ADD_C0_get_r;
      else    if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_IDLE)                
            R_3_ADD_C0             <= 32'd0;       
      end 
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_ADD_C0_CNT  <=  5'd0;         
      else if ( R_3_ADD_C0_flow_cnt_State  ==R_3_ADD_C0_flow_cnt_CHK)      
            R_3_ADD_C0_CNT  <= R_3_ADD_C0_CNT + 5'd1  ;
      else     
            R_3_ADD_C0_CNT   <=  5'd0;              
      end 
      
localparam [4:0]
           R_3_MUL_Qab_flow_cnt_RST   = 5'b00001	,
           R_3_MUL_Qab_flow_cnt_IDLE  = 5'b00010	,
           R_3_MUL_Qab_flow_cnt_BEGIN = 5'b00100	,
           R_3_MUL_Qab_flow_cnt_CHK   = 5'b01000	,
           R_3_MUL_Qab_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R_3_MUL_Qab_flow_cnt_State <= R_3_MUL_Qab_flow_cnt_RST;
     end 
      else begin 
           case( R_3_MUL_Qab_flow_cnt_State)  
            R_3_MUL_Qab_flow_cnt_RST :
                begin
                      R_3_MUL_Qab_flow_cnt_State  <=R_3_MUL_Qab_flow_cnt_IDLE;
                end 
            R_3_MUL_Qab_flow_cnt_IDLE:
                begin
                  if (R_3_MUL_Qab_en)
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_BEGIN;
                  else
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_IDLE;
                  end 
            R_3_MUL_Qab_flow_cnt_BEGIN:
                 begin
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_CHK;
                 end 
            R_3_MUL_Qab_flow_cnt_CHK:
                  begin
                     if ( R_3_MUL_Qab_get_vil && R_3_MUL_Qab_CNT ==   5'd10    )
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_END;
                     else
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_CHK;
                   end 
            R_3_MUL_Qab_flow_cnt_END:
                 begin        
                    if  ( third_order_done )        
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_IDLE;
                      else
                      R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_END;
                 end     
                 
       default:       R_3_MUL_Qab_flow_cnt_State <=R_3_MUL_Qab_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_A_out  <=  32'd0;         
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_BEGIN)      
            R_3_MUL_Qab_A_out  <= ParaM_QQab    ;
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_IDLE)      
            R_3_MUL_Qab_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_B_out  <=  32'd0;         
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_BEGIN)
            R_3_MUL_Qab_B_out  <= R_3_ADD_C0    ;
      else   if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_IDLE)           
            R_3_MUL_Qab_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_A_Vil  <= 1'b0;          
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_BEGIN)
            R_3_MUL_Qab_A_Vil <= 1'b1;  
      else  if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_IDLE)            
            R_3_MUL_Qab_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_B_Vil <= 1'b0;         
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_BEGIN)
            R_3_MUL_Qab_B_Vil <= 1'b1;  
      else  if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_IDLE)            
            R_3_MUL_Qab_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab            <=  32'd0;          
      else if  ( R_3_MUL_Qab_get_vil && R_3_MUL_Qab_CNT ==   5'd10    )
            R_3_MUL_Qab             <=  R_3_MUL_Qab_get_r;
      else   if (  R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_IDLE)          
            R_3_MUL_Qab             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_done           <= 1'b0;            
      else if  ( R_3_MUL_Qab_get_vil && R_3_MUL_Qab_CNT ==   5'd10    )
            R_3_MUL_Qab_done           <= 1'b1;       
      else        
            R_3_MUL_Qab_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R_3_MUL_Qab_CNT  <=  5'd0;         
      else if ( R_3_MUL_Qab_flow_cnt_State  ==R_3_MUL_Qab_flow_cnt_CHK)      
            R_3_MUL_Qab_CNT  <= R_3_MUL_Qab_CNT + 5'd1  ;
      else  
            R_3_MUL_Qab_CNT   <=  5'd0;              
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
                    if  ( Force_ADD_Done )        
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
            X_Add_A_out  <= R_14_MUL_Aab    ;
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)      
            X_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Add_B_out  <=  32'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            Y_Add_B_out  <= R_8_MUL_Bab   ;
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
            Z_Add_C_out        <= R_3_MUL_Qab;  
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
            Force_ParaM            <=  32'd0;          
      else if ( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
            Force_ParaM     <=  RR_Add_get_r; 
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            Force_ParaM             <= 32'd0;       
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
//-----------------------------------------------------------------------
//               
//-----------------------------------------------------------------------    
    localparam [4:0]
           Force_ParaM_deltaX_MUL_flow_cnt_RST   = 5'b00001	,
           Force_ParaM_deltaX_MUL_flow_cnt_IDLE  = 5'b00010	,
           Force_ParaM_deltaX_MUL_flow_cnt_BEGIN = 5'b00100	,
           Force_ParaM_deltaX_MUL_flow_cnt_CHK   = 5'b01000	,
           Force_ParaM_deltaX_MUL_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Force_ParaM_deltaX_MUL_flow_cnt_State <= Force_ParaM_deltaX_MUL_flow_cnt_RST;
     end 
      else begin 
           case( Force_ParaM_deltaX_MUL_flow_cnt_State)  
            Force_ParaM_deltaX_MUL_flow_cnt_RST :
                begin
                      Force_ParaM_deltaX_MUL_flow_cnt_State  <=Force_ParaM_deltaX_MUL_flow_cnt_IDLE;
                end 
            Force_ParaM_deltaX_MUL_flow_cnt_IDLE:
                begin
                  if (Force_ParaM_deltaX_MUL_en)
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_BEGIN;
                  else
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_IDLE;
                  end 
            Force_ParaM_deltaX_MUL_flow_cnt_BEGIN:
                 begin
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_CHK;
                 end 
            Force_ParaM_deltaX_MUL_flow_cnt_CHK:
                  begin
                     if ( Force_ParaM_deltaX_MUL_get_vil && Force_ParaM_deltaX_MUL_CNT ==   5'd10    )
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_END;
                     else
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_CHK;
                   end 
            Force_ParaM_deltaX_MUL_flow_cnt_END:
                 begin        
                    if  ( Force_ADD_Done )        
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_IDLE;
                      else
                      Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_END;
                 end     
                 
       default:       Force_ParaM_deltaX_MUL_flow_cnt_State <=Force_ParaM_deltaX_MUL_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX_MUL_A_out  <=  32'd0;         
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_BEGIN)      
            Force_ParaM_deltaX_MUL_A_out  <= Force_ParaM    ;
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_IDLE)      
            Force_ParaM_deltaX_MUL_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX_MUL_B_out  <=  32'd0;         
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaX_MUL_B_out  <= ParaM_X_A[95:64]    ;
      else   if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_IDLE)           
            Force_ParaM_deltaX_MUL_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX_MUL_A_Vil  <= 1'b0;          
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaX_MUL_A_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaX_MUL_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX_MUL_B_Vil <= 1'b0;         
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaX_MUL_B_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaX_MUL_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX            <=  32'd0;          
      else if  ( Force_ParaM_deltaX_MUL_get_vil && Force_ParaM_deltaX_MUL_CNT ==   5'd10    )
            Force_ParaM_deltaX             <=  Force_ParaM_deltaX_MUL_get_r;
      else   if (  Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_IDLE)          
            Force_ParaM_deltaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Force_ParaM_deltaX_MUL_done           <= 1'b0;            
      else if  ( Force_ParaM_deltaX_MUL_get_vil && Force_ParaM_deltaX_MUL_CNT ==   5'd10    )
             Force_ParaM_deltaX_MUL_done           <= 1'b1;       
      else        
             Force_ParaM_deltaX_MUL_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaX_MUL_CNT  <=  5'd0;         
      else if ( Force_ParaM_deltaX_MUL_flow_cnt_State  ==Force_ParaM_deltaX_MUL_flow_cnt_CHK)      
            Force_ParaM_deltaX_MUL_CNT  <= Force_ParaM_deltaX_MUL_CNT + 5'd1  ;
      else  
            Force_ParaM_deltaX_MUL_CNT   <=  5'd0;              
      end     
      
 //-----------------------------------------------------------------------
//               
//-----------------------------------------------------------------------    
    localparam [4:0]
           Force_ParaM_deltaY_MUL_flow_cnt_RST   = 5'b00001	,
           Force_ParaM_deltaY_MUL_flow_cnt_IDLE  = 5'b00010	,
           Force_ParaM_deltaY_MUL_flow_cnt_BEGIN = 5'b00100	,
           Force_ParaM_deltaY_MUL_flow_cnt_CHK   = 5'b01000	,
           Force_ParaM_deltaY_MUL_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Force_ParaM_deltaY_MUL_flow_cnt_State <= Force_ParaM_deltaY_MUL_flow_cnt_RST;
     end 
      else begin 
           case( Force_ParaM_deltaY_MUL_flow_cnt_State)  
            Force_ParaM_deltaY_MUL_flow_cnt_RST :
                begin
                      Force_ParaM_deltaY_MUL_flow_cnt_State  <=Force_ParaM_deltaY_MUL_flow_cnt_IDLE;
                end 
            Force_ParaM_deltaY_MUL_flow_cnt_IDLE:
                begin
                  if (Force_ParaM_deltaY_MUL_en)
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_BEGIN;
                  else
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_IDLE;
                  end 
            Force_ParaM_deltaY_MUL_flow_cnt_BEGIN:
                 begin
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_CHK;
                 end 
            Force_ParaM_deltaY_MUL_flow_cnt_CHK:
                  begin
                     if ( Force_ParaM_deltaY_MUL_get_vil && Force_ParaM_deltaY_MUL_CNT ==   5'd10    )
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_END;
                     else
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_CHK;
                   end 
            Force_ParaM_deltaY_MUL_flow_cnt_END:
                 begin        
                    if  ( Force_ADD_Done )        
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_IDLE;
                      else
                      Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_END;
                 end     
                 
       default:       Force_ParaM_deltaY_MUL_flow_cnt_State <=Force_ParaM_deltaY_MUL_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY_MUL_A_out  <=  32'd0;         
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_BEGIN)      
            Force_ParaM_deltaY_MUL_A_out  <= Force_ParaM    ;
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_IDLE)      
            Force_ParaM_deltaY_MUL_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY_MUL_B_out  <=  32'd0;         
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaY_MUL_B_out  <= ParaM_X_A[95:64]    ;
      else   if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_IDLE)           
            Force_ParaM_deltaY_MUL_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY_MUL_A_Vil  <= 1'b0;          
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaY_MUL_A_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaY_MUL_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY_MUL_B_Vil <= 1'b0;         
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaY_MUL_B_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaY_MUL_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY            <=  32'd0;          
      else if  ( Force_ParaM_deltaY_MUL_get_vil && Force_ParaM_deltaY_MUL_CNT ==   5'd10    )
            Force_ParaM_deltaY             <=  Force_ParaM_deltaY_MUL_get_r;
      else   if (  Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_IDLE)          
            Force_ParaM_deltaY             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Force_ParaM_deltaY_MUL_done           <= 1'b0;            
      else if  ( Force_ParaM_deltaY_MUL_get_vil && Force_ParaM_deltaY_MUL_CNT ==   5'd10    )
             Force_ParaM_deltaY_MUL_done           <= 1'b1;       
      else        
             Force_ParaM_deltaY_MUL_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaY_MUL_CNT  <=  5'd0;         
      else if ( Force_ParaM_deltaY_MUL_flow_cnt_State  ==Force_ParaM_deltaY_MUL_flow_cnt_CHK)      
            Force_ParaM_deltaY_MUL_CNT  <= Force_ParaM_deltaY_MUL_CNT + 5'd1  ;
      else  
            Force_ParaM_deltaY_MUL_CNT   <=  5'd0;              
      end         
  //-----------------------------------------------------------------------
//               
//-----------------------------------------------------------------------    
    localparam [4:0]
           Force_ParaM_deltaZ_MUL_flow_cnt_RST   = 5'b00001	,
           Force_ParaM_deltaZ_MUL_flow_cnt_IDLE  = 5'b00010	,
           Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN = 5'b00100	,
           Force_ParaM_deltaZ_MUL_flow_cnt_CHK   = 5'b01000	,
           Force_ParaM_deltaZ_MUL_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Force_ParaM_deltaZ_MUL_flow_cnt_State <= Force_ParaM_deltaZ_MUL_flow_cnt_RST;
     end 
      else begin 
           case( Force_ParaM_deltaZ_MUL_flow_cnt_State)  
            Force_ParaM_deltaZ_MUL_flow_cnt_RST :
                begin
                      Force_ParaM_deltaZ_MUL_flow_cnt_State  <=Force_ParaM_deltaZ_MUL_flow_cnt_IDLE;
                end 
            Force_ParaM_deltaZ_MUL_flow_cnt_IDLE:
                begin
                  if (Force_ParaM_deltaZ_MUL_en)
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN;
                  else
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_IDLE;
                  end 
            Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN:
                 begin
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_CHK;
                 end 
            Force_ParaM_deltaZ_MUL_flow_cnt_CHK:
                  begin
                     if ( Force_ParaM_deltaZ_MUL_get_vil && Force_ParaM_deltaZ_MUL_CNT ==   5'd10    )
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_END;
                     else
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_CHK;
                   end 
            Force_ParaM_deltaZ_MUL_flow_cnt_END:
                 begin        
                    if  ( Force_ADD_Done )        
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_IDLE;
                      else
                      Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_END;
                 end     
                 
       default:       Force_ParaM_deltaZ_MUL_flow_cnt_State <=Force_ParaM_deltaZ_MUL_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ_MUL_A_out  <=  32'd0;         
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN)      
            Force_ParaM_deltaZ_MUL_A_out  <= Force_ParaM    ;
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)      
            Force_ParaM_deltaZ_MUL_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ_MUL_B_out  <=  32'd0;         
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaZ_MUL_B_out  <= ParaM_X_A[95:64]    ;
      else   if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)           
            Force_ParaM_deltaZ_MUL_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ_MUL_A_Vil  <= 1'b0;          
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaZ_MUL_A_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaZ_MUL_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ_MUL_B_Vil <= 1'b0;         
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_BEGIN)
            Force_ParaM_deltaZ_MUL_B_Vil <= 1'b1;  
      else  if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)            
            Force_ParaM_deltaZ_MUL_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ            <=  32'd0;          
      else if  ( Force_ParaM_deltaZ_MUL_get_vil && Force_ParaM_deltaZ_MUL_CNT ==   5'd10    )
            Force_ParaM_deltaZ             <=  Force_ParaM_deltaZ_MUL_get_r;
      else   if (  Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)          
            Force_ParaM_deltaZ             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_EnE_Force            <=  32'd0;          
      else if  ( Force_ParaM_deltaZ_MUL_get_vil && Force_ParaM_deltaZ_MUL_CNT ==   5'd10    )
            M_AXIS_EnE_Force             <=  {ParaM_X_A,Force_ParaM_deltaZ,Force_ParaM_deltaZ,Force_ParaM_deltaZ,Force_ParaM};
      else   if (  Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_IDLE)          
            M_AXIS_EnE_Force             <= 32'd0;       
      end    
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Force_ParaM_deltaZ_MUL_done           <= 1'b0;            
      else if  ( Force_ParaM_deltaZ_MUL_get_vil && Force_ParaM_deltaZ_MUL_CNT ==   5'd10    )
             Force_ParaM_deltaZ_MUL_done           <= 1'b1;       
      else        
             Force_ParaM_deltaZ_MUL_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Force_ParaM_deltaZ_MUL_CNT  <=  5'd0;         
      else if ( Force_ParaM_deltaZ_MUL_flow_cnt_State  ==Force_ParaM_deltaZ_MUL_flow_cnt_CHK)      
            Force_ParaM_deltaZ_MUL_CNT  <= Force_ParaM_deltaZ_MUL_CNT + 5'd1  ;
      else  
            Force_ParaM_deltaZ_MUL_CNT   <=  5'd0;              
      end         
       
endmodule
