`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2022 06:00:28 PM
// Design Name: 
// Module Name: Col_dir_Moudle
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


module Col_dir_Moudle(
 input                     Sys_Clk  ,
 input                     Sys_Rst_n,

 input    [31:0]           ParaM_X_A,// X= rr      
 input    [31:0]           ParaM_A, 
 
 output reg    [31:0]      ParaM_Aab,      
 output reg    [31:0]      ParaM_Bab, 
 output reg    [31:0]      ParaM_QQab,
  
 output reg     [31:0]     ParaM_R_14_C1,      
 output reg     [31:0]     ParaM_R_14_C0, 
 
 output reg     [31:0]     ParaM_R_8_C1,      
 output reg     [31:0]     ParaM_R_8_C0,
 
 output reg   [31:0]       ParaM_R_3_C1,      
 output reg   [31:0]       ParaM_R_3_C0 , 
input                      M_AXIS_Force_done,
input                      Home0_cell_cal_finish,

input                      S_AXIS_COMP_Begin     ,       //previous input, enable XYZ buf  
input                      S_AXIS_COMP_2_Begin   ,       //previous input, enable XYZ buf  

input         [159:0]      S_AXIS_home_Index_buf,    
 input        [159:0]      S_AXIS_Index_buf                
    );
    
 reg  [159:0]   Index_Pos_home_buf;
 reg  [159:0]   Index_Pos_nei_buf;
 // ---------------------------------------- -----------------------      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         Index_Pos_home_buf        <=  160'd0;  
 else if (  S_AXIS_COMP_Begin )
         Index_Pos_home_buf        <=  S_AXIS_home_Index_buf    ;   
 else  if (Home0_cell_cal_finish)     
         Index_Pos_home_buf        <=  160'd0;              
 end 
    
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         Index_Pos_nei_buf        <=  160'd0;  
 else if (  S_AXIS_COMP_2_Begin )
         Index_Pos_nei_buf        <=  S_AXIS_Index_buf    ;   
 else if (M_AXIS_Force_done)        
         Index_Pos_nei_buf        <=  160'd0;              
 end     
   // ---------------------------------------- -----------------------      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_Aab        <=  32'd0;  
 else if (M_AXIS_Force_done)        
         ParaM_Aab        <=  32'd0;   
 else  //  
         ParaM_Aab        <=  32'h4AECEA5E;
            
 end     
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_Bab        <=  32'd0; 
 else  if (M_AXIS_Force_done)       
         ParaM_Bab        <=  32'd0;    
 else 
         ParaM_Bab        <= 32'h45A8731A ;  
           
 end      
    
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_QQab        <=  32'd0;  
 else  if (M_AXIS_Force_done)       
         ParaM_QQab        <=  32'd0;  
 else  
         ParaM_QQab        <= 32'h4D7AD374 ; 
            
 end      

 
 
 
endmodule
