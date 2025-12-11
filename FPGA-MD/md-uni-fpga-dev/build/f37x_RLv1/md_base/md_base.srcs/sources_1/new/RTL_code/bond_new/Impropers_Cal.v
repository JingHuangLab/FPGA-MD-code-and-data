`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:45:18 PM
// Design Name: 
// Module Name: Impropers_Cal
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


module Impropers_Cal(
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
  
 input     [31:0]          Komiga,
 input     [31:0]          Omiga0,     
 
 input     [31:0]          R2_Root,
  output reg [31:0]    Impropers_Add_BUF,
     //X to caculation sub unit 
 output reg [31:0]     Omiga_Sub_A_out ,
 output reg            Omiga_Sub_A_Vil ,
 output reg            Omiga_Sub_B_Vil ,
 output reg [31:0]     Omiga_Sub_B_out ,
 input      [31:0]     Omiga_Sub_get_r ,
 input                 Omiga_Sub_get_vil ,
 
      //X to caculation sub unit 
 output reg [31:0]     KOmiga_MUl_A_out ,
 output reg            KOmiga_MUl_A_Vil ,
 output reg            KOmiga_MUl_B_Vil ,
 output reg [31:0]     KOmiga_MUl_B_out ,
 input      [31:0]     KOmiga_MUl_get_r ,
 input                 KOmiga_MUl_get_vil ,
 
       //X to caculation sub unit 
 output reg [31:0]     Impropers_Add_A_out ,
 output reg            Impropers_Add_A_Vil ,
 output reg            Impropers_Add_B_Vil ,
 output reg [31:0]     Impropers_Add_B_out ,
 input      [31:0]     Impropers_Add_get_r ,
 input                 Impropers_Add_get_vil  
 
    );
    
      reg          Impropers_Cal_Done;
    

reg          Omiga_Sub_en;
reg [31:0]   Omiga_Sub;
reg          Omiga_Sub_done;
reg [6:0]    Omiga_Sub_CNT;
reg [6:0]    Omiga_Sub_flow_cnt_State;

reg          KOmiga_MUl_en;
reg [31:0]   KOmiga_MUl;
reg          KOmiga_MUl_done;
reg [6:0]    KOmiga_MUl_CNT;
reg [6:0]    KOmiga_MUl_flow_cnt_State;

reg          Impropers_Add_en;
reg [31:0]   Impropers_Add;
reg          Impropers_Add_done;
reg [6:0]    Impropers_Add_CNT;
reg [6:0]    Impropers_Add_flow_cnt_State;

//reg [31:0]    Impropers_Add_BUF;


    
//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           Omiga_Sub_flow_cnt_RST   = 5'b00001	,
           Omiga_Sub_flow_cnt_IDLE  = 5'b00010	,
           Omiga_Sub_flow_cnt_BEGIN = 5'b00100	,
           Omiga_Sub_flow_cnt_CHK   = 5'b01000	,
           Omiga_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Omiga_Sub_flow_cnt_State <= Omiga_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Omiga_Sub_flow_cnt_State)  
            Omiga_Sub_flow_cnt_RST :
                begin
                      Omiga_Sub_flow_cnt_State  <=Omiga_Sub_flow_cnt_IDLE;
                end 
            Omiga_Sub_flow_cnt_IDLE:
                begin
                  if (Omiga_Sub_en)
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_BEGIN;
                  else
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_IDLE;
                  end 
            Omiga_Sub_flow_cnt_BEGIN:
                 begin
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_CHK;
                 end 
            Omiga_Sub_flow_cnt_CHK:
                  begin
                     if ( Omiga_Sub_get_vil &&( Omiga_Sub_CNT == 5'd12))
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_END;
                     else
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_CHK;
                   end 
            Omiga_Sub_flow_cnt_END:
                 begin        
                    if  ( Impropers_Cal_Done )        
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_IDLE;
                      else
                      Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_END;
                 end     
                 
       default:       Omiga_Sub_flow_cnt_State <=Omiga_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_A_out  <=  32'd0;         
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_BEGIN)      
            Omiga_Sub_A_out  <=  R2_Root  ;
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_IDLE)      
            Omiga_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_B_out  <=  32'd0;         
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_BEGIN)
            Omiga_Sub_B_out  <=    Omiga0;
      else   if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_IDLE)           
            Omiga_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_A_Vil  <= 1'b0;          
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_BEGIN)
            Omiga_Sub_A_Vil <= 1'b1;  
      else  if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_IDLE)            
            Omiga_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_B_Vil <= 1'b0;         
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_BEGIN)
            Omiga_Sub_B_Vil <= 1'b1;  
      else              
            Omiga_Sub_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub             <=  32'd0;          
      else if ( Omiga_Sub_get_vil &&( Omiga_Sub_CNT == 5'd12))
            Omiga_Sub             <=  Omiga_Sub_get_r;
      else   if (  Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_IDLE)          
            Omiga_Sub             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_done           <= 1'b0;            
      else if ( Omiga_Sub_get_vil &&( Omiga_Sub_CNT == 5'd12))
            Omiga_Sub_done           <= 1'b1;       
      else     
            Omiga_Sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Omiga_Sub_CNT  <=  5'd0;         
      else if ( Omiga_Sub_flow_cnt_State  ==Omiga_Sub_flow_cnt_CHK)      
            Omiga_Sub_CNT  <= Omiga_Sub_CNT + 5'd1  ;
      else 
            Omiga_Sub_CNT   <=  5'd0;              
      end  
  //-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           KOmiga_MUl_flow_cnt_RST   = 5'b00001	,
           KOmiga_MUl_flow_cnt_IDLE  = 5'b00010	,
           KOmiga_MUl_flow_cnt_BEGIN = 5'b00100	,
           KOmiga_MUl_flow_cnt_CHK   = 5'b01000	,
           KOmiga_MUl_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       KOmiga_MUl_flow_cnt_State <= KOmiga_MUl_flow_cnt_RST;
     end 
      else begin 
           case( KOmiga_MUl_flow_cnt_State)  
            KOmiga_MUl_flow_cnt_RST :
                begin
                      KOmiga_MUl_flow_cnt_State  <=KOmiga_MUl_flow_cnt_IDLE;
                end 
            KOmiga_MUl_flow_cnt_IDLE:
                begin
                  if (KOmiga_MUl_en)
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_BEGIN;
                  else
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_IDLE;
                  end 
            KOmiga_MUl_flow_cnt_BEGIN:
                 begin
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_CHK;
                 end 
            KOmiga_MUl_flow_cnt_CHK:
                  begin
                     if ( KOmiga_MUl_get_vil &&( KOmiga_MUl_CNT == 5'd12))
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_END;
                     else
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_CHK;
                   end 
            KOmiga_MUl_flow_cnt_END:
                 begin        
                    if  ( Impropers_Cal_Done )        
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_IDLE;
                      else
                      KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_END;
                 end     
                 
       default:       KOmiga_MUl_flow_cnt_State <=KOmiga_MUl_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_A_out  <=  32'd0;         
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_BEGIN)      
            KOmiga_MUl_A_out  <=   Komiga  ;
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_IDLE)      
            KOmiga_MUl_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_B_out  <=  32'd0;         
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_BEGIN)
            KOmiga_MUl_B_out  <=     Omiga_Sub ;
      else   if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_IDLE)           
            KOmiga_MUl_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_A_Vil  <= 1'b0;          
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_BEGIN)
            KOmiga_MUl_A_Vil <= 1'b1;  
      else  if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_IDLE)            
            KOmiga_MUl_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_B_Vil <= 1'b0;         
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_BEGIN)
            KOmiga_MUl_B_Vil <= 1'b1;  
      else              
            KOmiga_MUl_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl             <=  32'd0;          
      else if ( KOmiga_MUl_get_vil &&( KOmiga_MUl_CNT == 5'd12))
            KOmiga_MUl             <=  KOmiga_MUl_get_r;
      else   if (  KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_IDLE)          
            KOmiga_MUl             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_done           <= 1'b0;            
      else if ( KOmiga_MUl_get_vil &&( KOmiga_MUl_CNT == 5'd12))
            KOmiga_MUl_done           <= 1'b1;       
      else     
            KOmiga_MUl_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            KOmiga_MUl_CNT  <=  5'd0;         
      else if ( KOmiga_MUl_flow_cnt_State  ==KOmiga_MUl_flow_cnt_CHK)      
            KOmiga_MUl_CNT  <= KOmiga_MUl_CNT + 5'd1  ;
      else 
            KOmiga_MUl_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           Impropers_Add_flow_cnt_RST   = 5'b00001	,
           Impropers_Add_flow_cnt_IDLE  = 5'b00010	,
           Impropers_Add_flow_cnt_BEGIN = 5'b00100	,
           Impropers_Add_flow_cnt_CHK   = 5'b01000	,
           Impropers_Add_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Impropers_Add_flow_cnt_State <= Impropers_Add_flow_cnt_RST;
     end 
      else begin 
           case( Impropers_Add_flow_cnt_State)  
            Impropers_Add_flow_cnt_RST :
                begin
                      Impropers_Add_flow_cnt_State  <=Impropers_Add_flow_cnt_IDLE;
                end 
            Impropers_Add_flow_cnt_IDLE:
                begin
                  if (Impropers_Add_en)
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_BEGIN;
                  else
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_IDLE;
                  end 
            Impropers_Add_flow_cnt_BEGIN:
                 begin
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_CHK;
                 end 
            Impropers_Add_flow_cnt_CHK:
                  begin
                     if ( Impropers_Add_get_vil &&( Impropers_Add_CNT == 5'd12))
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_END;
                     else
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_CHK;
                   end 
            Impropers_Add_flow_cnt_END:
                 begin        
                    if  ( Impropers_Cal_Done )        
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_IDLE;
                      else
                      Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_END;
                 end     
                 
       default:       Impropers_Add_flow_cnt_State <=Impropers_Add_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_A_out  <=  32'd0;         
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_BEGIN)      
            Impropers_Add_A_out  <=    Impropers_Add  ;
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_IDLE)      
            Impropers_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_B_out  <=  32'd0;         
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_BEGIN)
            Impropers_Add_B_out  <=     KOmiga_MUl ;
      else   if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_IDLE)           
            Impropers_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_A_Vil  <= 1'b0;          
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_BEGIN)
            Impropers_Add_A_Vil <= 1'b1;  
      else  if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_IDLE)            
            Impropers_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_B_Vil <= 1'b0;         
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_BEGIN)
            Impropers_Add_B_Vil <= 1'b1;  
      else              
            Impropers_Add_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add             <=  32'd0;          
      else if ( Impropers_Add_get_vil &&( Impropers_Add_CNT == 5'd12))
            Impropers_Add             <=  Impropers_Add_get_r;
      else   if (  Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_IDLE)          
            Impropers_Add             <= 32'd0;       
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_BUF             <=  32'd0;          
      else if ( Impropers_Add_get_vil &&( Impropers_Add_CNT == 5'd12))
            Impropers_Add_BUF             <=  Impropers_Add_get_r;
      else  if (  Impropers_Cal_Done)          
            Impropers_Add_BUF             <= 32'd0;       
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_done           <= 1'b0;            
      else if ( Impropers_Add_get_vil &&( Impropers_Add_CNT == 5'd12))
            Impropers_Add_done           <= 1'b1;       
      else     
            Impropers_Add_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Impropers_Add_CNT  <=  5'd0;         
      else if ( Impropers_Add_flow_cnt_State  ==Impropers_Add_flow_cnt_CHK)      
            Impropers_Add_CNT  <= Impropers_Add_CNT + 5'd1  ;
      else 
            Impropers_Add_CNT   <=  5'd0;              
      end       
    
    
endmodule
