`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2022 05:43:07 PM
// Design Name: 
// Module Name: Rd_cotr
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


module Rd_cotr(
               input                  Sys_Clk,
               input                  Sys_Rst_n,              
                //Ram to fifo 
               input                  Rd_cotr_en,//when new cell position updata
               input                  Home_Rd_finish,
                //Ram RD cor                     
               output  reg    [7:0]   M_AXIS_homeRam_rd_Addr,
               input          [255:0] S_AXIS_homeRam_tData  ,                        
               // to compare module
               output reg [31:0]      M_AXIS_X_Pos_buf,
               output reg [31:0]      M_AXIS_Y_Pos_buf,
               output reg [31:0]      M_AXIS_Z_Pos_buf,     
               output reg [159:0]     M_AXIS_Index_buf,              
           
               output reg             Get_XYZ     //                          
                                                            //  compare module ask xyz                                                                
    );
        
reg  [4:0]         Home_Rd_Rd_State;
reg                Get_XYZ_buff;
reg  [255:0]       M_AXIS_buf_Data ;

 localparam [4:0]
           Home_Rd_Rd_RST   = 5'b00001	,
           Home_Rd_Rd_IDLE  = 5'b00010	,
           Home_Rd_Rd_BEGIN = 5'b00100	,
           Home_Rd_Rd_CHK   = 5'b01000	,
           Home_Rd_Rd_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Home_Rd_Rd_State <= Home_Rd_Rd_RST;
     end 
      else begin 
           case( Home_Rd_Rd_State)  
            Home_Rd_Rd_RST :
                begin
                      Home_Rd_Rd_State  <=Home_Rd_Rd_IDLE;
                end 
            Home_Rd_Rd_IDLE:
                begin
                  if (Rd_cotr_en)
                      Home_Rd_Rd_State <=Home_Rd_Rd_BEGIN;
                  else
                      Home_Rd_Rd_State <=Home_Rd_Rd_IDLE;
                  end 
            Home_Rd_Rd_BEGIN:
                 begin
                      Home_Rd_Rd_State <=Home_Rd_Rd_CHK;
                 end 
            Home_Rd_Rd_CHK:
                  begin
                     Home_Rd_Rd_State <=Home_Rd_Rd_END;
                   end 
            Home_Rd_Rd_END:
                 begin        
                      Home_Rd_Rd_State <=Home_Rd_Rd_IDLE;
                 end     
                 
       default:       Home_Rd_Rd_State <=Home_Rd_Rd_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_homeRam_rd_Addr  <= 8'd0 ;         
      else if (Home_Rd_Rd_State==Home_Rd_Rd_BEGIN )
            M_AXIS_homeRam_rd_Addr  <= M_AXIS_homeRam_rd_Addr + 8'd1    ;
      else if (Home_Rd_finish)      
            M_AXIS_homeRam_rd_Addr  <= 8'd0    ;                    
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Get_XYZ_buff           <= 1'b0;           
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_CHK )
            Get_XYZ_buff           <= 1'b1;     
      else    if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)         
            Get_XYZ_buff           <= 1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_buf_Data            <= 256'd0 ;          
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_CHK )
            M_AXIS_buf_Data       <=    S_AXIS_homeRam_tData ;
      else   if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)          
            M_AXIS_buf_Data             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Index_buf            <= 160'd0 ;          
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_END )
            M_AXIS_Index_buf            <=   M_AXIS_buf_Data[255:96] ; 
      else   if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)          
            M_AXIS_Index_buf             <= 160'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_X_Pos_buf            <= 32'd0 ;          
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_END )
            M_AXIS_X_Pos_buf            <=   M_AXIS_buf_Data[95:64] ;  
      else   if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)          
            M_AXIS_X_Pos_buf             <= 256'd0 ;       
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Y_Pos_buf            <= 32'd0 ;          
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_END )
           M_AXIS_Y_Pos_buf            <=   M_AXIS_buf_Data[63:32] ;    
      else   if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)          
            M_AXIS_Y_Pos_buf             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Z_Pos_buf            <= 32'd0 ;          
      else if (  Home_Rd_Rd_State ==Home_Rd_Rd_END )
            M_AXIS_Z_Pos_buf            <=   M_AXIS_buf_Data[31:0] ;
      else   if (  Home_Rd_Rd_State  ==Home_Rd_Rd_IDLE)          
            M_AXIS_Z_Pos_buf             <= 256'd0 ;       
      end 


endmodule
