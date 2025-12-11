`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2022 05:43:07 PM
// Design Name: 
// Module Name: Subram_Rd_cotr
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


module Subram_Rd_cotr(
               input                  Sys_Clk,
               input                  Sys_Rst_n,              
                //Ram to fifo 
               input                  Subcell_Rd_en,//when new cell position updata
                //Ram RD cor                     
               output  reg    [7:0]   M_AXIS_homeRam_rd_Addr,
               input          [255:0] S_AXIS_homeRam_tData  ,
               input                  Subcell_finish  ,
               input                  Home0_cell_cal_finish,
               // to compare module
               output reg [31:0]      M_AXIS_X_Pos_buf,
               output reg [31:0]      M_AXIS_Y_Pos_buf,
               output reg [31:0]      M_AXIS_Z_Pos_buf,     
               output reg [159:0]     M_AXIS_Index_buf,              
           
               output reg             M_AXIS_COMP_Begin     //                          
                                                            //  compare module ask xyz                                                                
    );
        
reg  [4:0]         Subcell_Rd_State;
reg                M_AXIS_COMP_Begin_buff;
reg  [255:0]       M_AXIS_buf_Data ;

 localparam [4:0]
           Subcell_Rd_RST   = 5'b00001	,
           Subcell_Rd_IDLE  = 5'b00010	,
           Subcell_Rd_BEGIN = 5'b00100	,
           Subcell_Rd_CHK   = 5'b01000	,
           Subcell_Rd_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Subcell_Rd_State <= Subcell_Rd_RST;
     end 
      else begin 
           case( Subcell_Rd_State)  
            Subcell_Rd_RST :
                begin
                      Subcell_Rd_State  <=Subcell_Rd_IDLE;
                end 
            Subcell_Rd_IDLE:
                begin
                  if (Subcell_Rd_en)
                      Subcell_Rd_State <=Subcell_Rd_BEGIN;
                  else
                      Subcell_Rd_State <=Subcell_Rd_IDLE;
                  end 
            Subcell_Rd_BEGIN:
                 begin
                      Subcell_Rd_State <=Subcell_Rd_CHK;
                 end 
            Subcell_Rd_CHK:
                  begin
                     Subcell_Rd_State <=Subcell_Rd_END;
                   end 
            Subcell_Rd_END:
                 begin        
                      Subcell_Rd_State <=Subcell_Rd_IDLE;
                 end     
                 
       default:       Subcell_Rd_State <=Subcell_Rd_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_homeRam_rd_Addr  <= 8'd0 ;         
      else if (Subcell_Rd_State==Subcell_Rd_BEGIN )
            M_AXIS_homeRam_rd_Addr  <= M_AXIS_homeRam_rd_Addr + 8'd1    ;
      else if (Subcell_finish)      
            M_AXIS_homeRam_rd_Addr  <= 8'd0    ;                    
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_COMP_Begin_buff           <= 1'b0;           
      else if (  Subcell_Rd_State ==Subcell_Rd_CHK )
            M_AXIS_COMP_Begin_buff           <= 1'b1;     
      else    if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)         
            M_AXIS_COMP_Begin_buff           <= 1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_buf_Data            <= 256'd0 ;          
      else if (  Subcell_Rd_State ==Subcell_Rd_CHK )
            M_AXIS_buf_Data       <=    S_AXIS_homeRam_tData ;
      else   if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)          
            M_AXIS_buf_Data             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Index_buf            <= 160'd0 ;          
      else if (  Subcell_Rd_State ==Subcell_Rd_END )
            M_AXIS_Index_buf            <=   M_AXIS_buf_Data[255:96] ; 
      else   if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)          
            M_AXIS_Index_buf             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_X_Pos_buf            <= 32'd0 ;          
      else if (  Subcell_Rd_State ==Subcell_Rd_END )
             M_AXIS_X_Pos_buf            <=   M_AXIS_buf_Data[95:64] ;  
      else   if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)          
            M_AXIS_X_Pos_buf             <= 256'd0 ;       
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Y_Pos_buf            <= 32'd0 ;          
      else if (  Subcell_Rd_State ==Subcell_Rd_END )
           M_AXIS_Y_Pos_buf            <=   M_AXIS_buf_Data[63:32] ;    
      else   if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)          
            M_AXIS_Y_Pos_buf             <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Z_Pos_buf            <= 32'd0 ;          
      else if (  Subcell_Rd_State ==Subcell_Rd_END )
             M_AXIS_Z_Pos_buf            <=   M_AXIS_buf_Data[31:0] ;
      else   if (  Subcell_Rd_State  ==Subcell_Rd_IDLE)          
            M_AXIS_Z_Pos_buf             <= 256'd0 ;       
      end 

//------------------------------------------------------------

always@( Home0_cell_cal_finish, Sys_Rst_n,M_AXIS_COMP_Begin_buff)  begin
  if (!Sys_Rst_n) 
          M_AXIS_COMP_Begin      <=  1'b0;         
   else if ( Home0_cell_cal_finish) 
          M_AXIS_COMP_Begin     <=   1'b0;                       
   else  
          M_AXIS_COMP_Begin    <=  M_AXIS_COMP_Begin_buff;        
end

endmodule
