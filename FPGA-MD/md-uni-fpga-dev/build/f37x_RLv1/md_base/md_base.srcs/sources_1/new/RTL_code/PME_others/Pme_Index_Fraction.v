`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 04:24:41 PM
// Design Name: 
// Module Name: Pme_Index_Fraction
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


module Pme_Index_Fraction(
    input                   Sys_Clk      ,
    input                   Sys_Rst_n    ,  
 
    input                   Pme_Index_Fraction_en,
    input        [31:0]     atomCoorn                , //x
    input        [31:0]     RecipBoxVector           , //x
    input        [31:0]     Ngrid                    , //x  
    input        [31:0]     Ngrid_HEX                , //x  
    output  reg  [31:0]     atomCoorn_Index          , //x
    output  reg  [31:0]     atomCoorn_Fraction       , //x
    output  reg           Pme_Index_Fraction_Done    ,
    
    output reg [31:0]   Coord_ReBox_Mul_A_out  ,
    output reg [31:0]   Coord_ReBox_Mul_B_out  ,
    output reg          Coord_ReBox_Mul_A_Vil  ,
    output reg          Coord_ReBox_Mul_B_Vil  ,
    input      [31:0]   Coord_ReBox_Mul_get_r  ,
    input               Coord_ReBox_Mul_get_vil ,            
    
    output reg [31:0]   T_floor_fix_A_out  ,
    output reg          T_floor_fix_A_Vil  ,
    input      [31:0]   T_floor_fix_get_r  ,
    input               T_floor_fix_get_vil ,
    
    output reg [31:0]   T_floor_float_A_out  ,
    output reg          T_floor_float_A_Vil  ,
    input      [31:0]   T_floor_float_get_r  ,
    input               T_floor_float_get_vil ,  
    
    output reg [31:0]   T_T_floor_SUB_A_out  ,
    output reg [31:0]   T_T_floor_SUB_B_out  ,
    output reg          T_T_floor_SUB_A_Vil  ,
    output reg          T_T_floor_SUB_B_Vil  ,
    input      [31:0]   T_T_floor_SUB_get_r  ,
    input               T_T_floor_SUB_get_vil,
     
    output reg [31:0]   T_Third_Mul_A_out  ,
    output reg [31:0]   T_Third_Mul_B_out  ,
    output reg          T_Third_Mul_A_Vil  ,
    output reg          T_Third_Mul_B_Vil  ,
    input      [31:0]   T_Third_Mul_get_r  ,
    input               T_Third_Mul_get_vil ,
     
    output reg [31:0]   T_int_fix_A_out  ,
    output reg          T_int_fix_A_Vil  ,
    input      [31:0]   T_int_fix_get_r  ,
    input               T_int_fix_get_vil ,
    
    output reg [31:0]   T_int_float_A_out  ,
    output reg          T_int_float_A_Vil  ,
    input      [31:0]   T_int_float_get_r  ,
    input               T_int_float_get_vil ,   
    
    output reg [31:0]   atomCoorn_Fraction_SUB_A_out  ,
    output reg [31:0]   atomCoorn_Fraction_SUB_B_out  ,
    output reg          atomCoorn_Fraction_SUB_A_Vil  ,
    output reg          atomCoorn_Fraction_SUB_B_Vil  ,
    input      [31:0]   atomCoorn_Fraction_SUB_get_r  ,
    input               atomCoorn_Fraction_SUB_get_vil 

    );
    //t        = coord x * RecipBoxVector X  
    //t floor
    //t_Second = t- t floor
    //t_Third  = t_Second * ngrid K(ieee654)
    //tint     = int( t_Third)
    //atomCoorn_Fraction =t_Third -  tint
    //atomCoorn_Index =tint % ngrid k
       
 reg  [4:0]           Coord_ReBox_Mul_State;
 reg  [4:0]           T_floor_fix_State;
 reg  [4:0]           T_floor_float_State;
 reg  [4:0]           T_T_floor_SUB_State;
 reg  [4:0]           T_Third_Mul_State;
 reg  [4:0]           T_int_fix_State;    
 reg  [4:0]           T_int_float_State; 
 reg  [4:0]           atomCoorn_Fraction_SUB_State;
  
 reg                  Coord_ReBox_Mul_en;
 reg                  T_floor_fix_en;              
 reg                  T_floor_float_en;            
 reg                  T_T_floor_SUB_en;           
 reg                  T_Third_Mul_en;              
 reg                  T_int_fix_en;                
 reg                  T_int_float_en;              
 reg                  atomCoorn_Fraction_SUB_en;                                                
                  
 reg   [31:0]         Coord_ReBox;
 reg   [31:0]         T_floor_fix ;               
 reg   [31:0]         T_floor_float ;             
 reg   [31:0]         T_T_floor_SUB ;             
 reg   [31:0]         T_Third_Mul ;               
 reg   [31:0]         T_int_fix ;                 
 reg   [31:0]         T_int_float ;               
  

 reg                  Coord_ReBox_Mul_Done;
 reg                  T_floor_fix_Done;             
 reg                  T_floor_float_Done;           
 reg                  T_T_floor_SUB_Done;           
 reg                  T_Third_Mul_Done;             
 reg                  T_int_fix_Done;               
 reg                  T_int_float_Done;              
 reg                  atomCoorn_Fraction_SUB_Done;
     
// reg                  Pme_Index_Fraction_Done;
 
 reg   [31:0]         atomCoorn_get;
    //--------------------------------------------------------------- 
    //        1  
    //---------------------------------------------------------------  
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              atomCoorn_get      <=  32'd0;   
      else if (Pme_Index_Fraction_en )
              atomCoorn_get      <=  atomCoorn;   
      else if (Pme_Index_Fraction_Done )
              atomCoorn_get      <=  32'd0;                 
      end 

    //--------------------------------------------------------------- 
    //        1  
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Coord_ReBox_Mul_en      <= 1'b0;  
      else if (Pme_Index_Fraction_en )
              Coord_ReBox_Mul_en      <= 1'b1;  
      else 
              Coord_ReBox_Mul_en      <= 1'b0;               
      end 
    //--------------------------------------------------------------- 
    //       2  
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_floor_fix_en      <= 1'b0;  
      else if (Coord_ReBox_Mul_Done )
              T_floor_fix_en      <= 1'b1;  
      else 
              T_floor_fix_en      <= 1'b0;               
      end 
    //--------------------------------------------------------------- 
    //      3  
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_floor_float_en      <= 1'b0;  
      else if (T_floor_fix_Done  )
              T_floor_float_en      <= 1'b1;  
      else 
              T_floor_float_en      <= 1'b0;               
      end 
    //--------------------------------------------------------------- 
    //      4 
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_T_floor_SUB_en      <= 1'b0;  
      else if ( T_floor_float_Done  )
              T_T_floor_SUB_en      <= 1'b1;  
      else 
              T_T_floor_SUB_en      <= 1'b0;               
      end 
    //--------------------------------------------------------------- 
    //     5 
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_Third_Mul_en      <= 1'b0;  
      else if ( T_T_floor_SUB_Done  )
              T_Third_Mul_en      <= 1'b1;  
      else 
              T_Third_Mul_en      <= 1'b0;               
      end   
    //--------------------------------------------------------------- 
    //     6 
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_int_fix_en      <= 1'b0;  
      else if (T_Third_Mul_Done  )
              T_int_fix_en      <= 1'b1;  
      else 
              T_int_fix_en      <= 1'b0;               
      end      
    //--------------------------------------------------------------- 
    //     7 
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              T_int_float_en      <= 1'b0;  
      else if (T_int_fix_Done  )
              T_int_float_en      <= 1'b1;  
      else 
              T_int_float_en      <= 1'b0;               
      end    
    //--------------------------------------------------------------- 
    //    8 
    //--------------------------------------------------------------- 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              atomCoorn_Fraction_SUB_en      <= 1'b0;  
      else if (T_int_float_Done  )
              atomCoorn_Fraction_SUB_en      <= 1'b1;  
      else 
              atomCoorn_Fraction_SUB_en      <= 1'b0;               
      end      

     //--------------------------------------------------------------- 
    //   Coord_ReBox_Mul
    //---------------------------------------------------------------   
 localparam [4:0]
           Coord_ReBox_Mul_RST   = 5'b00001	,
           Coord_ReBox_Mul_IDLE  = 5'b00010	,
           Coord_ReBox_Mul_BEGIN = 5'b00100	,
           Coord_ReBox_Mul_CHK   = 5'b01000	,
           Coord_ReBox_Mul_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Coord_ReBox_Mul_State <= Coord_ReBox_Mul_RST;
     end 
      else begin 
           case( Coord_ReBox_Mul_State)  
            Coord_ReBox_Mul_RST :
                begin
                      Coord_ReBox_Mul_State  <=Coord_ReBox_Mul_IDLE;
                end 
            Coord_ReBox_Mul_IDLE:
                begin
                  if (Coord_ReBox_Mul_en)
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_BEGIN;
                  else
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_IDLE;
                  end 
            Coord_ReBox_Mul_BEGIN:
                 begin
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_CHK;
                 end 
            Coord_ReBox_Mul_CHK:
                  begin
                     if ( Coord_ReBox_Mul_get_vil )
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_END;
                     else
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_CHK;
                   end 
            Coord_ReBox_Mul_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_IDLE;
                      else
                      Coord_ReBox_Mul_State <=Coord_ReBox_Mul_END;
                 end     
                 
       default:       Coord_ReBox_Mul_State <=Coord_ReBox_Mul_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Coord_ReBox_Mul_A_out  <=  32'd0;         
      else if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_BEGIN)      
            Coord_ReBox_Mul_A_out  <= RecipBoxVector  ;
      else if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_IDLE)      
            Coord_ReBox_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Coord_ReBox_Mul_B_out  <=  32'd0;         
      else if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_BEGIN)
            Coord_ReBox_Mul_B_out  <= atomCoorn_get    ;
      else   if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_IDLE)           
            Coord_ReBox_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Coord_ReBox_Mul_A_Vil  <= 1'b0;          
      else if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_BEGIN)
             Coord_ReBox_Mul_A_Vil <= 1'b1;  
      else  if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_IDLE)            
             Coord_ReBox_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Coord_ReBox_Mul_B_Vil <= 1'b0;         
      else if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_BEGIN)
           Coord_ReBox_Mul_B_Vil <= 1'b1;  
      else  if ( Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_IDLE)            
           Coord_ReBox_Mul_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Coord_ReBox            <=  32'd0;          
      else if ( Coord_ReBox_Mul_get_vil )
            Coord_ReBox             <=  Coord_ReBox_Mul_get_r;
      else   if (  Coord_ReBox_Mul_State  ==Coord_ReBox_Mul_IDLE)          
            Coord_ReBox            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Coord_ReBox_Mul_Done           <= 1'b0;            
      else if ( Coord_ReBox_Mul_get_vil&& (Coord_ReBox_Mul_State ==Coord_ReBox_Mul_CHK  ))
            Coord_ReBox_Mul_Done           <= 1'b1;       
      else     
            Coord_ReBox_Mul_Done           <= 1'b0;              
      end 
      
    //--------------------------------------------------------------- 
    //   T_floor_fix
    //---------------------------------------------------------------   
 localparam [4:0]
           T_floor_fix_RST   = 5'b00001	,
           T_floor_fix_IDLE  = 5'b00010	,
           T_floor_fix_BEGIN = 5'b00100	,
           T_floor_fix_CHK   = 5'b01000	,
           T_floor_fix_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_floor_fix_State <= T_floor_fix_RST;
     end 
      else begin 
           case( T_floor_fix_State)  
            T_floor_fix_RST :
                begin
                      T_floor_fix_State  <=T_floor_fix_IDLE;
                end 
            T_floor_fix_IDLE:
                begin
                  if (T_floor_fix_en)
                      T_floor_fix_State <=T_floor_fix_BEGIN;
                  else
                      T_floor_fix_State <=T_floor_fix_IDLE;
                  end 
            T_floor_fix_BEGIN:
                 begin
                      T_floor_fix_State <=T_floor_fix_CHK;
                 end 
            T_floor_fix_CHK:
                  begin
                     if ( T_floor_fix_get_vil )
                      T_floor_fix_State <=T_floor_fix_END;
                     else
                      T_floor_fix_State <=T_floor_fix_CHK;
                   end 
            T_floor_fix_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_floor_fix_State <=T_floor_fix_IDLE;
                      else
                      T_floor_fix_State <=T_floor_fix_END;
                 end     
                 
       default:       T_floor_fix_State <=T_floor_fix_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_fix_A_out  <=  32'd0;         
      else if ( T_floor_fix_State  ==T_floor_fix_BEGIN)      
            T_floor_fix_A_out  <= Coord_ReBox  ;
      else if ( T_floor_fix_State  ==T_floor_fix_IDLE)      
            T_floor_fix_A_out  <= 32'd0;             
      end 
  

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_floor_fix_A_Vil  <= 1'b0;          
      else if ( T_floor_fix_State  ==T_floor_fix_BEGIN)
             T_floor_fix_A_Vil  <= 1'b1;  
      else  if ( T_floor_fix_State  ==T_floor_fix_IDLE)            
             T_floor_fix_A_Vil  <= 1'b0;               
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_fix            <=  32'd0;          
      else if ( T_floor_fix_get_vil )
            T_floor_fix            <=  T_floor_fix_get_r;
      else   if (  T_floor_fix_State  ==T_floor_fix_IDLE)          
            T_floor_fix            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_fix_Done           <= 1'b0;            
      else if ( T_floor_fix_get_vil&& T_floor_fix_State ==T_floor_fix_CHK  )
            T_floor_fix_Done           <= 1'b1;       
      else     
            T_floor_fix_Done           <= 1'b0;              
      end 
      //--------------------------------------------------------------- 
    //   T_floor_float
    //---------------------------------------------------------------   
 localparam [4:0]
           T_floor_float_RST   = 5'b00001	,
           T_floor_float_IDLE  = 5'b00010	,
           T_floor_float_BEGIN = 5'b00100	,
           T_floor_float_CHK   = 5'b01000	,
           T_floor_float_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_floor_float_State <= T_floor_float_RST;
     end 
      else begin 
           case( T_floor_float_State)  
            T_floor_float_RST :
                begin
                      T_floor_float_State  <=T_floor_float_IDLE;
                end 
            T_floor_float_IDLE:
                begin
                  if (T_floor_float_en)
                      T_floor_float_State <=T_floor_float_BEGIN;
                  else
                      T_floor_float_State <=T_floor_float_IDLE;
                  end 
            T_floor_float_BEGIN:
                 begin
                      T_floor_float_State <=T_floor_float_CHK;
                 end 
            T_floor_float_CHK:
                  begin
                     if ( T_floor_float_get_vil )
                      T_floor_float_State <=T_floor_float_END;
                     else
                      T_floor_float_State <=T_floor_float_CHK;
                   end 
            T_floor_float_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_floor_float_State <=T_floor_float_IDLE;
                      else
                      T_floor_float_State <=T_floor_float_END;
                 end     
                 
       default:       T_floor_float_State <=T_floor_float_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_float_A_out  <=  32'd0;         
      else if ( T_floor_float_State  ==T_floor_float_BEGIN)      
            T_floor_float_A_out  <= T_floor_fix  ;
      else if ( T_floor_float_State  ==T_floor_float_IDLE)      
            T_floor_float_A_out  <= 32'd0;             
      end 
      


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_floor_float_A_Vil  <= 1'b0;          
      else if ( T_floor_float_State  ==T_floor_float_BEGIN)
             T_floor_float_A_Vil <= 1'b1;  
      else  if ( T_floor_float_State  ==T_floor_float_IDLE)            
             T_floor_float_A_Vil  <= 1'b0;               
    end


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_float            <=  32'd0;          
      else if ( T_floor_float_get_vil )
            T_floor_float             <=  T_floor_float_get_r;
      else   if (  T_floor_float_State  ==T_floor_float_IDLE)          
            T_floor_float            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_floor_float_Done           <= 1'b0;            
      else if ( T_floor_float_get_vil&& (T_floor_float_State ==T_floor_float_CHK  ))
            T_floor_float_Done           <= 1'b1;       
      else     
            T_floor_float_Done           <= 1'b0;              
      end 
      
     //--------------------------------------------------------------- 
    //   T_T_floor_SUB 
    //---------------------------------------------------------------   
 localparam [4:0]
           T_T_floor_SUB_RST   = 5'b00001	,
           T_T_floor_SUB_IDLE  = 5'b00010	,
           T_T_floor_SUB_BEGIN = 5'b00100	,
           T_T_floor_SUB_CHK   = 5'b01000	,
           T_T_floor_SUB_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_T_floor_SUB_State <= T_T_floor_SUB_RST;
     end 
      else begin 
           case( T_T_floor_SUB_State)  
            T_T_floor_SUB_RST :
                begin
                      T_T_floor_SUB_State  <=T_T_floor_SUB_IDLE;
                end 
            T_T_floor_SUB_IDLE:
                begin
                  if (T_T_floor_SUB_en)
                      T_T_floor_SUB_State <=T_T_floor_SUB_BEGIN;
                  else
                      T_T_floor_SUB_State <=T_T_floor_SUB_IDLE;
                  end 
            T_T_floor_SUB_BEGIN:
                 begin
                      T_T_floor_SUB_State <=T_T_floor_SUB_CHK;
                 end 
            T_T_floor_SUB_CHK:
                  begin
                     if ( T_T_floor_SUB_get_vil )
                      T_T_floor_SUB_State <=T_T_floor_SUB_END;
                     else
                      T_T_floor_SUB_State <=T_T_floor_SUB_CHK;
                   end 
            T_T_floor_SUB_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_T_floor_SUB_State <=T_T_floor_SUB_IDLE;
                      else
                      T_T_floor_SUB_State <=T_T_floor_SUB_END;
                 end     
                 
       default:       T_T_floor_SUB_State <=T_T_floor_SUB_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_T_floor_SUB_A_out  <=  32'd0;         
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_BEGIN)      
            T_T_floor_SUB_A_out  <= Coord_ReBox  ;
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_IDLE)      
            T_T_floor_SUB_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_T_floor_SUB_B_out  <=  32'd0;         
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_BEGIN)
            T_T_floor_SUB_B_out  <= T_floor_float    ;
      else   if ( T_T_floor_SUB_State  ==T_T_floor_SUB_IDLE)           
            T_T_floor_SUB_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_T_floor_SUB_A_Vil  <= 1'b0;          
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_BEGIN)
             T_T_floor_SUB_A_Vil <= 1'b1;  
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_IDLE)            
             T_T_floor_SUB_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           T_T_floor_SUB_B_Vil <= 1'b0;         
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_BEGIN)
           T_T_floor_SUB_B_Vil <= 1'b1;  
      else if ( T_T_floor_SUB_State  ==T_T_floor_SUB_IDLE)            
           T_T_floor_SUB_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_T_floor_SUB            <=  32'd0;          
      else if ( T_T_floor_SUB_get_vil )
            T_T_floor_SUB             <=  T_T_floor_SUB_get_r;
      else   if (  T_T_floor_SUB_State  ==T_T_floor_SUB_IDLE)          
            T_T_floor_SUB            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_T_floor_SUB_Done           <= 1'b0;            
      else if ( T_T_floor_SUB_get_vil&& T_T_floor_SUB_State ==T_T_floor_SUB_CHK  )
            T_T_floor_SUB_Done           <= 1'b1;       
      else     
            T_T_floor_SUB_Done           <= 1'b0;              
      end 
    
    //--------------------------------------------------------------- 
    //   T_Third_Mul
    //---------------------------------------------------------------   
 localparam [4:0]
           T_Third_Mul_RST   = 5'b00001	,
           T_Third_Mul_IDLE  = 5'b00010	,
           T_Third_Mul_BEGIN = 5'b00100	,
           T_Third_Mul_CHK   = 5'b01000	,
           T_Third_Mul_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_Third_Mul_State <= T_Third_Mul_RST;
     end 
      else begin 
           case( T_Third_Mul_State)  
            T_Third_Mul_RST :
                begin
                      T_Third_Mul_State  <=T_Third_Mul_IDLE;
                end 
            T_Third_Mul_IDLE:
                begin
                  if (T_Third_Mul_en)
                      T_Third_Mul_State <=T_Third_Mul_BEGIN;
                  else
                      T_Third_Mul_State <=T_Third_Mul_IDLE;
                  end 
            T_Third_Mul_BEGIN:
                 begin
                      T_Third_Mul_State <=T_Third_Mul_CHK;
                 end 
            T_Third_Mul_CHK:
                  begin
                     if ( T_Third_Mul_get_vil )
                      T_Third_Mul_State <=T_Third_Mul_END;
                     else
                      T_Third_Mul_State <=T_Third_Mul_CHK;
                   end 
            T_Third_Mul_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_Third_Mul_State <=T_Third_Mul_IDLE;
                      else
                      T_Third_Mul_State <=T_Third_Mul_END;
                 end     
                 
       default:       T_Third_Mul_State <=T_Third_Mul_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_Third_Mul_A_out  <=  32'd0;         
      else if ( T_Third_Mul_State  ==T_Third_Mul_BEGIN)      
            T_Third_Mul_A_out  <=  T_T_floor_SUB  ;
      else if ( T_Third_Mul_State  ==T_Third_Mul_IDLE)      
            T_Third_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_Third_Mul_B_out  <=  32'd0;         
      else if ( T_Third_Mul_State  ==T_Third_Mul_BEGIN)
            T_Third_Mul_B_out  <=  Ngrid_HEX    ;
      else   if ( T_Third_Mul_State  ==T_Third_Mul_IDLE)           
            T_Third_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_Third_Mul_A_Vil  <= 1'b0;          
      else if ( T_Third_Mul_State  ==T_Third_Mul_BEGIN)
             T_Third_Mul_A_Vil <= 1'b1;  
      else  if ( T_Third_Mul_State  ==T_Third_Mul_IDLE)            
             T_Third_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           T_Third_Mul_B_Vil <= 1'b0;         
      else if ( T_Third_Mul_State  ==T_Third_Mul_BEGIN)
           T_Third_Mul_B_Vil <= 1'b1;  
      else  if ( T_Third_Mul_State  ==T_Third_Mul_IDLE)            
           T_Third_Mul_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_Third_Mul            <=  32'd0;          
      else if ( T_Third_Mul_get_vil )
            T_Third_Mul             <=  T_Third_Mul_get_r;
      else   if (  T_Third_Mul_State  ==T_Third_Mul_IDLE)          
            T_Third_Mul            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_Third_Mul_Done           <= 1'b0;            
      else if ( T_Third_Mul_get_vil&& T_Third_Mul_State ==T_Third_Mul_CHK  )
            T_Third_Mul_Done           <= 1'b1;       
      else     
            T_Third_Mul_Done           <= 1'b0;              
      end   
    
        //--------------------------------------------------------------- 
    //   T_int_fix
    //---------------------------------------------------------------   
 localparam [4:0]
           T_int_fix_RST   = 5'b00001	,
           T_int_fix_IDLE  = 5'b00010	,
           T_int_fix_BEGIN = 5'b00100	,
           T_int_fix_CHK   = 5'b01000	,
           T_int_fix_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_int_fix_State <= T_int_fix_RST;
     end 
      else begin 
           case( T_int_fix_State)  
            T_int_fix_RST :
                begin
                      T_int_fix_State  <=T_int_fix_IDLE;
                end 
            T_int_fix_IDLE:
                begin
                  if (T_int_fix_en)
                      T_int_fix_State <=T_int_fix_BEGIN;
                  else
                      T_int_fix_State <=T_int_fix_IDLE;
                  end 
            T_int_fix_BEGIN:
                 begin
                      T_int_fix_State <=T_int_fix_CHK;
                 end 
            T_int_fix_CHK:
                  begin
                     if ( T_int_fix_get_vil )
                      T_int_fix_State <=T_int_fix_END;
                     else
                      T_int_fix_State <=T_int_fix_CHK;
                   end 
            T_int_fix_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_int_fix_State <=T_int_fix_IDLE;
                      else
                      T_int_fix_State <=T_int_fix_END;
                 end     
                 
       default:       T_int_fix_State <=T_int_fix_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_fix_A_out  <=  32'd0;         
      else if ( T_int_fix_State  ==T_int_fix_BEGIN)      
            T_int_fix_A_out  <= T_Third_Mul  ;
      else if ( T_int_fix_State  ==T_int_fix_IDLE)      
            T_int_fix_A_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_int_fix_A_Vil  <= 1'b0;          
      else if ( T_int_fix_State  ==T_int_fix_BEGIN)
             T_int_fix_A_Vil <= 1'b1;  
      else  if ( T_int_fix_State  ==T_int_fix_IDLE)            
             T_int_fix_A_Vil  <= 1'b0;               
      end 
     

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_fix            <=  32'd0;          
      else if ( T_int_fix_get_vil )
            T_int_fix             <=  T_int_fix_get_r;
      else   if (  T_int_fix_State  ==T_int_fix_IDLE)          
            T_int_fix            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_fix_Done           <= 1'b0;            
      else if ( T_int_fix_get_vil&& T_int_fix_State ==T_int_fix_CHK  )
            T_int_fix_Done           <= 1'b1;       
      else     
            T_int_fix_Done           <= 1'b0;              
      end 
      //--------------------------------------------------------------- 
    //   T_int_float
    //---------------------------------------------------------------   
 localparam [4:0]
           T_int_float_RST   = 5'b00001	,
           T_int_float_IDLE  = 5'b00010	,
           T_int_float_BEGIN = 5'b00100	,
           T_int_float_CHK   = 5'b01000	,
           T_int_float_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       T_int_float_State <= T_int_float_RST;
     end 
      else begin 
           case( T_int_float_State)  
            T_int_float_RST :
                begin
                      T_int_float_State  <=T_int_float_IDLE;
                end 
            T_int_float_IDLE:
                begin
                  if (T_int_float_en)
                      T_int_float_State <=T_int_float_BEGIN;
                  else
                      T_int_float_State <=T_int_float_IDLE;
                  end 
            T_int_float_BEGIN:
                 begin
                      T_int_float_State <=T_int_float_CHK;
                 end 
            T_int_float_CHK:
                  begin
                     if ( T_int_float_get_vil )
                      T_int_float_State <=T_int_float_END;
                     else
                      T_int_float_State <=T_int_float_CHK;
                   end 
            T_int_float_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      T_int_float_State <=T_int_float_IDLE;
                      else
                      T_int_float_State <=T_int_float_END;
                 end     
                 
       default:       T_int_float_State <=T_int_float_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_float_A_out  <=  32'd0;         
      else if ( T_int_float_State  ==T_int_float_BEGIN)      
            T_int_float_A_out  <=   T_int_fix ;
      else if ( T_int_float_State  ==T_int_float_IDLE)      
            T_int_float_A_out  <= 32'd0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             T_int_float_A_Vil  <= 1'b0;          
      else if ( T_int_float_State  ==T_int_float_BEGIN)
             T_int_float_A_Vil <= 1'b1;  
      else  if ( T_int_float_State  ==T_int_float_IDLE)            
             T_int_float_A_Vil  <= 1'b0;               
      end 
      


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_float            <=  32'd0;          
      else if ( T_int_float_get_vil )
            T_int_float             <=  T_int_float_get_r;
      else   if (  T_int_float_State  ==T_int_float_IDLE)          
            T_int_float            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            T_int_float_Done           <= 1'b0;            
      else if ( T_int_float_get_vil&& T_int_float_State ==T_int_float_CHK  )
            T_int_float_Done           <= 1'b1;       
      else     
            T_int_float_Done           <= 1'b0;              
      end 
      //--------------------------------------------------------------- 
    //   atomCoorn_Fraction
    //---------------------------------------------------------------   
 localparam [4:0]
           atomCoorn_Fraction_SUB_RST   = 5'b00001	,
           atomCoorn_Fraction_SUB_IDLE  = 5'b00010	,
           atomCoorn_Fraction_SUB_BEGIN = 5'b00100	,
           atomCoorn_Fraction_SUB_CHK   = 5'b01000	,
           atomCoorn_Fraction_SUB_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       atomCoorn_Fraction_SUB_State <= atomCoorn_Fraction_SUB_RST;
     end 
      else begin 
           case( atomCoorn_Fraction_SUB_State)  
            atomCoorn_Fraction_SUB_RST :
                begin
                      atomCoorn_Fraction_SUB_State  <=atomCoorn_Fraction_SUB_IDLE;
                end 
            atomCoorn_Fraction_SUB_IDLE:
                begin
                  if (atomCoorn_Fraction_SUB_en)
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_BEGIN;
                  else
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_IDLE;
                  end 
            atomCoorn_Fraction_SUB_BEGIN:
                 begin
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_CHK;
                 end 
            atomCoorn_Fraction_SUB_CHK:
                  begin
                     if ( atomCoorn_Fraction_SUB_get_vil )
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_END;
                     else
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_CHK;
                   end 
            atomCoorn_Fraction_SUB_END:
                 begin        
                    if  ( Pme_Index_Fraction_Done )        
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_IDLE;
                      else
                      atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_END;
                 end     
                 
       default:       atomCoorn_Fraction_SUB_State <=atomCoorn_Fraction_SUB_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            atomCoorn_Fraction_SUB_A_out  <=  32'd0;         
      else if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_BEGIN)      
            atomCoorn_Fraction_SUB_A_out  <= Coord_ReBox  ;
      else if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_IDLE)      
            atomCoorn_Fraction_SUB_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            atomCoorn_Fraction_SUB_B_out  <=  32'd0;         
      else if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_BEGIN)
            atomCoorn_Fraction_SUB_B_out  <= T_floor_float    ;
      else   if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_IDLE)           
            atomCoorn_Fraction_SUB_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             atomCoorn_Fraction_SUB_A_Vil  <= 1'b0;          
      else if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_BEGIN)
             atomCoorn_Fraction_SUB_A_Vil <= 1'b1;  
      else  if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_IDLE)            
             atomCoorn_Fraction_SUB_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           atomCoorn_Fraction_SUB_B_Vil <= 1'b0;         
      else if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_BEGIN)
           atomCoorn_Fraction_SUB_B_Vil <= 1'b1;  
      else  if ( atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_IDLE)            
            atomCoorn_Fraction_SUB_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            atomCoorn_Fraction            <=  32'd0;          
      else if ( atomCoorn_Fraction_SUB_get_vil )
            atomCoorn_Fraction             <=  atomCoorn_Fraction_SUB_get_r;
      else   if (  atomCoorn_Fraction_SUB_State  ==atomCoorn_Fraction_SUB_IDLE)          
            atomCoorn_Fraction            <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            atomCoorn_Fraction_SUB_Done           <= 1'b0;            
      else if ( atomCoorn_Fraction_SUB_get_vil&& (atomCoorn_Fraction_SUB_State ==atomCoorn_Fraction_SUB_CHK  ))
            atomCoorn_Fraction_SUB_Done           <= 1'b1;       
      else     
            atomCoorn_Fraction_SUB_Done           <= 1'b0;              
      end 
    
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)      
            atomCoorn_Index  <=  32'd0;         
       else if     (atomCoorn_Fraction_SUB_Done)
            atomCoorn_Index <=T_int_fix % Ngrid  ;        
       else if  (Pme_Index_Fraction_Done     )
            atomCoorn_Index  <=  32'd0;       
       end 
    
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)      
            Pme_Index_Fraction_Done   <= 1'b0;          
       else if     (atomCoorn_Fraction_SUB_Done)
            Pme_Index_Fraction_Done  <= 1'b1;          
       else 
            Pme_Index_Fraction_Done   <= 1'b0;       
       end 
      
endmodule
