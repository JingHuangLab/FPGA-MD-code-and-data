`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2023 06:22:38 PM
// Design Name: 
// Module Name: READ_from_Cache
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


module READ_from_Cache(
  input                         Sys_Clk  ,         
  input                         Sys_Rst_n,  
  input                         Bond_buf_Data_en,       
  input         [31:0]          Filter_R2_INDEX ,//
  
 output reg     [31:0]          B0,
 output reg     [31:0]          KB,
 
 output reg     [31:0]          N,
 output reg     [31:0]          Fai,     
 output reg     [31:0]          DIR_KThate,
 output reg     [31:0]          Sigma,
 
 output reg     [31:0]          Angle_KThate,
 output reg     [31:0]          Thate0,     
 
 output reg     [31:0]          Komiga,
 output reg     [31:0]          Omiga0  
 
    );
    
    
reg  [4:0]         Bond_Rd_State;
reg                Get_XYZ_buff;
reg  [255:0]       Bond_buf_Data ;
reg  [31:0]        Bond_buf_DataRam_rd_Addr;
reg  [31:0]        Bond_buf_DataRam_tData;
reg                Bond_finish;
 localparam [4:0]
           Bond_Rd_RST   = 5'b00001	,
           Bond_Rd_IDLE  = 5'b00010	,
           Bond_Rd_BEGIN = 5'b00100	,
           Bond_Rd_CHK   = 5'b01000	,
           Bond_Rd_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Bond_Rd_State <= Bond_Rd_RST;
     end 
      else begin 
           case( Bond_Rd_State)  
            Bond_Rd_RST :
                begin
                      Bond_Rd_State  <=Bond_Rd_IDLE;
                end 
            Bond_Rd_IDLE:
                begin
                  if (Bond_buf_Data_en)
                      Bond_Rd_State <=Bond_Rd_BEGIN;
                  else
                      Bond_Rd_State <=Bond_Rd_IDLE;
                  end 
            Bond_Rd_BEGIN:
                 begin
                      Bond_Rd_State <=Bond_Rd_CHK;
                 end 
            Bond_Rd_CHK:
                  begin
                     Bond_Rd_State <=Bond_Rd_END;
                   end 
            Bond_Rd_END:
                 begin        
                      Bond_Rd_State <=Bond_Rd_IDLE;
                 end     
                 
       default:       Bond_Rd_State <=Bond_Rd_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Bond_buf_DataRam_rd_Addr  <= 8'd0 ;         
      else if (Bond_Rd_State==Bond_Rd_BEGIN )
            Bond_buf_DataRam_rd_Addr  <= Filter_R2_INDEX *4   ;
      else if (Bond_finish)      
            Bond_buf_DataRam_rd_Addr  <= 8'd0    ;                    
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Get_XYZ_buff           <= 1'b0;           
      else if (  Bond_Rd_State ==Bond_Rd_CHK )
            Get_XYZ_buff           <= 1'b1;     
      else    if (  Bond_Rd_State  ==Bond_Rd_IDLE)         
            Get_XYZ_buff           <= 1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Bond_buf_Data            <= 256'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_CHK )
            Bond_buf_Data       <=    Bond_buf_DataRam_tData ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Bond_buf_Data             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B0            <= 160'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            B0            <=   Bond_buf_Data[255:96] ; 
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            B0             <= 160'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KB            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            KB            <=   Bond_buf_Data[95:64] ;  
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            KB             <= 256'd0 ;       
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
           N            <=   Bond_buf_Data[63:32] ;    
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            N             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Fai            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Fai            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Fai             <= 256'd0 ;       
      end 
    
         
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DIR_KThate            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            DIR_KThate            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            DIR_KThate             <= 256'd0 ;       
      end 
     
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Sigma            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Sigma             <= 256'd0 ;       
      end 
        
         
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_KThate            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Angle_KThate            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Angle_KThate             <= 256'd0 ;       
      end 
    
         
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate0            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Thate0            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Thate0             <= 256'd0 ;       
      end 
     
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Komiga            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Komiga            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Komiga             <= 256'd0 ;       
      end 
         
        
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga0            <= 32'd0 ;          
      else if (  Bond_Rd_State ==Bond_Rd_END )
            Omiga0            <=   Bond_buf_Data[31:0] ;
      else   if (  Bond_Rd_State  ==Bond_Rd_IDLE)          
            Omiga0             <= 256'd0 ;       
      end 
          
    
    
    
    
endmodule
