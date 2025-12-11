`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2023 07:21:42 PM
// Design Name: 
// Module Name: Bond_ACC
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


module Bond_ACC(
  input                     Sys_Clk  ,
  input                     Sys_Rst_n, 
  
 input     [31:0]         B_Add_BUF           ,
 input     [31:0]         Dih_Add_BUF         ,
 input     [31:0]         Angle_Add_BUF       ,
 input     [31:0]         Impropers_Add_BUF  ,
  
         //X to caculation sub unit 
 output reg [31:0]     ADD_Bond_A_out ,
 output reg            ADD_Bond_A_Vil ,
 output reg            ADD_Bond_B_Vil ,
 output reg [31:0]     ADD_Bond_B_out ,
 input      [31:0]     ADD_Bond_get_r ,
 input                 ADD_Bond_get_vil  ,
        //X to caculation sub unit 
 output reg [31:0]     IM_ADD_DI_A_out ,
 output reg            IM_ADD_DI_A_Vil ,
 output reg            IM_ADD_DI_B_Vil ,
 output reg [31:0]     IM_ADD_DI_B_out ,
 input      [31:0]     IM_ADD_DI_get_r ,
 input                 IM_ADD_DI_get_vil  ,
        //X to caculation sub unit 
 output reg [31:0]     B_ADD_A_A_out ,
 output reg            B_ADD_A_A_Vil ,
 output reg            B_ADD_A_B_Vil ,
 output reg [31:0]     B_ADD_A_B_out ,
 input      [31:0]     B_ADD_A_get_r ,
 input                 B_ADD_A_get_vil , 
  
  
    output reg  [31:0]        Bond_Force 
    );
    
    
 reg [31:0] B_ADD_A_BUF;
 reg [31:0] IM_ADD_DI_BUF;   
  reg  Bond_Cal_Done;
    
    
reg          B_ADD_A_en;
reg [31:0]   B_ADD_A;
reg          B_ADD_A_done;
reg [6:0]    B_ADD_A_CNT;
reg [6:0]    B_ADD_A_flow_cnt_State;    
    
reg          IM_ADD_DI_en;
reg [31:0]   IM_ADD_DI;
reg          IM_ADD_DI_done;
reg [6:0]    IM_ADD_DI_CNT;
reg [6:0]    IM_ADD_DI_flow_cnt_State;

reg          ADD_Bond_en;
reg [31:0]   ADD_Bond;
reg          ADD_Bond_done;
reg [6:0]    ADD_Bond_CNT;
reg [6:0]    ADD_Bond_flow_cnt_State;
//-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           B_ADD_A_flow_cnt_RST   = 5'b00001	,
           B_ADD_A_flow_cnt_IDLE  = 5'b00010	,
           B_ADD_A_flow_cnt_BEGIN = 5'b00100	,
           B_ADD_A_flow_cnt_CHK   = 5'b01000	,
           B_ADD_A_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       B_ADD_A_flow_cnt_State <= B_ADD_A_flow_cnt_RST;
     end 
      else begin 
           case( B_ADD_A_flow_cnt_State)  
            B_ADD_A_flow_cnt_RST :
                begin
                      B_ADD_A_flow_cnt_State  <=B_ADD_A_flow_cnt_IDLE;
                end 
            B_ADD_A_flow_cnt_IDLE:
                begin
                  if (B_ADD_A_en)
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_BEGIN;
                  else
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_IDLE;
                  end 
            B_ADD_A_flow_cnt_BEGIN:
                 begin
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_CHK;
                 end 
            B_ADD_A_flow_cnt_CHK:
                  begin
                     if ( B_ADD_A_get_vil &&( B_ADD_A_CNT == 5'd12))
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_END;
                     else
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_CHK;
                   end 
            B_ADD_A_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_IDLE;
                      else
                      B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_END;
                 end     
                 
       default:       B_ADD_A_flow_cnt_State <=B_ADD_A_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_A_out  <=  32'd0;         
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_BEGIN)      
            B_ADD_A_A_out  <=    B_Add_BUF  ;
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_IDLE)      
            B_ADD_A_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_B_out  <=  32'd0;         
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_BEGIN)
            B_ADD_A_B_out  <=     Angle_Add_BUF ;
      else   if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_IDLE)           
            B_ADD_A_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_A_Vil  <= 1'b0;          
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_BEGIN)
            B_ADD_A_A_Vil <= 1'b1;  
      else  if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_IDLE)            
            B_ADD_A_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_B_Vil <= 1'b0;         
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_BEGIN)
            B_ADD_A_B_Vil <= 1'b1;  
      else              
            B_ADD_A_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A             <=  32'd0;          
      else if ( B_ADD_A_get_vil &&( B_ADD_A_CNT == 5'd12))
            B_ADD_A             <=  B_ADD_A_get_r;
      else   if (  B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_IDLE)          
            B_ADD_A             <= 32'd0;       
      end 
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_BUF             <=  32'd0;          
      else if ( B_ADD_A_get_vil &&( B_ADD_A_CNT == 5'd12))
            B_ADD_A_BUF             <=  B_ADD_A_get_r;
      else  if (  Bond_Cal_Done)          
            B_ADD_A_BUF             <= 32'd0;       
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_done           <= 1'b0;            
      else if ( B_ADD_A_get_vil &&( B_ADD_A_CNT == 5'd12))
            B_ADD_A_done           <= 1'b1;       
      else     
            B_ADD_A_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            B_ADD_A_CNT  <=  5'd0;         
      else if ( B_ADD_A_flow_cnt_State  ==B_ADD_A_flow_cnt_CHK)      
            B_ADD_A_CNT  <= B_ADD_A_CNT + 5'd1  ;
      else 
            B_ADD_A_CNT   <=  5'd0;              
      end          
    
    
//-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           IM_ADD_DI_flow_cnt_RST   = 5'b00001	,
           IM_ADD_DI_flow_cnt_IDLE  = 5'b00010	,
           IM_ADD_DI_flow_cnt_BEGIN = 5'b00100	,
           IM_ADD_DI_flow_cnt_CHK   = 5'b01000	,
           IM_ADD_DI_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       IM_ADD_DI_flow_cnt_State <= IM_ADD_DI_flow_cnt_RST;
     end 
      else begin 
           case( IM_ADD_DI_flow_cnt_State)  
            IM_ADD_DI_flow_cnt_RST :
                begin
                      IM_ADD_DI_flow_cnt_State  <=IM_ADD_DI_flow_cnt_IDLE;
                end 
            IM_ADD_DI_flow_cnt_IDLE:
                begin
                  if (IM_ADD_DI_en)
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_BEGIN;
                  else
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_IDLE;
                  end 
            IM_ADD_DI_flow_cnt_BEGIN:
                 begin
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_CHK;
                 end 
            IM_ADD_DI_flow_cnt_CHK:
                  begin
                     if ( IM_ADD_DI_get_vil &&( IM_ADD_DI_CNT == 5'd12))
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_END;
                     else
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_CHK;
                   end 
            IM_ADD_DI_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_IDLE;
                      else
                      IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_END;
                 end     
                 
       default:       IM_ADD_DI_flow_cnt_State <=IM_ADD_DI_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_A_out  <=  32'd0;         
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_BEGIN)      
            IM_ADD_DI_A_out  <=  Dih_Add_BUF  ;
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_IDLE)      
            IM_ADD_DI_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_B_out  <=  32'd0;         
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_BEGIN)
            IM_ADD_DI_B_out  <=     Impropers_Add_BUF ;
      else   if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_IDLE)           
            IM_ADD_DI_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_A_Vil  <= 1'b0;          
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_BEGIN)
            IM_ADD_DI_A_Vil <= 1'b1;  
      else  if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_IDLE)            
            IM_ADD_DI_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_B_Vil <= 1'b0;         
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_BEGIN)
            IM_ADD_DI_B_Vil <= 1'b1;  
      else              
            IM_ADD_DI_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI             <=  32'd0;          
      else if ( IM_ADD_DI_get_vil &&( IM_ADD_DI_CNT == 5'd12))
            IM_ADD_DI             <=  IM_ADD_DI_get_r;
      else   if (  IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_IDLE)          
            IM_ADD_DI             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_done           <= 1'b0;            
      else if ( IM_ADD_DI_get_vil &&( IM_ADD_DI_CNT == 5'd12))
            IM_ADD_DI_done           <= 1'b1;       
      else     
            IM_ADD_DI_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            IM_ADD_DI_CNT  <=  5'd0;         
      else if ( IM_ADD_DI_flow_cnt_State  ==IM_ADD_DI_flow_cnt_CHK)      
            IM_ADD_DI_CNT  <= IM_ADD_DI_CNT + 5'd1  ;
      else 
            IM_ADD_DI_CNT   <=  5'd0;              
      end     
      
      
  //-----------------------------------------------------------------------
//              
//-----------------------------------------------------------------------
localparam [4:0]
           ADD_Bond_flow_cnt_RST   = 5'b00001	,
           ADD_Bond_flow_cnt_IDLE  = 5'b00010	,
           ADD_Bond_flow_cnt_BEGIN = 5'b00100	,
           ADD_Bond_flow_cnt_CHK   = 5'b01000	,
           ADD_Bond_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       ADD_Bond_flow_cnt_State <= ADD_Bond_flow_cnt_RST;
     end 
      else begin 
           case( ADD_Bond_flow_cnt_State)  
            ADD_Bond_flow_cnt_RST :
                begin
                      ADD_Bond_flow_cnt_State  <=ADD_Bond_flow_cnt_IDLE;
                end 
            ADD_Bond_flow_cnt_IDLE:
                begin
                  if (ADD_Bond_en)
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_BEGIN;
                  else
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_IDLE;
                  end 
            ADD_Bond_flow_cnt_BEGIN:
                 begin
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_CHK;
                 end 
            ADD_Bond_flow_cnt_CHK:
                  begin
                     if ( ADD_Bond_get_vil &&( ADD_Bond_CNT == 5'd12))
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_END;
                     else
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_CHK;
                   end 
            ADD_Bond_flow_cnt_END:
                 begin        
                    if  ( Bond_Cal_Done )        
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_IDLE;
                      else
                      ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_END;
                 end     
                 
       default:       ADD_Bond_flow_cnt_State <=ADD_Bond_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_A_out  <=  32'd0;         
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_BEGIN)      
            ADD_Bond_A_out  <=  IM_ADD_DI  ;
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_IDLE)      
            ADD_Bond_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_B_out  <=  32'd0;         
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_BEGIN)
            ADD_Bond_B_out  <=     B_ADD_A_BUF ;
      else   if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_IDLE)           
            ADD_Bond_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_A_Vil  <= 1'b0;          
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_BEGIN)
            ADD_Bond_A_Vil <= 1'b1;  
      else  if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_IDLE)            
            ADD_Bond_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_B_Vil <= 1'b0;         
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_BEGIN)
            ADD_Bond_B_Vil <= 1'b1;  
      else              
            ADD_Bond_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Bond_Force             <=  32'd0;          
      else if ( ADD_Bond_get_vil &&( ADD_Bond_CNT == 5'd12))
            Bond_Force             <=  ADD_Bond_get_r;
      else   if (  ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_IDLE)          
            Bond_Force             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_done           <= 1'b0;            
      else if ( ADD_Bond_get_vil &&( ADD_Bond_CNT == 5'd12))
            ADD_Bond_done           <= 1'b1;       
      else     
            ADD_Bond_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ADD_Bond_CNT  <=  5'd0;         
      else if ( ADD_Bond_flow_cnt_State  ==ADD_Bond_flow_cnt_CHK)      
            ADD_Bond_CNT  <= ADD_Bond_CNT + 5'd1  ;
      else 
            ADD_Bond_CNT   <=  5'd0;              
      end      
      
      
endmodule
