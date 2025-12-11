`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 06:11:54 PM
// Design Name: 
// Module Name: XFFT_2RAM_Module
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


module ZFFT_2RAM_Module #  (parameter  Loop_times         =  14'd4096,
                            parameter  Loop_times_Before  =  6'b111111,
                            parameter  Loop_times_AFTER  =  14'd64, //4096/64
                            parameter  X_K_value         =  9'd64,
                            parameter  Y_K_value         =  9'd64,
                            parameter  Z_K_value         =  9'd64 
                             
                            )
(
 input                        Sys_Clk              , 
 input                        Sys_Rst_n            , 
 
 output reg                   ZFFT_Running         ,
  
 input                        FFT_Forward_begin    ,
 input                        FFT_Backward_begin   ,
 
 output reg                   ZFFT_Forward_end     ,
 output reg                   ZFFT_Backward_end    ,
 //------------------------------------------------------ 
 output reg                   M_AXIS_Q_Rd_en       ,     
 input           [63:0]       M_AXIS_Q_Rd_data     ,
 output reg      [31:0]       M_AXIS_Q_Rd_addr     ,  // read data from Ram_Q
 //------------------------------------------------------    
       
output reg                 M_AXIS_1_ZFFT_Wr_en   ,    // write data to ram
output reg   [511:0]       M_AXIS_1_ZFFT_Wr_data ,
output reg     [15:0]      M_AXIS_1_ZFFT_Wr_addr ,
                                          
output reg                 M_AXIS_2_ZFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_2_ZFFT_Wr_data ,
output reg     [15:0]      M_AXIS_2_ZFFT_Wr_addr ,
                                           
output  reg                M_AXIS_3_ZFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_3_ZFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_3_ZFFT_Wr_addr ,
                                                 
output  reg                M_AXIS_4_ZFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_4_ZFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_4_ZFFT_Wr_addr ,
                                           
output reg                 M_AXIS_5_ZFFT_Wr_en   ,
output reg    [511:0]      M_AXIS_5_ZFFT_Wr_data ,
output reg      [15:0]     M_AXIS_5_ZFFT_Wr_addr ,
                                                  
output  reg                M_AXIS_6_ZFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_6_ZFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_6_ZFFT_Wr_addr ,
                                          
output  reg                M_AXIS_7_ZFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_7_ZFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_7_ZFFT_Wr_addr ,
                                                  
output reg                 M_AXIS_8_ZFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_8_ZFFT_Wr_data ,
output reg     [15:0]      M_AXIS_8_ZFFT_Wr_addr ,
 //------------------------------------------------------    
                                                      //read data to FFT 
 output  reg     [15:0]      Before_1_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_2_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_3_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_4_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_5_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_6_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_7_ZFFT_Rd_addr  ,
 output  reg     [15:0]      Before_8_ZFFT_Rd_addr  ,  
                                                       
  //------------------------------------------------------    
                                                   
 output reg                   ZFFT_1_vaild_en,            
 output  reg     [15:0]       ZFFT_1_Loop_Num,
 input                        ZFFT_1_Done     ,
 output   reg                 ZFFT_1_Before_en,
 
  output reg                  ZFFT_2_vaild_en,            
 output  reg     [15:0]       ZFFT_2_Loop_Num,
 input                        ZFFT_2_Done     ,
 output   reg                 ZFFT_2_Before_en,
 
 output reg                   ZFFT_3_vaild_en,  
 output  reg     [15:0]       ZFFT_3_Loop_Num,
 input                        ZFFT_3_Done     ,
 output   reg                 ZFFT_3_Before_en,
 
   output reg                 ZFFT_4_vaild_en,  
 output  reg     [15:0]       ZFFT_4_Loop_Num,
 input                        ZFFT_4_Done     ,
 output   reg                 ZFFT_4_Before_en,
 
   output reg                 ZFFT_5_vaild_en,  
 output  reg      [15:0]      ZFFT_5_Loop_Num,
 input                        ZFFT_5_Done     ,
 output   reg                 ZFFT_5_Before_en,

   output reg                 ZFFT_6_vaild_en,  
  output  reg     [15:0]      ZFFT_6_Loop_Num,
 input                        ZFFT_6_Done     ,
 output   reg                 ZFFT_6_Before_en,

   output reg                 ZFFT_7_vaild_en,  
  output  reg     [15:0]      ZFFT_7_Loop_Num,
 input                        ZFFT_7_Done     ,
 output   reg                 ZFFT_7_Before_en,

 output reg                   ZFFT_8_vaild_en,  
 output  reg     [15:0]       ZFFT_8_Loop_Num,
 input                        ZFFT_8_Done     ,
 output   reg                 ZFFT_8_Before_en ,  
  //------------------------------------------------------  
 //write data to FFT 
  output  reg     [11:0]       ZFFT_1_W_Loop_Num,
  output  reg     [11:0]       ZFFT_2_W_Loop_Num,
  output  reg     [11:0]       ZFFT_3_W_Loop_Num,
  output  reg     [11:0]       ZFFT_4_W_Loop_Num,
  output  reg     [11:0]       ZFFT_5_W_Loop_Num,
  output  reg     [11:0]       ZFFT_6_W_Loop_Num,
  output  reg     [11:0]       ZFFT_7_W_Loop_Num,
  output  reg     [11:0]       ZFFT_8_W_Loop_Num 
    );

 reg                Wr_1_RAM_en;
 reg                Wr_2_RAM_en;
 reg                Wr_3_RAM_en;
 reg                Wr_4_RAM_en;
 reg                Wr_5_RAM_en;
 reg                Wr_6_RAM_en;
 reg                Wr_7_RAM_en;
 reg                Wr_8_RAM_en; 
 
 reg                ZFFT_1_wr_Done;
 reg                ZFFT_2_wr_Done;
 reg                ZFFT_3_wr_Done;
 reg                ZFFT_4_wr_Done;
 reg                ZFFT_5_wr_Done;
 reg                ZFFT_6_wr_Done;
 reg                ZFFT_7_wr_Done;
 reg                ZFFT_8_wr_Done;
 reg                ZFFT_wr_Done;
 
reg     [3:0]       ZFFT_1_wr_State;
reg     [3:0]       ZFFT_2_wr_State;
reg     [3:0]       ZFFT_3_wr_State;
reg     [3:0]       ZFFT_4_wr_State;
reg     [3:0]       ZFFT_5_wr_State;
reg     [3:0]       ZFFT_6_wr_State;
reg     [3:0]       ZFFT_7_wr_State;
reg     [3:0]       ZFFT_8_wr_State;

reg   [511:0]       Before_Data_ZFFT;
reg    [7:0]        Data_Loop_Num;
reg                 X_Data_Loop_8_plus;
reg                 X_Data_Loop_8_plu_en;

reg     [9:0]        ZFFT_Rd_Q_State;

reg     [7:0]        X_AXI_Loop_Num;
reg     [7:0]        Y_AXI_Loop_Num;
reg     [7:0]        Z_AXI_Loop_Num;   
 
reg     [5:0]        Before_ZFFT_1_Rd_State ;   
reg     [15:0]       Before_ZFFT_1_Rd_Loop_Num;
reg                  Before_ZFFT_1_Rd_Done;

reg     [5:0]        Before_ZFFT_2_Rd_State ;   
reg     [15:0]       Before_ZFFT_2_Rd_Loop_Num;
reg                  Before_ZFFT_2_Rd_Done;

reg     [5:0]        Before_ZFFT_3_Rd_State ;   
reg     [15:0]       Before_ZFFT_3_Rd_Loop_Num;
reg                  Before_ZFFT_3_Rd_Done;

reg     [5:0]        Before_ZFFT_4_Rd_State ;   
reg     [15:0]       Before_ZFFT_4_Rd_Loop_Num;
reg                  Before_ZFFT_4_Rd_Done;

reg     [5:0]        Before_ZFFT_5_Rd_State ;   
reg     [15:0]       Before_ZFFT_5_Rd_Loop_Num;
reg                  Before_ZFFT_5_Rd_Done;

reg     [5:0]        Before_ZFFT_6_Rd_State ;   
reg     [15:0]       Before_ZFFT_6_Rd_Loop_Num;
reg                  Before_ZFFT_6_Rd_Done;

reg     [5:0]        Before_ZFFT_7_Rd_State ;   
reg     [15:0]       Before_ZFFT_7_Rd_Loop_Num;
reg                  Before_ZFFT_7_Rd_Done;

reg     [4:0]        Before_ZFFT_8_Rd_State ;   
reg     [15:0]       Before_ZFFT_8_Rd_Loop_Num;
reg                  Before_ZFFT_8_Rd_Done;
//reg                  Before_8_ZFFT_Rd_en;

reg                  ZFFT_1_W_Done;
reg     [4:0]        AFTER_ZFFT_1_W_State;
//reg     [15:0]       ZFFT_1_W_Loop_Num;

reg                  ZFFT_2_W_Done;
reg     [4:0]        AFTER_ZFFT_2_W_State;
//reg     [15:0]       ZFFT_2_W_Loop_Num;

reg                  ZFFT_3_W_Done;
reg     [4:0]        AFTER_ZFFT_3_W_State;
//reg     [15:0]       ZFFT_3_W_Loop_Num;

reg                  ZFFT_4_W_Done;
reg     [4:0]        AFTER_ZFFT_4_W_State;
//reg     [15:0]       ZFFT_4_W_Loop_Num;

reg                  ZFFT_5_W_Done;
reg     [4:0]        AFTER_ZFFT_5_W_State;
//reg     [15:0]       ZFFT_5_W_Loop_Num;

reg                  ZFFT_6_W_Done;
reg     [4:0]        AFTER_ZFFT_6_W_State;
//reg     [15:0]       ZFFT_6_W_Loop_Num;

reg                  ZFFT_7_W_Done;
reg     [4:0]        AFTER_ZFFT_7_W_State;
//reg     [15:0]       ZFFT_7_W_Loop_Num;

reg                  ZFFT_8_W_Done;
reg     [4:0]        AFTER_ZFFT_8_W_State;
//reg     [15:0]       ZFFT_8_W_Loop_Num; 

reg                 ZFFT_1_W_Finish;
reg                 ZFFT_2_W_Finish; 
reg                 ZFFT_3_W_Finish; 
reg                 ZFFT_4_W_Finish; 
reg                 ZFFT_5_W_Finish; 
reg                 ZFFT_6_W_Finish; 
reg                 ZFFT_7_W_Finish; 
reg                 ZFFT_8_W_Finish;
reg                 ZFFT_W_Finish;
reg                 ZFFT_ALL_wr_Done;
//////////////////////////////////////////////////////////////////////////////////
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
       ZFFT_Running <=   1'b0 ;
 else if (FFT_Forward_begin)  
       ZFFT_Running <=   1'b1 ;
  else if (ZFFT_Forward_end)  
       ZFFT_Running <=   1'b0 ;
 end    

//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       ZFFT_wr_Done         <=   1'b0 ;
 else  
       ZFFT_wr_Done         <=     ZFFT_1_wr_Done|| ZFFT_2_wr_Done||ZFFT_3_wr_Done||ZFFT_4_wr_Done 
                                 ||ZFFT_5_wr_Done|| ZFFT_6_wr_Done||ZFFT_7_wr_Done||ZFFT_8_wr_Done ;  // wr  512  
 end    
//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       ZFFT_W_Finish         <=   1'b0 ;
 else  
       ZFFT_W_Finish         <=    ZFFT_1_W_Finish && ZFFT_2_W_Finish && ZFFT_3_W_Finish && ZFFT_4_W_Finish 
                                && ZFFT_5_W_Finish && ZFFT_6_W_Finish && ZFFT_7_W_Finish && ZFFT_8_W_Finish ;  
 end   
 //////////////////////////////////////////////////////////////////////////////////
localparam [8:0]
           ZFFT_Rd_Q_RST   = 9'b00000001	,
           ZFFT_Rd_Q_IDLE  = 9'b00000010	,
           ZFFT_Rd_Q_ADD   = 9'b00000100	,
           ZFFT_Rd_Q_BEGIN = 9'b00001000	,
           ZFFT_Rd_Q_Buf   = 9'b00010000	,
           ZFFT_Rd_Q_Buf2  = 9'b00100000	,
           ZFFT_Rd_Q_COR   = 9'b01000000	,             
           ZFFT_Rd_Q_END   = 9'b10000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_RST;
     end 
      else begin 
           case( ZFFT_Rd_Q_State)  
            ZFFT_Rd_Q_RST :
                begin
                      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_IDLE;
                end 
            ZFFT_Rd_Q_IDLE:
                begin
                  if   ( FFT_Forward_begin  ) 
                      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_BEGIN;
                  else
                      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_IDLE;
                  end 
                     
             ZFFT_Rd_Q_ADD:
                 begin                   
                        ZFFT_Rd_Q_State <= ZFFT_Rd_Q_BEGIN;         
                  end 
             ZFFT_Rd_Q_BEGIN:
                 begin
                    if(  X_AXI_Loop_Num ==  X_K_value)
                        ZFFT_Rd_Q_State <= ZFFT_Rd_Q_Buf;  
                    else if (X_Data_Loop_8_plus)
                        ZFFT_Rd_Q_State <= ZFFT_Rd_Q_ADD;
                    else    
                        ZFFT_Rd_Q_State <= ZFFT_Rd_Q_BEGIN;       
                 end       
              ZFFT_Rd_Q_Buf:
                 begin
                    if ( Y_AXI_Loop_Num ==  Y_K_value-1) 
                      ZFFT_Rd_Q_State  <= ZFFT_Rd_Q_Buf2;
                    else
                      ZFFT_Rd_Q_State  <= ZFFT_Rd_Q_BEGIN;
                 end                   
              ZFFT_Rd_Q_Buf2:
                 begin
                    if ( Z_AXI_Loop_Num ==  Z_K_value-1) 
                      ZFFT_Rd_Q_State  <= ZFFT_Rd_Q_COR;
                    else
                      ZFFT_Rd_Q_State  <= ZFFT_Rd_Q_BEGIN;
                 end        
             ZFFT_Rd_Q_COR:
                   begin 
                      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_END;               
                   end 
             ZFFT_Rd_Q_END:
                   begin 
                      ZFFT_Rd_Q_State <=ZFFT_Rd_Q_IDLE;               
                   end 
         default:     ZFFT_Rd_Q_State <=ZFFT_Rd_Q_IDLE;
     endcase
   end 
 end   
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_AXI_Loop_Num         <=   8'd0  ;
      else if  (ZFFT_Rd_Q_State == ZFFT_Rd_Q_Buf  )
           X_AXI_Loop_Num         <=   8'd0  ;                 
      else if  (ZFFT_Rd_Q_State ==  ZFFT_Rd_Q_ADD) 
           X_AXI_Loop_Num         <=   X_AXI_Loop_Num + 8'd1 ;      
            
      end 
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y_AXI_Loop_Num         <=   8'd0  ;  
      else if  (ZFFT_Rd_Q_State == ZFFT_Rd_Q_Buf2  )
           Y_AXI_Loop_Num         <=   8'd0  ;           
      else if  (ZFFT_Rd_Q_State ==  ZFFT_Rd_Q_Buf)
           Y_AXI_Loop_Num         <=   Y_AXI_Loop_Num + 1'b1 ;                 
                    
      end    
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Z_AXI_Loop_Num         <=   8'd0  ;  
      else if  (ZFFT_Rd_Q_State == ZFFT_Rd_Q_COR  )
           Z_AXI_Loop_Num         <=   8'd0  ;           
      else if  (ZFFT_Rd_Q_State ==  ZFFT_Rd_Q_Buf2)
           Z_AXI_Loop_Num         <=   Z_AXI_Loop_Num + 1'b1 ;                 
                 
      end    
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Data_Loop_Num         <=   16'b0 ;
      else if ( (ZFFT_Rd_Q_State ==  ZFFT_Rd_Q_ADD)&&(Data_Loop_Num <=  16'd8)  ) 
           Data_Loop_Num         <=  Data_Loop_Num+ 1'b1 ;                          // 8         
      else if  (ZFFT_wr_Done)  
           Data_Loop_Num         <=   16'b0 ;    
      else if (ZFFT_Rd_Q_State == ZFFT_Rd_Q_COR)    
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
           Before_Data_ZFFT          <=  512'd0  ;               
      else if(ZFFT_Rd_Q_State == ZFFT_Rd_Q_ADD)
           Before_Data_ZFFT  <= {Before_Data_ZFFT[447:0],64'd0  } ; 
       
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_Data_ZFFT          <=  512'd0  ;               
      else if(ZFFT_Rd_Q_State == ZFFT_Rd_Q_BEGIN)
           Before_Data_ZFFT[63:0]   <= {24'd0 ,Data_Loop_Num,M_AXIS_Q_Rd_data } ; 
          
      end     
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_en        <=    1'b0  ;            
      else if(ZFFT_Rd_Q_State == ZFFT_Rd_Q_ADD)
           M_AXIS_Q_Rd_en        <=    1'b1  ; 
      else   
           M_AXIS_Q_Rd_en        <=    1'b0  ;              
      end  

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_addr         <=   32'd0  ;                
      else if (ZFFT_Rd_Q_State == ZFFT_Rd_Q_ADD)
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
           ZFFT_1_wr_RST   = 5'b00001	,
           ZFFT_1_wr_IDLE  = 5'b00010	,
           ZFFT_1_wr_BEGIN = 5'b00100	, 
           ZFFT_1_wr_BUF   = 5'b01000	,       
           ZFFT_1_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_1_wr_State <=ZFFT_1_wr_RST;
     end 
      else begin 
           case( ZFFT_1_wr_State)  
            ZFFT_1_wr_RST :
                begin
                      ZFFT_1_wr_State <=ZFFT_1_wr_IDLE;
                end 
            ZFFT_1_wr_IDLE:
                begin
                  if (Wr_1_RAM_en  ) 
                      ZFFT_1_wr_State <=ZFFT_1_wr_BEGIN;
                  else
                      ZFFT_1_wr_State <=ZFFT_1_wr_IDLE;
                 end 
            ZFFT_1_wr_BUF:
                 begin
                      ZFFT_1_wr_State <=ZFFT_1_wr_IDLE;         
                 end    
            ZFFT_1_wr_BEGIN:
                 begin
                    if (ZFFT_1_Loop_Num ==  Loop_times) 
                      ZFFT_1_wr_State <=ZFFT_1_wr_END;
                    else
                      ZFFT_1_wr_State <=ZFFT_1_wr_BUF;   
                 end 
                                           
             ZFFT_1_wr_END:
                   begin 
                      ZFFT_1_wr_State <=ZFFT_1_wr_IDLE;               
                   end 
         default:     ZFFT_1_wr_State <=ZFFT_1_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_1_wr_State == ZFFT_1_wr_BEGIN) )
           M_AXIS_1_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_1_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_1_wr_State == ZFFT_1_wr_BEGIN)
           ZFFT_1_Loop_Num         <=   ZFFT_1_Loop_Num + 1'b1 ;      
      else  if (ZFFT_1_Loop_Num ==  Loop_times)  
           ZFFT_1_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_1_wr_State == ZFFT_1_wr_BEGIN)
           M_AXIS_1_ZFFT_Wr_addr         <=   ZFFT_1_Loop_Num  ;      
      else   
           M_AXIS_1_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_1_wr_State == ZFFT_1_wr_BEGIN)
           M_AXIS_1_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_1_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_1_wr_State == ZFFT_1_wr_BUF)
           ZFFT_1_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_1_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_2_wr_RST   = 5'b00001	,
           ZFFT_2_wr_IDLE  = 5'b00010	,
           ZFFT_2_wr_BEGIN = 5'b00100	, 
           ZFFT_2_wr_BUF   = 5'b01000	,       
           ZFFT_2_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_2_wr_State <=ZFFT_2_wr_RST;
     end 
      else begin 
           case( ZFFT_2_wr_State)  
            ZFFT_2_wr_RST :
                begin
                      ZFFT_2_wr_State <=ZFFT_2_wr_IDLE;
                end 
            ZFFT_2_wr_IDLE:
                begin
                  if (Wr_2_RAM_en  ) 
                      ZFFT_2_wr_State <=ZFFT_2_wr_BEGIN;
                  else
                      ZFFT_2_wr_State <=ZFFT_2_wr_IDLE;
                 end 
            ZFFT_2_wr_BUF:
                 begin
                      ZFFT_2_wr_State <=ZFFT_2_wr_IDLE;         
                 end    
            ZFFT_2_wr_BEGIN:
                 begin
                    if (ZFFT_2_Loop_Num ==  Loop_times) 
                      ZFFT_2_wr_State <=ZFFT_2_wr_END;
                    else
                      ZFFT_2_wr_State <=ZFFT_2_wr_BUF;   
                 end 
                                           
             ZFFT_2_wr_END:
                   begin 
                      ZFFT_2_wr_State <=ZFFT_2_wr_IDLE;               
                   end 
         default:     ZFFT_2_wr_State <=ZFFT_2_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_2_wr_State == ZFFT_2_wr_BEGIN) )
           M_AXIS_2_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_2_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_2_wr_State == ZFFT_2_wr_BEGIN)
           ZFFT_2_Loop_Num         <=   ZFFT_2_Loop_Num + 1'b1 ;      
      else  if (ZFFT_2_Loop_Num ==  Loop_times)  
           ZFFT_2_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_2_wr_State == ZFFT_2_wr_BEGIN)
           M_AXIS_2_ZFFT_Wr_addr         <=   ZFFT_2_Loop_Num  ;      
      else   
           M_AXIS_2_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_2_wr_State == ZFFT_2_wr_BEGIN)
           M_AXIS_2_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_2_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_2_wr_State == ZFFT_2_wr_BUF)
           ZFFT_2_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_2_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_3_wr_RST   = 5'b00001	,
           ZFFT_3_wr_IDLE  = 5'b00010	,
           ZFFT_3_wr_BEGIN = 5'b00100	, 
           ZFFT_3_wr_BUF   = 5'b01000	,       
           ZFFT_3_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_3_wr_State <=ZFFT_3_wr_RST;
     end 
      else begin 
           case( ZFFT_3_wr_State)  
            ZFFT_3_wr_RST :
                begin
                      ZFFT_3_wr_State <=ZFFT_3_wr_IDLE;
                end 
            ZFFT_3_wr_IDLE:
                begin
                  if (Wr_3_RAM_en  ) 
                      ZFFT_3_wr_State <=ZFFT_3_wr_BEGIN;
                  else
                      ZFFT_3_wr_State <=ZFFT_3_wr_IDLE;
                 end 
            ZFFT_3_wr_BUF:
                 begin
                      ZFFT_3_wr_State <=ZFFT_3_wr_IDLE;         
                 end    
            ZFFT_3_wr_BEGIN:
                 begin
                    if (ZFFT_3_Loop_Num ==  Loop_times) 
                      ZFFT_3_wr_State <=ZFFT_3_wr_END;
                    else
                      ZFFT_3_wr_State <=ZFFT_3_wr_BUF;   
                 end 
                                           
             ZFFT_3_wr_END:
                   begin 
                      ZFFT_3_wr_State <=ZFFT_3_wr_IDLE;               
                   end 
         default:     ZFFT_3_wr_State <=ZFFT_3_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_3_wr_State == ZFFT_3_wr_BEGIN) )
           M_AXIS_3_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_3_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_3_wr_State == ZFFT_3_wr_BEGIN)
           ZFFT_3_Loop_Num         <=   ZFFT_3_Loop_Num + 1'b1 ;      
      else  if (ZFFT_3_Loop_Num ==  Loop_times)  
           ZFFT_3_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_3_wr_State == ZFFT_3_wr_BEGIN)
           M_AXIS_3_ZFFT_Wr_addr         <=   ZFFT_3_Loop_Num  ;      
      else   
           M_AXIS_3_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_3_wr_State == ZFFT_3_wr_BEGIN)
           M_AXIS_3_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_3_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_3_wr_State == ZFFT_3_wr_BUF)
           ZFFT_3_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_3_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_4_wr_RST   = 5'b00001	,
           ZFFT_4_wr_IDLE  = 5'b00010	,
           ZFFT_4_wr_BEGIN = 5'b00100	, 
           ZFFT_4_wr_BUF   = 5'b01000	,       
           ZFFT_4_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_4_wr_State <=ZFFT_4_wr_RST;
     end 
      else begin 
           case( ZFFT_4_wr_State)  
            ZFFT_4_wr_RST :
                begin
                      ZFFT_4_wr_State <=ZFFT_4_wr_IDLE;
                end 
            ZFFT_4_wr_IDLE:
                begin
                  if (Wr_4_RAM_en  ) 
                      ZFFT_4_wr_State <=ZFFT_4_wr_BEGIN;
                  else
                      ZFFT_4_wr_State <=ZFFT_4_wr_IDLE;
                 end 
            ZFFT_4_wr_BUF:
                 begin
                      ZFFT_4_wr_State <=ZFFT_4_wr_IDLE;         
                 end    
            ZFFT_4_wr_BEGIN:
                 begin
                    if (ZFFT_4_Loop_Num ==  Loop_times) 
                      ZFFT_4_wr_State <=ZFFT_4_wr_END;
                    else
                      ZFFT_4_wr_State <=ZFFT_4_wr_BUF;   
                 end 
                                           
             ZFFT_4_wr_END:
                   begin 
                      ZFFT_4_wr_State <=ZFFT_4_wr_IDLE;               
                   end 
         default:     ZFFT_4_wr_State <=ZFFT_4_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_4_wr_State == ZFFT_4_wr_BEGIN) )
           M_AXIS_4_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_4_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_4_wr_State == ZFFT_4_wr_BEGIN)
           ZFFT_4_Loop_Num         <=   ZFFT_4_Loop_Num + 1'b1 ;      
      else  if (ZFFT_4_Loop_Num ==  Loop_times)  
           ZFFT_4_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_4_wr_State == ZFFT_4_wr_BEGIN)
           M_AXIS_4_ZFFT_Wr_addr         <=   ZFFT_4_Loop_Num  ;      
      else   
           M_AXIS_4_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_4_wr_State == ZFFT_4_wr_BEGIN)
           M_AXIS_4_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_4_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_4_wr_State == ZFFT_4_wr_BUF)
           ZFFT_4_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_4_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_5_wr_RST   = 5'b00001	,
           ZFFT_5_wr_IDLE  = 5'b00010	,
           ZFFT_5_wr_BEGIN = 5'b00100	, 
           ZFFT_5_wr_BUF   = 5'b01000	,       
           ZFFT_5_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_5_wr_State <=ZFFT_5_wr_RST;
     end 
      else begin 
           case( ZFFT_5_wr_State)  
            ZFFT_5_wr_RST :
                begin
                      ZFFT_5_wr_State <=ZFFT_5_wr_IDLE;
                end 
            ZFFT_5_wr_IDLE:
                begin
                  if (Wr_5_RAM_en  ) 
                      ZFFT_5_wr_State <=ZFFT_5_wr_BEGIN;
                  else
                      ZFFT_5_wr_State <=ZFFT_5_wr_IDLE;
                 end 
            ZFFT_5_wr_BUF:
                 begin
                      ZFFT_5_wr_State <=ZFFT_5_wr_IDLE;         
                 end    
            ZFFT_5_wr_BEGIN:
                 begin
                    if (ZFFT_5_Loop_Num ==  Loop_times) 
                      ZFFT_5_wr_State <=ZFFT_5_wr_END;
                    else
                      ZFFT_5_wr_State <=ZFFT_5_wr_BUF;   
                 end 
                                           
             ZFFT_5_wr_END:
                   begin 
                      ZFFT_5_wr_State <=ZFFT_5_wr_IDLE;               
                   end 
         default:     ZFFT_5_wr_State <=ZFFT_5_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_5_wr_State == ZFFT_5_wr_BEGIN) )
           M_AXIS_5_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_5_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_5_wr_State == ZFFT_5_wr_BEGIN)
           ZFFT_5_Loop_Num         <=   ZFFT_5_Loop_Num + 1'b1 ;      
      else  if (ZFFT_5_Loop_Num ==  Loop_times)  
           ZFFT_5_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_5_wr_State == ZFFT_5_wr_BEGIN)
           M_AXIS_5_ZFFT_Wr_addr         <=   ZFFT_5_Loop_Num  ;      
      else   
           M_AXIS_5_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_5_wr_State == ZFFT_5_wr_BEGIN)
           M_AXIS_5_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_5_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_5_wr_State == ZFFT_5_wr_BUF)
           ZFFT_5_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_5_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_6_wr_RST   = 5'b00001	,
           ZFFT_6_wr_IDLE  = 5'b00010	,
           ZFFT_6_wr_BEGIN = 5'b00100	, 
           ZFFT_6_wr_BUF   = 5'b01000	,       
           ZFFT_6_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_6_wr_State <=ZFFT_6_wr_RST;
     end 
      else begin 
           case( ZFFT_6_wr_State)  
            ZFFT_6_wr_RST :
                begin
                      ZFFT_6_wr_State <=ZFFT_6_wr_IDLE;
                end 
            ZFFT_6_wr_IDLE:
                begin
                  if (Wr_6_RAM_en  ) 
                      ZFFT_6_wr_State <=ZFFT_6_wr_BEGIN;
                  else
                      ZFFT_6_wr_State <=ZFFT_6_wr_IDLE;
                 end 
            ZFFT_6_wr_BUF:
                 begin
                      ZFFT_6_wr_State <=ZFFT_6_wr_IDLE;         
                 end    
            ZFFT_6_wr_BEGIN:
                 begin
                    if (ZFFT_6_Loop_Num ==  Loop_times) 
                      ZFFT_6_wr_State <=ZFFT_6_wr_END;
                    else
                      ZFFT_6_wr_State <=ZFFT_6_wr_BUF;   
                 end 
                                           
             ZFFT_6_wr_END:
                   begin 
                      ZFFT_6_wr_State <=ZFFT_6_wr_IDLE;               
                   end 
         default:     ZFFT_6_wr_State <=ZFFT_6_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_6_wr_State == ZFFT_6_wr_BEGIN) )
           M_AXIS_6_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_6_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_6_wr_State == ZFFT_6_wr_BEGIN)
           ZFFT_6_Loop_Num         <=   ZFFT_6_Loop_Num + 1'b1 ;      
      else  if (ZFFT_6_Loop_Num ==  Loop_times)  
           ZFFT_6_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_6_wr_State == ZFFT_6_wr_BEGIN)
           M_AXIS_6_ZFFT_Wr_addr         <=   ZFFT_6_Loop_Num  ;      
      else   
           M_AXIS_6_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_6_wr_State == ZFFT_6_wr_BEGIN)
           M_AXIS_6_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_6_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_6_wr_State == ZFFT_6_wr_BUF)
           ZFFT_6_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_6_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_7_wr_RST   = 5'b00001	,
           ZFFT_7_wr_IDLE  = 5'b00010	,
           ZFFT_7_wr_BEGIN = 5'b00100	, 
           ZFFT_7_wr_BUF   = 5'b01000	,       
           ZFFT_7_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_7_wr_State <=ZFFT_7_wr_RST;
     end 
      else begin 
           case( ZFFT_7_wr_State)  
            ZFFT_7_wr_RST :
                begin
                      ZFFT_7_wr_State <=ZFFT_7_wr_IDLE;
                end 
            ZFFT_7_wr_IDLE:
                begin
                  if (Wr_7_RAM_en  ) 
                      ZFFT_7_wr_State <=ZFFT_7_wr_BEGIN;
                  else
                      ZFFT_7_wr_State <=ZFFT_7_wr_IDLE;
                 end 
            ZFFT_7_wr_BUF:
                 begin
                      ZFFT_7_wr_State <=ZFFT_7_wr_IDLE;         
                 end    
            ZFFT_7_wr_BEGIN:
                 begin
                    if (ZFFT_7_Loop_Num ==  Loop_times) 
                      ZFFT_7_wr_State <=ZFFT_7_wr_END;
                    else
                      ZFFT_7_wr_State <=ZFFT_7_wr_BUF;   
                 end 
                                           
             ZFFT_7_wr_END:
                   begin 
                      ZFFT_7_wr_State <=ZFFT_7_wr_IDLE;               
                   end 
         default:     ZFFT_7_wr_State <=ZFFT_7_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_7_wr_State == ZFFT_7_wr_BEGIN) )
           M_AXIS_7_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_7_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_7_wr_State == ZFFT_7_wr_BEGIN)
           ZFFT_7_Loop_Num         <=   ZFFT_7_Loop_Num + 1'b1 ;      
      else  if (ZFFT_7_Loop_Num ==  Loop_times)  
           ZFFT_7_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_7_wr_State == ZFFT_7_wr_BEGIN)
           M_AXIS_7_ZFFT_Wr_addr         <=   ZFFT_7_Loop_Num  ;      
      else   
           M_AXIS_7_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_7_wr_State == ZFFT_7_wr_BEGIN)
           M_AXIS_7_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_7_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_7_wr_State == ZFFT_7_wr_BUF)
           ZFFT_7_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_7_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////// 
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           ZFFT_8_wr_RST   = 5'b00001	,
           ZFFT_8_wr_IDLE  = 5'b00010	,
           ZFFT_8_wr_BEGIN = 5'b00100	, 
           ZFFT_8_wr_BUF   = 5'b01000	,       
           ZFFT_8_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      ZFFT_8_wr_State <=ZFFT_8_wr_RST;
     end 
      else begin 
           case( ZFFT_8_wr_State)  
            ZFFT_8_wr_RST :
                begin
                      ZFFT_8_wr_State <=ZFFT_8_wr_IDLE;
                end 
            ZFFT_8_wr_IDLE:
                begin
                  if (Wr_8_RAM_en  ) 
                      ZFFT_8_wr_State <=ZFFT_8_wr_BEGIN;
                  else
                      ZFFT_8_wr_State <=ZFFT_8_wr_IDLE;
                 end   
                
            ZFFT_8_wr_BEGIN:
                 begin
                    if (ZFFT_8_Loop_Num ==  Loop_times) 
                      ZFFT_8_wr_State <=ZFFT_8_wr_END;
                    else
                      ZFFT_8_wr_State <=ZFFT_8_wr_BUF;   
                 end 
            ZFFT_8_wr_BUF:                                  
                 begin                                      
                     ZFFT_8_wr_State <=ZFFT_8_wr_IDLE; 
                 end                                     
             ZFFT_8_wr_END:
                   begin 
                      ZFFT_8_wr_State <=ZFFT_8_wr_IDLE;               
                   end 
         default:     ZFFT_8_wr_State <=ZFFT_8_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_ZFFT_Wr_en          <= 1'b0 ;                 
      else if ((ZFFT_8_wr_State == ZFFT_8_wr_BEGIN) )
           M_AXIS_8_ZFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_8_ZFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_Loop_Num         <=   8'd0  ;                
      else if (ZFFT_8_wr_State == ZFFT_8_wr_BEGIN)
           ZFFT_8_Loop_Num         <=   ZFFT_8_Loop_Num + 1'b1 ;      
      else  if (ZFFT_8_Loop_Num ==  Loop_times)  
           ZFFT_8_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_ZFFT_Wr_addr         <=   8'd0  ;                
      else if (ZFFT_8_wr_State == ZFFT_8_wr_BEGIN)
           M_AXIS_8_ZFFT_Wr_addr         <=   ZFFT_8_Loop_Num  ;      
      else   
           M_AXIS_8_ZFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_ZFFT_Wr_data          <=  512'd0  ;               
      else if (ZFFT_8_wr_State == ZFFT_8_wr_BEGIN)
           M_AXIS_8_ZFFT_Wr_data<=   Before_Data_ZFFT; 
      else   
           M_AXIS_8_ZFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_8_wr_State == ZFFT_8_wr_BUF)
           ZFFT_8_wr_Done          <= 1'b1 ;      
      else   
           ZFFT_8_wr_Done          <= 1'b0 ;                          
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_ALL_wr_Done          <= 1'b0 ;                    
      else if (ZFFT_1_Loop_Num == 63 && ZFFT_1_wr_State == ZFFT_1_wr_BEGIN)
            ZFFT_ALL_wr_Done          <= 1'b1 ;      
      else   
            ZFFT_ALL_wr_Done          <= 1'b0 ;                          
      end  

      
//////////////////////////////////////////////////////////////////////////////////
//   TEANSFORM DATA TO FFT IP CORE                                              //
//////////////////////////////////////////////////////////////////////////////////    

localparam [5:0]
           Before_ZFFT_1_Rd_RST   = 6'b000001	,
           Before_ZFFT_1_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_1_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_1_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_1_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_1_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_1_Rd_State)  
            Before_ZFFT_1_Rd_RST :
                begin
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_IDLE;
                end 
            Before_ZFFT_1_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_BEGIN;
                  else
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_IDLE;
                 end 
            Before_ZFFT_1_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_1_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_END;
                    else if((Before_ZFFT_1_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) )                   
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_Wait;
                    else
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_BEGIN;
                 end

             Before_ZFFT_1_Rd_Wait:
                 begin 
                    if ( ZFFT_1_W_Done) 
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_BEGIN;
                    else
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_Wait;
                 end                                      
             Before_ZFFT_1_Rd_END:
                   begin 
                      Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_1_Rd_State <=Before_ZFFT_1_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_1_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_1_Rd_State == Before_ZFFT_1_Rd_BEGIN )  
           Before_ZFFT_1_Rd_Loop_Num         <=   Before_ZFFT_1_Rd_Loop_Num + 1'b1 ;      
      else if ( Before_ZFFT_1_Rd_State  == Before_ZFFT_1_Rd_END) 
           Before_ZFFT_1_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_1_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_1_Rd_State == Before_ZFFT_1_Rd_BEGIN)
            Before_1_ZFFT_Rd_addr         <=   Before_ZFFT_1_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_1_Rd_State == Before_ZFFT_1_Rd_END)   
            Before_1_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_Before_en        <= 1'b0 ;                       
      else if   (Before_ZFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           ZFFT_1_Before_en        <= 1'b1 ;            
      else   
           ZFFT_1_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_1_vaild_en          <= 1'b0 ;                 
      else if  (   Before_ZFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            ZFFT_1_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_1_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_1_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_1_Rd_State == Before_ZFFT_1_Rd_END)
           Before_ZFFT_1_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_1_Rd_Done          <= 1'b0 ;                          
      end
      
      
   

localparam [5:0]
           Before_ZFFT_2_Rd_RST   = 6'b000001	,
           Before_ZFFT_2_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_2_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_2_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_2_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_2_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_2_Rd_State)  
            Before_ZFFT_2_Rd_RST :
                begin
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_IDLE;
                end 
            Before_ZFFT_2_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_BEGIN;
                  else
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_IDLE;
                 end 
            Before_ZFFT_2_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_2_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_END;
                    else  if( (Before_ZFFT_2_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before) )
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_Wait;
                    else
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_BEGIN;
                 end
 
             Before_ZFFT_2_Rd_Wait:
                 begin 
                    if ( ZFFT_2_W_Done) 
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_BEGIN;
                    else
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_Wait;
                 end      
                 
             Before_ZFFT_2_Rd_END:
                   begin 
                      Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_2_Rd_State <=Before_ZFFT_2_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_2_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_2_Rd_State == Before_ZFFT_2_Rd_BEGIN )   
           Before_ZFFT_2_Rd_Loop_Num         <=   Before_ZFFT_2_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_ZFFT_2_Rd_State ==Before_ZFFT_2_Rd_END)  
           Before_ZFFT_2_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_2_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_2_Rd_State == Before_ZFFT_2_Rd_BEGIN)
            Before_2_ZFFT_Rd_addr         <=   Before_ZFFT_2_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_2_Rd_State ==Before_ZFFT_2_Rd_END)   
            Before_2_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_Before_en        <= 1'b0 ;                       
      else if  (Before_ZFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
           ZFFT_2_Before_en        <= 1'b1 ;            
      else   
           ZFFT_2_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_2_vaild_en          <= 1'b0 ;                 
      else if   (Before_ZFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
            ZFFT_2_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_2_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_2_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_2_Rd_State == Before_ZFFT_2_Rd_END)
           Before_ZFFT_2_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_2_Rd_Done          <= 1'b0 ;                          
      end
      
  
localparam [5:0]
           Before_ZFFT_3_Rd_RST   = 6'b000001	,
           Before_ZFFT_3_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_3_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_3_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_3_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_3_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_3_Rd_State)  
            Before_ZFFT_3_Rd_RST :
                begin
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_IDLE;
                end 
            Before_ZFFT_3_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_BEGIN;
                  else
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_IDLE;
                 end 
           Before_ZFFT_3_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_3_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_END;
                    else if((Before_ZFFT_3_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_Wait;
                    else
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_BEGIN;
                 end

             Before_ZFFT_3_Rd_Wait:
                 begin 
                    if ( ZFFT_3_W_Done) 
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_BEGIN;
                    else
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_Wait;
                 end                  
                 
             Before_ZFFT_3_Rd_END:
                   begin 
                      Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_3_Rd_State <=Before_ZFFT_3_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_3_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_3_Rd_State == Before_ZFFT_3_Rd_BEGIN&& Before_ZFFT_3_Rd_Loop_Num <=Loop_times)   
           Before_ZFFT_3_Rd_Loop_Num         <=   Before_ZFFT_3_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_ZFFT_3_Rd_State == Before_ZFFT_3_Rd_END)     
           Before_ZFFT_3_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_3_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_3_Rd_State == Before_ZFFT_3_Rd_BEGIN)
            Before_3_ZFFT_Rd_addr         <=   Before_ZFFT_3_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_3_Rd_State == Before_ZFFT_3_Rd_END)     
            Before_3_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_Before_en        <= 1'b0 ;                       
      else if (Before_ZFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
           ZFFT_3_Before_en        <= 1'b1 ;            
      else   
           ZFFT_3_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_3_vaild_en          <= 1'b0 ;                 
      else if  (Before_ZFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
            ZFFT_3_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_3_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_3_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_3_Rd_State == Before_ZFFT_3_Rd_END)
           Before_ZFFT_3_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_3_Rd_Done          <= 1'b0 ;                          
      end
      
 localparam [5:0]
           Before_ZFFT_4_Rd_RST   = 6'b000001	,
           Before_ZFFT_4_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_4_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_4_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_4_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_4_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_4_Rd_State)  
            Before_ZFFT_4_Rd_RST :
                begin
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_IDLE;
                end 
            Before_ZFFT_4_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_BEGIN;
                  else
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_IDLE;
                 end 
           Before_ZFFT_4_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_4_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_END;
                    else if((Before_ZFFT_4_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_Wait;
                    else
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_BEGIN;
                 end

             Before_ZFFT_4_Rd_Wait:
                 begin 
                    if ( ZFFT_4_W_Done) 
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_BEGIN;
                    else
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_Wait;
                 end                  
                 
                 
             Before_ZFFT_4_Rd_END:
                   begin 
                      Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_4_Rd_State <=Before_ZFFT_4_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_4_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_4_Rd_State == Before_ZFFT_4_Rd_BEGIN&& Before_ZFFT_4_Rd_Loop_Num <=Loop_times)   
           Before_ZFFT_4_Rd_Loop_Num         <=   Before_ZFFT_4_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_ZFFT_4_Rd_State ==Before_ZFFT_4_Rd_END)     
           Before_ZFFT_4_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_4_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_4_Rd_State == Before_ZFFT_4_Rd_BEGIN)
            Before_4_ZFFT_Rd_addr         <=   Before_ZFFT_4_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_4_Rd_State ==Before_ZFFT_4_Rd_END)     
            Before_4_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_Before_en        <= 1'b0 ;                       
      else if(Before_ZFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           ZFFT_4_Before_en        <= 1'b1 ;            
      else   
           ZFFT_4_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_4_vaild_en          <= 1'b0 ;                 
      else if (Before_ZFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            ZFFT_4_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_4_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_4_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_4_Rd_State == Before_ZFFT_4_Rd_END)
           Before_ZFFT_4_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_4_Rd_Done          <= 1'b0 ;                          
      end

localparam [5:0]
           Before_ZFFT_5_Rd_RST   = 6'b000001	,
           Before_ZFFT_5_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_5_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_5_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_5_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_5_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_5_Rd_State)  
            Before_ZFFT_5_Rd_RST :
                begin
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_IDLE;
                end 
            Before_ZFFT_5_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_BEGIN;
                  else
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_IDLE;
                 end 
        Before_ZFFT_5_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_5_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_END;
                    else if((Before_ZFFT_5_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_Wait;
                    else
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_BEGIN;
                 end

             Before_ZFFT_5_Rd_Wait:
                 begin 
                    if ( ZFFT_5_W_Done) 
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_BEGIN;
                    else
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_Wait;
                 end                  
                 
                    
                 
             Before_ZFFT_5_Rd_END:
                   begin 
                      Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_5_Rd_State <=Before_ZFFT_5_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_5_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_5_Rd_State == Before_ZFFT_5_Rd_BEGIN&& Before_ZFFT_5_Rd_Loop_Num <=Loop_times)    
           Before_ZFFT_5_Rd_Loop_Num         <=   Before_ZFFT_5_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_ZFFT_5_Rd_State == Before_ZFFT_5_Rd_END)    
           Before_ZFFT_5_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_5_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_5_Rd_State == Before_ZFFT_5_Rd_BEGIN)
            Before_5_ZFFT_Rd_addr         <=   Before_ZFFT_5_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_5_Rd_State == Before_ZFFT_5_Rd_END)     
            Before_5_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_Before_en        <= 1'b0 ;                       
      else if (Before_ZFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           ZFFT_5_Before_en        <= 1'b1 ;            
      else   
           ZFFT_5_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_5_vaild_en          <= 1'b0 ;                 
      else if(Before_ZFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            ZFFT_5_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_5_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_5_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_5_Rd_State == Before_ZFFT_5_Rd_END)
           Before_ZFFT_5_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_5_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_ZFFT_6_Rd_RST   = 6'b000001	,
           Before_ZFFT_6_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_6_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_6_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_6_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_6_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_6_Rd_State)  
            Before_ZFFT_6_Rd_RST :
                begin
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_IDLE;
                end 
            Before_ZFFT_6_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_BEGIN;
                  else
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_IDLE;
                 end 
             Before_ZFFT_6_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_6_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_END;
                    else if((Before_ZFFT_6_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_Wait;
                    else
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_BEGIN;
                 end

             Before_ZFFT_6_Rd_Wait:
                 begin 
                    if ( ZFFT_6_W_Done) 
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_BEGIN;
                    else
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_Wait;
                 end                  
                 
                 
             Before_ZFFT_6_Rd_END:
                   begin 
                      Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_6_Rd_State <=Before_ZFFT_6_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_6_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_6_Rd_State == Before_ZFFT_6_Rd_BEGIN&& Before_ZFFT_6_Rd_Loop_Num <=Loop_times)    
           Before_ZFFT_6_Rd_Loop_Num         <=   Before_ZFFT_6_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_ZFFT_6_Rd_State ==Before_ZFFT_6_Rd_END)     
           Before_ZFFT_6_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_6_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_6_Rd_State == Before_ZFFT_6_Rd_BEGIN)
            Before_6_ZFFT_Rd_addr         <=   Before_ZFFT_6_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_6_Rd_State ==Before_ZFFT_6_Rd_END)     
            Before_6_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_Before_en        <= 1'b0 ;                       
      else if (Before_ZFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           ZFFT_6_Before_en        <= 1'b1 ;            
      else   
           ZFFT_6_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_6_vaild_en          <= 1'b0 ;                 
      else if  (Before_ZFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before)
            ZFFT_6_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_6_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_6_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_6_Rd_State == Before_ZFFT_6_Rd_END)
           Before_ZFFT_6_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_6_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_ZFFT_7_Rd_RST   = 6'b000001	,
           Before_ZFFT_7_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_7_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_7_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_7_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_7_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_7_Rd_State)  
            Before_ZFFT_7_Rd_RST :
                begin
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_IDLE;
                end 
            Before_ZFFT_7_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_BEGIN;
                  else
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_IDLE;
                 end 
            Before_ZFFT_7_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_7_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_END;
                    else if((Before_ZFFT_7_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_Wait;
                    else
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_BEGIN;
                 end

             Before_ZFFT_7_Rd_Wait:
                 begin 
                    if ( ZFFT_7_W_Done) 
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_BEGIN;
                    else
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_Wait;
                 end                  
                 
             Before_ZFFT_7_Rd_END:
                   begin 
                      Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_7_Rd_State <=Before_ZFFT_7_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_7_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_7_Rd_State == Before_ZFFT_7_Rd_BEGIN&& Before_ZFFT_7_Rd_Loop_Num <=Loop_times)   
           Before_ZFFT_7_Rd_Loop_Num         <=   Before_ZFFT_7_Rd_Loop_Num + 1'b1 ;      
      else if( Before_ZFFT_7_Rd_State ==Before_ZFFT_7_Rd_END)      
           Before_ZFFT_7_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_7_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_7_Rd_State == Before_ZFFT_7_Rd_BEGIN)
            Before_7_ZFFT_Rd_addr         <=   Before_ZFFT_7_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_7_Rd_State ==Before_ZFFT_7_Rd_END)     
            Before_7_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_Before_en        <= 1'b0 ;                       
      else if (Before_ZFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
           ZFFT_7_Before_en        <= 1'b1 ;            
      else   
           ZFFT_7_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_7_vaild_en          <= 1'b0 ;                 
      else if  (Before_ZFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
            ZFFT_7_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_7_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_7_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_7_Rd_State == Before_ZFFT_7_Rd_END)
           Before_ZFFT_7_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_7_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_ZFFT_8_Rd_RST   = 6'b000001	,
           Before_ZFFT_8_Rd_IDLE  = 6'b000010	,
           Before_ZFFT_8_Rd_BEGIN = 6'b000100	, 
           Before_ZFFT_8_Rd_BUF   = 6'b001000 	,     
           Before_ZFFT_8_Rd_Wait  = 6'b010000 	,      
           Before_ZFFT_8_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_RST;
     end 
      else begin 
           case( Before_ZFFT_8_Rd_State)  
            Before_ZFFT_8_Rd_RST :
                begin
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_IDLE;
                end 
            Before_ZFFT_8_Rd_IDLE:
                begin
                  if (ZFFT_ALL_wr_Done  ) 
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_BEGIN;
                  else
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_IDLE;
                 end 
            Before_ZFFT_8_Rd_BEGIN:
                 begin
                    if (Before_ZFFT_8_Rd_Loop_Num  ==  Loop_times) 
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_END;
                    else if((Before_ZFFT_8_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_ZFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_Wait;
                    else
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_BEGIN;
                 end

             Before_ZFFT_8_Rd_Wait:
                 begin 
                    if ( ZFFT_8_W_Done) 
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_BEGIN;
                    else
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_Wait;
                 end                  
                      
                 
             Before_ZFFT_8_Rd_END:
                   begin 
                      Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_IDLE;               
                   end 
         default:     Before_ZFFT_8_Rd_State <=Before_ZFFT_8_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_8_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_ZFFT_8_Rd_State == Before_ZFFT_8_Rd_BEGIN&& Before_ZFFT_8_Rd_Loop_Num <=Loop_times)    
           Before_ZFFT_8_Rd_Loop_Num         <=   Before_ZFFT_8_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_ZFFT_8_Rd_State ==Before_ZFFT_8_Rd_END)     
           Before_ZFFT_8_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_8_ZFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_ZFFT_8_Rd_State == Before_ZFFT_8_Rd_BEGIN)
            Before_8_ZFFT_Rd_addr         <=   Before_ZFFT_8_Rd_Loop_Num  ;      
      else  if( Before_ZFFT_8_Rd_State ==Before_ZFFT_8_Rd_END)     
            Before_8_ZFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_Before_en        <= 1'b0 ;                       
      else if  (Before_ZFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
           ZFFT_8_Before_en        <= 1'b1 ;            
      else   
           ZFFT_8_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            ZFFT_8_vaild_en          <= 1'b0 ;                 
      else if   (Before_ZFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
            ZFFT_8_vaild_en          <= 1'b1 ;        
      else   
            ZFFT_8_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_ZFFT_8_Rd_Done          <= 1'b0 ;                    
      else if ( Before_ZFFT_8_Rd_State == Before_ZFFT_8_Rd_END)
           Before_ZFFT_8_Rd_Done          <= 1'b1 ;      
      else   
           Before_ZFFT_8_Rd_Done          <= 1'b0 ;                          
      end                                                               
         
//////////////////////////////////////////////////////////////////////////////////
//   after fft ip buffer to ram                                                 //
//////////////////////////////////////////////////////////////////////////////////    
    
 localparam [4:0]
           ZFFT_1_W_RST   = 5'b00001	,
           ZFFT_1_W_IDLE  = 5'b00010	,
           ZFFT_1_W_BEGIN = 5'b00100	, 
           ZFFT_1_W_Wait  = 5'b01000	,                 
           ZFFT_1_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_1_W_State <=ZFFT_1_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_1_W_State)  
            ZFFT_1_W_RST :
                begin
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_IDLE;
                end 
            ZFFT_1_W_IDLE:
                begin
                  if ( ZFFT_1_Before_en) /// to fft ip  
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_Wait;
                  else
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_IDLE;
                 end 
           ZFFT_1_W_Wait :    
                 begin
                    if ( ZFFT_1_Done) /// response from fft ip
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_BEGIN;
                    else
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_Wait;
                 end 
                 
            ZFFT_1_W_BEGIN:
                 begin
                    if (ZFFT_1_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_END;
                    else
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_IDLE;
                 end                  
             ZFFT_1_W_END:
                   begin 
                      AFTER_ZFFT_1_W_State <=ZFFT_1_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_1_W_State <=ZFFT_1_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_1_W_State == ZFFT_1_W_BEGIN)
           ZFFT_1_W_Loop_Num         <=   ZFFT_1_W_Loop_Num + 8'd64 ;     
      else  if (AFTER_ZFFT_1_W_State ==ZFFT_1_W_END)       
           ZFFT_1_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_1_W_State == ZFFT_1_W_Wait&& ZFFT_1_Done)
           ZFFT_1_W_Done          <= 1'b1 ;      
      else   
           ZFFT_1_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_1_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_1_W_State ==ZFFT_1_W_END  )
           ZFFT_1_W_Finish          <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_1_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_2_W_RST   = 5'b00001	,
           ZFFT_2_W_IDLE  = 5'b00010	,
           ZFFT_2_W_BEGIN = 5'b00100	, 
           ZFFT_2_W_Wait  = 5'b01000	,                 
           ZFFT_2_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_2_W_State <=ZFFT_2_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_2_W_State)  
            ZFFT_2_W_RST :
                begin
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_IDLE;
                end 
            ZFFT_2_W_IDLE:
                begin
                  if ( ZFFT_2_Before_en) 
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_BEGIN;
                  else
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_IDLE;
                 end 
          ZFFT_2_W_Wait :    
                 begin
                    if ( ZFFT_2_Done) 
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_BEGIN;
                    else
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_Wait;
                 end 
                 
            ZFFT_2_W_BEGIN:
                 begin
                    if (ZFFT_2_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_END;
                    else
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_IDLE;
                 end 

                 
             ZFFT_2_W_END:
                   begin 
                      AFTER_ZFFT_2_W_State <=ZFFT_2_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_2_W_State <=ZFFT_2_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_2_W_State == ZFFT_2_W_BEGIN)
           ZFFT_2_W_Loop_Num         <=   ZFFT_2_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_ZFFT_2_W_State ==ZFFT_2_W_END)       
           ZFFT_2_W_Loop_Num         <=   8'd0  ;              
      end     

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_2_W_State == ZFFT_2_W_Wait&& ZFFT_2_Done)
           ZFFT_2_W_Done          <= 1'b1 ;      
      else   
           ZFFT_2_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_2_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_2_W_State ==ZFFT_2_W_END  )
           ZFFT_2_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_2_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_3_W_RST   = 5'b00001	,
           ZFFT_3_W_IDLE  = 5'b00010	,
           ZFFT_3_W_BEGIN = 5'b00100	, 
           ZFFT_3_W_Wait  = 5'b01000	,                 
           ZFFT_3_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_3_W_State <=ZFFT_3_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_3_W_State)  
            ZFFT_3_W_RST :
                begin
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_IDLE;
                end 
            ZFFT_3_W_IDLE:
                begin
                  if ( ZFFT_3_Before_en) 
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_BEGIN;
                  else
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_IDLE;
                 end 
           ZFFT_3_W_Wait :    
                 begin
                    if ( ZFFT_3_Done) 
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_BEGIN;
                    else
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_Wait;
                 end 
                 
            ZFFT_3_W_BEGIN:
                 begin
                    if (ZFFT_3_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_END;
                    else
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_IDLE;
                 end 

                 
             ZFFT_3_W_END:
                   begin 
                      AFTER_ZFFT_3_W_State <=ZFFT_3_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_3_W_State <=ZFFT_3_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_3_W_State == ZFFT_3_W_BEGIN)
           ZFFT_3_W_Loop_Num         <=   ZFFT_3_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_ZFFT_3_W_State ==ZFFT_3_W_END)       
           ZFFT_3_W_Loop_Num         <=   8'd0  ;              
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_3_W_State == ZFFT_3_W_Wait&& ZFFT_3_Done)
           ZFFT_3_W_Done          <= 1'b1 ;      
      else   
           ZFFT_3_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_3_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_3_W_State ==ZFFT_3_W_END  )
           ZFFT_3_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_3_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_4_W_RST   = 5'b00001	,
           ZFFT_4_W_IDLE  = 5'b00010	,
           ZFFT_4_W_BEGIN = 5'b00100	, 
           ZFFT_4_W_Wait  = 5'b01000	,                 
           ZFFT_4_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_4_W_State <=ZFFT_4_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_4_W_State)  
            ZFFT_4_W_RST :
                begin
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_IDLE;
                end 
            ZFFT_4_W_IDLE:
                begin
                  if ( ZFFT_4_Before_en) 
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_BEGIN;
                  else
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_IDLE;
                 end 
            ZFFT_4_W_Wait :    
                 begin
                    if ( ZFFT_4_Done) 
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_BEGIN;
                    else
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_Wait;
                 end 
                 
            ZFFT_4_W_BEGIN:
                 begin
                    if (ZFFT_4_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_END;
                    else
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_IDLE;
                 end 

                 
             ZFFT_4_W_END:
                   begin 
                      AFTER_ZFFT_4_W_State <=ZFFT_4_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_4_W_State <=ZFFT_4_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_4_W_State == ZFFT_4_W_BEGIN)
           ZFFT_4_W_Loop_Num         <=   ZFFT_4_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_ZFFT_4_W_State ==ZFFT_4_W_END)       
           ZFFT_4_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_4_W_State == ZFFT_4_W_Wait&& ZFFT_4_Done)
           ZFFT_4_W_Done          <= 1'b1 ;      
      else   
           ZFFT_4_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_4_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_4_W_State ==ZFFT_4_W_END  )
           ZFFT_4_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_4_W_Finish          <= 1'b0 ;                          
      end
      
    localparam [4:0]
           ZFFT_5_W_RST   = 5'b00001	,
           ZFFT_5_W_IDLE  = 5'b00010	,
           ZFFT_5_W_BEGIN = 5'b00100	, 
           ZFFT_5_W_Wait  = 5'b01000	,                 
           ZFFT_5_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_5_W_State <=ZFFT_5_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_5_W_State)  
            ZFFT_5_W_RST :
                begin
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_IDLE;
                end 
            ZFFT_5_W_IDLE:
                begin
                  if ( ZFFT_5_Before_en) 
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_BEGIN;
                  else
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_IDLE;
                 end 
            ZFFT_5_W_Wait :    
                 begin
                    if ( ZFFT_5_Done) 
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_BEGIN;
                    else
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_Wait;
                 end 
                 
            ZFFT_5_W_BEGIN:
                 begin
                    if (ZFFT_5_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_END;
                    else
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_IDLE;
                 end 

                 
             ZFFT_5_W_END:
                   begin 
                      AFTER_ZFFT_5_W_State <=ZFFT_5_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_5_W_State <=ZFFT_5_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_5_W_State == ZFFT_5_W_BEGIN)
           ZFFT_5_W_Loop_Num         <=   ZFFT_5_W_Loop_Num + 8'd64 ;          
      else if (AFTER_ZFFT_5_W_State ==ZFFT_5_W_END)     
           ZFFT_5_W_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_5_W_State == ZFFT_5_W_Wait&& ZFFT_5_Done)
           ZFFT_5_W_Done          <= 1'b1 ;      
      else   
           ZFFT_5_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_5_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_5_W_State ==ZFFT_5_W_END  )
           ZFFT_5_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_5_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_6_W_RST   = 5'b00001	,
           ZFFT_6_W_IDLE  = 5'b00010	,
           ZFFT_6_W_BEGIN = 5'b00100	, 
           ZFFT_6_W_Wait  = 5'b01000	,                 
           ZFFT_6_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_6_W_State <=ZFFT_6_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_6_W_State)  
            ZFFT_6_W_RST :
                begin
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_IDLE;
                end 
            ZFFT_6_W_IDLE:
                begin
                  if ( ZFFT_6_Before_en) 
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_BEGIN;
                  else
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_IDLE;
                 end 
           ZFFT_6_W_Wait :    
                 begin
                    if ( ZFFT_6_Done) 
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_BEGIN;
                    else
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_Wait;
                 end 
                 
            ZFFT_6_W_BEGIN:
                 begin
                    if (ZFFT_6_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_END;
                    else
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_IDLE;
                 end 

                 
             ZFFT_6_W_END:
                   begin 
                      AFTER_ZFFT_6_W_State <=ZFFT_6_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_6_W_State <=ZFFT_6_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_6_W_State == ZFFT_6_W_BEGIN)
           ZFFT_6_W_Loop_Num         <=   ZFFT_6_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_ZFFT_6_W_State ==ZFFT_6_W_END)   
           ZFFT_6_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_6_W_State == ZFFT_6_W_Wait&& ZFFT_6_Done)
           ZFFT_6_W_Done          <= 1'b1 ;      
      else   
           ZFFT_6_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_6_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_6_W_State ==ZFFT_6_W_END  )
           ZFFT_6_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_6_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_7_W_RST   = 5'b00001	,
           ZFFT_7_W_IDLE  = 5'b00010	,
           ZFFT_7_W_BEGIN = 5'b00100	, 
           ZFFT_7_W_Wait  = 5'b01000	,                 
           ZFFT_7_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_7_W_State <=ZFFT_7_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_7_W_State)  
            ZFFT_7_W_RST :
                begin
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_IDLE;
                end 
            ZFFT_7_W_IDLE:
                begin
                  if ( ZFFT_7_Before_en) 
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_BEGIN;
                  else
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_IDLE;
                 end 
          ZFFT_7_W_Wait :    
                 begin
                    if ( ZFFT_7_Done) 
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_BEGIN;
                    else
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_Wait;
                 end 
                 
            ZFFT_7_W_BEGIN:
                 begin
                    if (ZFFT_7_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_END;
                    else
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_IDLE;
                 end 

                 
             ZFFT_7_W_END:
                   begin 
                      AFTER_ZFFT_7_W_State <=ZFFT_7_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_7_W_State <=ZFFT_7_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_7_W_State == ZFFT_7_W_BEGIN)
           ZFFT_7_W_Loop_Num         <=   ZFFT_7_W_Loop_Num + 8'd64 ;         
      else   if (AFTER_ZFFT_7_W_State ==ZFFT_7_W_END)  
           ZFFT_7_W_Loop_Num         <=   8'd0  ;              
      end      

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_7_W_State == ZFFT_7_W_Wait&& ZFFT_7_Done)
           ZFFT_7_W_Done          <= 1'b1 ;      
      else   
           ZFFT_7_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_7_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_7_W_State ==ZFFT_7_W_END  )
           ZFFT_7_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_7_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           ZFFT_8_W_RST   = 5'b00001	,
           ZFFT_8_W_IDLE  = 5'b00010	,
           ZFFT_8_W_BEGIN = 5'b00100	, 
           ZFFT_8_W_Wait  = 5'b01000	,                 
           ZFFT_8_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_ZFFT_8_W_State <=ZFFT_8_W_RST;
     end 
      else begin 
           case( AFTER_ZFFT_8_W_State)  
            ZFFT_8_W_RST :
                begin
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_IDLE;
                end 
            ZFFT_8_W_IDLE:
                begin
                  if ( ZFFT_8_Before_en) 
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_BEGIN;
                  else
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_IDLE;
                 end 
          ZFFT_8_W_Wait :    
                 begin
                    if ( ZFFT_8_Done) 
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_BEGIN;
                    else
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_Wait;
                 end 
                 
            ZFFT_8_W_BEGIN:
                 begin
                    if (ZFFT_8_W_Loop_Num ==  Loop_times_Before) 
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_END;
                    else
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_IDLE;
                 end 

                 
             ZFFT_8_W_END:
                   begin 
                      AFTER_ZFFT_8_W_State <=ZFFT_8_W_IDLE;               
                   end 
         default:     AFTER_ZFFT_8_W_State <=ZFFT_8_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_ZFFT_8_W_State == ZFFT_8_W_BEGIN)
           ZFFT_8_W_Loop_Num         <=   ZFFT_8_W_Loop_Num + 8'd64 ;      
      else  if (AFTER_ZFFT_8_W_State ==ZFFT_8_W_END) 
           ZFFT_8_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_W_Done          <= 1'b0 ;                    
      else if (AFTER_ZFFT_8_W_State == ZFFT_8_W_Wait&& ZFFT_8_Done)
           ZFFT_8_W_Done          <= 1'b1 ;      
      else   
           ZFFT_8_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_8_W_Finish          <= 1'b0 ;                    
      else if (AFTER_ZFFT_8_W_State ==ZFFT_8_W_END  )
           ZFFT_8_W_Finish         <= 1'b1 ;      
      else if (ZFFT_W_Finish)  
           ZFFT_8_W_Finish          <= 1'b0 ;                          
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_Forward_end          <= 1'b0 ;                    
      else if (ZFFT_8_W_Finish  )
           ZFFT_Forward_end         <= 1'b1 ;      
      else 
           ZFFT_Forward_end          <= 1'b0 ;                          
      end    
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ZFFT_Backward_end          <= 1'b0 ;                    
      else if (FFT_Backward_begin  )
           ZFFT_Backward_end         <= 1'b1 ;      
      else 
           ZFFT_Backward_end          <= 1'b0 ;                          
      end     
endmodule