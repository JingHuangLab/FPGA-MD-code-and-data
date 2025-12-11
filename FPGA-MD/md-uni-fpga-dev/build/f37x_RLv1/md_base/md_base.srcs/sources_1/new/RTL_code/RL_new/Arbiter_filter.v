`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2023 07:00:23 PM
// Design Name: 
// Module Name: Arbiter_filter
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


module Arbiter_filter(
      input                              Sys_Clk                 ,
      input                              Sys_Rst_n               ,
      input                              Force_cal_finish,
                //X to caculation sub unit 
      output reg [31:0]     Filter_1_comp_A_out ,
      output reg            Filter_1_comp_A_Vil ,
      output reg            Filter_1_comp_B_Vil ,
      output reg [31:0]     Filter_1_comp_B_out ,
      input      [31:0]     Filter_1_comp_get_r,
      input                 Filter_1_comp_get_vil,        
                //X to caculation sub unit 
      output reg [31:0]     Filter_2_comp_A_out ,
      output reg            Filter_2_comp_A_Vil ,
      output reg            Filter_2_comp_B_Vil ,
      output reg [31:0]     Filter_2_comp_B_out ,
      input      [31:0]     Filter_2_comp_get_r,
      input                 Filter_2_comp_get_vil,         
                //X to caculation sub unit 
      output reg [31:0]     Filter_3_comp_A_out ,
      output reg            Filter_3_comp_A_Vil ,
      output reg            Filter_3_comp_B_Vil ,
      output reg [31:0]     Filter_3_comp_B_out ,
      input      [31:0]     Filter_3_comp_get_r,
      input                 Filter_3_comp_get_vil,        
                //X to caculation sub unit 
      output reg [31:0]     Filter_4_comp_A_out ,
      output reg            Filter_4_comp_A_Vil ,
      output reg            Filter_4_comp_B_Vil ,
      output reg [31:0]     Filter_4_comp_B_out ,
      input      [31:0]     Filter_4_comp_get_r,
      input                 Filter_4_comp_get_vil,   
                 //X to caculation sub unit 
      output reg [31:0]     Filter_5_comp_A_out ,
      output reg            Filter_5_comp_A_Vil ,
      output reg            Filter_5_comp_B_Vil ,
      output reg [31:0]     Filter_5_comp_B_out ,
      input      [31:0]     Filter_5_comp_get_r,
      input                 Filter_5_comp_get_vil,      
                //X to caculation sub unit 
      output reg [31:0]     Filter_6_comp_A_out ,
      output reg            Filter_6_comp_A_Vil ,
      output reg            Filter_6_comp_B_Vil ,
      output reg [31:0]     Filter_6_comp_B_out ,
      input      [31:0]     Filter_6_comp_get_r,
      input                 Filter_6_comp_get_vil,     
                //X to caculation sub unit 
      output reg [31:0]     Filter_7_comp_A_out ,
      output reg            Filter_7_comp_A_Vil ,
      output reg            Filter_7_comp_B_Vil ,
      output reg [31:0]     Filter_7_comp_B_out ,
      input      [31:0]     Filter_7_comp_get_r,
      input                 Filter_7_comp_get_vil,         
                //X to caculation sub unit 
      output reg [31:0]     Filter_8_comp_A_out ,
      output reg            Filter_8_comp_A_Vil ,
      output reg            Filter_8_comp_B_Vil ,
      output reg [31:0]     Filter_8_comp_B_out ,
      input      [31:0]     Filter_8_comp_get_r,
      input                 Filter_8_comp_get_vil,   
      
     output reg   [31:0]    Filter_to_cal      ,
     input                  Filter_to_cal_Done , 
     
     output reg             Filter_1_Ture,
     output reg             Filter_2_Ture,
     output reg             Filter_3_Ture,
     output reg             Filter_4_Ture,
     output reg             Filter_5_Ture,
     output reg             Filter_6_Ture,
     output reg             Filter_7_Ture,
     output reg             Filter_8_Ture,


input        [31:0]    Filter_RC               , 
input        [31:0]    Filter_1_R2             , 
input        [31:0]    Filter_2_R2             , 
input        [31:0]    Filter_3_R2             , 
input        [31:0]    Filter_4_R2             , 
input        [31:0]    Filter_5_R2             , 
input        [31:0]    Filter_6_R2             , 
input        [31:0]    Filter_7_R2             , 
input        [31:0]    Filter_8_R2              
    );
reg [7:0]    Filter_RUNing  ; 

reg Filter_1_Ture_runing;
reg Filter_2_Ture_runing;
reg Filter_3_Ture_runing;
reg Filter_4_Ture_runing;
reg Filter_5_Ture_runing;
reg Filter_6_Ture_runing;
reg Filter_7_Ture_runing;
reg Filter_8_Ture_runing;
 
 reg   [31:0]    Filter_1_data_to_cal      ;  
 reg   [31:0]    Filter_2_data_to_cal      ;  
 reg   [31:0]    Filter_3_data_to_cal      ;  
 reg   [31:0]    Filter_4_data_to_cal      ;   
 reg   [31:0]    Filter_5_data_to_cal      ;  
 reg   [31:0]    Filter_6_data_to_cal      ;  
 reg   [31:0]    Filter_7_data_to_cal      ;  
 reg   [31:0]    Filter_8_data_to_cal      ;   
 
reg           Filter_1_done;
reg           Filter_2_done;     
reg           Filter_3_done;     
reg           Filter_4_done;     
reg           Filter_5_done;     
reg           Filter_6_done;     
reg           Filter_7_done;     
reg           Filter_8_done;     

reg           Filter_1_Ture_pass;
reg           Filter_2_Ture_pass;   
reg           Filter_3_Ture_pass;   
reg           Filter_4_Ture_pass;   
reg           Filter_5_Ture_pass;   
reg           Filter_6_Ture_pass;   
reg           Filter_7_Ture_pass;   
reg           Filter_8_Ture_pass;   
         
reg [6:0]    Filter_1_comp_flow_cnt_State;
reg          Filter_1_comp_en;
reg [6:0]    Filter_1_comp_CNT;
reg          Filter_1_comp_Done;

reg [6:0]    Filter_2_comp_flow_cnt_State;
reg          Filter_2_comp_en;
reg [6:0]    Filter_2_comp_CNT;
reg          Filter_2_comp_Done;

reg [6:0]    Filter_3_comp_flow_cnt_State;
reg          Filter_3_comp_en;
reg [6:0]    Filter_3_comp_CNT;
//reg          Filter_3_Ture;
reg          Filter_3_comp_Done;

reg [6:0]    Filter_4_comp_flow_cnt_State;
reg          Filter_4_comp_en;
reg [6:0]    Filter_4_comp_CNT;
//reg          Filter_4_Ture;
reg          Filter_4_comp_Done;

reg [6:0]    Filter_5_comp_flow_cnt_State;
reg          Filter_5_comp_en;
reg [6:0]    Filter_5_comp_CNT;
//reg          Filter_5_Ture;
reg          Filter_5_comp_Done;

reg [6:0]    Filter_6_comp_flow_cnt_State;
reg          Filter_6_comp_en;
reg [6:0]    Filter_6_comp_CNT;
//reg          Filter_6_Ture;
reg          Filter_6_comp_Done;

reg [6:0]    Filter_7_comp_flow_cnt_State;
reg          Filter_7_comp_en;
reg [6:0]    Filter_7_comp_CNT;
//reg          Filter_7_Ture;
reg          Filter_7_comp_Done;

reg [6:0]    Filter_8_comp_flow_cnt_State;
reg          Filter_8_comp_en;
reg [6:0]    Filter_8_comp_CNT;
//reg          Filter_8_Ture;
reg          Filter_8_comp_Done;
reg          Filter_comp_Done; 

reg [6:0]    Filter_sel_wr_flow_State;
reg [12:0]     Filter_cnt_flow_State;
 //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_1_comp_flow_cnt_RST   = 5'b00001	,
           Filter_1_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_1_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_1_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_1_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_1_comp_flow_cnt_State <= Filter_1_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_1_comp_flow_cnt_State)  
            Filter_1_comp_flow_cnt_RST :
                begin
                      Filter_1_comp_flow_cnt_State  <=Filter_1_comp_flow_cnt_IDLE;
                end 
            Filter_1_comp_flow_cnt_IDLE:
                begin
                  if (Filter_1_comp_en)
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_BEGIN;
                  else
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_IDLE;
                  end 
            Filter_1_comp_flow_cnt_BEGIN:
                 begin
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_CHK;
                 end 
            Filter_1_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_1_comp_get_vil) &&( Filter_1_comp_CNT == 5'd12))
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_END;
                     else
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_CHK;
                   end 
            Filter_1_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_IDLE;
                      else
                      Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_1_comp_flow_cnt_State <=Filter_1_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_A_out  <=  32'd0;         
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_BEGIN)      
            Filter_1_comp_A_out  <=   Filter_1_R2   ;
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_IDLE)      
            Filter_1_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_B_out  <=  32'd0;         
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_BEGIN)
            Filter_1_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_IDLE)           
            Filter_1_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_A_Vil  <= 1'b0;          
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_BEGIN)
            Filter_1_comp_A_Vil <= 1'b1;  
      else  if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_IDLE)            
            Filter_1_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_B_Vil <= 1'b0;         
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_BEGIN)
            Filter_1_comp_B_Vil <= 1'b1;  
      else              
            Filter_1_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_Ture             <=  1'd0;          
      else if (( Filter_1_comp_get_r[0]) &&( Filter_1_comp_CNT == 5'd12))
            Filter_1_Ture             <=  1'd1;  
      else   if (  Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_IDLE)          
            Filter_1_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_Done           <= 1'b0;            
      else if ( Filter_1_comp_get_vil &&( Filter_1_comp_CNT == 5'd12))
            Filter_1_comp_Done           <= 1'b1;       
      else     
            Filter_1_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_1_comp_CNT  <=  5'd0;         
      else if ( Filter_1_comp_flow_cnt_State  ==Filter_1_comp_flow_cnt_CHK)      
            Filter_1_comp_CNT  <= Filter_1_comp_CNT + 5'd1  ;
      else 
            Filter_1_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_2_comp_flow_cnt_RST   = 5'b00001	,
           Filter_2_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_2_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_2_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_2_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_2_comp_flow_cnt_State <= Filter_2_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_2_comp_flow_cnt_State)  
            Filter_2_comp_flow_cnt_RST :
                begin
                      Filter_2_comp_flow_cnt_State  <=Filter_2_comp_flow_cnt_IDLE;
                end 
            Filter_2_comp_flow_cnt_IDLE:
                begin
                  if (Filter_2_comp_en)
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_BEGIN;
                  else
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_IDLE;
                  end 
            Filter_2_comp_flow_cnt_BEGIN:
                 begin
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_CHK;
                 end 
            Filter_2_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_2_comp_get_vil) &&( Filter_2_comp_CNT == 5'd12))
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_END;
                     else
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_CHK;
                   end 
            Filter_2_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_IDLE;
                      else
                      Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_2_comp_flow_cnt_State <=Filter_2_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_A_out  <=  32'd0;         
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_BEGIN)      
            Filter_2_comp_A_out  <=   Filter_2_R2   ;
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_IDLE)      
            Filter_2_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_B_out  <=  32'd0;         
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_BEGIN)
            Filter_2_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_IDLE)           
            Filter_2_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_A_Vil  <= 1'b0;          
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_BEGIN)
            Filter_2_comp_A_Vil <= 1'b1;  
      else  if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_IDLE)            
            Filter_2_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_B_Vil <= 1'b0;         
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_BEGIN)
            Filter_2_comp_B_Vil <= 1'b1;  
      else              
            Filter_2_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_Ture             <=  1'd0;          
      else if (( Filter_2_comp_get_r[0]) &&( Filter_2_comp_CNT == 5'd12))
            Filter_2_Ture             <=  1'd1;  
      else   if (  Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_IDLE)          
            Filter_2_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_Done           <= 1'b0;            
      else if ( Filter_2_comp_get_vil &&( Filter_2_comp_CNT == 5'd12))
            Filter_2_comp_Done           <= 1'b1;       
      else     
            Filter_2_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_2_comp_CNT  <=  5'd0;         
      else if ( Filter_2_comp_flow_cnt_State  ==Filter_2_comp_flow_cnt_CHK)      
            Filter_2_comp_CNT  <= Filter_2_comp_CNT + 5'd1  ;
      else 
            Filter_2_comp_CNT   <=  5'd0;              
      end 
    
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_3_comp_flow_cnt_RST   = 5'b00001	,
           Filter_3_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_3_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_3_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_3_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_3_comp_flow_cnt_State <= Filter_3_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_3_comp_flow_cnt_State)  
            Filter_3_comp_flow_cnt_RST :
                begin
                      Filter_3_comp_flow_cnt_State  <=Filter_3_comp_flow_cnt_IDLE;
                end 
            Filter_3_comp_flow_cnt_IDLE:
                begin
                  if (Filter_3_comp_en)
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_BEGIN;
                  else
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_IDLE;
                  end 
            Filter_3_comp_flow_cnt_BEGIN:
                 begin
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_CHK;
                 end 
            Filter_3_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_3_comp_get_vil) &&( Filter_3_comp_CNT == 5'd12))
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_END;
                     else
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_CHK;
                   end 
            Filter_3_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_IDLE;
                      else
                      Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_3_comp_flow_cnt_State <=Filter_3_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_A_out  <=  32'd0;         
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_BEGIN)      
            Filter_3_comp_A_out  <=   Filter_3_R2   ;
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_IDLE)      
            Filter_3_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_B_out  <=  32'd0;         
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_BEGIN)
            Filter_3_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_IDLE)           
            Filter_3_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_A_Vil  <= 1'b0;          
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_BEGIN)
            Filter_3_comp_A_Vil <= 1'b1;  
      else  if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_IDLE)            
            Filter_3_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_B_Vil <= 1'b0;         
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_BEGIN)
            Filter_3_comp_B_Vil <= 1'b1;  
      else              
            Filter_3_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_Ture             <=  1'd0;          
      else if (( Filter_3_comp_get_r[0]) &&( Filter_3_comp_CNT == 5'd12))
            Filter_3_Ture             <=  1'd1;  
      else   if (  Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_IDLE)          
            Filter_3_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_Done           <= 1'b0;            
      else if ( Filter_3_comp_get_vil &&( Filter_3_comp_CNT == 5'd12))
            Filter_3_comp_Done           <= 1'b1;       
      else     
            Filter_3_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_3_comp_CNT  <=  5'd0;         
      else if ( Filter_3_comp_flow_cnt_State  ==Filter_3_comp_flow_cnt_CHK)      
            Filter_3_comp_CNT  <= Filter_3_comp_CNT + 5'd1  ;
      else 
            Filter_3_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_4_comp_flow_cnt_RST   = 5'b00001	,
           Filter_4_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_4_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_4_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_4_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_4_comp_flow_cnt_State <= Filter_4_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_4_comp_flow_cnt_State)  
            Filter_4_comp_flow_cnt_RST :
                begin
                      Filter_4_comp_flow_cnt_State  <=Filter_4_comp_flow_cnt_IDLE;
                end 
            Filter_4_comp_flow_cnt_IDLE:
                begin
                  if (Filter_4_comp_en)
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_BEGIN;
                  else
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_IDLE;
                  end 
            Filter_4_comp_flow_cnt_BEGIN:
                 begin
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_CHK;
                 end 
            Filter_4_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_4_comp_get_vil) &&( Filter_4_comp_CNT == 5'd12))
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_END;
                     else
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_CHK;
                   end 
            Filter_4_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_IDLE;
                      else
                      Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_4_comp_flow_cnt_State <=Filter_4_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_A_out  <=  32'd0;         
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_BEGIN)      
            Filter_4_comp_A_out  <=   Filter_4_R2   ;
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_IDLE)      
            Filter_4_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_B_out  <=  32'd0;         
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_BEGIN)
            Filter_4_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_IDLE)           
            Filter_4_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_A_Vil  <= 1'b0;          
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_BEGIN)
            Filter_4_comp_A_Vil <= 1'b1;  
      else  if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_IDLE)            
            Filter_4_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_B_Vil <= 1'b0;         
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_BEGIN)
            Filter_4_comp_B_Vil <= 1'b1;  
      else              
            Filter_4_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_Ture             <=  1'd0;          
      else if (( Filter_4_comp_get_r[0]) &&( Filter_4_comp_CNT == 5'd12))
            Filter_4_Ture             <=  1'd1;  
      else   if (  Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_IDLE)          
            Filter_4_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_Done           <= 1'b0;            
      else if ( Filter_4_comp_get_vil &&( Filter_4_comp_CNT == 5'd12))
            Filter_4_comp_Done           <= 1'b1;       
      else     
            Filter_4_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_4_comp_CNT  <=  5'd0;         
      else if ( Filter_4_comp_flow_cnt_State  ==Filter_4_comp_flow_cnt_CHK)      
            Filter_4_comp_CNT  <= Filter_4_comp_CNT + 5'd1  ;
      else 
            Filter_4_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_5_comp_flow_cnt_RST   = 5'b00001	,
           Filter_5_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_5_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_5_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_5_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_5_comp_flow_cnt_State <= Filter_5_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_5_comp_flow_cnt_State)  
            Filter_5_comp_flow_cnt_RST :
                begin
                      Filter_5_comp_flow_cnt_State  <=Filter_5_comp_flow_cnt_IDLE;
                end 
            Filter_5_comp_flow_cnt_IDLE:
                begin
                  if (Filter_5_comp_en)
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_BEGIN;
                  else
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_IDLE;
                  end 
            Filter_5_comp_flow_cnt_BEGIN:
                 begin
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_CHK;
                 end 
            Filter_5_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_5_comp_get_vil) &&( Filter_5_comp_CNT == 5'd12))
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_END;
                     else
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_CHK;
                   end 
            Filter_5_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_IDLE;
                      else
                      Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_5_comp_flow_cnt_State <=Filter_5_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_A_out  <=  32'd0;         
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_BEGIN)      
            Filter_5_comp_A_out  <=   Filter_5_R2   ;
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_IDLE)      
            Filter_5_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_B_out  <=  32'd0;         
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_BEGIN)
            Filter_5_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_IDLE)           
            Filter_5_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_A_Vil  <= 1'b0;          
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_BEGIN)
            Filter_5_comp_A_Vil <= 1'b1;  
      else  if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_IDLE)            
            Filter_5_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_B_Vil <= 1'b0;         
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_BEGIN)
            Filter_5_comp_B_Vil <= 1'b1;  
      else              
            Filter_5_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_Ture             <=  1'd0;          
      else if (( Filter_5_comp_get_r[0]) &&( Filter_5_comp_CNT == 5'd12))
            Filter_5_Ture             <=  1'd1;  
      else   if (  Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_IDLE)          
            Filter_5_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_Done           <= 1'b0;            
      else if ( Filter_5_comp_get_vil &&( Filter_5_comp_CNT == 5'd12))
            Filter_5_comp_Done           <= 1'b1;       
      else     
            Filter_5_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_5_comp_CNT  <=  5'd0;         
      else if ( Filter_5_comp_flow_cnt_State  ==Filter_5_comp_flow_cnt_CHK)      
            Filter_5_comp_CNT  <= Filter_5_comp_CNT + 5'd1  ;
      else 
            Filter_5_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_6_comp_flow_cnt_RST   = 5'b00001	,
           Filter_6_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_6_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_6_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_6_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_6_comp_flow_cnt_State <= Filter_6_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_6_comp_flow_cnt_State)  
            Filter_6_comp_flow_cnt_RST :
                begin
                      Filter_6_comp_flow_cnt_State  <=Filter_6_comp_flow_cnt_IDLE;
                end 
            Filter_6_comp_flow_cnt_IDLE:
                begin
                  if (Filter_6_comp_en)
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_BEGIN;
                  else
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_IDLE;
                  end 
            Filter_6_comp_flow_cnt_BEGIN:
                 begin
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_CHK;
                 end 
            Filter_6_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_6_comp_get_vil) &&( Filter_6_comp_CNT == 5'd12))
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_END;
                     else
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_CHK;
                   end 
            Filter_6_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_IDLE;
                      else
                      Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_6_comp_flow_cnt_State <=Filter_6_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_A_out  <=  32'd0;         
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_BEGIN)      
            Filter_6_comp_A_out  <=   Filter_6_R2   ;
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_IDLE)      
            Filter_6_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_B_out  <=  32'd0;         
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_BEGIN)
            Filter_6_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_IDLE)           
            Filter_6_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_A_Vil  <= 1'b0;          
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_BEGIN)
            Filter_6_comp_A_Vil <= 1'b1;  
      else  if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_IDLE)            
            Filter_6_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_B_Vil <= 1'b0;         
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_BEGIN)
            Filter_6_comp_B_Vil <= 1'b1;  
      else              
            Filter_6_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_Ture             <=  1'd0;          
      else if (( Filter_6_comp_get_r[0]) &&( Filter_6_comp_CNT == 5'd12))
            Filter_6_Ture             <=  1'd1;  
      else   if (  Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_IDLE)          
            Filter_6_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_Done           <= 1'b0;            
      else if ( Filter_6_comp_get_vil &&( Filter_6_comp_CNT == 5'd12))
            Filter_6_comp_Done           <= 1'b1;       
      else     
            Filter_6_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_6_comp_CNT  <=  5'd0;         
      else if ( Filter_6_comp_flow_cnt_State  ==Filter_6_comp_flow_cnt_CHK)      
            Filter_6_comp_CNT  <= Filter_6_comp_CNT + 5'd1  ;
      else 
            Filter_6_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_7_comp_flow_cnt_RST   = 5'b00001	,
           Filter_7_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_7_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_7_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_7_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_7_comp_flow_cnt_State <= Filter_7_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_7_comp_flow_cnt_State)  
            Filter_7_comp_flow_cnt_RST :
                begin
                      Filter_7_comp_flow_cnt_State  <=Filter_7_comp_flow_cnt_IDLE;
                end 
            Filter_7_comp_flow_cnt_IDLE:
                begin
                  if (Filter_7_comp_en)
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_BEGIN;
                  else
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_IDLE;
                  end 
            Filter_7_comp_flow_cnt_BEGIN:
                 begin
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_CHK;
                 end 
            Filter_7_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_7_comp_get_vil) &&( Filter_7_comp_CNT == 5'd12))
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_END;
                     else
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_CHK;
                   end 
            Filter_7_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_IDLE;
                      else
                      Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_7_comp_flow_cnt_State <=Filter_7_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_A_out  <=  32'd0;         
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_BEGIN)      
            Filter_7_comp_A_out  <=   Filter_7_R2   ;
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_IDLE)      
            Filter_7_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_B_out  <=  32'd0;         
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_BEGIN)
            Filter_7_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_IDLE)           
            Filter_7_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_A_Vil  <= 1'b0;          
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_BEGIN)
            Filter_7_comp_A_Vil <= 1'b1;  
      else  if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_IDLE)            
            Filter_7_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_B_Vil <= 1'b0;         
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_BEGIN)
            Filter_7_comp_B_Vil <= 1'b1;  
      else              
            Filter_7_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_Ture             <=  1'd0;          
      else if (( Filter_7_comp_get_r[0]) &&( Filter_7_comp_CNT == 5'd12))
            Filter_7_Ture             <=  1'd1;  
      else   if (  Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_IDLE)          
            Filter_7_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_Done           <= 1'b0;            
      else if ( Filter_7_comp_get_vil &&( Filter_7_comp_CNT == 5'd12))
            Filter_7_comp_Done           <= 1'b1;       
      else     
            Filter_7_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_7_comp_CNT  <=  5'd0;         
      else if ( Filter_7_comp_flow_cnt_State  ==Filter_7_comp_flow_cnt_CHK)      
            Filter_7_comp_CNT  <= Filter_7_comp_CNT + 5'd1  ;
      else 
            Filter_7_comp_CNT   <=  5'd0;              
      end 
    
    //-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           Filter_8_comp_flow_cnt_RST   = 5'b00001	,
           Filter_8_comp_flow_cnt_IDLE  = 5'b00010	,
           Filter_8_comp_flow_cnt_BEGIN = 5'b00100	,
           Filter_8_comp_flow_cnt_CHK   = 5'b01000	,
           Filter_8_comp_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_8_comp_flow_cnt_State <= Filter_8_comp_flow_cnt_RST;
     end 
      else begin 
           case( Filter_1_comp_flow_cnt_State)  
                 Filter_8_comp_flow_cnt_RST :
                begin
                      Filter_8_comp_flow_cnt_State  <=Filter_8_comp_flow_cnt_IDLE;
                end 
            Filter_8_comp_flow_cnt_IDLE:
                begin
                  if (Filter_8_comp_en)
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_BEGIN;
                  else
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_IDLE;
                  end 
            Filter_8_comp_flow_cnt_BEGIN:
                 begin
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_CHK;
                 end 
            Filter_8_comp_flow_cnt_CHK:
                  begin
                     if (( Filter_8_comp_get_vil) &&( Filter_8_comp_CNT == 5'd12))
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_END;
                     else
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_CHK;
                   end 
            Filter_8_comp_flow_cnt_END:
                 begin        
                    if  ( Filter_comp_Done )        
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_IDLE;
                      else
                      Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_END;
                 end     
                 
       default:       Filter_8_comp_flow_cnt_State <=Filter_8_comp_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_A_out  <=  32'd0;         
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_BEGIN)      
            Filter_8_comp_A_out  <=   Filter_8_R2   ;
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_IDLE)      
            Filter_8_comp_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_B_out  <=  32'd0;         
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_BEGIN)
            Filter_8_comp_B_out  <=   Filter_RC   ;
      else   if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_IDLE)           
            Filter_8_comp_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_A_Vil  <= 1'b0;          
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_BEGIN)
            Filter_8_comp_A_Vil <= 1'b1;  
      else  if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_IDLE)            
            Filter_8_comp_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_B_Vil <= 1'b0;         
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_BEGIN)
            Filter_8_comp_B_Vil <= 1'b1;  
      else              
            Filter_8_comp_B_Vil  <= 1'b0;             
      end 

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_Ture             <=  1'd0;          
      else if (( Filter_8_comp_get_r[0]) &&( Filter_8_comp_CNT == 5'd12))
            Filter_8_Ture             <=  1'd1;  
      else   if (  Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_IDLE)          
            Filter_8_Ture             <= 1'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_Done           <= 1'b0;            
      else if ( Filter_8_comp_get_vil &&( Filter_8_comp_CNT == 5'd12))
            Filter_8_comp_Done           <= 1'b1;       
      else     
            Filter_8_comp_Done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Filter_8_comp_CNT  <=  5'd0;         
      else if ( Filter_8_comp_flow_cnt_State  ==Filter_8_comp_flow_cnt_CHK)      
            Filter_8_comp_CNT  <= Filter_8_comp_CNT + 5'd1  ;
      else 
            Filter_8_comp_CNT   <=  5'd0;              
      end 
                               
//-----------------------------------------------------------------------
//                                                                                                               
//-----------------------------------------------------------------------                               
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_1_data_to_cal    <= 32'd0 ;       
      else if ( Filter_1_Ture )
             Filter_1_data_to_cal    <= Filter_1_R2; 
      else if (Force_cal_finish)       
             Filter_1_data_to_cal    <= 32'd0 ;      
      end 
       
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_2_data_to_cal    <= 32'd0 ;       
      else if ( Filter_2_Ture )
             Filter_2_data_to_cal    <= Filter_2_R2; 
      else if (Force_cal_finish)        
             Filter_2_data_to_cal    <= 32'd0 ;      
      end 
                
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_3_data_to_cal    <= 32'd0 ;       
      else if ( Filter_3_Ture )
             Filter_3_data_to_cal    <= Filter_3_R2; 
      else if (Force_cal_finish)        
             Filter_3_data_to_cal    <= 32'd0 ;      
      end 
       
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_4_data_to_cal    <= 32'd0 ;       
      else if ( Filter_4_Ture )
             Filter_4_data_to_cal    <= Filter_4_R2; 
      else if (Force_cal_finish)        
             Filter_4_data_to_cal    <= 32'd0 ;      
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_5_data_to_cal    <= 32'd0 ;       
      else if ( Filter_5_Ture )
             Filter_5_data_to_cal    <= Filter_5_R2; 
      else if (Force_cal_finish)        
             Filter_5_data_to_cal    <= 32'd0 ;      
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_6_data_to_cal    <= 32'd0 ;       
      else if ( Filter_6_Ture )
             Filter_6_data_to_cal    <= Filter_6_R2; 
      else if (Force_cal_finish)        
             Filter_6_data_to_cal    <= 32'd0 ;      
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_7_data_to_cal    <= 32'd0 ;       
      else if ( Filter_7_Ture )
             Filter_7_data_to_cal    <= Filter_7_R2; 
      else if (Force_cal_finish)        
             Filter_7_data_to_cal    <= 32'd0 ;      
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_8_data_to_cal    <= 32'd0 ;       
      else if ( Filter_8_Ture )
             Filter_8_data_to_cal    <= Filter_8_R2; 
      else if (Force_cal_finish)        
             Filter_8_data_to_cal    <= 32'd0 ;      
      end  
//-----------------------------------------------------------------------
//                                                                                                               
//-----------------------------------------------------------------------   

localparam [4:0]
           Filter_flow_cnt_RST = 9'b000000001	,
           Filter_flow_cnt_Idle = 9'b000000001	,
           Filter_cnt_1_flow   = 9'b000000010	,
           Filter_cnt_2_flow   = 9'b000000100	,
           Filter_cnt_3_flow   = 9'b000001000	,
           Filter_cnt_4_flow   = 9'b000010000	,
           Filter_cnt_5_flow   = 9'b000100000	,
           Filter_cnt_6_flow   = 9'b001000000	,
           Filter_cnt_7_flow   = 9'b010000000	,
           Filter_cnt_8_flow   = 9'b100000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Filter_cnt_flow_State <= Filter_flow_cnt_RST;
     end 
      else begin 
           case( Filter_cnt_flow_State)  
                 Filter_flow_cnt_RST :
                begin
                      Filter_cnt_flow_State  <=Filter_flow_cnt_Idle;
                end 
             Filter_flow_cnt_Idle:
                begin
                  if (Filter_comp_Done)
                      Filter_cnt_flow_State <=Filter_cnt_1_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_flow_cnt_Idle;
                  end     
            Filter_cnt_1_flow:
                begin
                  if (Filter_1_done || Filter_1_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_2_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_1_flow;
                  end 
            Filter_cnt_2_flow:
                begin
                  if (Filter_2_done || Filter_2_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_3_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_2_flow;
                  end 
           Filter_cnt_3_flow:
                begin
                  if (Filter_3_done || Filter_3_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_4_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_3_flow;
                  end 
            Filter_cnt_4_flow:
                begin
                  if (Filter_4_done || Filter_4_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_5_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_4_flow;
                  end 
             Filter_cnt_5_flow:
                begin
                  if (Filter_5_done || Filter_5_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_6_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_5_flow;
                  end 
            Filter_cnt_6_flow:
                begin
                  if (Filter_6_done || Filter_6_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_7_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_6_flow;
                  end 
           Filter_cnt_7_flow:
                begin
                  if (Filter_7_done || Filter_7_Ture_pass)
                      Filter_cnt_flow_State <=Filter_cnt_8_flow;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_7_flow;
                  end 
            Filter_cnt_8_flow:
                begin
                  if (Filter_8_done || Filter_8_Ture_pass)
                      Filter_cnt_flow_State <=Filter_flow_cnt_Idle;
                  else  
                      Filter_cnt_flow_State <=Filter_cnt_8_flow;
                  end     
       default:       Filter_cnt_flow_State <=Filter_flow_cnt_Idle;
     endcase
   end 
 end   
 
//-----------------------------------------------------------------------  
  
 always@(posedge Sys_Clk  ) begin
       if (!Sys_Rst_n) begin   
          Filter_RUNing       <=  8'd0 ;   
       end 
      else begin

 Filter_RUNing  ={ Filter_1_Ture_runing,Filter_2_Ture_runing,Filter_3_Ture_runing,Filter_4_Ture_runing,
                   Filter_5_Ture_runing,Filter_6_Ture_runing,Filter_7_Ture_runing,Filter_8_Ture_runing};
   end  
  end  
  //-----------------------------------------------------------------------   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_to_cal    <= 32'd0 ;       
      else if ( Filter_1_Ture && (Filter_RUNing ==  8'b10000000))
             Filter_to_cal    <= Filter_1_data_to_cal; 
      else  if ( Filter_2_Ture && (Filter_RUNing ==  8'b01000000))
             Filter_to_cal    <= Filter_2_data_to_cal; 
      else  if ( Filter_3_Ture && (Filter_RUNing ==  8'b00100000))
             Filter_to_cal    <= Filter_3_data_to_cal; 
      else  if ( Filter_3_Ture && (Filter_RUNing ==  8'b00010000))       
              Filter_to_cal    <=Filter_4_data_to_cal;        
      else if ( Filter_1_Ture && (Filter_RUNing  ==  8'b00001000))
             Filter_to_cal    <= Filter_5_data_to_cal; 
      else  if ( Filter_2_Ture && (Filter_RUNing ==  8'b00000100))
             Filter_to_cal    <= Filter_6_data_to_cal; 
      else  if ( Filter_3_Ture && (Filter_RUNing ==  8'b00000010))
             Filter_to_cal    <= Filter_7_data_to_cal;     
      else  if ( Filter_3_Ture && (Filter_RUNing ==  8'b00000001))
             Filter_to_cal    <= Filter_8_data_to_cal;            
      else if (Force_cal_finish)       
             Filter_to_cal    <= 32'd0 ;      
      end 
   
   //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_1_Ture_runing    <= 1'd0 ;       
      else if  (Filter_1_Ture )
             Filter_1_Ture_runing    <= 1'd1 ;   // 1 calculating      
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_1_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_1_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_1_Ture )
             Filter_1_Ture_pass    <= 1'd1 ;      // 1 don't need calculated  
      else 
             Filter_1_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_1_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_1_done    <= 1'd1 ;  //   1 calculated done 
      else 
             Filter_1_done    <= 1'd0 ;                 
      end 
       //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_2_Ture_runing    <= 1'd0 ;       
      else if  (Filter_2_Ture )
             Filter_2_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_2_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_2_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_2_Ture )
             Filter_2_Ture_pass    <= 1'd1 ;        
      else 
             Filter_2_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_2_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_2_done    <= 1'd1 ;  
      else  
             Filter_2_done    <= 1'd0 ;                 
      end 
    
           //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_3_Ture_runing    <= 1'd0 ;       
      else if  (Filter_3_Ture )
             Filter_3_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_3_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_3_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_3_Ture )
             Filter_3_Ture_pass    <= 1'd1 ;        
      else 
             Filter_3_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_3_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_3_done    <= 1'd1 ;  
      else  
             Filter_3_done    <= 1'd0 ;                 
      end 
          //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_4_Ture_runing    <= 1'd0 ;       
      else if  (Filter_4_Ture )
             Filter_4_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_4_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_4_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_4_Ture )
             Filter_4_Ture_pass    <= 1'd1 ;        
      else 
             Filter_4_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_4_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_4_done    <= 1'd1 ;  
      else  
             Filter_4_done    <= 1'd0 ;                 
      end 
         
   //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_5_Ture_runing    <= 1'd0 ;       
      else if  (Filter_5_Ture )
             Filter_5_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_5_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_5_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_5_Ture )
             Filter_5_Ture_pass    <= 1'd1 ;        
      else 
             Filter_5_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_5_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_5_done    <= 1'd1 ;  
      else  
             Filter_5_done    <= 1'd0 ;                 
      end 
       //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_6_Ture_runing    <= 1'd0 ;       
      else if  (Filter_6_Ture )
             Filter_6_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_6_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_6_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_6_Ture )
             Filter_6_Ture_pass    <= 1'd1 ;        
      else 
             Filter_6_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_6_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_6_done    <= 1'd1 ;  
      else  
             Filter_6_done    <= 1'd0 ;                 
      end 
    
           //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_7_Ture_runing    <= 1'd0 ;       
      else if  (Filter_7_Ture )
             Filter_7_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_7_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_7_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_7_Ture )
             Filter_7_Ture_pass    <= 1'd1 ;        
      else 
             Filter_7_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_7_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_7_done    <= 1'd1 ;  
      else  
             Filter_7_done    <= 1'd0 ;                 
      end 
          //-----------------------------------------------------------------------  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_8_Ture_runing    <= 1'd0 ;       
      else if  (Filter_8_Ture )
             Filter_8_Ture_runing    <= 1'd1 ;        
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_8_Ture_runing    <= 1'd0 ;         
      end 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_8_Ture_pass    <= 1'd0 ;       
      else if  (!Filter_8_Ture )
             Filter_8_Ture_pass    <= 1'd1 ;        
      else 
             Filter_8_Ture_pass    <= 1'd0 ;         
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Filter_8_done    <= 1'd0 ;              
      else if (Filter_to_cal_Done &&  (Filter_RUNing ==  8'b10000000))       
             Filter_8_done    <= 1'd1 ;  
      else  
             Filter_8_done    <= 1'd0 ;                 
      end  
endmodule
