`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 06:11:54 PM
// Design Name: 
// Module Name: YFFT_2RAM_Module
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


module YFFT_2RAM_Module #  (parameter  Loop_times         =  14'd4096,
                            parameter  Loop_times_Before  =  6'b111111,
                            parameter  Loop_times_AFTER  =  14'd64, //4096/64
                            parameter  X_K_value         =  9'd64,
                            parameter  Y_K_value         =  9'd64,
                            parameter  Z_K_value         =  9'd64 
                             
                            )
(
 input                        Sys_Clk              , 
 input                        Sys_Rst_n            , 
 
 output reg                   YFFT_Running         ,
  
 input                        FFT_Forward_begin    ,
 input                        FFT_Backward_begin   ,
 
 output reg                   YFFT_Forward_end     ,
 output reg                   YFFT_Backward_end    ,
 //------------------------------------------------------ 
 output reg                   M_AXIS_Q_Rd_en       ,     
 input           [63:0]       M_AXIS_Q_Rd_data     ,
 output reg      [31:0]       M_AXIS_Q_Rd_addr     ,  // read data from Ram_Q
 //------------------------------------------------------    
       
output reg                 M_AXIS_1_YFFT_Wr_en   ,    // write data to ram
output reg   [511:0]       M_AXIS_1_YFFT_Wr_data ,
output reg     [15:0]      M_AXIS_1_YFFT_Wr_addr ,
                                          
output reg                 M_AXIS_2_YFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_2_YFFT_Wr_data ,
output reg     [15:0]      M_AXIS_2_YFFT_Wr_addr ,
                                           
output  reg                M_AXIS_3_YFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_3_YFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_3_YFFT_Wr_addr ,
                                                 
output  reg                M_AXIS_4_YFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_4_YFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_4_YFFT_Wr_addr ,
                                           
output reg                 M_AXIS_5_YFFT_Wr_en   ,
output reg    [511:0]      M_AXIS_5_YFFT_Wr_data ,
output reg      [15:0]     M_AXIS_5_YFFT_Wr_addr ,
                                                  
output  reg                M_AXIS_6_YFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_6_YFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_6_YFFT_Wr_addr ,
                                          
output  reg                M_AXIS_7_YFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_7_YFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_7_YFFT_Wr_addr ,
                                                  
output reg                 M_AXIS_8_YFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_8_YFFT_Wr_data ,
output reg     [15:0]      M_AXIS_8_YFFT_Wr_addr ,
 //------------------------------------------------------    
                                                      //read data to FFT 
 output  reg     [15:0]      Before_1_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_2_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_3_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_4_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_5_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_6_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_7_YFFT_Rd_addr  ,
 output  reg     [15:0]      Before_8_YFFT_Rd_addr  ,  
                                                       
  //------------------------------------------------------    
                                                   
 output reg                   YFFT_1_vaild_en,            
 output  reg     [15:0]       YFFT_1_Loop_Num,
 input                        YFFT_1_Done     ,
 output   reg                 YFFT_1_Before_en,
 
  output reg                  YFFT_2_vaild_en,            
 output  reg     [15:0]       YFFT_2_Loop_Num,
 input                        YFFT_2_Done     ,
 output   reg                 YFFT_2_Before_en,
 
 output reg                   YFFT_3_vaild_en,  
 output  reg     [15:0]       YFFT_3_Loop_Num,
 input                        YFFT_3_Done     ,
 output   reg                 YFFT_3_Before_en,
 
   output reg                 YFFT_4_vaild_en,  
 output  reg     [15:0]       YFFT_4_Loop_Num,
 input                        YFFT_4_Done     ,
 output   reg                 YFFT_4_Before_en,
 
   output reg                 YFFT_5_vaild_en,  
 output  reg      [15:0]      YFFT_5_Loop_Num,
 input                        YFFT_5_Done     ,
 output   reg                 YFFT_5_Before_en,

   output reg                 YFFT_6_vaild_en,  
  output  reg     [15:0]      YFFT_6_Loop_Num,
 input                        YFFT_6_Done     ,
 output   reg                 YFFT_6_Before_en,

   output reg                 YFFT_7_vaild_en,  
  output  reg     [15:0]      YFFT_7_Loop_Num,
 input                        YFFT_7_Done     ,
 output   reg                 YFFT_7_Before_en,

 output reg                   YFFT_8_vaild_en,  
 output  reg     [15:0]       YFFT_8_Loop_Num,
 input                        YFFT_8_Done     ,
 output   reg                 YFFT_8_Before_en ,  
  //------------------------------------------------------  
 //write data to FFT 
  output  reg     [11:0]       YFFT_1_W_Loop_Num,
  output  reg     [11:0]       YFFT_2_W_Loop_Num,
  output  reg     [11:0]       YFFT_3_W_Loop_Num,
  output  reg     [11:0]       YFFT_4_W_Loop_Num,
  output  reg     [11:0]       YFFT_5_W_Loop_Num,
  output  reg     [11:0]       YFFT_6_W_Loop_Num,
  output  reg     [11:0]       YFFT_7_W_Loop_Num,
  output  reg     [11:0]       YFFT_8_W_Loop_Num 
    );

 reg                Wr_1_RAM_en;
 reg                Wr_2_RAM_en;
 reg                Wr_3_RAM_en;
 reg                Wr_4_RAM_en;
 reg                Wr_5_RAM_en;
 reg                Wr_6_RAM_en;
 reg                Wr_7_RAM_en;
 reg                Wr_8_RAM_en; 
 
 reg                YFFT_1_wr_Done;
 reg                YFFT_2_wr_Done;
 reg                YFFT_3_wr_Done;
 reg                YFFT_4_wr_Done;
 reg                YFFT_5_wr_Done;
 reg                YFFT_6_wr_Done;
 reg                YFFT_7_wr_Done;
 reg                YFFT_8_wr_Done;
 reg                YFFT_wr_Done;
 
reg     [3:0]       YFFT_1_wr_State;
reg     [3:0]       YFFT_2_wr_State;
reg     [3:0]       YFFT_3_wr_State;
reg     [3:0]       YFFT_4_wr_State;
reg     [3:0]       YFFT_5_wr_State;
reg     [3:0]       YFFT_6_wr_State;
reg     [3:0]       YFFT_7_wr_State;
reg     [3:0]       YFFT_8_wr_State;

reg   [511:0]       Before_Data_YFFT;
reg    [7:0]        Data_Loop_Num;
reg                 X_Data_Loop_8_plus;
reg                 X_Data_Loop_8_plu_en;

reg     [9:0]        YFFT_Rd_Q_State;

reg     [7:0]        X_AXI_Loop_Num;
reg     [7:0]        Y_AXI_Loop_Num;
reg     [7:0]        Z_AXI_Loop_Num;   
 
reg     [5:0]        Before_YFFT_1_Rd_State ;   
reg     [15:0]       Before_YFFT_1_Rd_Loop_Num;
reg                  Before_YFFT_1_Rd_Done;

reg     [5:0]        Before_YFFT_2_Rd_State ;   
reg     [15:0]       Before_YFFT_2_Rd_Loop_Num;
reg                  Before_YFFT_2_Rd_Done;

reg     [5:0]        Before_YFFT_3_Rd_State ;   
reg     [15:0]       Before_YFFT_3_Rd_Loop_Num;
reg                  Before_YFFT_3_Rd_Done;

reg     [5:0]        Before_YFFT_4_Rd_State ;   
reg     [15:0]       Before_YFFT_4_Rd_Loop_Num;
reg                  Before_YFFT_4_Rd_Done;

reg     [5:0]        Before_YFFT_5_Rd_State ;   
reg     [15:0]       Before_YFFT_5_Rd_Loop_Num;
reg                  Before_YFFT_5_Rd_Done;

reg     [5:0]        Before_YFFT_6_Rd_State ;   
reg     [15:0]       Before_YFFT_6_Rd_Loop_Num;
reg                  Before_YFFT_6_Rd_Done;

reg     [5:0]        Before_YFFT_7_Rd_State ;   
reg     [15:0]       Before_YFFT_7_Rd_Loop_Num;
reg                  Before_YFFT_7_Rd_Done;

reg     [4:0]        Before_YFFT_8_Rd_State ;   
reg     [15:0]       Before_YFFT_8_Rd_Loop_Num;
reg                  Before_YFFT_8_Rd_Done;
//reg                  Before_8_YFFT_Rd_en;

reg                  YFFT_1_W_Done;
reg     [4:0]        AFTER_YFFT_1_W_State;
//reg     [15:0]       YFFT_1_W_Loop_Num;

reg                  YFFT_2_W_Done;
reg     [4:0]        AFTER_YFFT_2_W_State;
//reg     [15:0]       YFFT_2_W_Loop_Num;

reg                  YFFT_3_W_Done;
reg     [4:0]        AFTER_YFFT_3_W_State;
//reg     [15:0]       YFFT_3_W_Loop_Num;

reg                  YFFT_4_W_Done;
reg     [4:0]        AFTER_YFFT_4_W_State;
//reg     [15:0]       YFFT_4_W_Loop_Num;

reg                  YFFT_5_W_Done;
reg     [4:0]        AFTER_YFFT_5_W_State;
//reg     [15:0]       YFFT_5_W_Loop_Num;

reg                  YFFT_6_W_Done;
reg     [4:0]        AFTER_YFFT_6_W_State;
//reg     [15:0]       YFFT_6_W_Loop_Num;

reg                  YFFT_7_W_Done;
reg     [4:0]        AFTER_YFFT_7_W_State;
//reg     [15:0]       YFFT_7_W_Loop_Num;

reg                  YFFT_8_W_Done;
reg     [4:0]        AFTER_YFFT_8_W_State;
//reg     [15:0]       YFFT_8_W_Loop_Num; 

reg                 YFFT_1_W_Finish;
reg                 YFFT_2_W_Finish; 
reg                 YFFT_3_W_Finish; 
reg                 YFFT_4_W_Finish; 
reg                 YFFT_5_W_Finish; 
reg                 YFFT_6_W_Finish; 
reg                 YFFT_7_W_Finish; 
reg                 YFFT_8_W_Finish;
reg                 YFFT_W_Finish;
reg                 YFFT_ALL_wr_Done;
//////////////////////////////////////////////////////////////////////////////////
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
       YFFT_Running <=   1'b0 ;
 else if (FFT_Forward_begin)  
       YFFT_Running <=   1'b1 ;
  else if (YFFT_Forward_end)  
       YFFT_Running <=   1'b0 ;
 end    

//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       YFFT_wr_Done         <=   1'b0 ;
 else  
       YFFT_wr_Done         <=     YFFT_1_wr_Done|| YFFT_2_wr_Done||YFFT_3_wr_Done||YFFT_4_wr_Done 
                                 ||YFFT_5_wr_Done|| YFFT_6_wr_Done||YFFT_7_wr_Done||YFFT_8_wr_Done ;  // wr  512  
 end    
//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       YFFT_W_Finish         <=   1'b0 ;
 else  
       YFFT_W_Finish         <=    YFFT_1_W_Finish && YFFT_2_W_Finish && YFFT_3_W_Finish && YFFT_4_W_Finish 
                                && YFFT_5_W_Finish && YFFT_6_W_Finish && YFFT_7_W_Finish && YFFT_8_W_Finish ;  
 end   
 //////////////////////////////////////////////////////////////////////////////////
localparam [8:0]
           YFFT_Rd_Q_RST   = 9'b00000001	,
           YFFT_Rd_Q_IDLE  = 9'b00000010	,
           YFFT_Rd_Q_ADD   = 9'b00000100	,
           YFFT_Rd_Q_BEGIN = 9'b00001000	,
           YFFT_Rd_Q_Buf   = 9'b00010000	,
           YFFT_Rd_Q_Buf2  = 9'b00100000	,
           YFFT_Rd_Q_COR   = 9'b01000000	,             
           YFFT_Rd_Q_END   = 9'b10000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_Rd_Q_State <=YFFT_Rd_Q_RST;
     end 
      else begin 
           case( YFFT_Rd_Q_State)  
            YFFT_Rd_Q_RST :
                begin
                      YFFT_Rd_Q_State <=YFFT_Rd_Q_IDLE;
                end 
            YFFT_Rd_Q_IDLE:
                begin
                  if   ( FFT_Forward_begin  ) 
                      YFFT_Rd_Q_State <=YFFT_Rd_Q_BEGIN;
                  else
                      YFFT_Rd_Q_State <=YFFT_Rd_Q_IDLE;
                  end 
                     
             YFFT_Rd_Q_ADD:
                 begin                   
                        YFFT_Rd_Q_State <= YFFT_Rd_Q_BEGIN;         
                  end 
             YFFT_Rd_Q_BEGIN:
                 begin
                    if(  X_AXI_Loop_Num ==  X_K_value)
                        YFFT_Rd_Q_State <= YFFT_Rd_Q_Buf;  
                    else if (X_Data_Loop_8_plus)
                        YFFT_Rd_Q_State <= YFFT_Rd_Q_ADD;
                    else    
                        YFFT_Rd_Q_State <= YFFT_Rd_Q_BEGIN;       
                 end       
              YFFT_Rd_Q_Buf:
                 begin
                    if ( Y_AXI_Loop_Num ==  Y_K_value-1) 
                      YFFT_Rd_Q_State  <= YFFT_Rd_Q_Buf2;
                    else
                      YFFT_Rd_Q_State  <= YFFT_Rd_Q_BEGIN;
                 end                   
              YFFT_Rd_Q_Buf2:
                 begin
                    if ( Z_AXI_Loop_Num ==  Z_K_value-1) 
                      YFFT_Rd_Q_State  <= YFFT_Rd_Q_COR;
                    else
                      YFFT_Rd_Q_State  <= YFFT_Rd_Q_BEGIN;
                 end        
             YFFT_Rd_Q_COR:
                   begin 
                      YFFT_Rd_Q_State <=YFFT_Rd_Q_END;               
                   end 
             YFFT_Rd_Q_END:
                   begin 
                      YFFT_Rd_Q_State <=YFFT_Rd_Q_IDLE;               
                   end 
         default:     YFFT_Rd_Q_State <=YFFT_Rd_Q_IDLE;
     endcase
   end 
 end   
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_AXI_Loop_Num         <=   8'd0  ;
      else if  (YFFT_Rd_Q_State == YFFT_Rd_Q_Buf  )
           X_AXI_Loop_Num         <=   8'd0  ;                 
      else if  (YFFT_Rd_Q_State ==  YFFT_Rd_Q_ADD) 
           X_AXI_Loop_Num         <=   X_AXI_Loop_Num + 8'd1 ;      
            
      end 
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y_AXI_Loop_Num         <=   8'd0  ;  
      else if  (YFFT_Rd_Q_State == YFFT_Rd_Q_Buf2  )
           Y_AXI_Loop_Num         <=   8'd0  ;           
      else if  (YFFT_Rd_Q_State ==  YFFT_Rd_Q_Buf)
           Y_AXI_Loop_Num         <=   Y_AXI_Loop_Num + 1'b1 ;                 
                    
      end    
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Z_AXI_Loop_Num         <=   8'd0  ;  
      else if  (YFFT_Rd_Q_State == YFFT_Rd_Q_COR  )
           Z_AXI_Loop_Num         <=   8'd0  ;           
      else if  (YFFT_Rd_Q_State ==  YFFT_Rd_Q_Buf2)
           Z_AXI_Loop_Num         <=   Z_AXI_Loop_Num + 1'b1 ;                 
                 
      end    
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Data_Loop_Num         <=   16'b0 ;
      else if ( (YFFT_Rd_Q_State ==  YFFT_Rd_Q_ADD)&&(Data_Loop_Num <=  16'd8)  ) 
           Data_Loop_Num         <=  Data_Loop_Num+ 1'b1 ;                          // 8         
      else if  (YFFT_wr_Done)  
           Data_Loop_Num         <=   16'b0 ;    
      else if (YFFT_Rd_Q_State == YFFT_Rd_Q_COR)    
           Data_Loop_Num         <=   16'b0 ;                 
      end    
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_Data_Loop_8_plus         <=   1'b0  ;  
      else if (Data_Loop_Num <   8'd7    )
           X_Data_Loop_8_plus         <=   1'b1 ;                                    // 8 
      else   
           X_Data_Loop_8_plus         <=   1'b0  ;              
      end   
       
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_Data_Loop_8_plu_en         <=   1'b0  ;  
      else if (Data_Loop_Num ==  8'd7   )
           X_Data_Loop_8_plu_en         <=   1'b1 ;                                   // 8 
      else   
           X_Data_Loop_8_plu_en         <=   1'b0  ;              
      end    

      
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_Data_YFFT          <=  512'd0  ;               
      else if(YFFT_Rd_Q_State == YFFT_Rd_Q_ADD)
           Before_Data_YFFT  <= {Before_Data_YFFT[447:0],64'd0  } ; 
       
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_Data_YFFT          <=  512'd0  ;               
      else if(YFFT_Rd_Q_State == YFFT_Rd_Q_BEGIN)
           Before_Data_YFFT[63:0]   <= {24'd0 ,Data_Loop_Num,M_AXIS_Q_Rd_data } ; 
          
      end     
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_en        <=    1'b0  ;            
      else if(YFFT_Rd_Q_State == YFFT_Rd_Q_ADD)
           M_AXIS_Q_Rd_en        <=    1'b1  ; 
      else   
           M_AXIS_Q_Rd_en        <=    1'b0  ;              
      end  

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_addr         <=   32'd0  ;                
      else if (YFFT_Rd_Q_State == YFFT_Rd_Q_ADD)
           M_AXIS_Q_Rd_addr         <=   Z_AXI_Loop_Num * Y_K_value*X_K_value+ Y_AXI_Loop_Num*X_K_value + X_AXI_Loop_Num ;     
      else   
           M_AXIS_Q_Rd_addr         <=   32'd0  ;              
      end 
//////////////////////////////////////////////////////////////////////////////////      
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_1_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd7  ) )
          Wr_1_RAM_en     <=    1'b1  ;              
      else   
          Wr_1_RAM_en     <=    1'b0  ;                    
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_2_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd15  )&&  (Y_AXI_Loop_Num >=  8'd8 ))
          Wr_2_RAM_en     <=    1'b1  ;              
      else   
          Wr_2_RAM_en     <=    1'b0  ;                    
      end 

  
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_3_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd23  )&&  (Y_AXI_Loop_Num >=  8'd16 ))
          Wr_3_RAM_en     <=    1'b1  ;              
      else   
          Wr_3_RAM_en     <=    1'b0  ;                    
      end 
      
   
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_4_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd31  )&&  (Y_AXI_Loop_Num >=  8'd24 ))
          Wr_4_RAM_en     <=    1'b1  ;              
      else   
          Wr_4_RAM_en     <=    1'b0  ;                    
      end      
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_5_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd39  )&&  (Y_AXI_Loop_Num >=  8'd32 ))
          Wr_5_RAM_en     <=    1'b1  ;              
      else   
          Wr_5_RAM_en     <=    1'b0  ;                    
      end           
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_6_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd47  )&&  (Y_AXI_Loop_Num >=  8'd40 ))
          Wr_6_RAM_en     <=    1'b1  ;              
      else   
          Wr_6_RAM_en     <=    1'b0  ;                    
      end         

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_7_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd55  )&&  (Y_AXI_Loop_Num >=  8'd48 ))
          Wr_7_RAM_en     <=    1'b1  ;              
      else   
          Wr_7_RAM_en     <=    1'b0  ;                    
      end         
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
          Wr_8_RAM_en     <=    1'b0  ;                   
      else if ( X_Data_Loop_8_plu_en && (Y_AXI_Loop_Num <=  8'd63  )&&  (Y_AXI_Loop_Num >=  8'd56 ))
          Wr_8_RAM_en     <=    1'b1  ;              
      else   
          Wr_8_RAM_en     <=    1'b0  ;                    
      end         
                                       
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_1_wr_RST   = 5'b00001	,
           YFFT_1_wr_IDLE  = 5'b00010	,
           YFFT_1_wr_BEGIN = 5'b00100	, 
           YFFT_1_wr_BUF   = 5'b01000	,       
           YFFT_1_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_1_wr_State <=YFFT_1_wr_RST;
     end 
      else begin 
           case( YFFT_1_wr_State)  
            YFFT_1_wr_RST :
                begin
                      YFFT_1_wr_State <=YFFT_1_wr_IDLE;
                end 
            YFFT_1_wr_IDLE:
                begin
                  if (Wr_1_RAM_en  ) 
                      YFFT_1_wr_State <=YFFT_1_wr_BEGIN;
                  else
                      YFFT_1_wr_State <=YFFT_1_wr_IDLE;
                 end 
            YFFT_1_wr_BUF:
                 begin
                      YFFT_1_wr_State <=YFFT_1_wr_IDLE;         
                 end    
            YFFT_1_wr_BEGIN:
                 begin
                    if (YFFT_1_Loop_Num ==  Loop_times) 
                      YFFT_1_wr_State <=YFFT_1_wr_END;
                    else
                      YFFT_1_wr_State <=YFFT_1_wr_BUF;   
                 end 
                                           
             YFFT_1_wr_END:
                   begin 
                      YFFT_1_wr_State <=YFFT_1_wr_IDLE;               
                   end 
         default:     YFFT_1_wr_State <=YFFT_1_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_1_wr_State == YFFT_1_wr_BEGIN) )
           M_AXIS_1_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_1_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_Loop_Num         <=   8'd0  ;                
      else if (YFFT_1_wr_State == YFFT_1_wr_BEGIN)
           YFFT_1_Loop_Num         <=   YFFT_1_Loop_Num + 1'b1 ;      
      else  if (YFFT_1_Loop_Num ==  Loop_times)  
           YFFT_1_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_1_wr_State == YFFT_1_wr_BEGIN)
           M_AXIS_1_YFFT_Wr_addr         <=   YFFT_1_Loop_Num  ;      
      else   
           M_AXIS_1_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_1_wr_State == YFFT_1_wr_BEGIN)
           M_AXIS_1_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_1_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_wr_Done          <= 1'b0 ;                    
      else if (YFFT_1_wr_State == YFFT_1_wr_BUF)
           YFFT_1_wr_Done          <= 1'b1 ;      
      else   
           YFFT_1_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_2_wr_RST   = 5'b00001	,
           YFFT_2_wr_IDLE  = 5'b00010	,
           YFFT_2_wr_BEGIN = 5'b00100	, 
           YFFT_2_wr_BUF   = 5'b01000	,       
           YFFT_2_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_2_wr_State <=YFFT_2_wr_RST;
     end 
      else begin 
           case( YFFT_2_wr_State)  
            YFFT_2_wr_RST :
                begin
                      YFFT_2_wr_State <=YFFT_2_wr_IDLE;
                end 
            YFFT_2_wr_IDLE:
                begin
                  if (Wr_2_RAM_en  ) 
                      YFFT_2_wr_State <=YFFT_2_wr_BEGIN;
                  else
                      YFFT_2_wr_State <=YFFT_2_wr_IDLE;
                 end 
            YFFT_2_wr_BUF:
                 begin
                      YFFT_2_wr_State <=YFFT_2_wr_IDLE;         
                 end    
            YFFT_2_wr_BEGIN:
                 begin
                    if (YFFT_2_Loop_Num ==  Loop_times) 
                      YFFT_2_wr_State <=YFFT_2_wr_END;
                    else
                      YFFT_2_wr_State <=YFFT_2_wr_BUF;   
                 end 
                                           
             YFFT_2_wr_END:
                   begin 
                      YFFT_2_wr_State <=YFFT_2_wr_IDLE;               
                   end 
         default:     YFFT_2_wr_State <=YFFT_2_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_2_wr_State == YFFT_2_wr_BEGIN) )
           M_AXIS_2_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_2_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_Loop_Num         <=   8'd0  ;                
      else if (YFFT_2_wr_State == YFFT_2_wr_BEGIN)
           YFFT_2_Loop_Num         <=   YFFT_2_Loop_Num + 1'b1 ;      
      else  if (YFFT_2_Loop_Num ==  Loop_times)  
           YFFT_2_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_2_wr_State == YFFT_2_wr_BEGIN)
           M_AXIS_2_YFFT_Wr_addr         <=   YFFT_2_Loop_Num  ;      
      else   
           M_AXIS_2_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_2_wr_State == YFFT_2_wr_BEGIN)
           M_AXIS_2_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_2_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_wr_Done          <= 1'b0 ;                    
      else if (YFFT_2_wr_State == YFFT_2_wr_BUF)
           YFFT_2_wr_Done          <= 1'b1 ;      
      else   
           YFFT_2_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_3_wr_RST   = 5'b00001	,
           YFFT_3_wr_IDLE  = 5'b00010	,
           YFFT_3_wr_BEGIN = 5'b00100	, 
           YFFT_3_wr_BUF   = 5'b01000	,       
           YFFT_3_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_3_wr_State <=YFFT_3_wr_RST;
     end 
      else begin 
           case( YFFT_3_wr_State)  
            YFFT_3_wr_RST :
                begin
                      YFFT_3_wr_State <=YFFT_3_wr_IDLE;
                end 
            YFFT_3_wr_IDLE:
                begin
                  if (Wr_3_RAM_en  ) 
                      YFFT_3_wr_State <=YFFT_3_wr_BEGIN;
                  else
                      YFFT_3_wr_State <=YFFT_3_wr_IDLE;
                 end 
            YFFT_3_wr_BUF:
                 begin
                      YFFT_3_wr_State <=YFFT_3_wr_IDLE;         
                 end    
            YFFT_3_wr_BEGIN:
                 begin
                    if (YFFT_3_Loop_Num ==  Loop_times) 
                      YFFT_3_wr_State <=YFFT_3_wr_END;
                    else
                      YFFT_3_wr_State <=YFFT_3_wr_BUF;   
                 end 
                                           
             YFFT_3_wr_END:
                   begin 
                      YFFT_3_wr_State <=YFFT_3_wr_IDLE;               
                   end 
         default:     YFFT_3_wr_State <=YFFT_3_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_3_wr_State == YFFT_3_wr_BEGIN) )
           M_AXIS_3_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_3_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_Loop_Num         <=   8'd0  ;                
      else if (YFFT_3_wr_State == YFFT_3_wr_BEGIN)
           YFFT_3_Loop_Num         <=   YFFT_3_Loop_Num + 1'b1 ;      
      else  if (YFFT_3_Loop_Num ==  Loop_times)  
           YFFT_3_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_3_wr_State == YFFT_3_wr_BEGIN)
           M_AXIS_3_YFFT_Wr_addr         <=   YFFT_3_Loop_Num  ;      
      else   
           M_AXIS_3_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_3_wr_State == YFFT_3_wr_BEGIN)
           M_AXIS_3_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_3_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_wr_Done          <= 1'b0 ;                    
      else if (YFFT_3_wr_State == YFFT_3_wr_BUF)
           YFFT_3_wr_Done          <= 1'b1 ;      
      else   
           YFFT_3_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_4_wr_RST   = 5'b00001	,
           YFFT_4_wr_IDLE  = 5'b00010	,
           YFFT_4_wr_BEGIN = 5'b00100	, 
           YFFT_4_wr_BUF   = 5'b01000	,       
           YFFT_4_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_4_wr_State <=YFFT_4_wr_RST;
     end 
      else begin 
           case( YFFT_4_wr_State)  
            YFFT_4_wr_RST :
                begin
                      YFFT_4_wr_State <=YFFT_4_wr_IDLE;
                end 
            YFFT_4_wr_IDLE:
                begin
                  if (Wr_4_RAM_en  ) 
                      YFFT_4_wr_State <=YFFT_4_wr_BEGIN;
                  else
                      YFFT_4_wr_State <=YFFT_4_wr_IDLE;
                 end 
            YFFT_4_wr_BUF:
                 begin
                      YFFT_4_wr_State <=YFFT_4_wr_IDLE;         
                 end    
            YFFT_4_wr_BEGIN:
                 begin
                    if (YFFT_4_Loop_Num ==  Loop_times) 
                      YFFT_4_wr_State <=YFFT_4_wr_END;
                    else
                      YFFT_4_wr_State <=YFFT_4_wr_BUF;   
                 end 
                                           
             YFFT_4_wr_END:
                   begin 
                      YFFT_4_wr_State <=YFFT_4_wr_IDLE;               
                   end 
         default:     YFFT_4_wr_State <=YFFT_4_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_4_wr_State == YFFT_4_wr_BEGIN) )
           M_AXIS_4_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_4_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_Loop_Num         <=   8'd0  ;                
      else if (YFFT_4_wr_State == YFFT_4_wr_BEGIN)
           YFFT_4_Loop_Num         <=   YFFT_4_Loop_Num + 1'b1 ;      
      else  if (YFFT_4_Loop_Num ==  Loop_times)  
           YFFT_4_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_4_wr_State == YFFT_4_wr_BEGIN)
           M_AXIS_4_YFFT_Wr_addr         <=   YFFT_4_Loop_Num  ;      
      else   
           M_AXIS_4_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_4_wr_State == YFFT_4_wr_BEGIN)
           M_AXIS_4_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_4_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_wr_Done          <= 1'b0 ;                    
      else if (YFFT_4_wr_State == YFFT_4_wr_BUF)
           YFFT_4_wr_Done          <= 1'b1 ;      
      else   
           YFFT_4_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_5_wr_RST   = 5'b00001	,
           YFFT_5_wr_IDLE  = 5'b00010	,
           YFFT_5_wr_BEGIN = 5'b00100	, 
           YFFT_5_wr_BUF   = 5'b01000	,       
           YFFT_5_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_5_wr_State <=YFFT_5_wr_RST;
     end 
      else begin 
           case( YFFT_5_wr_State)  
            YFFT_5_wr_RST :
                begin
                      YFFT_5_wr_State <=YFFT_5_wr_IDLE;
                end 
            YFFT_5_wr_IDLE:
                begin
                  if (Wr_5_RAM_en  ) 
                      YFFT_5_wr_State <=YFFT_5_wr_BEGIN;
                  else
                      YFFT_5_wr_State <=YFFT_5_wr_IDLE;
                 end 
            YFFT_5_wr_BUF:
                 begin
                      YFFT_5_wr_State <=YFFT_5_wr_IDLE;         
                 end    
            YFFT_5_wr_BEGIN:
                 begin
                    if (YFFT_5_Loop_Num ==  Loop_times) 
                      YFFT_5_wr_State <=YFFT_5_wr_END;
                    else
                      YFFT_5_wr_State <=YFFT_5_wr_BUF;   
                 end 
                                           
             YFFT_5_wr_END:
                   begin 
                      YFFT_5_wr_State <=YFFT_5_wr_IDLE;               
                   end 
         default:     YFFT_5_wr_State <=YFFT_5_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_5_wr_State == YFFT_5_wr_BEGIN) )
           M_AXIS_5_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_5_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_Loop_Num         <=   8'd0  ;                
      else if (YFFT_5_wr_State == YFFT_5_wr_BEGIN)
           YFFT_5_Loop_Num         <=   YFFT_5_Loop_Num + 1'b1 ;      
      else  if (YFFT_5_Loop_Num ==  Loop_times)  
           YFFT_5_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_5_wr_State == YFFT_5_wr_BEGIN)
           M_AXIS_5_YFFT_Wr_addr         <=   YFFT_5_Loop_Num  ;      
      else   
           M_AXIS_5_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_5_wr_State == YFFT_5_wr_BEGIN)
           M_AXIS_5_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_5_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_wr_Done          <= 1'b0 ;                    
      else if (YFFT_5_wr_State == YFFT_5_wr_BUF)
           YFFT_5_wr_Done          <= 1'b1 ;      
      else   
           YFFT_5_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_6_wr_RST   = 5'b00001	,
           YFFT_6_wr_IDLE  = 5'b00010	,
           YFFT_6_wr_BEGIN = 5'b00100	, 
           YFFT_6_wr_BUF   = 5'b01000	,       
           YFFT_6_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_6_wr_State <=YFFT_6_wr_RST;
     end 
      else begin 
           case( YFFT_6_wr_State)  
            YFFT_6_wr_RST :
                begin
                      YFFT_6_wr_State <=YFFT_6_wr_IDLE;
                end 
            YFFT_6_wr_IDLE:
                begin
                  if (Wr_6_RAM_en  ) 
                      YFFT_6_wr_State <=YFFT_6_wr_BEGIN;
                  else
                      YFFT_6_wr_State <=YFFT_6_wr_IDLE;
                 end 
            YFFT_6_wr_BUF:
                 begin
                      YFFT_6_wr_State <=YFFT_6_wr_IDLE;         
                 end    
            YFFT_6_wr_BEGIN:
                 begin
                    if (YFFT_6_Loop_Num ==  Loop_times) 
                      YFFT_6_wr_State <=YFFT_6_wr_END;
                    else
                      YFFT_6_wr_State <=YFFT_6_wr_BUF;   
                 end 
                                           
             YFFT_6_wr_END:
                   begin 
                      YFFT_6_wr_State <=YFFT_6_wr_IDLE;               
                   end 
         default:     YFFT_6_wr_State <=YFFT_6_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_6_wr_State == YFFT_6_wr_BEGIN) )
           M_AXIS_6_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_6_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_Loop_Num         <=   8'd0  ;                
      else if (YFFT_6_wr_State == YFFT_6_wr_BEGIN)
           YFFT_6_Loop_Num         <=   YFFT_6_Loop_Num + 1'b1 ;      
      else  if (YFFT_6_Loop_Num ==  Loop_times)  
           YFFT_6_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_6_wr_State == YFFT_6_wr_BEGIN)
           M_AXIS_6_YFFT_Wr_addr         <=   YFFT_6_Loop_Num  ;      
      else   
           M_AXIS_6_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_6_wr_State == YFFT_6_wr_BEGIN)
           M_AXIS_6_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_6_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_wr_Done          <= 1'b0 ;                    
      else if (YFFT_6_wr_State == YFFT_6_wr_BUF)
           YFFT_6_wr_Done          <= 1'b1 ;      
      else   
           YFFT_6_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_7_wr_RST   = 5'b00001	,
           YFFT_7_wr_IDLE  = 5'b00010	,
           YFFT_7_wr_BEGIN = 5'b00100	, 
           YFFT_7_wr_BUF   = 5'b01000	,       
           YFFT_7_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_7_wr_State <=YFFT_7_wr_RST;
     end 
      else begin 
           case( YFFT_7_wr_State)  
            YFFT_7_wr_RST :
                begin
                      YFFT_7_wr_State <=YFFT_7_wr_IDLE;
                end 
            YFFT_7_wr_IDLE:
                begin
                  if (Wr_7_RAM_en  ) 
                      YFFT_7_wr_State <=YFFT_7_wr_BEGIN;
                  else
                      YFFT_7_wr_State <=YFFT_7_wr_IDLE;
                 end 
            YFFT_7_wr_BUF:
                 begin
                      YFFT_7_wr_State <=YFFT_7_wr_IDLE;         
                 end    
            YFFT_7_wr_BEGIN:
                 begin
                    if (YFFT_7_Loop_Num ==  Loop_times) 
                      YFFT_7_wr_State <=YFFT_7_wr_END;
                    else
                      YFFT_7_wr_State <=YFFT_7_wr_BUF;   
                 end 
                                           
             YFFT_7_wr_END:
                   begin 
                      YFFT_7_wr_State <=YFFT_7_wr_IDLE;               
                   end 
         default:     YFFT_7_wr_State <=YFFT_7_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_7_wr_State == YFFT_7_wr_BEGIN) )
           M_AXIS_7_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_7_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_Loop_Num         <=   8'd0  ;                
      else if (YFFT_7_wr_State == YFFT_7_wr_BEGIN)
           YFFT_7_Loop_Num         <=   YFFT_7_Loop_Num + 1'b1 ;      
      else  if (YFFT_7_Loop_Num ==  Loop_times)  
           YFFT_7_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_7_wr_State == YFFT_7_wr_BEGIN)
           M_AXIS_7_YFFT_Wr_addr         <=   YFFT_7_Loop_Num  ;      
      else   
           M_AXIS_7_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_7_wr_State == YFFT_7_wr_BEGIN)
           M_AXIS_7_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_7_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_wr_Done          <= 1'b0 ;                    
      else if (YFFT_7_wr_State == YFFT_7_wr_BUF)
           YFFT_7_wr_Done          <= 1'b1 ;      
      else   
           YFFT_7_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////// 
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           YFFT_8_wr_RST   = 5'b00001	,
           YFFT_8_wr_IDLE  = 5'b00010	,
           YFFT_8_wr_BEGIN = 5'b00100	, 
           YFFT_8_wr_BUF   = 5'b01000	,       
           YFFT_8_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      YFFT_8_wr_State <=YFFT_8_wr_RST;
     end 
      else begin 
           case( YFFT_8_wr_State)  
            YFFT_8_wr_RST :
                begin
                      YFFT_8_wr_State <=YFFT_8_wr_IDLE;
                end 
            YFFT_8_wr_IDLE:
                begin
                  if (Wr_8_RAM_en  ) 
                      YFFT_8_wr_State <=YFFT_8_wr_BEGIN;
                  else
                      YFFT_8_wr_State <=YFFT_8_wr_IDLE;
                 end   
                
            YFFT_8_wr_BEGIN:
                 begin
                    if (YFFT_8_Loop_Num ==  Loop_times) 
                      YFFT_8_wr_State <=YFFT_8_wr_END;
                    else
                      YFFT_8_wr_State <=YFFT_8_wr_BUF;   
                 end 
            YFFT_8_wr_BUF:                                  
                 begin                                      
                     YFFT_8_wr_State <=YFFT_8_wr_IDLE; 
                 end                                     
             YFFT_8_wr_END:
                   begin 
                      YFFT_8_wr_State <=YFFT_8_wr_IDLE;               
                   end 
         default:     YFFT_8_wr_State <=YFFT_8_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_YFFT_Wr_en          <= 1'b0 ;                 
      else if ((YFFT_8_wr_State == YFFT_8_wr_BEGIN) )
           M_AXIS_8_YFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_8_YFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_Loop_Num         <=   8'd0  ;                
      else if (YFFT_8_wr_State == YFFT_8_wr_BEGIN)
           YFFT_8_Loop_Num         <=   YFFT_8_Loop_Num + 1'b1 ;      
      else  if (YFFT_8_Loop_Num ==  Loop_times)  
           YFFT_8_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_YFFT_Wr_addr         <=   8'd0  ;                
      else if (YFFT_8_wr_State == YFFT_8_wr_BEGIN)
           M_AXIS_8_YFFT_Wr_addr         <=   YFFT_8_Loop_Num  ;      
      else   
           M_AXIS_8_YFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_YFFT_Wr_data          <=  512'd0  ;               
      else if (YFFT_8_wr_State == YFFT_8_wr_BEGIN)
           M_AXIS_8_YFFT_Wr_data<=   Before_Data_YFFT; 
      else   
           M_AXIS_8_YFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_wr_Done          <= 1'b0 ;                    
      else if (YFFT_8_wr_State == YFFT_8_wr_BUF)
           YFFT_8_wr_Done          <= 1'b1 ;      
      else   
           YFFT_8_wr_Done          <= 1'b0 ;                          
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_ALL_wr_Done          <= 1'b0 ;                    
      else if (YFFT_1_Loop_Num == 63 && YFFT_1_wr_State == YFFT_1_wr_BEGIN)
            YFFT_ALL_wr_Done          <= 1'b1 ;      
      else   
            YFFT_ALL_wr_Done          <= 1'b0 ;                          
      end  

      
//////////////////////////////////////////////////////////////////////////////////
//   TEANSFORM DATA TO FFT IP CORE                                              //
//////////////////////////////////////////////////////////////////////////////////    

localparam [5:0]
           Before_YFFT_1_Rd_RST   = 6'b000001	,
           Before_YFFT_1_Rd_IDLE  = 6'b000010	,
           Before_YFFT_1_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_1_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_1_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_1_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_1_Rd_State)  
            Before_YFFT_1_Rd_RST :
                begin
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_IDLE;
                end 
            Before_YFFT_1_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_BEGIN;
                  else
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_IDLE;
                 end 
            Before_YFFT_1_Rd_BEGIN:
                 begin
                    if (Before_YFFT_1_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_END;
                    else if((Before_YFFT_1_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) )                   
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_Wait;
                    else
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_BEGIN;
                 end

             Before_YFFT_1_Rd_Wait:
                 begin 
                    if ( YFFT_1_W_Done) 
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_BEGIN;
                    else
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_Wait;
                 end                                      
             Before_YFFT_1_Rd_END:
                   begin 
                      Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_IDLE;               
                   end 
         default:     Before_YFFT_1_Rd_State <=Before_YFFT_1_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_1_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_1_Rd_State == Before_YFFT_1_Rd_BEGIN )  
           Before_YFFT_1_Rd_Loop_Num         <=   Before_YFFT_1_Rd_Loop_Num + 1'b1 ;      
      else if ( Before_YFFT_1_Rd_State  == Before_YFFT_1_Rd_END) 
           Before_YFFT_1_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_1_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_1_Rd_State == Before_YFFT_1_Rd_BEGIN)
            Before_1_YFFT_Rd_addr         <=   Before_YFFT_1_Rd_Loop_Num  ;      
      else  if( Before_YFFT_1_Rd_State == Before_YFFT_1_Rd_END)   
            Before_1_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_Before_en        <= 1'b0 ;                       
      else if   (Before_YFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           YFFT_1_Before_en        <= 1'b1 ;            
      else   
           YFFT_1_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_1_vaild_en          <= 1'b0 ;                 
      else if  (   Before_YFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            YFFT_1_vaild_en          <= 1'b1 ;        
      else   
            YFFT_1_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_1_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_1_Rd_State == Before_YFFT_1_Rd_END)
           Before_YFFT_1_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_1_Rd_Done          <= 1'b0 ;                          
      end
      
      
   

localparam [5:0]
           Before_YFFT_2_Rd_RST   = 6'b000001	,
           Before_YFFT_2_Rd_IDLE  = 6'b000010	,
           Before_YFFT_2_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_2_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_2_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_2_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_2_Rd_State)  
            Before_YFFT_2_Rd_RST :
                begin
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_IDLE;
                end 
            Before_YFFT_2_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_BEGIN;
                  else
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_IDLE;
                 end 
            Before_YFFT_2_Rd_BEGIN:
                 begin
                    if (Before_YFFT_2_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_END;
                    else  if( (Before_YFFT_2_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before) )
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_Wait;
                    else
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_BEGIN;
                 end
 
             Before_YFFT_2_Rd_Wait:
                 begin 
                    if ( YFFT_2_W_Done) 
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_BEGIN;
                    else
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_Wait;
                 end      
                 
             Before_YFFT_2_Rd_END:
                   begin 
                      Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_IDLE;               
                   end 
         default:     Before_YFFT_2_Rd_State <=Before_YFFT_2_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_2_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_2_Rd_State == Before_YFFT_2_Rd_BEGIN )   
           Before_YFFT_2_Rd_Loop_Num         <=   Before_YFFT_2_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_YFFT_2_Rd_State ==Before_YFFT_2_Rd_END)  
           Before_YFFT_2_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_2_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_2_Rd_State == Before_YFFT_2_Rd_BEGIN)
            Before_2_YFFT_Rd_addr         <=   Before_YFFT_2_Rd_Loop_Num  ;      
      else  if( Before_YFFT_2_Rd_State ==Before_YFFT_2_Rd_END)   
            Before_2_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_Before_en        <= 1'b0 ;                       
      else if  (Before_YFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
           YFFT_2_Before_en        <= 1'b1 ;            
      else   
           YFFT_2_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_2_vaild_en          <= 1'b0 ;                 
      else if   (Before_YFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
            YFFT_2_vaild_en          <= 1'b1 ;        
      else   
            YFFT_2_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_2_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_2_Rd_State == Before_YFFT_2_Rd_END)
           Before_YFFT_2_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_2_Rd_Done          <= 1'b0 ;                          
      end
      
  
localparam [5:0]
           Before_YFFT_3_Rd_RST   = 6'b000001	,
           Before_YFFT_3_Rd_IDLE  = 6'b000010	,
           Before_YFFT_3_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_3_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_3_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_3_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_3_Rd_State)  
            Before_YFFT_3_Rd_RST :
                begin
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_IDLE;
                end 
            Before_YFFT_3_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_BEGIN;
                  else
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_IDLE;
                 end 
           Before_YFFT_3_Rd_BEGIN:
                 begin
                    if (Before_YFFT_3_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_END;
                    else if((Before_YFFT_3_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_Wait;
                    else
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_BEGIN;
                 end

             Before_YFFT_3_Rd_Wait:
                 begin 
                    if ( YFFT_3_W_Done) 
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_BEGIN;
                    else
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_Wait;
                 end                  
                 
             Before_YFFT_3_Rd_END:
                   begin 
                      Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_IDLE;               
                   end 
         default:     Before_YFFT_3_Rd_State <=Before_YFFT_3_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_3_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_3_Rd_State == Before_YFFT_3_Rd_BEGIN&& Before_YFFT_3_Rd_Loop_Num <=Loop_times)   
           Before_YFFT_3_Rd_Loop_Num         <=   Before_YFFT_3_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_YFFT_3_Rd_State == Before_YFFT_3_Rd_END)     
           Before_YFFT_3_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_3_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_3_Rd_State == Before_YFFT_3_Rd_BEGIN)
            Before_3_YFFT_Rd_addr         <=   Before_YFFT_3_Rd_Loop_Num  ;      
      else  if( Before_YFFT_3_Rd_State == Before_YFFT_3_Rd_END)     
            Before_3_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_Before_en        <= 1'b0 ;                       
      else if (Before_YFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
           YFFT_3_Before_en        <= 1'b1 ;            
      else   
           YFFT_3_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_3_vaild_en          <= 1'b0 ;                 
      else if  (Before_YFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
            YFFT_3_vaild_en          <= 1'b1 ;        
      else   
            YFFT_3_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_3_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_3_Rd_State == Before_YFFT_3_Rd_END)
           Before_YFFT_3_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_3_Rd_Done          <= 1'b0 ;                          
      end
      
 localparam [5:0]
           Before_YFFT_4_Rd_RST   = 6'b000001	,
           Before_YFFT_4_Rd_IDLE  = 6'b000010	,
           Before_YFFT_4_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_4_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_4_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_4_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_4_Rd_State)  
            Before_YFFT_4_Rd_RST :
                begin
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_IDLE;
                end 
            Before_YFFT_4_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_BEGIN;
                  else
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_IDLE;
                 end 
           Before_YFFT_4_Rd_BEGIN:
                 begin
                    if (Before_YFFT_4_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_END;
                    else if((Before_YFFT_4_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_Wait;
                    else
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_BEGIN;
                 end

             Before_YFFT_4_Rd_Wait:
                 begin 
                    if ( YFFT_4_W_Done) 
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_BEGIN;
                    else
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_Wait;
                 end                  
                 
                 
             Before_YFFT_4_Rd_END:
                   begin 
                      Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_IDLE;               
                   end 
         default:     Before_YFFT_4_Rd_State <=Before_YFFT_4_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_4_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_4_Rd_State == Before_YFFT_4_Rd_BEGIN&& Before_YFFT_4_Rd_Loop_Num <=Loop_times)   
           Before_YFFT_4_Rd_Loop_Num         <=   Before_YFFT_4_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_YFFT_4_Rd_State ==Before_YFFT_4_Rd_END)     
           Before_YFFT_4_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_4_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_4_Rd_State == Before_YFFT_4_Rd_BEGIN)
            Before_4_YFFT_Rd_addr         <=   Before_YFFT_4_Rd_Loop_Num  ;      
      else  if( Before_YFFT_4_Rd_State ==Before_YFFT_4_Rd_END)     
            Before_4_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_Before_en        <= 1'b0 ;                       
      else if(Before_YFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           YFFT_4_Before_en        <= 1'b1 ;            
      else   
           YFFT_4_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_4_vaild_en          <= 1'b0 ;                 
      else if (Before_YFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            YFFT_4_vaild_en          <= 1'b1 ;        
      else   
            YFFT_4_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_4_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_4_Rd_State == Before_YFFT_4_Rd_END)
           Before_YFFT_4_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_4_Rd_Done          <= 1'b0 ;                          
      end

localparam [5:0]
           Before_YFFT_5_Rd_RST   = 6'b000001	,
           Before_YFFT_5_Rd_IDLE  = 6'b000010	,
           Before_YFFT_5_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_5_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_5_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_5_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_5_Rd_State)  
            Before_YFFT_5_Rd_RST :
                begin
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_IDLE;
                end 
            Before_YFFT_5_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_BEGIN;
                  else
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_IDLE;
                 end 
        Before_YFFT_5_Rd_BEGIN:
                 begin
                    if (Before_YFFT_5_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_END;
                    else if((Before_YFFT_5_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_Wait;
                    else
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_BEGIN;
                 end

             Before_YFFT_5_Rd_Wait:
                 begin 
                    if ( YFFT_5_W_Done) 
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_BEGIN;
                    else
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_Wait;
                 end                  
                 
                    
                 
             Before_YFFT_5_Rd_END:
                   begin 
                      Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_IDLE;               
                   end 
         default:     Before_YFFT_5_Rd_State <=Before_YFFT_5_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_5_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_5_Rd_State == Before_YFFT_5_Rd_BEGIN&& Before_YFFT_5_Rd_Loop_Num <=Loop_times)    
           Before_YFFT_5_Rd_Loop_Num         <=   Before_YFFT_5_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_YFFT_5_Rd_State == Before_YFFT_5_Rd_END)    
           Before_YFFT_5_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_5_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_5_Rd_State == Before_YFFT_5_Rd_BEGIN)
            Before_5_YFFT_Rd_addr         <=   Before_YFFT_5_Rd_Loop_Num  ;      
      else  if( Before_YFFT_5_Rd_State == Before_YFFT_5_Rd_END)     
            Before_5_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_Before_en        <= 1'b0 ;                       
      else if (Before_YFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           YFFT_5_Before_en        <= 1'b1 ;            
      else   
           YFFT_5_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_5_vaild_en          <= 1'b0 ;                 
      else if(Before_YFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            YFFT_5_vaild_en          <= 1'b1 ;        
      else   
            YFFT_5_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_5_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_5_Rd_State == Before_YFFT_5_Rd_END)
           Before_YFFT_5_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_5_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_YFFT_6_Rd_RST   = 6'b000001	,
           Before_YFFT_6_Rd_IDLE  = 6'b000010	,
           Before_YFFT_6_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_6_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_6_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_6_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_6_Rd_State)  
            Before_YFFT_6_Rd_RST :
                begin
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_IDLE;
                end 
            Before_YFFT_6_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_BEGIN;
                  else
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_IDLE;
                 end 
             Before_YFFT_6_Rd_BEGIN:
                 begin
                    if (Before_YFFT_6_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_END;
                    else if((Before_YFFT_6_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_Wait;
                    else
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_BEGIN;
                 end

             Before_YFFT_6_Rd_Wait:
                 begin 
                    if ( YFFT_6_W_Done) 
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_BEGIN;
                    else
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_Wait;
                 end                  
                 
                 
             Before_YFFT_6_Rd_END:
                   begin 
                      Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_IDLE;               
                   end 
         default:     Before_YFFT_6_Rd_State <=Before_YFFT_6_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_6_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_6_Rd_State == Before_YFFT_6_Rd_BEGIN&& Before_YFFT_6_Rd_Loop_Num <=Loop_times)    
           Before_YFFT_6_Rd_Loop_Num         <=   Before_YFFT_6_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_YFFT_6_Rd_State ==Before_YFFT_6_Rd_END)     
           Before_YFFT_6_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_6_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_6_Rd_State == Before_YFFT_6_Rd_BEGIN)
            Before_6_YFFT_Rd_addr         <=   Before_YFFT_6_Rd_Loop_Num  ;      
      else  if( Before_YFFT_6_Rd_State ==Before_YFFT_6_Rd_END)     
            Before_6_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_Before_en        <= 1'b0 ;                       
      else if (Before_YFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           YFFT_6_Before_en        <= 1'b1 ;            
      else   
           YFFT_6_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_6_vaild_en          <= 1'b0 ;                 
      else if  (Before_YFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before)
            YFFT_6_vaild_en          <= 1'b1 ;        
      else   
            YFFT_6_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_6_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_6_Rd_State == Before_YFFT_6_Rd_END)
           Before_YFFT_6_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_6_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_YFFT_7_Rd_RST   = 6'b000001	,
           Before_YFFT_7_Rd_IDLE  = 6'b000010	,
           Before_YFFT_7_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_7_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_7_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_7_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_7_Rd_State)  
            Before_YFFT_7_Rd_RST :
                begin
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_IDLE;
                end 
            Before_YFFT_7_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_BEGIN;
                  else
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_IDLE;
                 end 
            Before_YFFT_7_Rd_BEGIN:
                 begin
                    if (Before_YFFT_7_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_END;
                    else if((Before_YFFT_7_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_Wait;
                    else
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_BEGIN;
                 end

             Before_YFFT_7_Rd_Wait:
                 begin 
                    if ( YFFT_7_W_Done) 
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_BEGIN;
                    else
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_Wait;
                 end                  
                 
             Before_YFFT_7_Rd_END:
                   begin 
                      Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_IDLE;               
                   end 
         default:     Before_YFFT_7_Rd_State <=Before_YFFT_7_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_7_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_7_Rd_State == Before_YFFT_7_Rd_BEGIN&& Before_YFFT_7_Rd_Loop_Num <=Loop_times)   
           Before_YFFT_7_Rd_Loop_Num         <=   Before_YFFT_7_Rd_Loop_Num + 1'b1 ;      
      else if( Before_YFFT_7_Rd_State ==Before_YFFT_7_Rd_END)      
           Before_YFFT_7_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_7_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_7_Rd_State == Before_YFFT_7_Rd_BEGIN)
            Before_7_YFFT_Rd_addr         <=   Before_YFFT_7_Rd_Loop_Num  ;      
      else  if( Before_YFFT_7_Rd_State ==Before_YFFT_7_Rd_END)     
            Before_7_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_Before_en        <= 1'b0 ;                       
      else if (Before_YFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
           YFFT_7_Before_en        <= 1'b1 ;            
      else   
           YFFT_7_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_7_vaild_en          <= 1'b0 ;                 
      else if  (Before_YFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
            YFFT_7_vaild_en          <= 1'b1 ;        
      else   
            YFFT_7_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_7_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_7_Rd_State == Before_YFFT_7_Rd_END)
           Before_YFFT_7_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_7_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_YFFT_8_Rd_RST   = 6'b000001	,
           Before_YFFT_8_Rd_IDLE  = 6'b000010	,
           Before_YFFT_8_Rd_BEGIN = 6'b000100	, 
           Before_YFFT_8_Rd_BUF   = 6'b001000 	,     
           Before_YFFT_8_Rd_Wait  = 6'b010000 	,      
           Before_YFFT_8_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_RST;
     end 
      else begin 
           case( Before_YFFT_8_Rd_State)  
            Before_YFFT_8_Rd_RST :
                begin
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_IDLE;
                end 
            Before_YFFT_8_Rd_IDLE:
                begin
                  if (YFFT_ALL_wr_Done  ) 
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_BEGIN;
                  else
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_IDLE;
                 end 
            Before_YFFT_8_Rd_BEGIN:
                 begin
                    if (Before_YFFT_8_Rd_Loop_Num  ==  Loop_times) 
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_END;
                    else if((Before_YFFT_8_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_YFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_Wait;
                    else
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_BEGIN;
                 end

             Before_YFFT_8_Rd_Wait:
                 begin 
                    if ( YFFT_8_W_Done) 
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_BEGIN;
                    else
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_Wait;
                 end                  
                      
                 
             Before_YFFT_8_Rd_END:
                   begin 
                      Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_IDLE;               
                   end 
         default:     Before_YFFT_8_Rd_State <=Before_YFFT_8_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_8_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_YFFT_8_Rd_State == Before_YFFT_8_Rd_BEGIN&& Before_YFFT_8_Rd_Loop_Num <=Loop_times)    
           Before_YFFT_8_Rd_Loop_Num         <=   Before_YFFT_8_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_YFFT_8_Rd_State ==Before_YFFT_8_Rd_END)     
           Before_YFFT_8_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_8_YFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_YFFT_8_Rd_State == Before_YFFT_8_Rd_BEGIN)
            Before_8_YFFT_Rd_addr         <=   Before_YFFT_8_Rd_Loop_Num  ;      
      else  if( Before_YFFT_8_Rd_State ==Before_YFFT_8_Rd_END)     
            Before_8_YFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_Before_en        <= 1'b0 ;                       
      else if  (Before_YFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
           YFFT_8_Before_en        <= 1'b1 ;            
      else   
           YFFT_8_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            YFFT_8_vaild_en          <= 1'b0 ;                 
      else if   (Before_YFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
            YFFT_8_vaild_en          <= 1'b1 ;        
      else   
            YFFT_8_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_YFFT_8_Rd_Done          <= 1'b0 ;                    
      else if ( Before_YFFT_8_Rd_State == Before_YFFT_8_Rd_END)
           Before_YFFT_8_Rd_Done          <= 1'b1 ;      
      else   
           Before_YFFT_8_Rd_Done          <= 1'b0 ;                          
      end                                                               
         
//////////////////////////////////////////////////////////////////////////////////
//   after fft ip buffer to ram                                                 //
//////////////////////////////////////////////////////////////////////////////////    
    
 localparam [4:0]
           YFFT_1_W_RST   = 5'b00001	,
           YFFT_1_W_IDLE  = 5'b00010	,
           YFFT_1_W_BEGIN = 5'b00100	, 
           YFFT_1_W_Wait  = 5'b01000	,                 
           YFFT_1_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_1_W_State <=YFFT_1_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_1_W_State)  
            YFFT_1_W_RST :
                begin
                      AFTER_YFFT_1_W_State <=YFFT_1_W_IDLE;
                end 
            YFFT_1_W_IDLE:
                begin
                  if ( YFFT_1_Before_en) /// to fft ip  
                      AFTER_YFFT_1_W_State <=YFFT_1_W_Wait;
                  else
                      AFTER_YFFT_1_W_State <=YFFT_1_W_IDLE;
                 end 
           YFFT_1_W_Wait :    
                 begin
                    if ( YFFT_1_Done) /// response from fft ip
                      AFTER_YFFT_1_W_State <=YFFT_1_W_BEGIN;
                    else
                      AFTER_YFFT_1_W_State <=YFFT_1_W_Wait;
                 end 
                 
            YFFT_1_W_BEGIN:
                 begin
                    if (YFFT_1_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_1_W_State <=YFFT_1_W_END;
                    else
                      AFTER_YFFT_1_W_State <=YFFT_1_W_IDLE;
                 end                  
             YFFT_1_W_END:
                   begin 
                      AFTER_YFFT_1_W_State <=YFFT_1_W_IDLE;               
                   end 
         default:     AFTER_YFFT_1_W_State <=YFFT_1_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_1_W_State == YFFT_1_W_BEGIN)
           YFFT_1_W_Loop_Num         <=   YFFT_1_W_Loop_Num + 8'd64 ;     
      else  if (AFTER_YFFT_1_W_State ==YFFT_1_W_END)       
           YFFT_1_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_1_W_State == YFFT_1_W_Wait&& YFFT_1_Done)
           YFFT_1_W_Done          <= 1'b1 ;      
      else   
           YFFT_1_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_1_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_1_W_State ==YFFT_1_W_END  )
           YFFT_1_W_Finish          <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_1_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_2_W_RST   = 5'b00001	,
           YFFT_2_W_IDLE  = 5'b00010	,
           YFFT_2_W_BEGIN = 5'b00100	, 
           YFFT_2_W_Wait  = 5'b01000	,                 
           YFFT_2_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_2_W_State <=YFFT_2_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_2_W_State)  
            YFFT_2_W_RST :
                begin
                      AFTER_YFFT_2_W_State <=YFFT_2_W_IDLE;
                end 
            YFFT_2_W_IDLE:
                begin
                  if ( YFFT_2_Before_en) 
                      AFTER_YFFT_2_W_State <=YFFT_2_W_BEGIN;
                  else
                      AFTER_YFFT_2_W_State <=YFFT_2_W_IDLE;
                 end 
          YFFT_2_W_Wait :    
                 begin
                    if ( YFFT_2_Done) 
                      AFTER_YFFT_2_W_State <=YFFT_2_W_BEGIN;
                    else
                      AFTER_YFFT_2_W_State <=YFFT_2_W_Wait;
                 end 
                 
            YFFT_2_W_BEGIN:
                 begin
                    if (YFFT_2_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_2_W_State <=YFFT_2_W_END;
                    else
                      AFTER_YFFT_2_W_State <=YFFT_2_W_IDLE;
                 end 

                 
             YFFT_2_W_END:
                   begin 
                      AFTER_YFFT_2_W_State <=YFFT_2_W_IDLE;               
                   end 
         default:     AFTER_YFFT_2_W_State <=YFFT_2_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_2_W_State == YFFT_2_W_BEGIN)
           YFFT_2_W_Loop_Num         <=   YFFT_2_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_YFFT_2_W_State ==YFFT_2_W_END)       
           YFFT_2_W_Loop_Num         <=   8'd0  ;              
      end     

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_2_W_State == YFFT_2_W_Wait&& YFFT_2_Done)
           YFFT_2_W_Done          <= 1'b1 ;      
      else   
           YFFT_2_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_2_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_2_W_State ==YFFT_2_W_END  )
           YFFT_2_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_2_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_3_W_RST   = 5'b00001	,
           YFFT_3_W_IDLE  = 5'b00010	,
           YFFT_3_W_BEGIN = 5'b00100	, 
           YFFT_3_W_Wait  = 5'b01000	,                 
           YFFT_3_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_3_W_State <=YFFT_3_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_3_W_State)  
            YFFT_3_W_RST :
                begin
                      AFTER_YFFT_3_W_State <=YFFT_3_W_IDLE;
                end 
            YFFT_3_W_IDLE:
                begin
                  if ( YFFT_3_Before_en) 
                      AFTER_YFFT_3_W_State <=YFFT_3_W_BEGIN;
                  else
                      AFTER_YFFT_3_W_State <=YFFT_3_W_IDLE;
                 end 
           YFFT_3_W_Wait :    
                 begin
                    if ( YFFT_3_Done) 
                      AFTER_YFFT_3_W_State <=YFFT_3_W_BEGIN;
                    else
                      AFTER_YFFT_3_W_State <=YFFT_3_W_Wait;
                 end 
                 
            YFFT_3_W_BEGIN:
                 begin
                    if (YFFT_3_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_3_W_State <=YFFT_3_W_END;
                    else
                      AFTER_YFFT_3_W_State <=YFFT_3_W_IDLE;
                 end 

                 
             YFFT_3_W_END:
                   begin 
                      AFTER_YFFT_3_W_State <=YFFT_3_W_IDLE;               
                   end 
         default:     AFTER_YFFT_3_W_State <=YFFT_3_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_3_W_State == YFFT_3_W_BEGIN)
           YFFT_3_W_Loop_Num         <=   YFFT_3_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_YFFT_3_W_State ==YFFT_3_W_END)       
           YFFT_3_W_Loop_Num         <=   8'd0  ;              
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_3_W_State == YFFT_3_W_Wait&& YFFT_3_Done)
           YFFT_3_W_Done          <= 1'b1 ;      
      else   
           YFFT_3_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_3_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_3_W_State ==YFFT_3_W_END  )
           YFFT_3_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_3_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_4_W_RST   = 5'b00001	,
           YFFT_4_W_IDLE  = 5'b00010	,
           YFFT_4_W_BEGIN = 5'b00100	, 
           YFFT_4_W_Wait  = 5'b01000	,                 
           YFFT_4_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_4_W_State <=YFFT_4_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_4_W_State)  
            YFFT_4_W_RST :
                begin
                      AFTER_YFFT_4_W_State <=YFFT_4_W_IDLE;
                end 
            YFFT_4_W_IDLE:
                begin
                  if ( YFFT_4_Before_en) 
                      AFTER_YFFT_4_W_State <=YFFT_4_W_BEGIN;
                  else
                      AFTER_YFFT_4_W_State <=YFFT_4_W_IDLE;
                 end 
            YFFT_4_W_Wait :    
                 begin
                    if ( YFFT_4_Done) 
                      AFTER_YFFT_4_W_State <=YFFT_4_W_BEGIN;
                    else
                      AFTER_YFFT_4_W_State <=YFFT_4_W_Wait;
                 end 
                 
            YFFT_4_W_BEGIN:
                 begin
                    if (YFFT_4_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_4_W_State <=YFFT_4_W_END;
                    else
                      AFTER_YFFT_4_W_State <=YFFT_4_W_IDLE;
                 end 

                 
             YFFT_4_W_END:
                   begin 
                      AFTER_YFFT_4_W_State <=YFFT_4_W_IDLE;               
                   end 
         default:     AFTER_YFFT_4_W_State <=YFFT_4_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_4_W_State == YFFT_4_W_BEGIN)
           YFFT_4_W_Loop_Num         <=   YFFT_4_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_YFFT_4_W_State ==YFFT_4_W_END)       
           YFFT_4_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_4_W_State == YFFT_4_W_Wait&& YFFT_4_Done)
           YFFT_4_W_Done          <= 1'b1 ;      
      else   
           YFFT_4_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_4_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_4_W_State ==YFFT_4_W_END  )
           YFFT_4_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_4_W_Finish          <= 1'b0 ;                          
      end
      
    localparam [4:0]
           YFFT_5_W_RST   = 5'b00001	,
           YFFT_5_W_IDLE  = 5'b00010	,
           YFFT_5_W_BEGIN = 5'b00100	, 
           YFFT_5_W_Wait  = 5'b01000	,                 
           YFFT_5_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_5_W_State <=YFFT_5_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_5_W_State)  
            YFFT_5_W_RST :
                begin
                      AFTER_YFFT_5_W_State <=YFFT_5_W_IDLE;
                end 
            YFFT_5_W_IDLE:
                begin
                  if ( YFFT_5_Before_en) 
                      AFTER_YFFT_5_W_State <=YFFT_5_W_BEGIN;
                  else
                      AFTER_YFFT_5_W_State <=YFFT_5_W_IDLE;
                 end 
            YFFT_5_W_Wait :    
                 begin
                    if ( YFFT_5_Done) 
                      AFTER_YFFT_5_W_State <=YFFT_5_W_BEGIN;
                    else
                      AFTER_YFFT_5_W_State <=YFFT_5_W_Wait;
                 end 
                 
            YFFT_5_W_BEGIN:
                 begin
                    if (YFFT_5_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_5_W_State <=YFFT_5_W_END;
                    else
                      AFTER_YFFT_5_W_State <=YFFT_5_W_IDLE;
                 end 

                 
             YFFT_5_W_END:
                   begin 
                      AFTER_YFFT_5_W_State <=YFFT_5_W_IDLE;               
                   end 
         default:     AFTER_YFFT_5_W_State <=YFFT_5_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_5_W_State == YFFT_5_W_BEGIN)
           YFFT_5_W_Loop_Num         <=   YFFT_5_W_Loop_Num + 8'd64 ;          
      else if (AFTER_YFFT_5_W_State ==YFFT_5_W_END)     
           YFFT_5_W_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_5_W_State == YFFT_5_W_Wait&& YFFT_5_Done)
           YFFT_5_W_Done          <= 1'b1 ;      
      else   
           YFFT_5_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_5_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_5_W_State ==YFFT_5_W_END  )
           YFFT_5_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_5_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_6_W_RST   = 5'b00001	,
           YFFT_6_W_IDLE  = 5'b00010	,
           YFFT_6_W_BEGIN = 5'b00100	, 
           YFFT_6_W_Wait  = 5'b01000	,                 
           YFFT_6_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_6_W_State <=YFFT_6_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_6_W_State)  
            YFFT_6_W_RST :
                begin
                      AFTER_YFFT_6_W_State <=YFFT_6_W_IDLE;
                end 
            YFFT_6_W_IDLE:
                begin
                  if ( YFFT_6_Before_en) 
                      AFTER_YFFT_6_W_State <=YFFT_6_W_BEGIN;
                  else
                      AFTER_YFFT_6_W_State <=YFFT_6_W_IDLE;
                 end 
           YFFT_6_W_Wait :    
                 begin
                    if ( YFFT_6_Done) 
                      AFTER_YFFT_6_W_State <=YFFT_6_W_BEGIN;
                    else
                      AFTER_YFFT_6_W_State <=YFFT_6_W_Wait;
                 end 
                 
            YFFT_6_W_BEGIN:
                 begin
                    if (YFFT_6_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_6_W_State <=YFFT_6_W_END;
                    else
                      AFTER_YFFT_6_W_State <=YFFT_6_W_IDLE;
                 end 

                 
             YFFT_6_W_END:
                   begin 
                      AFTER_YFFT_6_W_State <=YFFT_6_W_IDLE;               
                   end 
         default:     AFTER_YFFT_6_W_State <=YFFT_6_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_6_W_State == YFFT_6_W_BEGIN)
           YFFT_6_W_Loop_Num         <=   YFFT_6_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_YFFT_6_W_State ==YFFT_6_W_END)   
           YFFT_6_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_6_W_State == YFFT_6_W_Wait&& YFFT_6_Done)
           YFFT_6_W_Done          <= 1'b1 ;      
      else   
           YFFT_6_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_6_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_6_W_State ==YFFT_6_W_END  )
           YFFT_6_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_6_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_7_W_RST   = 5'b00001	,
           YFFT_7_W_IDLE  = 5'b00010	,
           YFFT_7_W_BEGIN = 5'b00100	, 
           YFFT_7_W_Wait  = 5'b01000	,                 
           YFFT_7_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_7_W_State <=YFFT_7_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_7_W_State)  
            YFFT_7_W_RST :
                begin
                      AFTER_YFFT_7_W_State <=YFFT_7_W_IDLE;
                end 
            YFFT_7_W_IDLE:
                begin
                  if ( YFFT_7_Before_en) 
                      AFTER_YFFT_7_W_State <=YFFT_7_W_BEGIN;
                  else
                      AFTER_YFFT_7_W_State <=YFFT_7_W_IDLE;
                 end 
          YFFT_7_W_Wait :    
                 begin
                    if ( YFFT_7_Done) 
                      AFTER_YFFT_7_W_State <=YFFT_7_W_BEGIN;
                    else
                      AFTER_YFFT_7_W_State <=YFFT_7_W_Wait;
                 end 
                 
            YFFT_7_W_BEGIN:
                 begin
                    if (YFFT_7_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_YFFT_7_W_State <=YFFT_7_W_END;
                    else
                      AFTER_YFFT_7_W_State <=YFFT_7_W_IDLE;
                 end 

                 
             YFFT_7_W_END:
                   begin 
                      AFTER_YFFT_7_W_State <=YFFT_7_W_IDLE;               
                   end 
         default:     AFTER_YFFT_7_W_State <=YFFT_7_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_7_W_State == YFFT_7_W_BEGIN)
           YFFT_7_W_Loop_Num         <=   YFFT_7_W_Loop_Num + 8'd64 ;         
      else   if (AFTER_YFFT_7_W_State ==YFFT_7_W_END)  
           YFFT_7_W_Loop_Num         <=   8'd0  ;              
      end      

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_7_W_State == YFFT_7_W_Wait&& YFFT_7_Done)
           YFFT_7_W_Done          <= 1'b1 ;      
      else   
           YFFT_7_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_7_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_7_W_State ==YFFT_7_W_END  )
           YFFT_7_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_7_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           YFFT_8_W_RST   = 5'b00001	,
           YFFT_8_W_IDLE  = 5'b00010	,
           YFFT_8_W_BEGIN = 5'b00100	, 
           YFFT_8_W_Wait  = 5'b01000	,                 
           YFFT_8_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_YFFT_8_W_State <=YFFT_8_W_RST;
     end 
      else begin 
           case( AFTER_YFFT_8_W_State)  
            YFFT_8_W_RST :
                begin
                      AFTER_YFFT_8_W_State <=YFFT_8_W_IDLE;
                end 
            YFFT_8_W_IDLE:
                begin
                  if ( YFFT_8_Before_en) 
                      AFTER_YFFT_8_W_State <=YFFT_8_W_BEGIN;
                  else
                      AFTER_YFFT_8_W_State <=YFFT_8_W_IDLE;
                 end 
          YFFT_8_W_Wait :    
                 begin
                    if ( YFFT_8_Done) 
                      AFTER_YFFT_8_W_State <=YFFT_8_W_BEGIN;
                    else
                      AFTER_YFFT_8_W_State <=YFFT_8_W_Wait;
                 end 
                 
            YFFT_8_W_BEGIN:
                 begin
                    if (YFFT_8_W_Loop_Num ==  Loop_times_Before) 
                      AFTER_YFFT_8_W_State <=YFFT_8_W_END;
                    else
                      AFTER_YFFT_8_W_State <=YFFT_8_W_IDLE;
                 end 

                 
             YFFT_8_W_END:
                   begin 
                      AFTER_YFFT_8_W_State <=YFFT_8_W_IDLE;               
                   end 
         default:     AFTER_YFFT_8_W_State <=YFFT_8_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_YFFT_8_W_State == YFFT_8_W_BEGIN)
           YFFT_8_W_Loop_Num         <=   YFFT_8_W_Loop_Num + 8'd64 ;      
      else  if (AFTER_YFFT_8_W_State ==YFFT_8_W_END) 
           YFFT_8_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_W_Done          <= 1'b0 ;                    
      else if (AFTER_YFFT_8_W_State == YFFT_8_W_Wait&& YFFT_8_Done)
           YFFT_8_W_Done          <= 1'b1 ;      
      else   
           YFFT_8_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_8_W_Finish          <= 1'b0 ;                    
      else if (AFTER_YFFT_8_W_State ==YFFT_8_W_END  )
           YFFT_8_W_Finish         <= 1'b1 ;      
      else if (YFFT_W_Finish)  
           YFFT_8_W_Finish          <= 1'b0 ;                          
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_Forward_end          <= 1'b0 ;                    
      else if (YFFT_8_W_Finish  )
           YFFT_Forward_end         <= 1'b1 ;      
      else 
           YFFT_Forward_end          <= 1'b0 ;                          
      end    
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           YFFT_Backward_end          <= 1'b0 ;                    
      else if (FFT_Backward_begin  )
           YFFT_Backward_end         <= 1'b1 ;      
      else 
           YFFT_Backward_end          <= 1'b0 ;                          
      end     
endmodule