`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2023 02:51:34 AM
// Design Name: 
// Module Name: Neighbor_ACC
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


module Motion_update(
 input                   Sys_Clk  ,
 input                   Sys_Rst_n,

 input           [159:0] Fx_Home_in  ,
 input           [159:0] Fy_Home_in  ,
 input           [159:0] Fz_Home_in  ,

 input           [159:0] Fx_Home_Mass  ,
 input           [159:0] Fy_Home_Mass  ,
 input           [159:0] Fz_Home_Mass  ,

 input           [159:0] time_step  ,

 input           [159:0] Vx_Home_in   ,
 input           [159:0] Vy_Home_in   ,
 input           [159:0] Vz_Home_in   ,

 input           [159:0] Rx_Home_in  ,
 input           [159:0] Ry_Home_in  ,
 input           [159:0] Rz_Home_in  ,  

 output  reg     [159:0] Vx_Home_out   ,
 output  reg     [159:0] Vy_Home_out   ,
 output  reg     [159:0] Vz_Home_out   ,

output  reg     [159:0] Rx_Home_out  ,
output  reg     [159:0] Ry_Home_out  ,
output  reg     [159:0] Rz_Home_out  ,  
/////////////////////////////////////////////////////////////
     //X to caculation mul unit 
 output reg [31:0]     Fx_MUL_InvM_A_out ,
 output reg            Fx_MUL_InvM_A_Vil ,
 output reg            Fx_MUL_InvM_B_Vil ,
 output reg [31:0]     Fx_MUL_InvM_B_out ,
 input      [31:0]     Fx_MUL_InvM_get_r,
 input                 Fx_MUL_InvM_get_vil,  
     //X to caculation mul unit 
 output reg [31:0]     Fy_MUL_InvM_A_out ,
 output reg            Fy_MUL_InvM_A_Vil ,
 output reg            Fy_MUL_InvM_B_Vil ,
 output reg [31:0]     Fy_MUL_InvM_B_out ,
 input      [31:0]     Fy_MUL_InvM_get_r,
 input                 Fy_MUL_InvM_get_vil,  
      //X to caculation mul unit 
 output reg [31:0]     Fz_MUL_InvM_A_out ,
 output reg            Fz_MUL_InvM_A_Vil ,
 output reg            Fz_MUL_InvM_B_Vil ,
 output reg [31:0]     Fz_MUL_InvM_B_out ,
 input      [31:0]     Fz_MUL_InvM_get_r,
 input                 Fz_MUL_InvM_get_vil,  

      //X to caculation mul unit 
 output reg [31:0]     Ax_MULA_T_A_out ,
 output reg            Ax_MULA_T_A_Vil ,
 output reg            Ax_MULA_T_B_Vil ,
 output reg [31:0]     Ax_MULA_T_B_out ,
 output reg            Ax_MULA_Vx_C_Vil ,
 output reg [31:0]     Ax_MULA_Vx_C_out ,
 input      [31:0]     Ax_MULA_T_get_r,
 input                 Ax_MULA_T_get_vil,  
 
     //X to caculation mul unit 
 output reg [31:0]     Ay_MULA_T_A_out ,
 output reg            Ay_MULA_T_A_Vil ,
 output reg            Ay_MULA_T_B_Vil ,
 output reg [31:0]     Ay_MULA_T_B_out ,
 output reg            Ay_MULA_Vy_C_Vil ,
 output reg [31:0]     Ay_MULA_Vy_C_out ,
 input      [31:0]     Ay_MULA_T_get_r,
 input                 Ay_MULA_T_get_vil,  
 
      //X to caculation mul unit 
 output reg [31:0]     Az_MULA_T_A_out ,
 output reg            Az_MULA_T_A_Vil ,
 output reg            Az_MULA_T_B_Vil ,
 output reg [31:0]     Az_MULA_T_B_out ,
 output reg            Az_MULA_Vz_C_Vil ,
 output reg [31:0]     Az_MULA_Vz_C_out ,
 input      [31:0]     Az_MULA_T_get_r,
 input                 Az_MULA_T_get_vil,  

      //X to caculation mul unit 
 output reg [31:0]     Vx_MULA_T_A_out ,
 output reg            Vx_MULA_T_A_Vil ,
 output reg            Vx_MULA_T_B_Vil ,
 output reg [31:0]     Vx_MULA_T_B_out ,
 output reg            Vx_MULA_Rx_C_Vil ,
 output reg [31:0]     Vx_MULA_Rx_C_out ,
 input      [31:0]     Vx_MULA_T_get_r,
 input                 Vx_MULA_T_get_vil,  
     //X to caculation mul unit 
 output reg [31:0]     Vy_MULA_T_A_out ,
 output reg            Vy_MULA_T_A_Vil ,
 output reg            Vy_MULA_T_B_Vil ,
 output reg [31:0]     Vy_MULA_T_B_out ,
 output reg            Vy_MULA_Ry_C_Vil ,
 output reg [31:0]     Vy_MULA_Ry_C_out ,
 input      [31:0]     Vy_MULA_T_get_r,
 input                 Vy_MULA_T_get_vil,  
      //X to caculation mul unit 
 output reg [31:0]     Vz_MULA_T_A_out ,
 output reg            Vz_MULA_T_A_Vil ,
 output reg            Vz_MULA_T_B_Vil ,
 output reg [31:0]     Vz_MULA_T_B_out ,
 output reg            Vz_MULA_Rz_C_Vil ,
 output reg [31:0]     Vz_MULA_Rz_C_out ,
 input      [31:0]     Vz_MULA_T_get_r,
 input                 Vz_MULA_T_get_vil   

      );
reg [7:0]         Fx_MUL_InvM_flow_cnt_State     ;
reg [7:0]         Fy_MUL_InvM_flow_cnt_State     ;
reg [7:0]         Fz_MUL_InvM_flow_cnt_State     ;
reg [7:0]         Ax_MULA_T_flow_cnt_State;
reg [7:0]         Ay_MULA_T_flow_cnt_State;
reg [7:0]         Az_MULA_T_flow_cnt_State;
reg [7:0]         Vx_MULA_T_flow_cnt_State;
reg [7:0]         Vy_MULA_T_flow_cnt_State;
reg [7:0]         Vz_MULA_T_flow_cnt_State;
  
reg          Fx_MUL_InvM_en;
reg          Fy_MUL_InvM_en;
reg          Fz_MUL_InvM_en;
reg            Ax_MULA_T_en; 
reg            Ay_MULA_T_en; 
reg            Az_MULA_T_en; 
reg            Vx_MULA_T_en; 
reg            Vy_MULA_T_en; 
reg            Vz_MULA_T_en; 
    
reg [3:0]   Fx_MUL_InvM_CNT;   
reg [3:0]   Fy_MUL_InvM_CNT;   
reg [3:0]   Fz_MUL_InvM_CNT;   
reg [3:0]     Ax_MULA_T_CNT;   
reg [3:0]     Ay_MULA_T_CNT;   
reg [3:0]     Az_MULA_T_CNT;   
reg [3:0]     Vx_MULA_T_CNT;   
reg [3:0]     Vy_MULA_T_CNT;   
reg [3:0]     Vz_MULA_T_CNT;   
  
 reg Motion_Cal_Done;
  
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Fx_MUL_InvM_flow_cnt_RST   = 5'b00001	,
           Fx_MUL_InvM_flow_cnt_IDLE  = 5'b00010	,
           Fx_MUL_InvM_flow_cnt_BEGIN = 5'b00100	,
           Fx_MUL_InvM_flow_cnt_CHK   = 5'b01000	,
           Fx_MUL_InvM_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Fx_MUL_InvM_flow_cnt_State <= Fx_MUL_InvM_flow_cnt_RST;
     end 
      else begin 
           case( Fx_MUL_InvM_flow_cnt_State)  
            Fx_MUL_InvM_flow_cnt_RST :
                begin
                      Fx_MUL_InvM_flow_cnt_State  <=Fx_MUL_InvM_flow_cnt_IDLE;
                end 
            Fx_MUL_InvM_flow_cnt_IDLE:
                begin
                  if (Fx_MUL_InvM_en)
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_BEGIN;
                  else
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_IDLE;
                  end 
            Fx_MUL_InvM_flow_cnt_BEGIN:
                 begin
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_CHK;
                 end 
            Fx_MUL_InvM_flow_cnt_CHK:
                  begin
                     if ( Fx_MUL_InvM_get_vil &&( Fx_MUL_InvM_CNT == 5'd12))
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_END;
                     else
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_CHK;
                   end 
            Fx_MUL_InvM_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_IDLE;
                      else
                      Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_END;
                 end     
                 
       default:       Fx_MUL_InvM_flow_cnt_State <=Fx_MUL_InvM_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fx_MUL_InvM_A_out  <=  32'd0;         
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_BEGIN)      
            Fx_MUL_InvM_A_out  <= Fx_Home_in    ;
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_IDLE)      
            Fx_MUL_InvM_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fx_MUL_InvM_B_out  <=  32'd0;         
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_BEGIN)
            Fx_MUL_InvM_B_out  <= Fx_Home_Mass    ;
      else   if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_IDLE)           
            Fx_MUL_InvM_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fx_MUL_InvM_A_Vil  <= 1'b0;          
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_BEGIN)
            Fx_MUL_InvM_A_Vil <= 1'b1;  
      else  if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_IDLE)            
            Fx_MUL_InvM_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fx_MUL_InvM_B_Vil <= 1'b0;         
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_BEGIN)
            Fx_MUL_InvM_B_Vil <= 1'b1;  
      else              
            Fx_MUL_InvM_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fx_MUL_InvM_CNT <= 1'b0;         
      else if ( Fx_MUL_InvM_flow_cnt_State  ==Fx_MUL_InvM_flow_cnt_BEGIN)
            Fx_MUL_InvM_CNT <=Fx_MUL_InvM_CNT + 1'b1;  
      else              
            Fx_MUL_InvM_CNT  <= 1'b0;             
      end 

 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Fy_MUL_InvM_flow_cnt_RST   = 5'b00001	,
           Fy_MUL_InvM_flow_cnt_IDLE  = 5'b00010	,
           Fy_MUL_InvM_flow_cnt_BEGIN = 5'b00100	,
           Fy_MUL_InvM_flow_cnt_CHK   = 5'b01000	,
           Fy_MUL_InvM_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Fy_MUL_InvM_flow_cnt_State <= Fy_MUL_InvM_flow_cnt_RST;
     end 
      else begin 
           case( Fy_MUL_InvM_flow_cnt_State)  
            Fy_MUL_InvM_flow_cnt_RST :
                begin
                      Fy_MUL_InvM_flow_cnt_State  <=Fy_MUL_InvM_flow_cnt_IDLE;
                end 
            Fy_MUL_InvM_flow_cnt_IDLE:
                begin
                  if (Fy_MUL_InvM_en)
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_BEGIN;
                  else
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_IDLE;
                  end 
            Fy_MUL_InvM_flow_cnt_BEGIN:
                 begin
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_CHK;
                 end 
            Fy_MUL_InvM_flow_cnt_CHK:
                  begin
                     if ( Fy_MUL_InvM_get_vil &&( Fy_MUL_InvM_CNT == 5'd12))
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_END;
                     else
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_CHK;
                   end 
            Fy_MUL_InvM_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_IDLE;
                      else
                      Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_END;
                 end     
                 
       default:       Fy_MUL_InvM_flow_cnt_State <=Fy_MUL_InvM_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fy_MUL_InvM_A_out  <=  32'd0;         
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_BEGIN)      
            Fy_MUL_InvM_A_out  <= Fy_Home_in    ;
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_IDLE)      
            Fy_MUL_InvM_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fy_MUL_InvM_B_out  <=  32'd0;         
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_BEGIN)
            Fy_MUL_InvM_B_out  <= Fy_Home_Mass     ;
      else   if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_IDLE)           
            Fy_MUL_InvM_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fy_MUL_InvM_A_Vil  <= 1'b0;          
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_BEGIN)
            Fy_MUL_InvM_A_Vil <= 1'b1;  
      else  if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_IDLE)            
            Fy_MUL_InvM_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fy_MUL_InvM_B_Vil <= 1'b0;         
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_BEGIN)
            Fy_MUL_InvM_B_Vil <= 1'b1;  
      else              
            Fy_MUL_InvM_B_Vil  <= 1'b0;             
      end 
      
            
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fy_MUL_InvM_CNT  <= 1'b0;         
      else if ( Fy_MUL_InvM_flow_cnt_State  ==Fy_MUL_InvM_flow_cnt_BEGIN)
            Fy_MUL_InvM_CNT  <= Fy_MUL_InvM_CNT  + 1'b1;  
      else              
            Fy_MUL_InvM_CNT  <= 1'b0;             
      end 
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Fz_MUL_InvM_flow_cnt_RST   = 5'b00001	,
           Fz_MUL_InvM_flow_cnt_IDLE  = 5'b00010	,
           Fz_MUL_InvM_flow_cnt_BEGIN = 5'b00100	,
           Fz_MUL_InvM_flow_cnt_CHK   = 5'b01000	,
           Fz_MUL_InvM_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Fz_MUL_InvM_flow_cnt_State <= Fz_MUL_InvM_flow_cnt_RST;
     end 
      else begin 
           case( Fz_MUL_InvM_flow_cnt_State)  
            Fz_MUL_InvM_flow_cnt_RST :
                begin
                      Fz_MUL_InvM_flow_cnt_State  <=Fz_MUL_InvM_flow_cnt_IDLE;
                end 
            Fz_MUL_InvM_flow_cnt_IDLE:
                begin
                  if (Fz_MUL_InvM_en)
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_BEGIN;
                  else
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_IDLE;
                  end 
            Fz_MUL_InvM_flow_cnt_BEGIN:
                 begin
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_CHK;
                 end 
            Fz_MUL_InvM_flow_cnt_CHK:
                  begin
                     if ( Fz_MUL_InvM_get_vil &&( Fz_MUL_InvM_CNT == 5'd12))
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_END;
                     else
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_CHK;
                   end 
            Fz_MUL_InvM_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_IDLE;
                      else
                      Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_END;
                 end     
                 
       default:       Fz_MUL_InvM_flow_cnt_State <=Fz_MUL_InvM_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fz_MUL_InvM_A_out  <=  32'd0;         
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_BEGIN)      
            Fz_MUL_InvM_A_out  <= Fz_Home_in    ;
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_IDLE)      
            Fz_MUL_InvM_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fz_MUL_InvM_B_out  <=  32'd0;         
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_BEGIN)
            Fz_MUL_InvM_B_out  <= Fz_Home_Mass    ;
      else   if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_IDLE)           
            Fz_MUL_InvM_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fz_MUL_InvM_A_Vil  <= 1'b0;          
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_BEGIN)
            Fz_MUL_InvM_A_Vil <= 1'b1;  
      else  if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_IDLE)            
            Fz_MUL_InvM_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fz_MUL_InvM_B_Vil <= 1'b0;         
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_BEGIN)
            Fz_MUL_InvM_B_Vil <= 1'b1;  
      else              
            Fz_MUL_InvM_B_Vil  <= 1'b0;             
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fz_MUL_InvM_CNT <= 1'b0;         
      else if ( Fz_MUL_InvM_flow_cnt_State  ==Fz_MUL_InvM_flow_cnt_BEGIN)
            Fz_MUL_InvM_CNT <= Fz_MUL_InvM_CNT+ 1'b1;  
      else              
            Fz_MUL_InvM_CNT  <= 1'b0;             
      end     
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Ax_MULA_T_flow_cnt_RST   = 5'b00001	,
           Ax_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Ax_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Ax_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Ax_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Ax_MULA_T_flow_cnt_State <= Ax_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Ax_MULA_T_flow_cnt_State)  
            Ax_MULA_T_flow_cnt_RST :
                begin
                      Ax_MULA_T_flow_cnt_State  <=Ax_MULA_T_flow_cnt_IDLE;
                end 
            Ax_MULA_T_flow_cnt_IDLE:
                begin
                  if (Ax_MULA_T_en)
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_BEGIN;
                  else
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_IDLE;
                  end 
            Ax_MULA_T_flow_cnt_BEGIN:
                 begin
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_CHK;
                 end 
            Ax_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Ax_MULA_T_get_vil &&( Ax_MULA_T_CNT == 5'd12))
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_END;
                     else
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_CHK;
                   end 
            Ax_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_IDLE;
                      else
                      Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Ax_MULA_T_flow_cnt_State <=Ax_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ax_MULA_T_A_out  <=  32'd0;         
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_BEGIN)      
            Ax_MULA_T_A_out  <= Vx_Home_in    ;
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_IDLE)      
            Ax_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ax_MULA_T_B_out  <=  32'd0;         
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_BEGIN)
            Ax_MULA_T_B_out  <= time_step    ;
      else   if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_IDLE)           
            Ax_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ax_MULA_T_A_Vil  <= 1'b0;          
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_BEGIN)
            Ax_MULA_T_A_Vil <= 1'b1;  
      else  if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_IDLE)            
            Ax_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ax_MULA_T_B_Vil <= 1'b0;         
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_BEGIN)
            Ax_MULA_T_B_Vil <= 1'b1;  
      else              
            Ax_MULA_T_B_Vil  <= 1'b0;             
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ax_MULA_T_CNT <= 1'b0;         
      else if ( Ax_MULA_T_flow_cnt_State  ==Ax_MULA_T_flow_cnt_BEGIN)
            Ax_MULA_T_CNT <= Ax_MULA_T_CNT+ 1'b1;  
      else              
            Ax_MULA_T_CNT  <= 1'b0;             
      end     
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Ay_MULA_T_flow_cnt_RST   = 5'b00001	,
           Ay_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Ay_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Ay_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Ay_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Ay_MULA_T_flow_cnt_State <= Ay_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Ay_MULA_T_flow_cnt_State)  
            Ay_MULA_T_flow_cnt_RST :
                begin
                      Ay_MULA_T_flow_cnt_State  <=Ay_MULA_T_flow_cnt_IDLE;
                end 
            Ay_MULA_T_flow_cnt_IDLE:
                begin
                  if (Ay_MULA_T_en)
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_BEGIN;
                  else
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_IDLE;
                  end 
            Ay_MULA_T_flow_cnt_BEGIN:
                 begin
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_CHK;
                 end 
            Ay_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Ay_MULA_T_get_vil &&( Ay_MULA_T_CNT == 5'd12))
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_END;
                     else
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_CHK;
                   end 
            Ay_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_IDLE;
                      else
                      Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Ay_MULA_T_flow_cnt_State <=Ay_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ay_MULA_T_A_out  <=  32'd0;         
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_BEGIN)      
            Ay_MULA_T_A_out  <= Vy_Home_in    ;
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_IDLE)      
            Ay_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ay_MULA_T_B_out  <=  32'd0;         
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_BEGIN)
            Ay_MULA_T_B_out  <= time_step    ;
      else   if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_IDLE)           
            Ay_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ay_MULA_T_A_Vil  <= 1'b0;          
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_BEGIN)
            Ay_MULA_T_A_Vil <= 1'b1;  
      else  if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_IDLE)            
            Ay_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ay_MULA_T_B_Vil <= 1'b0;         
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_BEGIN)
            Ay_MULA_T_B_Vil <= 1'b1;  
      else              
            Ay_MULA_T_B_Vil  <= 1'b0;             
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Ay_MULA_T_CNT <= 1'b0;         
      else if ( Ay_MULA_T_flow_cnt_State  ==Ay_MULA_T_flow_cnt_BEGIN)
            Ay_MULA_T_CNT <=  Ay_MULA_T_CNT + 1'b1;  
      else              
            Ay_MULA_T_CNT  <= 1'b0;             
      end     
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Az_MULA_T_flow_cnt_RST   = 5'b00001	,
           Az_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Az_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Az_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Az_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Az_MULA_T_flow_cnt_State <= Az_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Az_MULA_T_flow_cnt_State)  
            Az_MULA_T_flow_cnt_RST :
                begin
                      Az_MULA_T_flow_cnt_State  <=Az_MULA_T_flow_cnt_IDLE;
                end 
            Az_MULA_T_flow_cnt_IDLE:
                begin
                  if (Az_MULA_T_en)
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_BEGIN;
                  else
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_IDLE;
                  end 
            Az_MULA_T_flow_cnt_BEGIN:
                 begin
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_CHK;
                 end 
            Az_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Az_MULA_T_get_vil &&( Az_MULA_T_CNT == 5'd12))
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_END;
                     else
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_CHK;
                   end 
            Az_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_IDLE;
                      else
                      Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Az_MULA_T_flow_cnt_State <=Az_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Az_MULA_T_A_out  <=  32'd0;         
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_BEGIN)      
            Az_MULA_T_A_out  <= Vz_Home_in    ;
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_IDLE)      
            Az_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Az_MULA_T_B_out  <=  32'd0;         
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_BEGIN)
            Az_MULA_T_B_out  <= time_step    ;
      else   if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_IDLE)           
            Az_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Az_MULA_T_A_Vil  <= 1'b0;          
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_BEGIN)
            Az_MULA_T_A_Vil <= 1'b1;  
      else  if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_IDLE)            
            Az_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Az_MULA_T_B_Vil <= 1'b0;         
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_BEGIN)
            Az_MULA_T_B_Vil <= 1'b1;  
      else              
            Az_MULA_T_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Az_MULA_T_CNT <= 1'b0;         
      else if ( Az_MULA_T_flow_cnt_State  ==Az_MULA_T_flow_cnt_BEGIN)
            Az_MULA_T_CNT <=  Az_MULA_T_CNT + 1'b1;  
      else              
            Az_MULA_T_CNT  <= 1'b0;             
      end 

 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Vx_MULA_T_flow_cnt_RST   = 5'b00001	,
           Vx_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Vx_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Vx_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Vx_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Vx_MULA_T_flow_cnt_State <= Vx_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Vx_MULA_T_flow_cnt_State)  
            Vx_MULA_T_flow_cnt_RST :
                begin
                      Vx_MULA_T_flow_cnt_State  <=Vx_MULA_T_flow_cnt_IDLE;
                end 
            Vx_MULA_T_flow_cnt_IDLE:
                begin
                  if (Vx_MULA_T_en)
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_BEGIN;
                  else
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_IDLE;
                  end 
            Vx_MULA_T_flow_cnt_BEGIN:
                 begin
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_CHK;
                 end 
            Vx_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Vx_MULA_T_get_vil &&( Vx_MULA_T_CNT == 5'd12))
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_END;
                     else
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_CHK;
                   end 
            Vx_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_IDLE;
                      else
                      Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Vx_MULA_T_flow_cnt_State <=Vx_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vx_MULA_T_A_out  <=  32'd0;         
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_BEGIN)      
            Vx_MULA_T_A_out  <= Vx_Home_in    ;
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_IDLE)      
            Vx_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vx_MULA_T_B_out  <=  32'd0;         
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_BEGIN)
            Vx_MULA_T_B_out  <= time_step    ;
      else   if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_IDLE)           
            Vx_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vx_MULA_T_A_Vil  <= 1'b0;          
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_BEGIN)
            Vx_MULA_T_A_Vil <= 1'b1;  
      else  if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_IDLE)            
            Vx_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vx_MULA_T_B_Vil <= 1'b0;         
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_BEGIN)
            Vx_MULA_T_B_Vil <= 1'b1;  
      else              
            Vx_MULA_T_B_Vil  <= 1'b0;             
      end 
      
       
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vx_MULA_T_CNT <= 1'b0;         
      else if ( Vx_MULA_T_flow_cnt_State  ==Vx_MULA_T_flow_cnt_BEGIN)
            Vx_MULA_T_CNT <=  Vx_MULA_T_CNT +1'b1;  
      else              
            Vx_MULA_T_CNT  <= 1'b0;             
      end      
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Vy_MULA_T_flow_cnt_RST   = 5'b00001	,
           Vy_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Vy_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Vy_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Vy_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Vy_MULA_T_flow_cnt_State <= Vy_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Vy_MULA_T_flow_cnt_State)  
            Vy_MULA_T_flow_cnt_RST :
                begin
                      Vy_MULA_T_flow_cnt_State  <=Vy_MULA_T_flow_cnt_IDLE;
                end 
            Vy_MULA_T_flow_cnt_IDLE:
                begin
                  if (Vy_MULA_T_en)
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_BEGIN;
                  else
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_IDLE;
                  end 
            Vy_MULA_T_flow_cnt_BEGIN:
                 begin
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_CHK;
                 end 
            Vy_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Vy_MULA_T_get_vil &&( Vy_MULA_T_CNT == 5'd12))
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_END;
                     else
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_CHK;
                   end 
            Vy_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_IDLE;
                      else
                      Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Vy_MULA_T_flow_cnt_State <=Vy_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vy_MULA_T_A_out  <=  32'd0;         
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_BEGIN)      
            Vy_MULA_T_A_out  <= Vy_Home_in    ;
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_IDLE)      
            Vy_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vy_MULA_T_B_out  <=  32'd0;         
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_BEGIN)
            Vy_MULA_T_B_out  <= time_step    ;
      else   if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_IDLE)           
            Vy_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vy_MULA_T_A_Vil  <= 1'b0;          
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_BEGIN)
            Vy_MULA_T_A_Vil <= 1'b1;  
      else  if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_IDLE)            
            Vy_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vy_MULA_T_B_Vil <= 1'b0;         
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_BEGIN)
            Vy_MULA_T_B_Vil <= 1'b1;  
      else              
            Vy_MULA_T_B_Vil  <= 1'b0;             
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vy_MULA_T_CNT <= 1'b0;         
      else if ( Vy_MULA_T_flow_cnt_State  ==Vy_MULA_T_flow_cnt_BEGIN)
            Vy_MULA_T_CNT <=Vy_MULA_T_CNT+ 1'b1;  
      else              
            Vy_MULA_T_CNT  <= 1'b0;             
      end     
 //-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Vz_MULA_T_flow_cnt_RST   = 5'b00001	,
           Vz_MULA_T_flow_cnt_IDLE  = 5'b00010	,
           Vz_MULA_T_flow_cnt_BEGIN = 5'b00100	,
           Vz_MULA_T_flow_cnt_CHK   = 5'b01000	,
           Vz_MULA_T_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Vz_MULA_T_flow_cnt_State <= Vz_MULA_T_flow_cnt_RST;
     end 
      else begin 
           case( Vz_MULA_T_flow_cnt_State)  
            Vz_MULA_T_flow_cnt_RST :
                begin
                      Vz_MULA_T_flow_cnt_State  <=Vz_MULA_T_flow_cnt_IDLE;
                end 
            Vz_MULA_T_flow_cnt_IDLE:
                begin
                  if (Vz_MULA_T_en)
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_BEGIN;
                  else
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_IDLE;
                  end 
            Vz_MULA_T_flow_cnt_BEGIN:
                 begin
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_CHK;
                 end 
            Vz_MULA_T_flow_cnt_CHK:
                  begin
                     if ( Vz_MULA_T_get_vil &&( Vz_MULA_T_CNT == 5'd12))
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_END;
                     else
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_CHK;
                   end 
            Vz_MULA_T_flow_cnt_END:
                 begin        
                    if  ( Motion_Cal_Done )        
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_IDLE;
                      else
                      Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_END;
                 end     
                 
       default:       Vz_MULA_T_flow_cnt_State <=Vz_MULA_T_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vz_MULA_T_A_out  <=  32'd0;         
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_BEGIN)      
            Vz_MULA_T_A_out  <= Rx_Home_in    ;
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_IDLE)      
            Vz_MULA_T_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vz_MULA_T_B_out  <=  32'd0;         
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_BEGIN)
            Vz_MULA_T_B_out  <= time_step    ;
      else   if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_IDLE)           
            Vz_MULA_T_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vz_MULA_T_A_Vil  <= 1'b0;          
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_BEGIN)
            Vz_MULA_T_A_Vil <= 1'b1;  
      else  if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_IDLE)            
            Vz_MULA_T_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vz_MULA_T_B_Vil <= 1'b0;         
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_BEGIN)
            Vz_MULA_T_B_Vil <= 1'b1;  
      else              
            Vz_MULA_T_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Vz_MULA_T_CNT <= 1'b0;         
      else if ( Vz_MULA_T_flow_cnt_State  ==Vz_MULA_T_flow_cnt_BEGIN)
            Vz_MULA_T_CNT <= Vz_MULA_T_CNT + 1'b1;  
      else              
            Vz_MULA_T_CNT  <= 1'b0;             
      end 



endmodule
