`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 03:36:48 PM
// Design Name: 
// Module Name: Bond_Cal
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


module Bond_Cal(
 input                     Sys_Clk  ,
 input                     Sys_Rst_n,
 
 input     [31:0]          Filter_R2,
 input     [31:0]          B0,
 input     [31:0]          KB,
 
output reg [31:0]          R2_Root ,
output reg [31:0]          B_Add_BUF ,
 
    //X to caculation sub unit 
 output reg [31:0]     R2_Root_A_out ,
 output reg            R2_Root_A_Vil ,
 input      [31:0]     R2_Root_get_r ,
 input                 R2_Root_get_vil ,
    
     //X to caculation sub unit 
 output reg [31:0]     B_Sub_A_out ,
 output reg            B_Sub_A_Vil ,
 output reg            B_Sub_B_Vil ,
 output reg [31:0]     B_Sub_B_out ,
 input      [31:0]     B_Sub_get_r ,
 input                 B_Sub_get_vil ,
 
      //X to caculation sub unit 
 output reg [31:0]     Kb_MUl_A_out ,
 output reg            Kb_MUl_A_Vil ,
 output reg            Kb_MUl_B_Vil ,
 output reg [31:0]     Kb_MUl_B_out ,
 input      [31:0]     Kb_MUl_get_r ,
 input                 Kb_MUl_get_vil ,
 
       //X to caculation sub unit 
 output reg [31:0]     B_Add_A_out ,
 output reg            B_Add_A_Vil ,
 output reg            B_Add_B_Vil ,
 output reg [31:0]     B_Add_B_out ,
 input      [31:0]     B_Add_get_r ,
 input                 B_Add_get_vil  

    );
reg          Bond_Cal_Done;
    
reg [6:0]    R2_Root_flow_cnt_State;
reg          R2_Root_en;
reg [6:0]    R2_Root_CNT;
reg          R2_Root_Done;    
reg          Bond_Done;

reg          B_Sub_en;
reg [31:0]   B_Sub;
reg          B_Sub_done;
reg [6:0]    B_Sub_CNT;
reg [6:0]    B_Sub_flow_cnt_State;

reg          Kb_MUl_en;
reg [31:0]   Kb_MUl;
reg          Kb_MUl_done;
reg [6:0]    Kb_MUl_CNT;
reg [6:0]    Kb_MUl_flow_cnt_State;

reg          B_Add_en;
reg [31:0]   B_Add;
reg          B_Add_done;
reg [6:0]    B_Add_CNT;
reg [6:0]    B_Add_flow_cnt_State;
//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           R2_Root_flow_cnt_RST   = 5'b00001	,
           R2_Root_flow_cnt_IDLE  = 5'b00010	,
           R2_Root_flow_cnt_BEGIN = 5'b00100	,
           R2_Root_flow_cnt_CHK   = 5'b01000	,
           R2_Root_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       R2_Root_flow_cnt_State <= R2_Root_flow_cnt_RST;
     end 
      else begin 
           case( R2_Root_flow_cnt_State)  
            R2_Root_flow_cnt_RST :
                begin
                      R2_Root_flow_cnt_State  <=R2_Root_flow_cnt_IDLE;
                end 
            R2_Root_flow_cnt_IDLE:
                begin
                  if (R2_Root_en)
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_BEGIN;
                  else
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_IDLE;
                  end 
            R2_Root_flow_cnt_BEGIN:
                 begin
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_CHK;
                 end 
            R2_Root_flow_cnt_CHK:
                  begin
                     if (( R2_Root_get_vil) &&( R2_Root_CNT == 5'd12))
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_END;
                     else
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_CHK;
                   end 
            R2_Root_flow_cnt_END:
                 begin        
                    if  ( Bond_Done )        
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_IDLE;
                      else
                      R2_Root_flow_cnt_State <=R2_Root_flow_cnt_END;
                 end     
                 
       default:       R2_Root_flow_cnt_State <=R2_Root_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R2_Root_A_out  <=  32'd0;         
      else if ( R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_BEGIN)      
            R2_Root_A_out  <=   Filter_R2   ;
      else if ( R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_IDLE)      
            R2_Root_A_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R2_Root_A_Vil  <= 1'b0;          
      else if ( R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_BEGIN)
            R2_Root_A_Vil <= 1'b1;  
      else  if ( R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_IDLE)            
            R2_Root_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R2_Root_Done           <= 1'b0;            
      else if ( R2_Root_get_vil &&( R2_Root_CNT == 5'd12))
            R2_Root_Done           <= 1'b1;       
      else     
            R2_Root_Done           <= 1'b0;              
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R2_Root             <=  32'd0;          
      else if ( R2_Root_get_vil &&( R2_Root_CNT == 5'd12))
            R2_Root             <=  R2_Root_get_r;
      else   if (  R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_IDLE)          
            R2_Root             <= 32'd0;       
      end
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            R2_Root_CNT  <=  5'd0;         
      else if ( R2_Root_flow_cnt_State  ==R2_Root_flow_cnt_CHK)      
            R2_Root_CNT  <= R2_Root_CNT + 5'd1  ;
      else 
            R2_Root_CNT   <=  5'd0;              
      end 
    
//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           B_Sub_flow_cnt_RST   = 5'b00001	,
           B_Sub_flow_cnt_IDLE  = 5'b00010	,
           B_Sub_flow_cnt_BEGIN = 5'b00100	,
           B_Sub_flow_cnt_CHK   = 5'b01000	,
           B_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       B_Sub_flow_cnt_State <= B_Sub_flow_cnt_RST;
     end 
      else begin 
           case( B_Sub_flow_cnt_State)  
            B_Sub_flow_cnt_RST :
                begin
                      B_Sub_flow_cnt_State  <=B_Sub_flow_cnt_IDLE;
                end 
            B_Sub_flow_cnt_IDLE:
                begin
                  if (B_Sub_en)
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_BEGIN;
                  else
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_IDLE;
                  end 
            B_Sub_flow_cnt_BEGIN:
                 begin
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_CHK;
                 end 
            B_Sub_flow_cnt_CHK:
                  begin
                     if ( B_Sub_get_vil &&( B_Sub_CNT == 5'd12))
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_END;
                     else
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_CHK;
                   end 
            B_Sub_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_IDLE;
                      else
                      B_Sub_flow_cnt_State <=B_Sub_flow_cnt_END;
                 end     
                 
       default:       B_Sub_flow_cnt_State <=B_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_A_out  <=  32'd0;         
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_BEGIN)      
            B_Sub_A_out  <=  R2_Root  ;
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_IDLE)      
            B_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_B_out  <=  32'd0;         
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_BEGIN)
            B_Sub_B_out  <=     B0 ;
      else   if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_IDLE)           
            B_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_A_Vil  <= 1'b0;          
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_BEGIN)
            B_Sub_A_Vil <= 1'b1;  
      else  if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_IDLE)            
            B_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_B_Vil <= 1'b0;         
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_BEGIN)
            B_Sub_B_Vil <= 1'b1;  
      else              
            B_Sub_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub             <=  32'd0;          
      else if ( B_Sub_get_vil &&( B_Sub_CNT == 5'd12))
            B_Sub             <=  B_Sub_get_r;
      else   if (  B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_IDLE)          
            B_Sub             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_done           <= 1'b0;            
      else if ( B_Sub_get_vil &&( B_Sub_CNT == 5'd12))
            B_Sub_done           <= 1'b1;       
      else     
            B_Sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Sub_CNT  <=  5'd0;         
      else if ( B_Sub_flow_cnt_State  ==B_Sub_flow_cnt_CHK)      
            B_Sub_CNT  <= B_Sub_CNT + 5'd1  ;
      else 
            B_Sub_CNT   <=  5'd0;              
      end  
  //-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           Kb_MUl_flow_cnt_RST   = 5'b00001	,
           Kb_MUl_flow_cnt_IDLE  = 5'b00010	,
           Kb_MUl_flow_cnt_BEGIN = 5'b00100	,
           Kb_MUl_flow_cnt_CHK   = 5'b01000	,
           Kb_MUl_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Kb_MUl_flow_cnt_State <= Kb_MUl_flow_cnt_RST;
     end 
      else begin 
           case( Kb_MUl_flow_cnt_State)  
            Kb_MUl_flow_cnt_RST :
                begin
                      Kb_MUl_flow_cnt_State  <=Kb_MUl_flow_cnt_IDLE;
                end 
            Kb_MUl_flow_cnt_IDLE:
                begin
                  if (Kb_MUl_en)
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_BEGIN;
                  else
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_IDLE;
                  end 
            Kb_MUl_flow_cnt_BEGIN:
                 begin
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_CHK;
                 end 
            Kb_MUl_flow_cnt_CHK:
                  begin
                     if ( Kb_MUl_get_vil &&( Kb_MUl_CNT == 5'd12))
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_END;
                     else
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_CHK;
                   end 
            Kb_MUl_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_IDLE;
                      else
                      Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_END;
                 end     
                 
       default:       Kb_MUl_flow_cnt_State <=Kb_MUl_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_A_out  <=  32'd0;         
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_BEGIN)      
            Kb_MUl_A_out  <=    KB  ;
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_IDLE)      
            Kb_MUl_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_B_out  <=  32'd0;         
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_BEGIN)
            Kb_MUl_B_out  <=     B_Sub ;
      else   if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_IDLE)           
            Kb_MUl_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_A_Vil  <= 1'b0;          
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_BEGIN)
            Kb_MUl_A_Vil <= 1'b1;  
      else  if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_IDLE)            
            Kb_MUl_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_B_Vil <= 1'b0;         
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_BEGIN)
            Kb_MUl_B_Vil <= 1'b1;  
      else              
            Kb_MUl_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl             <=  32'd0;          
      else if ( Kb_MUl_get_vil &&( Kb_MUl_CNT == 5'd12))
            Kb_MUl             <=  Kb_MUl_get_r;
      else   if (  Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_IDLE)          
            Kb_MUl             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_done           <= 1'b0;            
      else if ( Kb_MUl_get_vil &&( Kb_MUl_CNT == 5'd12))
            Kb_MUl_done           <= 1'b1;       
      else     
            Kb_MUl_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Kb_MUl_CNT  <=  5'd0;         
      else if ( Kb_MUl_flow_cnt_State  ==Kb_MUl_flow_cnt_CHK)      
            Kb_MUl_CNT  <= Kb_MUl_CNT + 5'd1  ;
      else 
            Kb_MUl_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           B_Add_flow_cnt_RST   = 5'b00001	,
           B_Add_flow_cnt_IDLE  = 5'b00010	,
           B_Add_flow_cnt_BEGIN = 5'b00100	,
           B_Add_flow_cnt_CHK   = 5'b01000	,
           B_Add_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       B_Add_flow_cnt_State <= B_Add_flow_cnt_RST;
     end 
      else begin 
           case( B_Add_flow_cnt_State)  
            B_Add_flow_cnt_RST :
                begin
                      B_Add_flow_cnt_State  <=B_Add_flow_cnt_IDLE;
                end 
            B_Add_flow_cnt_IDLE:
                begin
                  if (B_Add_en)
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_BEGIN;
                  else
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_IDLE;
                  end 
            B_Add_flow_cnt_BEGIN:
                 begin
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_CHK;
                 end 
            B_Add_flow_cnt_CHK:
                  begin
                     if ( B_Add_get_vil &&( B_Add_CNT == 5'd12))
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_END;
                     else
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_CHK;
                   end 
            B_Add_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_IDLE;
                      else
                      B_Add_flow_cnt_State <=B_Add_flow_cnt_END;
                 end     
                 
       default:       B_Add_flow_cnt_State <=B_Add_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_A_out  <=  32'd0;         
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_BEGIN)      
            B_Add_A_out  <=    B_Add  ;
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_IDLE)      
            B_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_B_out  <=  32'd0;         
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_BEGIN)
            B_Add_B_out  <=     Kb_MUl ;
      else   if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_IDLE)           
            B_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_A_Vil  <= 1'b0;          
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_BEGIN)
            B_Add_A_Vil <= 1'b1;  
      else  if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_IDLE)            
            B_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_B_Vil <= 1'b0;         
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_BEGIN)
            B_Add_B_Vil <= 1'b1;  
      else              
            B_Add_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add             <=  32'd0;          
      else if ( B_Add_get_vil &&( B_Add_CNT == 5'd12))
            B_Add             <=  B_Add_get_r;
      else   if (  B_Add_flow_cnt_State  ==B_Add_flow_cnt_IDLE)          
            B_Add             <= 32'd0;       
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_BUF             <=  32'd0;          
      else if ( B_Add_get_vil &&( B_Add_CNT == 5'd12))
            B_Add_BUF             <=  B_Add_get_r;
      else  if (  Bond_Cal_Done)          
            B_Add_BUF             <= 32'd0;       
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_done           <= 1'b0;            
      else if ( B_Add_get_vil &&( B_Add_CNT == 5'd12))
            B_Add_done           <= 1'b1;       
      else     
            B_Add_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_Add_CNT  <=  5'd0;         
      else if ( B_Add_flow_cnt_State  ==B_Add_flow_cnt_CHK)      
            B_Add_CNT  <= B_Add_CNT + 5'd1  ;
      else 
            B_Add_CNT   <=  5'd0;              
      end      
endmodule
