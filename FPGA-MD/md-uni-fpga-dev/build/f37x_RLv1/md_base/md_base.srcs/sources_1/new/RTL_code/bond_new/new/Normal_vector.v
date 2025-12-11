`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 02:47:18 AM
// Design Name: 
// Module Name: Normal_vector
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


module Normal_vector(
 input                       Sys_Clk  ,
 input                       Sys_Rst_n ,
 
input                  Index_DIR_AB_en,
input  [95:0]          Index_DIR_AB_in  ,
input  [95:0]          Index_DIR_AC_in  ,

 output reg   [95:0]          Index_DIR_ABC_out  ,

     //X to caculation sub unit 
 output reg [31:0]     Y1Z1_Mul_A_out ,
 output reg            Y1Z1_Mul_A_Vil ,
 output reg            Y1Z1_Mul_B_Vil ,
 output reg [31:0]     Y1Z1_Mul_B_out ,
 input      [31:0]     Y1Z1_Mul_get_r,
 input                 Y1Z1_Mul_get_vil,   

     //Y to caculation sub unit 
 output reg [31:0]     Y2Z1_Mul_A_out ,
 output reg            Y2Z1_Mul_A_Vil ,
 output reg            Y2Z1_Mul_B_Vil ,
 output reg [31:0]     Y2Z1_Mul_B_out ,
 input      [31:0]     Y2Z1_Mul_get_r,
 input                 Y2Z1_Mul_get_vil,   

     //Z to caculation Mul unit 
 output reg [31:0]     X2Z1_Mul_A_out ,
 output reg            X2Z1_Mul_A_Vil ,
 output reg            X2Z1_Mul_B_Vil ,
 output reg [31:0]     X2Z1_Mul_B_out ,
 input      [31:0]     X2Z1_Mul_get_r,
 input                 X2Z1_Mul_get_vil  ,
 
      //X to caculation sub unit 
 output reg [31:0]     X1Z1_Mul_A_out ,
 output reg            X1Z1_Mul_A_Vil ,
 output reg            X1Z1_Mul_B_Vil ,
 output reg [31:0]     X1Z1_Mul_B_out ,
 input      [31:0]     X1Z1_Mul_get_r,
 input                 X1Z1_Mul_get_vil,   

     //Y to caculation sub unit 
 output reg [31:0]     X1Y1_Mul_A_out ,
 output reg            X1Y1_Mul_A_Vil ,
 output reg            X1Y1_Mul_B_Vil ,
 output reg [31:0]     X1Y1_Mul_B_out ,
 input      [31:0]     X1Y1_Mul_get_r,
 input                 X1Y1_Mul_get_vil,   

     //Z to caculation Mul unit 
 output reg [31:0]     X2Y1_Mul_A_out ,
 output reg            X2Y1_Mul_A_Vil ,
 output reg            X2Y1_Mul_B_Vil ,
 output reg [31:0]     X2Y1_Mul_B_out ,
 input      [31:0]     X2Y1_Mul_get_r,
 input                 X2Y1_Mul_get_vil ,
 
      //X to caculation sub unit 
 output reg [31:0]     X_Sub_A_out ,
 output reg            X_Sub_A_Vil ,
 output reg            X_Sub_B_Vil ,
 output reg [31:0]     X_Sub_B_out ,
 input      [31:0]     X_Sub_get_r,
 input                 X_Sub_get_vil,   

     //Y to caculation sub unit 
 output reg [31:0]     Y_Sub_A_out ,
 output reg            Y_Sub_A_Vil ,
 output reg            Y_Sub_B_Vil ,
 output reg [31:0]     Y_Sub_B_out ,
 input      [31:0]     Y_Sub_get_r,
 input                 Y_Sub_get_vil,   

     //Z to caculation sub unit 
 output reg [31:0]     Z_Sub_A_out ,
 output reg            Z_Sub_A_Vil ,
 output reg            Z_Sub_B_Vil ,
 output reg [31:0]     Z_Sub_B_out ,
 input      [31:0]     Z_Sub_get_r,
 input                 Z_Sub_get_vil              
     );
     // ---------------------------------------- -----------------------       
//  --state

reg [7:0]         Y1Z1_Mul_flow_cnt_State;
 
reg [31:0]        X_Pos_home          ;              
reg [31:0]        Y_Pos_home          ;              
reg [31:0]        Z_Pos_home          ;    
reg [31:0]        X_Pos_nei           ;  
reg [31:0]        Y_Pos_nei           ;  
reg [31:0]        Z_Pos_nei           ;  
      
reg               Mul_done            ;
reg               Y1Z1_Mul_en            ;  
reg               Y_Mul_en            ; 
reg               Z_Mul_en            ; 
reg               Get_XYZ_delta_en    ;

reg [4:0]         Y1Z1_Mul_CNT           ;  

 reg [31:0]         DertaX;
 reg [31:0]         DertaY;
 reg [31:0]         DertaZ;
 
 reg               R_Root_en;
 reg               R_Root_Done;
 
 reg               Get_AB_en;
 reg               Get_AC_en;
 reg               Get_BC_en;
 reg               Get_BD_en;
//-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Y1Z1_Mul_flow_cnt_RST   = 5'b00001	,
           Y1Z1_Mul_flow_cnt_IDLE  = 5'b00010	,
           Y1Z1_Mul_flow_cnt_BEGIN = 5'b00100	,
           Y1Z1_Mul_flow_cnt_CHK   = 5'b01000	,
           Y1Z1_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y1Z1_Mul_flow_cnt_State <= Y1Z1_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Y1Z1_Mul_flow_cnt_State)  
            Y1Z1_Mul_flow_cnt_RST :
                begin
                      Y1Z1_Mul_flow_cnt_State  <=Y1Z1_Mul_flow_cnt_IDLE;
                end 
            Y1Z1_Mul_flow_cnt_IDLE:
                begin
                  if (Y1Z1_Mul_en)
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_BEGIN;
                  else
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_IDLE;
                  end 
            Y1Z1_Mul_flow_cnt_BEGIN:
                 begin
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_CHK;
                 end 
            Y1Z1_Mul_flow_cnt_CHK:
                  begin
                     if ( Y1Z1_Mul_get_vil &&( Y1Z1_Mul_CNT == 5'd12))
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_END;
                     else
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_CHK;
                   end 
            Y1Z1_Mul_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_IDLE;
                      else
                      Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_END;
                 end     
                 
       default:       Y1Z1_Mul_flow_cnt_State <=Y1Z1_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y1Z1_Mul_A_out  <=  32'd0;         
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_BEGIN)      
            Y1Z1_Mul_A_out  <= X_Pos_home    ;
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_IDLE)      
            Y1Z1_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y1Z1_Mul_B_out  <=  32'd0;         
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_BEGIN)
            Y1Z1_Mul_B_out  <= X_Pos_nei    ;
      else   if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_IDLE)           
            Y1Z1_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y1Z1_Mul_A_Vil  <= 1'b0;          
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_BEGIN)
            Y1Z1_Mul_A_Vil <= 1'b1;  
      else  if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_IDLE)            
            Y1Z1_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y1Z1_Mul_B_Vil <= 1'b0;         
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_BEGIN)
            Y1Z1_Mul_B_Vil <= 1'b1;  
      else              
            Y1Z1_Mul_B_Vil  <= 1'b0;             
      end 
   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaX             <=  32'd0;          
      else if ( Y1Z1_Mul_get_vil &&( Y1Z1_Mul_CNT == 5'd12))
            DertaX             <=  Y1Z1_Mul_get_r;
      else   if (  Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_IDLE)          
            DertaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Mul_done           <= 1'b0;            
      else if ( Y1Z1_Mul_get_vil &&( Y1Z1_Mul_CNT == 5'd12))
            Mul_done           <= 1'b1;       
      else     
            Mul_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y1Z1_Mul_CNT  <=  5'd0;         
      else if ( Y1Z1_Mul_flow_cnt_State  ==Y1Z1_Mul_flow_cnt_CHK)      
            Y1Z1_Mul_CNT  <= Y1Z1_Mul_CNT + 5'd1  ;
      else 
            Y1Z1_Mul_CNT   <=  5'd0;              
      end 
 

 
endmodule  
    

