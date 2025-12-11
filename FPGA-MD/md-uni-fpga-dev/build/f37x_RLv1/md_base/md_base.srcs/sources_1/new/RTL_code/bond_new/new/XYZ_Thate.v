`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2023 02:50:46 PM
// Design Name: 
// Module Name: XYZ_Thate
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


module XYZ_Thate(
 input                 Sys_Clk  ,
 input                 Sys_Rst_n,
 output reg            XYZ_Cos_done, 
                   
input    [95:0]         Index_bond_A_in,
input                   Index_bond_A_en,
input    [95:0]         Index_bond_B_in,
input                   Index_bond_B_en,
input    [95:0]         Index_bond_C_in,
input                   Index_bond_C_en,

 input                  Home0_cell_cal_finish,
  output reg [31:0]     XYZ_Cos,


 //X to caculation mul unit 
 output reg [31:0]     Point_MUL_A_out ,
 output reg            Point_MUL_A_Vil ,
 output reg            Point_MUL_B_Vil ,
 output reg [31:0]     Point_MUL_B_out ,
 input      [31:0]     Point_MUL_get_r ,
 input                 Point_MUL_get_vil,

   //Z to caculation mul unit 
 output reg [31:0]     Cos_DIR_A_out ,
 output reg            Cos_DIR_A_Vil ,
 output reg            Cos_DIR_B_Vil ,
 output reg [31:0]     Cos_DIR_B_out ,
 input      [31:0]     Cos_DIR_get_r ,
 input                 Cos_DIR_get_vil ,
 
        //X to caculation sub unit          
 output reg [31:0]     XYZ_Cos_A_out ,  //cos(n * fai -sigma) 
 output reg            XYZ_Cos_A_Vil ,   
 input      [31:0]     XYZ_Cos_get_r ,  
 input                 XYZ_Cos_get_vil 
 

     );
     // ---------------------------------------- -----------------------       
//  --state
 
 
reg [7:0]         Point_MUL_flow_cnt_State   ;
reg [7:0]         Cos_DIR_flow_cnt_State   ;

reg [7:0]         Point_MUL_CNT               ;

 reg [7:0]         Cos_DIR_CNT              ;
 reg               Mul_done               ;
 reg [31:0]        Point_result           ;
 reg               Point_MUL_en               ;  
 reg               Cos_DIR_en               ;
 reg [31:0]        Cos_thate              ;
 reg               R_Root_Done            ;
 reg               DIR_done               ;
 reg               Force_Sub_Done         ;
   
reg                XYZ_Cos_en            ;
//reg [31:0]         XYZ_Cos               ;
//reg                XYZ_Cos_done          ;
reg [6:0]          XYZ_Cos_CNT           ;
reg [6:0]          XYZ_Cos_flow_cnt_State;
 //-------------------------------------------------------    

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Point_MUL_en      <= 1'b0;  
      else if (Index_bond_A_in )
              Point_MUL_en      <= 1'b1;  
      else 
              Point_MUL_en      <= 1'b0;               
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Cos_DIR_en      <= 1'b0;  
      else if (Mul_done )
              Cos_DIR_en      <= 1'b1;  
      else 
              Cos_DIR_en      <= 1'b0;               
      end 

 

    //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------   
  localparam [4:0]
           Point_MUL_flow_cnt_RST   = 5'b00001	,
           Point_MUL_flow_cnt_IDLE  = 5'b00010	,
           Point_MUL_flow_cnt_BEGIN = 5'b00100	,
           Point_MUL_flow_cnt_CHK   = 5'b01000	,
           Point_MUL_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Point_MUL_flow_cnt_State <= Point_MUL_flow_cnt_RST;
     end 
      else begin 
           case( Point_MUL_flow_cnt_State)  
            Point_MUL_flow_cnt_RST :
                begin
                      Point_MUL_flow_cnt_State  <=Point_MUL_flow_cnt_IDLE;
                end 
            Point_MUL_flow_cnt_IDLE:
                begin
                  if (Point_MUL_en)
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_BEGIN;
                  else
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_IDLE;
                  end 
            Point_MUL_flow_cnt_BEGIN:
                 begin
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_CHK;
                 end 
            Point_MUL_flow_cnt_CHK:
                  begin
                     if ( Point_MUL_get_vil && Point_MUL_CNT ==   5'd10    )
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_END;
                     else
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_CHK;
                   end 
            Point_MUL_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_IDLE;
                      else
                      Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_END;
                 end     
                 
       default:       Point_MUL_flow_cnt_State <=Point_MUL_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_MUL_A_out  <=  32'd0;         
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_BEGIN)      
            Point_MUL_A_out  <= Index_bond_A_in    ;
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_IDLE)      
            Point_MUL_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_MUL_B_out  <=  32'd0;         
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_BEGIN)
            Point_MUL_B_out  <= Index_bond_B_in    ;
      else   if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_IDLE)           
            Point_MUL_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_MUL_A_Vil  <= 1'b0;          
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_BEGIN)
            Point_MUL_A_Vil <= 1'b1;  
      else  if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_IDLE)            
            Point_MUL_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_MUL_B_Vil <= 1'b0;         
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_BEGIN)
            Point_MUL_B_Vil <= 1'b1;  
      else  if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_IDLE)            
            Point_MUL_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_result            <=  32'd0;          
      else if  ( Point_MUL_get_vil && Point_MUL_CNT ==   5'd10    )
            Point_result             <=  Point_MUL_get_r;
      else   if (  Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_IDLE)          
            Point_result             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Mul_done           <= 1'b0;            
      else if  ( Point_MUL_get_vil && Point_MUL_CNT ==   5'd10    )
            Mul_done           <= 1'b1;       
      else        
            Mul_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Point_MUL_CNT  <=  5'd0;         
      else if ( Point_MUL_flow_cnt_State  ==Point_MUL_flow_cnt_CHK)      
            Point_MUL_CNT  <= Point_MUL_CNT + 5'd1  ;
      else  
            Point_MUL_CNT   <=  5'd0;              
      end     
       //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------   
  localparam [4:0]
           Cos_DIR_flow_cnt_RST   = 5'b00001	,
           Cos_DIR_flow_cnt_IDLE  = 5'b00010	,
           Cos_DIR_flow_cnt_BEGIN = 5'b00100	,
           Cos_DIR_flow_cnt_CHK   = 5'b01000	,
           Cos_DIR_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Cos_DIR_flow_cnt_State <= Cos_DIR_flow_cnt_RST;
     end 
      else begin 
           case( Cos_DIR_flow_cnt_State)  
            Cos_DIR_flow_cnt_RST :
                begin
                      Cos_DIR_flow_cnt_State  <=Cos_DIR_flow_cnt_IDLE;
                end 
            Cos_DIR_flow_cnt_IDLE:
                begin
                  if (Cos_DIR_en)
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_BEGIN;
                  else
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_IDLE;
                  end 
            Cos_DIR_flow_cnt_BEGIN:
                 begin
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_CHK;
                 end 
            Cos_DIR_flow_cnt_CHK:
                  begin
                     if ( Cos_DIR_get_vil && Cos_DIR_CNT ==   5'd10    )
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_END;
                     else
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_CHK;
                   end 
            Cos_DIR_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_IDLE;
                      else
                      Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_END;
                 end     
                 
       default:       Cos_DIR_flow_cnt_State <=Cos_DIR_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_DIR_A_out  <=  32'd0;         
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_BEGIN)      
            Cos_DIR_A_out  <= Point_result    ;
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_IDLE)      
            Cos_DIR_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_DIR_B_out  <=  32'd0;         
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_BEGIN)
            Cos_DIR_B_out  <= Index_bond_C_en    ;
      else   if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_IDLE)           
            Cos_DIR_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_DIR_A_Vil  <= 1'b0;          
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_BEGIN)
            Cos_DIR_A_Vil <= 1'b1;  
      else  if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_IDLE)            
            Cos_DIR_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_DIR_B_Vil <= 1'b0;         
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_BEGIN)
            Cos_DIR_B_Vil <= 1'b1;  
      else  if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_IDLE)            
            Cos_DIR_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_thate            <=  32'd0;          
      else if  ( Cos_DIR_get_vil && Cos_DIR_CNT ==   5'd10    )
            Cos_thate             <=  Cos_DIR_get_r;
      else   if (  Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_IDLE)          
            Cos_thate             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             DIR_done           <= 1'b0;            
      else if  ( Cos_DIR_get_vil && Cos_DIR_CNT ==   5'd10    )
            DIR_done           <= 1'b1;       
      else        
            DIR_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Cos_DIR_CNT  <=  5'd0;         
      else if ( Cos_DIR_flow_cnt_State  ==Cos_DIR_flow_cnt_CHK)      
            Cos_DIR_CNT  <= Cos_DIR_CNT + 5'd1  ;
      else  
            Cos_DIR_CNT   <=  5'd0;              
      end        
 
 //-----------------------------------------------------------------------
//             bond accumlation
//-----------------------------------------------------------------------
localparam [4:0]
           XYZ_Cos_flow_cnt_RST   = 5'b00001	,
           XYZ_Cos_flow_cnt_IDLE  = 5'b00010	,
           XYZ_Cos_flow_cnt_BEGIN = 5'b00100	,
           XYZ_Cos_flow_cnt_CHK   = 5'b01000	,
           XYZ_Cos_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       XYZ_Cos_flow_cnt_State <= XYZ_Cos_flow_cnt_RST;
     end 
      else begin 
           case( XYZ_Cos_flow_cnt_State)  
            XYZ_Cos_flow_cnt_RST :
                begin
                      XYZ_Cos_flow_cnt_State  <=XYZ_Cos_flow_cnt_IDLE;
                end 
            XYZ_Cos_flow_cnt_IDLE:
                begin
                  if (XYZ_Cos_en)
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_BEGIN;
                  else
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_IDLE;
                  end 
            XYZ_Cos_flow_cnt_BEGIN:
                 begin
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_CHK;
                 end 
            XYZ_Cos_flow_cnt_CHK:
                  begin
                     if ( XYZ_Cos_get_vil &&( XYZ_Cos_CNT == 5'd12))
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_END;
                     else
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_CHK;
                   end 
            XYZ_Cos_flow_cnt_END:
                 begin        
                    if  ( Force_Sub_Done )        
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_IDLE;
                      else
                      XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_END;
                 end     
                 
       default:       XYZ_Cos_flow_cnt_State <=XYZ_Cos_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XYZ_Cos_A_out  <=  32'd0;         
      else if ( XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_BEGIN)      
            XYZ_Cos_A_out  <=    Cos_thate  ;
      else if ( XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_IDLE)      
            XYZ_Cos_A_out  <= 32'd0;             
      end 
      


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XYZ_Cos_A_Vil  <= 1'b0;          
      else if ( XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_BEGIN)
            XYZ_Cos_A_Vil <= 1'b1;  
      else  if ( XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_IDLE)            
            XYZ_Cos_A_Vil  <= 1'b0;               
      end 
      

      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XYZ_Cos             <=  32'd0;          
      else if ( XYZ_Cos_get_vil &&( XYZ_Cos_CNT == 5'd12))
            XYZ_Cos             <=  XYZ_Cos_get_r;
      else   if (  XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_IDLE)          
            XYZ_Cos             <= 32'd0;       
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XYZ_Cos_done           <= 1'b0;            
      else if ( XYZ_Cos_get_vil &&( XYZ_Cos_CNT == 5'd12))
            XYZ_Cos_done           <= 1'b1;       
      else     
            XYZ_Cos_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XYZ_Cos_CNT  <=  5'd0;         
      else if ( XYZ_Cos_flow_cnt_State  ==XYZ_Cos_flow_cnt_CHK)      
            XYZ_Cos_CNT  <= XYZ_Cos_CNT + 5'd1  ;
      else 
            XYZ_Cos_CNT   <=  5'd0;              
      end       
    
      
     
endmodule