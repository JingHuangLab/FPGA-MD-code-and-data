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
 input                  Sys_Clk  ,
 input                  Sys_Rst_n,

output   reg [31:0]     ParaM_A_LJ,      
output   reg [31:0]     ParaM_B_LJ,      
output   reg [31:0]     ParaM_A_LJ_Force ,      
output   reg [31:0]     ParaM_B_LJ_Force ,  

output  reg [31:0]      ParaM_Ene_Col    ,      
output  reg [31:0]      ParaM_Ene_Force  ,   
input                   M_AXIS_Force_done,
input                   Home0_cell_cal_finish,

input                   S_AXIS_COMP_Begin     ,       //previous input, enable XYZ buf  
input                   S_AXIS_COMP_2_Begin   ,       //previous input, enable XYZ buf  

input         [159:0]  S_AXIS_home_Index_buf,    
 input        [159:0]  S_AXIS_Index_buf                
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
         ParaM_A_LJ        <=  32'd0;  
 else if (M_AXIS_Force_done)        
         ParaM_A_LJ        <=  32'd0;   
 else  //  
         ParaM_A_LJ        <=  32'h4AECEA5E;
            
 end     
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_B_LJ        <=  32'd0; 
 else  if (M_AXIS_Force_done)       
         ParaM_B_LJ        <=  32'd0;    
 else 
         ParaM_B_LJ        <= 32'h45A8731A ;  
           
 end      
    
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_A_LJ_Force        <=  32'd0;  
 else  if (M_AXIS_Force_done)       
         ParaM_A_LJ_Force        <=  32'd0;  
 else  
         ParaM_A_LJ_Force        <= 32'h4D7AD374 ; 
            
 end      
    
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_B_LJ_Force        <=  32'd0;  
  else if (M_AXIS_Force_done)        
         ParaM_B_LJ_Force        <=  32'd0; 
 else 
         ParaM_B_LJ_Force        <=   32'h47B25713 ;      
             
 end      
      
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_Ene_Col        <=  32'd0;  
  else if (M_AXIS_Force_done)        
         ParaM_Ene_Col        <=  32'd0; 
 else 
         ParaM_Ene_Col        <=   32'h47B25713 ;      
             
 end      
       
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
         ParaM_Ene_Force        <=  32'd0;  
  else if (M_AXIS_Force_done)        
         ParaM_Ene_Force        <=  32'd0; 
 else 
         ParaM_Ene_Force        <=   32'h47B25713 ;      
             
 end      
             
     // ---------------------------------------- ----------------------- 

  
 
 
 
endmodule
