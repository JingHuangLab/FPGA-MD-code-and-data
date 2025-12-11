`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:26:44 PM
// Design Name: 
// Module Name: Angle_Cal
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


module Angle_Cal(
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
  
 input     [31:0]          KThate,
 input     [31:0]          Thate0,     
 
 input     [31:0]          R2_Root,
  output reg [31:0]       Angle_Add_BUF,
     //X to caculation sub unit 
 output reg [31:0]     Thate_Sub_A_out ,
 output reg            Thate_Sub_A_Vil ,
 output reg            Thate_Sub_B_Vil ,
 output reg [31:0]     Thate_Sub_B_out ,
 input      [31:0]     Thate_Sub_get_r ,
 input                 Thate_Sub_get_vil ,
 
      //X to caculation sub unit 
 output reg [31:0]     KThate_MUl_A_out ,
 output reg            KThate_MUl_A_Vil ,
 output reg            KThate_MUl_B_Vil ,
 output reg [31:0]     KThate_MUl_B_out ,
 input      [31:0]     KThate_MUl_get_r ,
 input                 KThate_MUl_get_vil ,
 
       //X to caculation sub unit 
 output reg [31:0]     Angle_Add_A_out ,
 output reg            Angle_Add_A_Vil ,
 output reg            Angle_Add_B_Vil ,
 output reg [31:0]     Angle_Add_B_out ,
 input      [31:0]     Angle_Add_get_r ,
 input                 Angle_Add_get_vil  
 
    );
    
   reg          Force_Sub_Done;
    

reg          Thate_Sub_en;
reg [31:0]   Thate_Sub;
reg          Thate_Sub_done;
reg [6:0]    Thate_Sub_CNT;
reg [6:0]    Thate_Sub_flow_cnt_State;

reg          KThate_MUl_en;
reg [31:0]   KThate_MUl;
reg          KThate_MUl_done;
reg [6:0]    KThate_MUl_CNT;
reg [6:0]    KThate_MUl_flow_cnt_State;

reg          Angle_Add_en;
reg [31:0]   Angle_Add;
reg          Angle_Add_done;
reg [6:0]    Angle_Add_CNT;
reg [6:0]    Angle_Add_flow_cnt_State;

//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           Thate_Sub_flow_cnt_RST   = 5'b00001	,
           Thate_Sub_flow_cnt_IDLE  = 5'b00010	,
           Thate_Sub_flow_cnt_BEGIN = 5'b00100	,
           Thate_Sub_flow_cnt_CHK   = 5'b01000	,
           Thate_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Thate_Sub_flow_cnt_State <= Thate_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Thate_Sub_flow_cnt_State)  
            Thate_Sub_flow_cnt_RST :
                begin
                      Thate_Sub_flow_cnt_State  <=Thate_Sub_flow_cnt_IDLE;
                end 
            Thate_Sub_flow_cnt_IDLE:
                begin
                  if (Thate_Sub_en)
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_BEGIN;
                  else
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_IDLE;
                  end 
            Thate_Sub_flow_cnt_BEGIN:
                 begin
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_CHK;
                 end 
            Thate_Sub_flow_cnt_CHK:
                  begin
                     if ( Thate_Sub_get_vil &&( Thate_Sub_CNT == 5'd12))
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_END;
                     else
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_CHK;
                   end 
            Thate_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_IDLE;
                      else
                      Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_END;
                 end     
                 
       default:       Thate_Sub_flow_cnt_State <=Thate_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_A_out  <=  32'd0;         
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_BEGIN)      
            Thate_Sub_A_out  <=  R2_Root  ;
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_IDLE)      
            Thate_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_B_out  <=  32'd0;         
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_BEGIN)
            Thate_Sub_B_out  <=    Thate0;
      else   if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_IDLE)           
            Thate_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_A_Vil  <= 1'b0;          
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_BEGIN)
            Thate_Sub_A_Vil <= 1'b1;  
      else  if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_IDLE)            
            Thate_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_B_Vil <= 1'b0;         
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_BEGIN)
            Thate_Sub_B_Vil <= 1'b1;  
      else              
            Thate_Sub_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub             <=  32'd0;          
      else if ( Thate_Sub_get_vil &&( Thate_Sub_CNT == 5'd12))
            Thate_Sub             <=  Thate_Sub_get_r;
      else   if (  Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_IDLE)          
            Thate_Sub             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_done           <= 1'b0;            
      else if ( Thate_Sub_get_vil &&( Thate_Sub_CNT == 5'd12))
            Thate_Sub_done           <= 1'b1;       
      else     
            Thate_Sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Thate_Sub_CNT  <=  5'd0;         
      else if ( Thate_Sub_flow_cnt_State  ==Thate_Sub_flow_cnt_CHK)      
            Thate_Sub_CNT  <= Thate_Sub_CNT + 5'd1  ;
      else 
            Thate_Sub_CNT   <=  5'd0;              
      end  
  //-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           KThate_MUl_flow_cnt_RST   = 5'b00001	,
           KThate_MUl_flow_cnt_IDLE  = 5'b00010	,
           KThate_MUl_flow_cnt_BEGIN = 5'b00100	,
           KThate_MUl_flow_cnt_CHK   = 5'b01000	,
           KThate_MUl_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       KThate_MUl_flow_cnt_State <= KThate_MUl_flow_cnt_RST;
     end 
      else begin 
           case( KThate_MUl_flow_cnt_State)  
            KThate_MUl_flow_cnt_RST :
                begin
                      KThate_MUl_flow_cnt_State  <=KThate_MUl_flow_cnt_IDLE;
                end 
            KThate_MUl_flow_cnt_IDLE:
                begin
                  if (KThate_MUl_en)
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_BEGIN;
                  else
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_IDLE;
                  end 
            KThate_MUl_flow_cnt_BEGIN:
                 begin
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_CHK;
                 end 
            KThate_MUl_flow_cnt_CHK:
                  begin
                     if ( KThate_MUl_get_vil &&( KThate_MUl_CNT == 5'd12))
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_END;
                     else
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_CHK;
                   end 
            KThate_MUl_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_IDLE;
                      else
                      KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_END;
                 end     
                 
       default:       KThate_MUl_flow_cnt_State <=KThate_MUl_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_A_out  <=  32'd0;         
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_BEGIN)      
            KThate_MUl_A_out  <=   KThate  ;
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_IDLE)      
            KThate_MUl_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_B_out  <=  32'd0;         
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_BEGIN)
            KThate_MUl_B_out  <=     Thate_Sub ;
      else   if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_IDLE)           
            KThate_MUl_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_A_Vil  <= 1'b0;          
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_BEGIN)
            KThate_MUl_A_Vil <= 1'b1;  
      else  if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_IDLE)            
            KThate_MUl_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_B_Vil <= 1'b0;         
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_BEGIN)
            KThate_MUl_B_Vil <= 1'b1;  
      else              
            KThate_MUl_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl             <=  32'd0;          
      else if ( KThate_MUl_get_vil &&( KThate_MUl_CNT == 5'd12))
            KThate_MUl             <=  KThate_MUl_get_r;
      else   if (  KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_IDLE)          
            KThate_MUl             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_done           <= 1'b0;            
      else if ( KThate_MUl_get_vil &&( KThate_MUl_CNT == 5'd12))
            KThate_MUl_done           <= 1'b1;       
      else     
            KThate_MUl_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KThate_MUl_CNT  <=  5'd0;         
      else if ( KThate_MUl_flow_cnt_State  ==KThate_MUl_flow_cnt_CHK)      
            KThate_MUl_CNT  <= KThate_MUl_CNT + 5'd1  ;
      else 
            KThate_MUl_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           Angle_Add_flow_cnt_RST   = 5'b00001	,
           Angle_Add_flow_cnt_IDLE  = 5'b00010	,
           Angle_Add_flow_cnt_BEGIN = 5'b00100	,
           Angle_Add_flow_cnt_CHK   = 5'b01000	,
           Angle_Add_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Angle_Add_flow_cnt_State <= Angle_Add_flow_cnt_RST;
     end 
      else begin 
           case( Angle_Add_flow_cnt_State)  
            Angle_Add_flow_cnt_RST :
                begin
                      Angle_Add_flow_cnt_State  <=Angle_Add_flow_cnt_IDLE;
                end 
            Angle_Add_flow_cnt_IDLE:
                begin
                  if (Angle_Add_en)
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_BEGIN;
                  else
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_IDLE;
                  end 
            Angle_Add_flow_cnt_BEGIN:
                 begin
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_CHK;
                 end 
            Angle_Add_flow_cnt_CHK:
                  begin
                     if ( Angle_Add_get_vil &&( Angle_Add_CNT == 5'd12))
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_END;
                     else
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_CHK;
                   end 
            Angle_Add_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_IDLE;
                      else
                      Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_END;
                 end     
                 
       default:       Angle_Add_flow_cnt_State <=Angle_Add_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_A_out  <=  32'd0;         
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_BEGIN)      
            Angle_Add_A_out  <=    Angle_Add  ;
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_IDLE)      
            Angle_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_B_out  <=  32'd0;         
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_BEGIN)
            Angle_Add_B_out  <=     KThate_MUl ;
      else   if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_IDLE)           
            Angle_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_A_Vil  <= 1'b0;          
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_BEGIN)
            Angle_Add_A_Vil <= 1'b1;  
      else  if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_IDLE)            
            Angle_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_B_Vil <= 1'b0;         
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_BEGIN)
            Angle_Add_B_Vil <= 1'b1;  
      else              
            Angle_Add_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add             <=  32'd0;          
      else if ( Angle_Add_get_vil &&( Angle_Add_CNT == 5'd12))
            Angle_Add             <=  Angle_Add_get_r;
      else   if (  Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_IDLE)          
            Angle_Add             <= 32'd0;       
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_BUF             <=  32'd0;          
      else if ( Angle_Add_get_vil &&( Angle_Add_CNT == 5'd12))
            Angle_Add_BUF             <=  Angle_Add_get_r;
      else  if (  Force_Sub_Done)          
            Angle_Add_BUF             <= 32'd0;       
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_done           <= 1'b0;            
      else if ( Angle_Add_get_vil &&( Angle_Add_CNT == 5'd12))
            Angle_Add_done           <= 1'b1;       
      else     
            Angle_Add_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Angle_Add_CNT  <=  5'd0;         
      else if ( Angle_Add_flow_cnt_State  ==Angle_Add_flow_cnt_CHK)      
            Angle_Add_CNT  <= Angle_Add_CNT + 5'd1  ;
      else 
            Angle_Add_CNT   <=  5'd0;              
      end       
    
    
endmodule
