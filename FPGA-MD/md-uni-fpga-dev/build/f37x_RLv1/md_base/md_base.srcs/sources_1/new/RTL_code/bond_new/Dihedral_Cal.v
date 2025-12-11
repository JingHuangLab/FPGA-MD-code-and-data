`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:54:34 PM
// Design Name: 
// Module Name: Dihedral_Cal
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


module Dihedral_Cal (
 input                    Sys_Clk  ,
 input                    Sys_Rst_n,
 input     [31:0]          N,
 input     [31:0]          Fai,     
 input     [31:0]          R2_Root,
 input     [31:0]          KThate,
 input     [31:0]          Sigma,
  output reg [31:0]        Dih_Add_BUF,
      //X to caculation sub unit 
 output reg [31:0]     N_Mul_A_out , //n * fai
 output reg            N_Mul_A_Vil ,
 output reg            N_Mul_B_Vil ,
 output reg [31:0]     N_Mul_B_out ,
 input      [31:0]     N_Mul_get_r ,
 input                 N_Mul_get_vil ,
 
      //X to caculation sub unit 
 output reg [31:0]     Sigma_Sub_A_out , //n * fai -sigma
 output reg            Sigma_Sub_A_Vil ,
 output reg            Sigma_Sub_B_Vil ,
 output reg [31:0]     Sigma_Sub_B_out ,
 input      [31:0]     Sigma_Sub_get_r ,
 input                 Sigma_Sub_get_vil ,
 
       //X to caculation sub unit          
 output reg [31:0]     nsubsigma_Cos_A_out ,  //cos(n * fai -sigma) 
 output reg            nsubsigma_Cos_A_Vil ,   
 input      [31:0]     nsubsigma_Cos_get_r ,  
 input                 nsubsigma_Cos_get_vil ,
 
       //X to caculation sub unit 
 output reg [31:0]     one_Add_A_out , //1+cos(n * fai -sigma)  
 output reg            one_Add_A_Vil ,
 output reg            one_Add_B_Vil ,
 output reg [31:0]     one_Add_B_out ,
 input      [31:0]     one_Add_get_r ,
 input                 one_Add_get_vil,
 
        //X to caculation sub unit 
 output reg [31:0]     Kthate_Mul_A_out ,//kthate(1+cos(n * fai -sigma) )
 output reg            Kthate_Mul_A_Vil ,
 output reg            Kthate_Mul_B_Vil ,
 output reg [31:0]     Kthate_Mul_B_out ,
 input      [31:0]     Kthate_Mul_get_r ,
 input                 Kthate_Mul_get_vil ,
 
        //X to caculation sub unit 
 output reg [31:0]     Dih_Add_A_out , //1+cos(n * fai -sigma)  
 output reg            Dih_Add_A_Vil ,
 output reg            Dih_Add_B_Vil ,
 output reg [31:0]     Dih_Add_B_out ,
 input      [31:0]     Dih_Add_get_r ,
 input                 Dih_Add_get_vil   
    );    
reg          Force_Sub_Done;
   
reg          N_Mul_en;
reg [31:0]   N_Mul;
reg          N_Mul_done;
reg [6:0]    N_Mul_CNT;
reg [6:0]    N_Mul_flow_cnt_State;   

reg          Sigma_Sub_en;
reg [31:0]   Sigma_Sub;
reg          Sigma_Sub_done;
reg [6:0]    Sigma_Sub_CNT;
reg [6:0]    Sigma_Sub_flow_cnt_State;

reg          Kthate_Mul_en;
reg [31:0]   Kthate_Mul;
reg          Kthate_Mul_done;
reg [6:0]    Kthate_Mul_CNT;
reg [6:0]    Kthate_Mul_flow_cnt_State;

reg          one_Add_en;
reg [31:0]   one_Add;
reg          one_Add_done;
reg [6:0]    one_Add_CNT;
reg [6:0]    one_Add_flow_cnt_State;

reg          nsubsigma_Cos_en;
reg [31:0]   nsubsigma_Cos;
reg          nsubsigma_Cos_done;
reg [6:0]    nsubsigma_Cos_CNT;
reg [6:0]    nsubsigma_Cos_flow_cnt_State;

reg          Dih_Add_en;
reg [31:0]   Dih_Add;
reg          Dih_Add_done;
reg [6:0]    Dih_Add_CNT;
reg [6:0]    Dih_Add_flow_cnt_State;

//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           N_Mul_flow_cnt_RST   = 5'b00001	,
           N_Mul_flow_cnt_IDLE  = 5'b00010	,
           N_Mul_flow_cnt_BEGIN = 5'b00100	,
           N_Mul_flow_cnt_CHK   = 5'b01000	,
           N_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       N_Mul_flow_cnt_State <= N_Mul_flow_cnt_RST;
     end 
      else begin 
           case( N_Mul_flow_cnt_State)  
            N_Mul_flow_cnt_RST :
                begin
                      N_Mul_flow_cnt_State  <=N_Mul_flow_cnt_IDLE;
                end 
            N_Mul_flow_cnt_IDLE:
                begin
                  if (N_Mul_en)
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_BEGIN;
                  else
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_IDLE;
                  end 
            N_Mul_flow_cnt_BEGIN:
                 begin
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_CHK;
                 end 
            N_Mul_flow_cnt_CHK:
                  begin
                     if ( N_Mul_get_vil &&( N_Mul_CNT == 5'd12))
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_END;
                     else
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_CHK;
                   end 
            N_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_IDLE;
                      else
                      N_Mul_flow_cnt_State <=N_Mul_flow_cnt_END;
                 end     
                 
       default:       N_Mul_flow_cnt_State <=N_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_A_out  <=  32'd0;         
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_BEGIN)      
            N_Mul_A_out  <=  R2_Root  ;
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_IDLE)      
            N_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_B_out  <=  32'd0;         
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_BEGIN)
            N_Mul_B_out  <=    N;
      else   if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_IDLE)           
            N_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_A_Vil  <= 1'b0;          
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_BEGIN)
            N_Mul_A_Vil <= 1'b1;  
      else  if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_IDLE)            
            N_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_B_Vil <= 1'b0;         
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_BEGIN)
            N_Mul_B_Vil <= 1'b1;  
      else              
            N_Mul_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul             <=  32'd0;          
      else if ( N_Mul_get_vil &&( N_Mul_CNT == 5'd12))
            N_Mul             <=  N_Mul_get_r;
      else   if (  N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_IDLE)          
            N_Mul             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_done           <= 1'b0;            
      else if ( N_Mul_get_vil &&( N_Mul_CNT == 5'd12))
            N_Mul_done           <= 1'b1;       
      else     
            N_Mul_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            N_Mul_CNT  <=  5'd0;         
      else if ( N_Mul_flow_cnt_State  ==N_Mul_flow_cnt_CHK)      
            N_Mul_CNT  <= N_Mul_CNT + 5'd1  ;
      else 
            N_Mul_CNT   <=  5'd0;              
      end  
    
//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           Sigma_Sub_flow_cnt_RST   = 5'b00001	,
           Sigma_Sub_flow_cnt_IDLE  = 5'b00010	,
           Sigma_Sub_flow_cnt_BEGIN = 5'b00100	,
           Sigma_Sub_flow_cnt_CHK   = 5'b01000	,
           Sigma_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Sigma_Sub_flow_cnt_State <= Sigma_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Sigma_Sub_flow_cnt_State)  
            Sigma_Sub_flow_cnt_RST :
                begin
                      Sigma_Sub_flow_cnt_State  <=Sigma_Sub_flow_cnt_IDLE;
                end 
            Sigma_Sub_flow_cnt_IDLE:
                begin
                  if (Sigma_Sub_en)
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_BEGIN;
                  else
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_IDLE;
                  end 
            Sigma_Sub_flow_cnt_BEGIN:
                 begin
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_CHK;
                 end 
            Sigma_Sub_flow_cnt_CHK:
                  begin
                     if ( Sigma_Sub_get_vil &&( Sigma_Sub_CNT == 5'd12))
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_END;
                     else
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_CHK;
                   end 
            Sigma_Sub_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_IDLE;
                      else
                      Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_END;
                 end     
                 
       default:       Sigma_Sub_flow_cnt_State <=Sigma_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_A_out  <=  32'd0;         
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_BEGIN)      
            Sigma_Sub_A_out  <=  R2_Root  ;
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_IDLE)      
            Sigma_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_B_out  <=  32'd0;         
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_BEGIN)
            Sigma_Sub_B_out  <=    Sigma;
      else   if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_IDLE)           
            Sigma_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_A_Vil  <= 1'b0;          
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_BEGIN)
            Sigma_Sub_A_Vil <= 1'b1;  
      else  if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_IDLE)            
            Sigma_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_B_Vil <= 1'b0;         
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_BEGIN)
            Sigma_Sub_B_Vil <= 1'b1;  
      else              
            Sigma_Sub_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub             <=  32'd0;          
      else if ( Sigma_Sub_get_vil &&( Sigma_Sub_CNT == 5'd12))
            Sigma_Sub             <=  Sigma_Sub_get_r;
      else   if (  Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_IDLE)          
            Sigma_Sub             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_done           <= 1'b0;            
      else if ( Sigma_Sub_get_vil &&( Sigma_Sub_CNT == 5'd12))
            Sigma_Sub_done           <= 1'b1;       
      else     
            Sigma_Sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sigma_Sub_CNT  <=  5'd0;         
      else if ( Sigma_Sub_flow_cnt_State  ==Sigma_Sub_flow_cnt_CHK)      
            Sigma_Sub_CNT  <= Sigma_Sub_CNT + 5'd1  ;
      else 
            Sigma_Sub_CNT   <=  5'd0;              
      end  
 //-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           nsubsigma_Cos_flow_cnt_RST   = 5'b00001	,
           nsubsigma_Cos_flow_cnt_IDLE  = 5'b00010	,
           nsubsigma_Cos_flow_cnt_BEGIN = 5'b00100	,
           nsubsigma_Cos_flow_cnt_CHK   = 5'b01000	,
           nsubsigma_Cos_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       nsubsigma_Cos_flow_cnt_State <= nsubsigma_Cos_flow_cnt_RST;
     end 
      else begin 
           case( nsubsigma_Cos_flow_cnt_State)  
            nsubsigma_Cos_flow_cnt_RST :
                begin
                      nsubsigma_Cos_flow_cnt_State  <=nsubsigma_Cos_flow_cnt_IDLE;
                end 
            nsubsigma_Cos_flow_cnt_IDLE:
                begin
                  if (nsubsigma_Cos_en)
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_BEGIN;
                  else
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_IDLE;
                  end 
            nsubsigma_Cos_flow_cnt_BEGIN:
                 begin
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_CHK;
                 end 
            nsubsigma_Cos_flow_cnt_CHK:
                  begin
                     if ( nsubsigma_Cos_get_vil &&( nsubsigma_Cos_CNT == 5'd12))
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_END;
                     else
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_CHK;
                   end 
            nsubsigma_Cos_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_IDLE;
                      else
                      nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_END;
                 end     
                 
       default:       nsubsigma_Cos_flow_cnt_State <=nsubsigma_Cos_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            nsubsigma_Cos_A_out  <=  32'd0;         
      else if ( nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_BEGIN)      
            nsubsigma_Cos_A_out  <=    Sigma_Sub  ;
      else if ( nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_IDLE)      
            nsubsigma_Cos_A_out  <= 32'd0;             
      end 
      


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            nsubsigma_Cos_A_Vil  <= 1'b0;          
      else if ( nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_BEGIN)
            nsubsigma_Cos_A_Vil <= 1'b1;  
      else  if ( nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_IDLE)            
            nsubsigma_Cos_A_Vil  <= 1'b0;               
      end 
      

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            nsubsigma_Cos             <=  32'd0;          
      else if ( nsubsigma_Cos_get_vil &&( nsubsigma_Cos_CNT == 5'd12))
            nsubsigma_Cos             <=  nsubsigma_Cos_get_r;
      else   if (  nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_IDLE)          
            nsubsigma_Cos             <= 32'd0;       
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            nsubsigma_Cos_done           <= 1'b0;            
      else if ( nsubsigma_Cos_get_vil &&( nsubsigma_Cos_CNT == 5'd12))
            nsubsigma_Cos_done           <= 1'b1;       
      else     
            nsubsigma_Cos_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            nsubsigma_Cos_CNT  <=  5'd0;         
      else if ( nsubsigma_Cos_flow_cnt_State  ==nsubsigma_Cos_flow_cnt_CHK)      
            nsubsigma_Cos_CNT  <= nsubsigma_Cos_CNT + 5'd1  ;
      else 
            nsubsigma_Cos_CNT   <=  5'd0;              
      end       
    
      
  //-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------



localparam [4:0]
           Kthate_Mul_flow_cnt_RST   = 5'b00001	,
           Kthate_Mul_flow_cnt_IDLE  = 5'b00010	,
           Kthate_Mul_flow_cnt_BEGIN = 5'b00100	,
           Kthate_Mul_flow_cnt_CHK   = 5'b01000	,
           Kthate_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Kthate_Mul_flow_cnt_State <= Kthate_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Kthate_Mul_flow_cnt_State)  
            Kthate_Mul_flow_cnt_RST :
                begin
                      Kthate_Mul_flow_cnt_State  <=Kthate_Mul_flow_cnt_IDLE;
                end 
            Kthate_Mul_flow_cnt_IDLE:
                begin
                  if (Kthate_Mul_en)
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_BEGIN;
                  else
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_IDLE;
                  end 
            Kthate_Mul_flow_cnt_BEGIN:
                 begin
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_CHK;
                 end 
            Kthate_Mul_flow_cnt_CHK:
                  begin
                     if ( Kthate_Mul_get_vil &&( Kthate_Mul_CNT == 5'd12))
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_END;
                     else
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_CHK;
                   end 
            Kthate_Mul_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_IDLE;
                      else
                      Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_END;
                 end     
                 
       default:       Kthate_Mul_flow_cnt_State <=Kthate_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_A_out  <=  32'd0;         
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_BEGIN)      
            Kthate_Mul_A_out  <=   KThate  ;
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_IDLE)      
            Kthate_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_B_out  <=  32'd0;         
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_BEGIN)
            Kthate_Mul_B_out  <=     Sigma_Sub ;
      else   if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_IDLE)           
            Kthate_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_A_Vil  <= 1'b0;          
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_BEGIN)
            Kthate_Mul_A_Vil <= 1'b1;  
      else  if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_IDLE)            
            Kthate_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_B_Vil <= 1'b0;         
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_BEGIN)
            Kthate_Mul_B_Vil <= 1'b1;  
      else              
            Kthate_Mul_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul             <=  32'd0;          
      else if ( Kthate_Mul_get_vil &&( Kthate_Mul_CNT == 5'd12))
            Kthate_Mul             <=  Kthate_Mul_get_r;
      else   if (  Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_IDLE)          
            Kthate_Mul             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_done           <= 1'b0;            
      else if ( Kthate_Mul_get_vil &&( Kthate_Mul_CNT == 5'd12))
            Kthate_Mul_done           <= 1'b1;       
      else     
            Kthate_Mul_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kthate_Mul_CNT  <=  5'd0;         
      else if ( Kthate_Mul_flow_cnt_State  ==Kthate_Mul_flow_cnt_CHK)      
            Kthate_Mul_CNT  <= Kthate_Mul_CNT + 5'd1  ;
      else 
            Kthate_Mul_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           one_Add_flow_cnt_RST   = 5'b00001	,
           one_Add_flow_cnt_IDLE  = 5'b00010	,
           one_Add_flow_cnt_BEGIN = 5'b00100	,
           one_Add_flow_cnt_CHK   = 5'b01000	,
           one_Add_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       one_Add_flow_cnt_State <= one_Add_flow_cnt_RST;
     end 
      else begin 
           case( one_Add_flow_cnt_State)  
            one_Add_flow_cnt_RST :
                begin
                      one_Add_flow_cnt_State  <=one_Add_flow_cnt_IDLE;
                end 
            one_Add_flow_cnt_IDLE:
                begin
                  if (one_Add_en)
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_BEGIN;
                  else
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_IDLE;
                  end 
            one_Add_flow_cnt_BEGIN:
                 begin
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_CHK;
                 end 
            one_Add_flow_cnt_CHK:
                  begin
                     if ( one_Add_get_vil &&( one_Add_CNT == 5'd12))
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_END;
                     else
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_CHK;
                   end 
            one_Add_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_IDLE;
                      else
                      one_Add_flow_cnt_State <=one_Add_flow_cnt_END;
                 end     
                 
       default:       one_Add_flow_cnt_State <=one_Add_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_A_out  <=  32'd0;         
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_BEGIN)      
            one_Add_A_out  <=    one_Add  ;
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_IDLE)      
            one_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_B_out  <=  32'd0;         
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_BEGIN)
            one_Add_B_out  <=     Kthate_Mul ;
      else   if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_IDLE)           
            one_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_A_Vil  <= 1'b0;          
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_BEGIN)
            one_Add_A_Vil <= 1'b1;  
      else  if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_IDLE)            
            one_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_B_Vil <= 1'b0;         
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_BEGIN)
            one_Add_B_Vil <= 1'b1;  
      else              
            one_Add_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add             <=  32'd0;          
      else if ( one_Add_get_vil &&( one_Add_CNT == 5'd12))
            one_Add             <=  one_Add_get_r;
      else   if (  one_Add_flow_cnt_State  ==one_Add_flow_cnt_IDLE)          
            one_Add             <= 32'd0;       
      end 
   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_done           <= 1'b0;            
      else if ( one_Add_get_vil &&( one_Add_CNT == 5'd12))
            one_Add_done           <= 1'b1;       
      else     
            one_Add_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            one_Add_CNT  <=  5'd0;         
      else if ( one_Add_flow_cnt_State  ==one_Add_flow_cnt_CHK)      
            one_Add_CNT  <= one_Add_CNT + 5'd1  ;
      else 
            one_Add_CNT   <=  5'd0;              
      end       
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           Dih_Add_flow_cnt_RST   = 5'b00001	,
           Dih_Add_flow_cnt_IDLE  = 5'b00010	,
           Dih_Add_flow_cnt_BEGIN = 5'b00100	,
           Dih_Add_flow_cnt_CHK   = 5'b01000	,
           Dih_Add_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Dih_Add_flow_cnt_State <= Dih_Add_flow_cnt_RST;
     end 
      else begin 
           case( Dih_Add_flow_cnt_State)  
            Dih_Add_flow_cnt_RST :
                begin
                      Dih_Add_flow_cnt_State  <=Dih_Add_flow_cnt_IDLE;
                end 
            Dih_Add_flow_cnt_IDLE:
                begin
                  if (Dih_Add_en)
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_BEGIN;
                  else
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_IDLE;
                  end 
            Dih_Add_flow_cnt_BEGIN:
                 begin
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_CHK;
                 end 
            Dih_Add_flow_cnt_CHK:
                  begin
                     if ( Dih_Add_get_vil &&( Dih_Add_CNT == 5'd12))
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_END;
                     else
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_CHK;
                   end 
            Dih_Add_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_IDLE;
                      else
                      Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_END;
                 end     
                 
       default:       Dih_Add_flow_cnt_State <=Dih_Add_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_A_out  <=  32'd0;         
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_BEGIN)      
            Dih_Add_A_out  <=    Dih_Add  ;
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_IDLE)      
            Dih_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_B_out  <=  32'd0;         
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_BEGIN)
            Dih_Add_B_out  <=     one_Add ;
      else   if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_IDLE)           
            Dih_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_A_Vil  <= 1'b0;          
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_BEGIN)
            Dih_Add_A_Vil <= 1'b1;  
      else  if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_IDLE)            
            Dih_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_B_Vil <= 1'b0;         
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_BEGIN)
            Dih_Add_B_Vil <= 1'b1;  
      else              
            Dih_Add_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add             <=  32'd0;          
      else if ( Dih_Add_get_vil &&( Dih_Add_CNT == 5'd12))
            Dih_Add             <=  Dih_Add_get_r;
      else   if (  Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_IDLE)          
            Dih_Add             <= 32'd0;       
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_BUF             <=  32'd0;          
      else if ( Dih_Add_get_vil &&( Dih_Add_CNT == 5'd12))
            Dih_Add_BUF             <=  Dih_Add_get_r;
      else  if (  Force_Sub_Done)          
            Dih_Add_BUF             <= 32'd0;       
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_done           <= 1'b0;            
      else if ( Dih_Add_get_vil &&( Dih_Add_CNT == 5'd12))
            Dih_Add_done           <= 1'b1;       
      else     
            Dih_Add_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Dih_Add_CNT  <=  5'd0;         
      else if ( Dih_Add_flow_cnt_State  ==Dih_Add_flow_cnt_CHK)      
            Dih_Add_CNT  <= Dih_Add_CNT + 5'd1  ;
      else 
            Dih_Add_CNT   <=  5'd0;              
      end       
        
       
endmodule
