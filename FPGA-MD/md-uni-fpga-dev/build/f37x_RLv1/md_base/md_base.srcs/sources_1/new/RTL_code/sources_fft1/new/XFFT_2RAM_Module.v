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


module XFFT_2RAM_Module #  (parameter  Loop_times         =  14'd4096,
                            parameter  Loop_times_Before  =  6'b111111,
                            parameter  Loop_times_AFTER  =  14'd64, //4096/64
                            parameter  X_K_value         =  9'd64,
                            parameter  Y_K_value         =  9'd64,
                            parameter  Z_K_value         =  9'd64 
                             
                            )
(
 input                        Sys_Clk              , 
 input                        Sys_Rst_n            , 
 
 output reg                   XFFT_Running         ,
  
 input                        FFT_Forward_begin    ,
 input                        FFT_Backward_begin   ,
 
 output reg                   XFFT_Forward_end     ,
 output reg                   XFFT_Backward_end    ,
 //------------------------------------------------------ 
 output reg                   M_AXIS_Q_Rd_en       ,     
 input           [63:0]       M_AXIS_Q_Rd_data     ,
 output reg      [31:0]       M_AXIS_Q_Rd_addr     ,  // read data from Ram_Q
 //------------------------------------------------------    
       
output reg                 M_AXIS_1_XFFT_Wr_en   ,    // write data to ram
output reg   [511:0]       M_AXIS_1_XFFT_Wr_data ,
output reg     [15:0]      M_AXIS_1_XFFT_Wr_addr ,
                                          
output reg                 M_AXIS_2_XFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_2_XFFT_Wr_data ,
output reg     [15:0]      M_AXIS_2_XFFT_Wr_addr ,
                                           
output  reg                M_AXIS_3_XFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_3_XFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_3_XFFT_Wr_addr ,
                                                 
output  reg                M_AXIS_4_XFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_4_XFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_4_XFFT_Wr_addr ,
                                           
output reg                 M_AXIS_5_XFFT_Wr_en   ,
output reg    [511:0]      M_AXIS_5_XFFT_Wr_data ,
output reg      [15:0]     M_AXIS_5_XFFT_Wr_addr ,
                                                  
output  reg                M_AXIS_6_XFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_6_XFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_6_XFFT_Wr_addr ,
                                          
output  reg                M_AXIS_7_XFFT_Wr_en   ,
output  reg   [511:0]      M_AXIS_7_XFFT_Wr_data ,
output  reg     [15:0]     M_AXIS_7_XFFT_Wr_addr ,
                                                  
output reg                 M_AXIS_8_XFFT_Wr_en   ,
output reg   [511:0]       M_AXIS_8_XFFT_Wr_data ,
output reg     [15:0]      M_AXIS_8_XFFT_Wr_addr ,
 //------------------------------------------------------    
                                                      //read data to FFT 
 output  reg     [15:0]      Before_1_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_2_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_3_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_4_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_5_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_6_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_7_XFFT_Rd_addr  ,
 output  reg     [15:0]      Before_8_XFFT_Rd_addr  ,  
                                                       
  //------------------------------------------------------    
                                                   
 output reg                   XFFT_1_vaild_en,            
 output  reg     [15:0]       XFFT_1_Loop_Num,
 input                        XFFT_1_Done     ,
 output   reg                 XFFT_1_Before_en,
 
  output reg                  XFFT_2_vaild_en,            
 output  reg     [15:0]       XFFT_2_Loop_Num,
 input                        XFFT_2_Done     ,
 output   reg                 XFFT_2_Before_en,
 
 output reg                   XFFT_3_vaild_en,  
 output  reg     [15:0]       XFFT_3_Loop_Num,
 input                        XFFT_3_Done     ,
 output   reg                 XFFT_3_Before_en,
 
   output reg                 XFFT_4_vaild_en,  
 output  reg     [15:0]       XFFT_4_Loop_Num,
 input                        XFFT_4_Done     ,
 output   reg                 XFFT_4_Before_en,
 
   output reg                 XFFT_5_vaild_en,  
 output  reg      [15:0]      XFFT_5_Loop_Num,
 input                        XFFT_5_Done     ,
 output   reg                 XFFT_5_Before_en,

   output reg                 XFFT_6_vaild_en,  
  output  reg     [15:0]      XFFT_6_Loop_Num,
 input                        XFFT_6_Done     ,
 output   reg                 XFFT_6_Before_en,

   output reg                 XFFT_7_vaild_en,  
  output  reg     [15:0]      XFFT_7_Loop_Num,
 input                        XFFT_7_Done     ,
 output   reg                 XFFT_7_Before_en,

 output reg                   XFFT_8_vaild_en,  
 output  reg     [15:0]       XFFT_8_Loop_Num,
 input                        XFFT_8_Done     ,
 output   reg                 XFFT_8_Before_en ,  
  //------------------------------------------------------  
 //write data to FFT 
  output  reg     [11:0]       XFFT_1_W_Loop_Num,
  output  reg     [11:0]       XFFT_2_W_Loop_Num,
  output  reg     [11:0]       XFFT_3_W_Loop_Num,
  output  reg     [11:0]       XFFT_4_W_Loop_Num,
  output  reg     [11:0]       XFFT_5_W_Loop_Num,
  output  reg     [11:0]       XFFT_6_W_Loop_Num,
  output  reg     [11:0]       XFFT_7_W_Loop_Num,
  output  reg     [11:0]       XFFT_8_W_Loop_Num 
    );

 reg                Wr_1_RAM_en;
 reg                Wr_2_RAM_en;
 reg                Wr_3_RAM_en;
 reg                Wr_4_RAM_en;
 reg                Wr_5_RAM_en;
 reg                Wr_6_RAM_en;
 reg                Wr_7_RAM_en;
 reg                Wr_8_RAM_en; 
 
 reg                XFFT_1_wr_Done;
 reg                XFFT_2_wr_Done;
 reg                XFFT_3_wr_Done;
 reg                XFFT_4_wr_Done;
 reg                XFFT_5_wr_Done;
 reg                XFFT_6_wr_Done;
 reg                XFFT_7_wr_Done;
 reg                XFFT_8_wr_Done;
 reg                XFFT_wr_Done;
 
reg     [3:0]       XFFT_1_wr_State;
reg     [3:0]       XFFT_2_wr_State;
reg     [3:0]       XFFT_3_wr_State;
reg     [3:0]       XFFT_4_wr_State;
reg     [3:0]       XFFT_5_wr_State;
reg     [3:0]       XFFT_6_wr_State;
reg     [3:0]       XFFT_7_wr_State;
reg     [3:0]       XFFT_8_wr_State;

reg   [511:0]       Before_Data_XFFT;
reg    [7:0]        Data_Loop_Num;
reg                 X_Data_Loop_8_plus;
reg                 X_Data_Loop_8_plu_en;

reg     [9:0]        XFFT_Rd_Q_State;

reg     [7:0]        X_AXI_Loop_Num;
reg     [7:0]        Y_AXI_Loop_Num;
reg     [7:0]        Z_AXI_Loop_Num;   
 
reg     [5:0]        Before_XFFT_1_Rd_State ;   
reg     [15:0]       Before_XFFT_1_Rd_Loop_Num;
reg                  Before_XFFT_1_Rd_Done;

reg     [5:0]        Before_XFFT_2_Rd_State ;   
reg     [15:0]       Before_XFFT_2_Rd_Loop_Num;
reg                  Before_XFFT_2_Rd_Done;

reg     [5:0]        Before_XFFT_3_Rd_State ;   
reg     [15:0]       Before_XFFT_3_Rd_Loop_Num;
reg                  Before_XFFT_3_Rd_Done;

reg     [5:0]        Before_XFFT_4_Rd_State ;   
reg     [15:0]       Before_XFFT_4_Rd_Loop_Num;
reg                  Before_XFFT_4_Rd_Done;

reg     [5:0]        Before_XFFT_5_Rd_State ;   
reg     [15:0]       Before_XFFT_5_Rd_Loop_Num;
reg                  Before_XFFT_5_Rd_Done;

reg     [5:0]        Before_XFFT_6_Rd_State ;   
reg     [15:0]       Before_XFFT_6_Rd_Loop_Num;
reg                  Before_XFFT_6_Rd_Done;

reg     [5:0]        Before_XFFT_7_Rd_State ;   
reg     [15:0]       Before_XFFT_7_Rd_Loop_Num;
reg                  Before_XFFT_7_Rd_Done;

reg     [4:0]        Before_XFFT_8_Rd_State ;   
reg     [15:0]       Before_XFFT_8_Rd_Loop_Num;
reg                  Before_XFFT_8_Rd_Done;
//reg                  Before_8_XFFT_Rd_en;

reg                  XFFT_1_W_Done;
reg     [4:0]        AFTER_XFFT_1_W_State;

reg                  XFFT_2_W_Done;
reg     [4:0]        AFTER_XFFT_2_W_State;

reg                  XFFT_3_W_Done;
reg     [4:0]        AFTER_XFFT_3_W_State;

reg                  XFFT_4_W_Done;
reg     [4:0]        AFTER_XFFT_4_W_State;

reg                  XFFT_5_W_Done;
reg     [4:0]        AFTER_XFFT_5_W_State;

reg                  XFFT_6_W_Done;
reg     [4:0]        AFTER_XFFT_6_W_State;

reg                  XFFT_7_W_Done;
reg     [4:0]        AFTER_XFFT_7_W_State;

reg                  XFFT_8_W_Done;
reg     [4:0]        AFTER_XFFT_8_W_State;

reg                 XFFT_1_W_Finish;
reg                 XFFT_2_W_Finish; 
reg                 XFFT_3_W_Finish; 
reg                 XFFT_4_W_Finish; 
reg                 XFFT_5_W_Finish; 
reg                 XFFT_6_W_Finish; 
reg                 XFFT_7_W_Finish; 
reg                 XFFT_8_W_Finish;
reg                 XFFT_W_Finish;
reg                 XFFT_ALL_wr_Done;
//////////////////////////////////////////////////////////////////////////////////
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
 if (!Sys_Rst_n)    
       XFFT_Running <=   1'b0 ;
 else if (FFT_Forward_begin)  
       XFFT_Running <=   1'b1 ;
  else if (XFFT_Forward_end)  
       XFFT_Running <=   1'b0 ;
 end    

//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       XFFT_wr_Done         <=   1'b0 ;
 else  
       XFFT_wr_Done         <=     XFFT_1_wr_Done|| XFFT_2_wr_Done||XFFT_3_wr_Done||XFFT_4_wr_Done 
                                 ||XFFT_5_wr_Done|| XFFT_6_wr_Done||XFFT_7_wr_Done||XFFT_8_wr_Done ;  // wr  512  
 end    
//////////////////////////////////////////////////////////////////////////////////
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
if (!Sys_Rst_n)    
       XFFT_W_Finish         <=   1'b0 ;
 else  
       XFFT_W_Finish         <=    XFFT_1_W_Finish && XFFT_2_W_Finish && XFFT_3_W_Finish && XFFT_4_W_Finish 
                                && XFFT_5_W_Finish && XFFT_6_W_Finish && XFFT_7_W_Finish && XFFT_8_W_Finish ;  
 end   
 //////////////////////////////////////////////////////////////////////////////////
localparam [8:0]
           XFFT_Rd_Q_RST   = 9'b00000001	,
           XFFT_Rd_Q_IDLE  = 9'b00000010	,
           XFFT_Rd_Q_ADD   = 9'b00000100	,
           XFFT_Rd_Q_BEGIN = 9'b00001000	,
           XFFT_Rd_Q_Buf   = 9'b00010000	,
           XFFT_Rd_Q_Buf2  = 9'b00100000	,
           XFFT_Rd_Q_COR   = 9'b01000000	,             
           XFFT_Rd_Q_END   = 9'b10000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_Rd_Q_State <=XFFT_Rd_Q_RST;
     end 
      else begin 
           case( XFFT_Rd_Q_State)  
            XFFT_Rd_Q_RST :
                begin
                      XFFT_Rd_Q_State <=XFFT_Rd_Q_IDLE;
                end 
            XFFT_Rd_Q_IDLE:
                begin
                  if   ( FFT_Forward_begin  ) 
                      XFFT_Rd_Q_State <=XFFT_Rd_Q_BEGIN;
                  else
                      XFFT_Rd_Q_State <=XFFT_Rd_Q_IDLE;
                  end 
                     
             XFFT_Rd_Q_ADD:
                 begin                   
                        XFFT_Rd_Q_State <= XFFT_Rd_Q_BEGIN;         
                  end 
             XFFT_Rd_Q_BEGIN:
                 begin
                    if(  X_AXI_Loop_Num ==  X_K_value)
                        XFFT_Rd_Q_State <= XFFT_Rd_Q_Buf;  
                    else if (X_Data_Loop_8_plus)
                        XFFT_Rd_Q_State <= XFFT_Rd_Q_ADD;
                    else    
                        XFFT_Rd_Q_State <= XFFT_Rd_Q_BEGIN;       
                 end       
              XFFT_Rd_Q_Buf:
                 begin
                    if ( Y_AXI_Loop_Num ==  Y_K_value-1) 
                      XFFT_Rd_Q_State  <= XFFT_Rd_Q_Buf2;
                    else
                      XFFT_Rd_Q_State  <= XFFT_Rd_Q_BEGIN;
                 end                   
              XFFT_Rd_Q_Buf2:
                 begin
                    if ( Z_AXI_Loop_Num ==  Z_K_value-1) 
                      XFFT_Rd_Q_State  <= XFFT_Rd_Q_COR;
                    else
                      XFFT_Rd_Q_State  <= XFFT_Rd_Q_BEGIN;
                 end        
             XFFT_Rd_Q_COR:
                   begin 
                      XFFT_Rd_Q_State <=XFFT_Rd_Q_END;               
                   end 
             XFFT_Rd_Q_END:
                   begin 
                      XFFT_Rd_Q_State <=XFFT_Rd_Q_IDLE;               
                   end 
         default:     XFFT_Rd_Q_State <=XFFT_Rd_Q_IDLE;
     endcase
   end 
 end   
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X_AXI_Loop_Num         <=   8'd0  ;
      else if  (XFFT_Rd_Q_State == XFFT_Rd_Q_Buf  )
           X_AXI_Loop_Num         <=   8'd0  ;                 
      else if  (XFFT_Rd_Q_State ==  XFFT_Rd_Q_ADD) 
           X_AXI_Loop_Num         <=   X_AXI_Loop_Num + 8'd1 ;      
            
      end 
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y_AXI_Loop_Num         <=   8'd0  ;  
      else if  (XFFT_Rd_Q_State == XFFT_Rd_Q_Buf2  )
           Y_AXI_Loop_Num         <=   8'd0  ;           
      else if  (XFFT_Rd_Q_State ==  XFFT_Rd_Q_Buf)
           Y_AXI_Loop_Num         <=   Y_AXI_Loop_Num + 1'b1 ;                 
                    
      end    
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Z_AXI_Loop_Num         <=   8'd0  ;  
      else if  (XFFT_Rd_Q_State == XFFT_Rd_Q_COR  )
           Z_AXI_Loop_Num         <=   8'd0  ;           
      else if  (XFFT_Rd_Q_State ==  XFFT_Rd_Q_Buf2)
           Z_AXI_Loop_Num         <=   Z_AXI_Loop_Num + 1'b1 ;                 
                 
      end    
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Data_Loop_Num         <=   16'b0 ;
      else if ( (XFFT_Rd_Q_State ==  XFFT_Rd_Q_ADD)&&(Data_Loop_Num <=  16'd8)  ) 
           Data_Loop_Num         <=  Data_Loop_Num+ 1'b1 ;                          // 8         
      else if  (XFFT_wr_Done)  
           Data_Loop_Num         <=   16'b0 ;    
      else if (XFFT_Rd_Q_State == XFFT_Rd_Q_COR)    
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
           Before_Data_XFFT          <=  512'd0  ;               
      else if(XFFT_Rd_Q_State == XFFT_Rd_Q_ADD)
           Before_Data_XFFT  <= {Before_Data_XFFT[447:0],64'd0  } ; 
       
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_Data_XFFT          <=  512'd0  ;               
      else if(XFFT_Rd_Q_State == XFFT_Rd_Q_BEGIN)
           Before_Data_XFFT[63:0]   <= {24'd0 ,Data_Loop_Num,M_AXIS_Q_Rd_data } ; 
          
      end     
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_en        <=    1'b0  ;            
      else if(XFFT_Rd_Q_State == XFFT_Rd_Q_ADD)
           M_AXIS_Q_Rd_en        <=    1'b1  ; 
      else   
           M_AXIS_Q_Rd_en        <=    1'b0  ;              
      end  

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_addr         <=   32'd0  ;                
      else if (XFFT_Rd_Q_State == XFFT_Rd_Q_ADD)
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
           XFFT_1_wr_RST   = 5'b00001	,
           XFFT_1_wr_IDLE  = 5'b00010	,
           XFFT_1_wr_BEGIN = 5'b00100	, 
           XFFT_1_wr_BUF   = 5'b01000	,       
           XFFT_1_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_1_wr_State <=XFFT_1_wr_RST;
     end 
      else begin 
           case( XFFT_1_wr_State)  
            XFFT_1_wr_RST :
                begin
                      XFFT_1_wr_State <=XFFT_1_wr_IDLE;
                end 
            XFFT_1_wr_IDLE:
                begin
                  if (Wr_1_RAM_en  ) 
                      XFFT_1_wr_State <=XFFT_1_wr_BEGIN;
                  else
                      XFFT_1_wr_State <=XFFT_1_wr_IDLE;
                 end 
            XFFT_1_wr_BUF:
                 begin
                      XFFT_1_wr_State <=XFFT_1_wr_IDLE;         
                 end    
            XFFT_1_wr_BEGIN:
                 begin
                    if (XFFT_1_Loop_Num ==  Loop_times) 
                      XFFT_1_wr_State <=XFFT_1_wr_END;
                    else
                      XFFT_1_wr_State <=XFFT_1_wr_BUF;   
                 end 
                                           
             XFFT_1_wr_END:
                   begin 
                      XFFT_1_wr_State <=XFFT_1_wr_IDLE;               
                   end 
         default:     XFFT_1_wr_State <=XFFT_1_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_1_wr_State == XFFT_1_wr_BEGIN) )
           M_AXIS_1_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_1_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_Loop_Num         <=   8'd0  ;                
      else if (XFFT_1_wr_State == XFFT_1_wr_BEGIN)
           XFFT_1_Loop_Num         <=   XFFT_1_Loop_Num + 1'b1 ;      
      else  if (XFFT_1_Loop_Num ==  Loop_times)  
           XFFT_1_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_1_wr_State == XFFT_1_wr_BEGIN)
           M_AXIS_1_XFFT_Wr_addr         <=   XFFT_1_Loop_Num  ;      
      else   
           M_AXIS_1_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_1_wr_State == XFFT_1_wr_BEGIN)
           M_AXIS_1_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_1_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_wr_Done          <= 1'b0 ;                    
      else if (XFFT_1_wr_State == XFFT_1_wr_BUF)
           XFFT_1_wr_Done          <= 1'b1 ;      
      else   
           XFFT_1_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_2_wr_RST   = 5'b00001	,
           XFFT_2_wr_IDLE  = 5'b00010	,
           XFFT_2_wr_BEGIN = 5'b00100	, 
           XFFT_2_wr_BUF   = 5'b01000	,       
           XFFT_2_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_2_wr_State <=XFFT_2_wr_RST;
     end 
      else begin 
           case( XFFT_2_wr_State)  
            XFFT_2_wr_RST :
                begin
                      XFFT_2_wr_State <=XFFT_2_wr_IDLE;
                end 
            XFFT_2_wr_IDLE:
                begin
                  if (Wr_2_RAM_en  ) 
                      XFFT_2_wr_State <=XFFT_2_wr_BEGIN;
                  else
                      XFFT_2_wr_State <=XFFT_2_wr_IDLE;
                 end 
            XFFT_2_wr_BUF:
                 begin
                      XFFT_2_wr_State <=XFFT_2_wr_IDLE;         
                 end    
            XFFT_2_wr_BEGIN:
                 begin
                    if (XFFT_2_Loop_Num ==  Loop_times) 
                      XFFT_2_wr_State <=XFFT_2_wr_END;
                    else
                      XFFT_2_wr_State <=XFFT_2_wr_BUF;   
                 end 
                                           
             XFFT_2_wr_END:
                   begin 
                      XFFT_2_wr_State <=XFFT_2_wr_IDLE;               
                   end 
         default:     XFFT_2_wr_State <=XFFT_2_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_2_wr_State == XFFT_2_wr_BEGIN) )
           M_AXIS_2_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_2_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_Loop_Num         <=   8'd0  ;                
      else if (XFFT_2_wr_State == XFFT_2_wr_BEGIN)
           XFFT_2_Loop_Num         <=   XFFT_2_Loop_Num + 1'b1 ;      
      else  if (XFFT_2_Loop_Num ==  Loop_times)  
           XFFT_2_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_2_wr_State == XFFT_2_wr_BEGIN)
           M_AXIS_2_XFFT_Wr_addr         <=   XFFT_2_Loop_Num  ;      
      else   
           M_AXIS_2_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_2_wr_State == XFFT_2_wr_BEGIN)
           M_AXIS_2_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_2_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_wr_Done          <= 1'b0 ;                    
      else if (XFFT_2_wr_State == XFFT_2_wr_BUF)
           XFFT_2_wr_Done          <= 1'b1 ;      
      else   
           XFFT_2_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_3_wr_RST   = 5'b00001	,
           XFFT_3_wr_IDLE  = 5'b00010	,
           XFFT_3_wr_BEGIN = 5'b00100	, 
           XFFT_3_wr_BUF   = 5'b01000	,       
           XFFT_3_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_3_wr_State <=XFFT_3_wr_RST;
     end 
      else begin 
           case( XFFT_3_wr_State)  
            XFFT_3_wr_RST :
                begin
                      XFFT_3_wr_State <=XFFT_3_wr_IDLE;
                end 
            XFFT_3_wr_IDLE:
                begin
                  if (Wr_3_RAM_en  ) 
                      XFFT_3_wr_State <=XFFT_3_wr_BEGIN;
                  else
                      XFFT_3_wr_State <=XFFT_3_wr_IDLE;
                 end 
            XFFT_3_wr_BUF:
                 begin
                      XFFT_3_wr_State <=XFFT_3_wr_IDLE;         
                 end    
            XFFT_3_wr_BEGIN:
                 begin
                    if (XFFT_3_Loop_Num ==  Loop_times) 
                      XFFT_3_wr_State <=XFFT_3_wr_END;
                    else
                      XFFT_3_wr_State <=XFFT_3_wr_BUF;   
                 end 
                                           
             XFFT_3_wr_END:
                   begin 
                      XFFT_3_wr_State <=XFFT_3_wr_IDLE;               
                   end 
         default:     XFFT_3_wr_State <=XFFT_3_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_3_wr_State == XFFT_3_wr_BEGIN) )
           M_AXIS_3_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_3_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_Loop_Num         <=   8'd0  ;                
      else if (XFFT_3_wr_State == XFFT_3_wr_BEGIN)
           XFFT_3_Loop_Num         <=   XFFT_3_Loop_Num + 1'b1 ;      
      else  if (XFFT_3_Loop_Num ==  Loop_times)  
           XFFT_3_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_3_wr_State == XFFT_3_wr_BEGIN)
           M_AXIS_3_XFFT_Wr_addr         <=   XFFT_3_Loop_Num  ;      
      else   
           M_AXIS_3_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_3_wr_State == XFFT_3_wr_BEGIN)
           M_AXIS_3_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_3_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_wr_Done          <= 1'b0 ;                    
      else if (XFFT_3_wr_State == XFFT_3_wr_BUF)
           XFFT_3_wr_Done          <= 1'b1 ;      
      else   
           XFFT_3_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_4_wr_RST   = 5'b00001	,
           XFFT_4_wr_IDLE  = 5'b00010	,
           XFFT_4_wr_BEGIN = 5'b00100	, 
           XFFT_4_wr_BUF   = 5'b01000	,       
           XFFT_4_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_4_wr_State <=XFFT_4_wr_RST;
     end 
      else begin 
           case( XFFT_4_wr_State)  
            XFFT_4_wr_RST :
                begin
                      XFFT_4_wr_State <=XFFT_4_wr_IDLE;
                end 
            XFFT_4_wr_IDLE:
                begin
                  if (Wr_4_RAM_en  ) 
                      XFFT_4_wr_State <=XFFT_4_wr_BEGIN;
                  else
                      XFFT_4_wr_State <=XFFT_4_wr_IDLE;
                 end 
            XFFT_4_wr_BUF:
                 begin
                      XFFT_4_wr_State <=XFFT_4_wr_IDLE;         
                 end    
            XFFT_4_wr_BEGIN:
                 begin
                    if (XFFT_4_Loop_Num ==  Loop_times) 
                      XFFT_4_wr_State <=XFFT_4_wr_END;
                    else
                      XFFT_4_wr_State <=XFFT_4_wr_BUF;   
                 end 
                                           
             XFFT_4_wr_END:
                   begin 
                      XFFT_4_wr_State <=XFFT_4_wr_IDLE;               
                   end 
         default:     XFFT_4_wr_State <=XFFT_4_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_4_wr_State == XFFT_4_wr_BEGIN) )
           M_AXIS_4_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_4_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_Loop_Num         <=   8'd0  ;                
      else if (XFFT_4_wr_State == XFFT_4_wr_BEGIN)
           XFFT_4_Loop_Num         <=   XFFT_4_Loop_Num + 1'b1 ;      
      else  if (XFFT_4_Loop_Num ==  Loop_times)  
           XFFT_4_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_4_wr_State == XFFT_4_wr_BEGIN)
           M_AXIS_4_XFFT_Wr_addr         <=   XFFT_4_Loop_Num  ;      
      else   
           M_AXIS_4_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_4_wr_State == XFFT_4_wr_BEGIN)
           M_AXIS_4_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_4_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_wr_Done          <= 1'b0 ;                    
      else if (XFFT_4_wr_State == XFFT_4_wr_BUF)
           XFFT_4_wr_Done          <= 1'b1 ;      
      else   
           XFFT_4_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_5_wr_RST   = 5'b00001	,
           XFFT_5_wr_IDLE  = 5'b00010	,
           XFFT_5_wr_BEGIN = 5'b00100	, 
           XFFT_5_wr_BUF   = 5'b01000	,       
           XFFT_5_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_5_wr_State <=XFFT_5_wr_RST;
     end 
      else begin 
           case( XFFT_5_wr_State)  
            XFFT_5_wr_RST :
                begin
                      XFFT_5_wr_State <=XFFT_5_wr_IDLE;
                end 
            XFFT_5_wr_IDLE:
                begin
                  if (Wr_5_RAM_en  ) 
                      XFFT_5_wr_State <=XFFT_5_wr_BEGIN;
                  else
                      XFFT_5_wr_State <=XFFT_5_wr_IDLE;
                 end 
            XFFT_5_wr_BUF:
                 begin
                      XFFT_5_wr_State <=XFFT_5_wr_IDLE;         
                 end    
            XFFT_5_wr_BEGIN:
                 begin
                    if (XFFT_5_Loop_Num ==  Loop_times) 
                      XFFT_5_wr_State <=XFFT_5_wr_END;
                    else
                      XFFT_5_wr_State <=XFFT_5_wr_BUF;   
                 end 
                                           
             XFFT_5_wr_END:
                   begin 
                      XFFT_5_wr_State <=XFFT_5_wr_IDLE;               
                   end 
         default:     XFFT_5_wr_State <=XFFT_5_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_5_wr_State == XFFT_5_wr_BEGIN) )
           M_AXIS_5_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_5_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_Loop_Num         <=   8'd0  ;                
      else if (XFFT_5_wr_State == XFFT_5_wr_BEGIN)
           XFFT_5_Loop_Num         <=   XFFT_5_Loop_Num + 1'b1 ;      
      else  if (XFFT_5_Loop_Num ==  Loop_times)  
           XFFT_5_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_5_wr_State == XFFT_5_wr_BEGIN)
           M_AXIS_5_XFFT_Wr_addr         <=   XFFT_5_Loop_Num  ;      
      else   
           M_AXIS_5_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_5_wr_State == XFFT_5_wr_BEGIN)
           M_AXIS_5_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_5_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_wr_Done          <= 1'b0 ;                    
      else if (XFFT_5_wr_State == XFFT_5_wr_BUF)
           XFFT_5_wr_Done          <= 1'b1 ;      
      else   
           XFFT_5_wr_Done          <= 1'b0 ;                          
      end 
//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_6_wr_RST   = 5'b00001	,
           XFFT_6_wr_IDLE  = 5'b00010	,
           XFFT_6_wr_BEGIN = 5'b00100	, 
           XFFT_6_wr_BUF   = 5'b01000	,       
           XFFT_6_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_6_wr_State <=XFFT_6_wr_RST;
     end 
      else begin 
           case( XFFT_6_wr_State)  
            XFFT_6_wr_RST :
                begin
                      XFFT_6_wr_State <=XFFT_6_wr_IDLE;
                end 
            XFFT_6_wr_IDLE:
                begin
                  if (Wr_6_RAM_en  ) 
                      XFFT_6_wr_State <=XFFT_6_wr_BEGIN;
                  else
                      XFFT_6_wr_State <=XFFT_6_wr_IDLE;
                 end 
            XFFT_6_wr_BUF:
                 begin
                      XFFT_6_wr_State <=XFFT_6_wr_IDLE;         
                 end    
            XFFT_6_wr_BEGIN:
                 begin
                    if (XFFT_6_Loop_Num ==  Loop_times) 
                      XFFT_6_wr_State <=XFFT_6_wr_END;
                    else
                      XFFT_6_wr_State <=XFFT_6_wr_BUF;   
                 end 
                                           
             XFFT_6_wr_END:
                   begin 
                      XFFT_6_wr_State <=XFFT_6_wr_IDLE;               
                   end 
         default:     XFFT_6_wr_State <=XFFT_6_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_6_wr_State == XFFT_6_wr_BEGIN) )
           M_AXIS_6_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_6_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_Loop_Num         <=   8'd0  ;                
      else if (XFFT_6_wr_State == XFFT_6_wr_BEGIN)
           XFFT_6_Loop_Num         <=   XFFT_6_Loop_Num + 1'b1 ;      
      else  if (XFFT_6_Loop_Num ==  Loop_times)  
           XFFT_6_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_6_wr_State == XFFT_6_wr_BEGIN)
           M_AXIS_6_XFFT_Wr_addr         <=   XFFT_6_Loop_Num  ;      
      else   
           M_AXIS_6_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_6_wr_State == XFFT_6_wr_BEGIN)
           M_AXIS_6_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_6_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_wr_Done          <= 1'b0 ;                    
      else if (XFFT_6_wr_State == XFFT_6_wr_BUF)
           XFFT_6_wr_Done          <= 1'b1 ;      
      else   
           XFFT_6_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_7_wr_RST   = 5'b00001	,
           XFFT_7_wr_IDLE  = 5'b00010	,
           XFFT_7_wr_BEGIN = 5'b00100	, 
           XFFT_7_wr_BUF   = 5'b01000	,       
           XFFT_7_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_7_wr_State <=XFFT_7_wr_RST;
     end 
      else begin 
           case( XFFT_7_wr_State)  
            XFFT_7_wr_RST :
                begin
                      XFFT_7_wr_State <=XFFT_7_wr_IDLE;
                end 
            XFFT_7_wr_IDLE:
                begin
                  if (Wr_7_RAM_en  ) 
                      XFFT_7_wr_State <=XFFT_7_wr_BEGIN;
                  else
                      XFFT_7_wr_State <=XFFT_7_wr_IDLE;
                 end 
            XFFT_7_wr_BUF:
                 begin
                      XFFT_7_wr_State <=XFFT_7_wr_IDLE;         
                 end    
            XFFT_7_wr_BEGIN:
                 begin
                    if (XFFT_7_Loop_Num ==  Loop_times) 
                      XFFT_7_wr_State <=XFFT_7_wr_END;
                    else
                      XFFT_7_wr_State <=XFFT_7_wr_BUF;   
                 end 
                                           
             XFFT_7_wr_END:
                   begin 
                      XFFT_7_wr_State <=XFFT_7_wr_IDLE;               
                   end 
         default:     XFFT_7_wr_State <=XFFT_7_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_7_wr_State == XFFT_7_wr_BEGIN) )
           M_AXIS_7_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_7_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_Loop_Num         <=   8'd0  ;                
      else if (XFFT_7_wr_State == XFFT_7_wr_BEGIN)
           XFFT_7_Loop_Num         <=   XFFT_7_Loop_Num + 1'b1 ;      
      else  if (XFFT_7_Loop_Num ==  Loop_times)  
           XFFT_7_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_7_wr_State == XFFT_7_wr_BEGIN)
           M_AXIS_7_XFFT_Wr_addr         <=   XFFT_7_Loop_Num  ;      
      else   
           M_AXIS_7_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_7_wr_State == XFFT_7_wr_BEGIN)
           M_AXIS_7_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_7_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_wr_Done          <= 1'b0 ;                    
      else if (XFFT_7_wr_State == XFFT_7_wr_BUF)
           XFFT_7_wr_Done          <= 1'b1 ;      
      else   
           XFFT_7_wr_Done          <= 1'b0 ;                          
      end 

//////////////////////////////////////////////////////////////////////////////// 
////////////////////////////////////////////////////////////////////////////////
localparam [4:0]
           XFFT_8_wr_RST   = 5'b00001	,
           XFFT_8_wr_IDLE  = 5'b00010	,
           XFFT_8_wr_BEGIN = 5'b00100	, 
           XFFT_8_wr_BUF   = 5'b01000	,       
           XFFT_8_wr_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_8_wr_State <=XFFT_8_wr_RST;
     end 
      else begin 
           case( XFFT_8_wr_State)  
            XFFT_8_wr_RST :
                begin
                      XFFT_8_wr_State <=XFFT_8_wr_IDLE;
                end 
            XFFT_8_wr_IDLE:
                begin
                  if (Wr_8_RAM_en  ) 
                      XFFT_8_wr_State <=XFFT_8_wr_BEGIN;
                  else
                      XFFT_8_wr_State <=XFFT_8_wr_IDLE;
                 end   
                
            XFFT_8_wr_BEGIN:
                 begin
                    if (XFFT_8_Loop_Num ==  Loop_times) 
                      XFFT_8_wr_State <=XFFT_8_wr_END;
                    else
                      XFFT_8_wr_State <=XFFT_8_wr_BUF;   
                 end 
            XFFT_8_wr_BUF:                                  
                 begin                                      
                     XFFT_8_wr_State <=XFFT_8_wr_IDLE; 
                 end                                     
             XFFT_8_wr_END:
                   begin 
                      XFFT_8_wr_State <=XFFT_8_wr_IDLE;               
                   end 
         default:     XFFT_8_wr_State <=XFFT_8_wr_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_XFFT_Wr_en          <= 1'b0 ;                 
      else if ((XFFT_8_wr_State == XFFT_8_wr_BEGIN) )
           M_AXIS_8_XFFT_Wr_en          <= 1'b1 ;        
      else   
           M_AXIS_8_XFFT_Wr_en          <= 1'b0 ;     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_Loop_Num         <=   8'd0  ;                
      else if (XFFT_8_wr_State == XFFT_8_wr_BEGIN)
           XFFT_8_Loop_Num         <=   XFFT_8_Loop_Num + 1'b1 ;      
      else  if (XFFT_8_Loop_Num ==  Loop_times)  
           XFFT_8_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_XFFT_Wr_addr         <=   8'd0  ;                
      else if (XFFT_8_wr_State == XFFT_8_wr_BEGIN)
           M_AXIS_8_XFFT_Wr_addr         <=   XFFT_8_Loop_Num  ;      
      else   
           M_AXIS_8_XFFT_Wr_addr         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_XFFT_Wr_data          <=  512'd0  ;               
      else if (XFFT_8_wr_State == XFFT_8_wr_BEGIN)
           M_AXIS_8_XFFT_Wr_data<=   Before_Data_XFFT; 
      else   
           M_AXIS_8_XFFT_Wr_data          <=  512'd0  ;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_wr_Done          <= 1'b0 ;                    
      else if (XFFT_8_wr_State == XFFT_8_wr_BUF)
           XFFT_8_wr_Done          <= 1'b1 ;      
      else   
           XFFT_8_wr_Done          <= 1'b0 ;                          
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_ALL_wr_Done          <= 1'b0 ;                    
      else if (XFFT_1_Loop_Num == 63 && XFFT_1_wr_State == XFFT_1_wr_BEGIN)
            XFFT_ALL_wr_Done          <= 1'b1 ;      
      else   
            XFFT_ALL_wr_Done          <= 1'b0 ;                          
      end  

      
//////////////////////////////////////////////////////////////////////////////////
//   TEANSFORM DATA TO FFT IP CORE                                              //
//////////////////////////////////////////////////////////////////////////////////    

localparam [5:0]
           Before_XFFT_1_Rd_RST   = 6'b000001	,
           Before_XFFT_1_Rd_IDLE  = 6'b000010	,
           Before_XFFT_1_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_1_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_1_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_1_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_1_Rd_State)  
            Before_XFFT_1_Rd_RST :
                begin
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_IDLE;
                end 
            Before_XFFT_1_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_BEGIN;
                  else
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_IDLE;
                 end 
            Before_XFFT_1_Rd_BEGIN:
                 begin
                    if (Before_XFFT_1_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_END;
                    else if((Before_XFFT_1_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) )                   
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_Wait;
                    else
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_BEGIN;
                 end

             Before_XFFT_1_Rd_Wait:
                 begin 
                    if ( XFFT_1_W_Done) 
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_BEGIN;
                    else
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_Wait;
                 end                                      
             Before_XFFT_1_Rd_END:
                   begin 
                      Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_IDLE;               
                   end 
         default:     Before_XFFT_1_Rd_State <=Before_XFFT_1_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_1_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_1_Rd_State == Before_XFFT_1_Rd_BEGIN )  
           Before_XFFT_1_Rd_Loop_Num         <=   Before_XFFT_1_Rd_Loop_Num + 1'b1 ;      
      else if ( Before_XFFT_1_Rd_State  == Before_XFFT_1_Rd_END) 
           Before_XFFT_1_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_1_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_1_Rd_State == Before_XFFT_1_Rd_BEGIN)
            Before_1_XFFT_Rd_addr         <=   Before_XFFT_1_Rd_Loop_Num  ;      
      else  if( Before_XFFT_1_Rd_State == Before_XFFT_1_Rd_END)   
            Before_1_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_Before_en        <= 1'b0 ;                       
      else if   (Before_XFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           XFFT_1_Before_en        <= 1'b1 ;            
      else   
           XFFT_1_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_1_vaild_en          <= 1'b0 ;                 
      else if  (   Before_XFFT_1_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            XFFT_1_vaild_en          <= 1'b1 ;        
      else   
            XFFT_1_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_1_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_1_Rd_State == Before_XFFT_1_Rd_END)
           Before_XFFT_1_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_1_Rd_Done          <= 1'b0 ;                          
      end
      
      
   

localparam [5:0]
           Before_XFFT_2_Rd_RST   = 6'b000001	,
           Before_XFFT_2_Rd_IDLE  = 6'b000010	,
           Before_XFFT_2_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_2_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_2_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_2_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_2_Rd_State)  
            Before_XFFT_2_Rd_RST :
                begin
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_IDLE;
                end 
            Before_XFFT_2_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_BEGIN;
                  else
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_IDLE;
                 end 
            Before_XFFT_2_Rd_BEGIN:
                 begin
                    if (Before_XFFT_2_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_END;
                    else  if( (Before_XFFT_2_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before) )
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_Wait;
                    else
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_BEGIN;
                 end
 
             Before_XFFT_2_Rd_Wait:
                 begin 
                    if ( XFFT_2_W_Done) 
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_BEGIN;
                    else
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_Wait;
                 end      
                 
             Before_XFFT_2_Rd_END:
                   begin 
                      Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_IDLE;               
                   end 
         default:     Before_XFFT_2_Rd_State <=Before_XFFT_2_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_2_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_2_Rd_State == Before_XFFT_2_Rd_BEGIN )   
           Before_XFFT_2_Rd_Loop_Num         <=   Before_XFFT_2_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_XFFT_2_Rd_State ==Before_XFFT_2_Rd_END)  
           Before_XFFT_2_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_2_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_2_Rd_State == Before_XFFT_2_Rd_BEGIN)
            Before_2_XFFT_Rd_addr         <=   Before_XFFT_2_Rd_Loop_Num  ;      
      else  if( Before_XFFT_2_Rd_State ==Before_XFFT_2_Rd_END)   
            Before_2_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_Before_en        <= 1'b0 ;                       
      else if  (Before_XFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
           XFFT_2_Before_en        <= 1'b1 ;            
      else   
           XFFT_2_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_2_vaild_en          <= 1'b0 ;                 
      else if   (Before_XFFT_2_Rd_Loop_Num[5:0]  ==  Loop_times_Before)
            XFFT_2_vaild_en          <= 1'b1 ;        
      else   
            XFFT_2_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_2_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_2_Rd_State == Before_XFFT_2_Rd_END)
           Before_XFFT_2_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_2_Rd_Done          <= 1'b0 ;                          
      end
      
  
localparam [5:0]
           Before_XFFT_3_Rd_RST   = 6'b000001	,
           Before_XFFT_3_Rd_IDLE  = 6'b000010	,
           Before_XFFT_3_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_3_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_3_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_3_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_3_Rd_State)  
            Before_XFFT_3_Rd_RST :
                begin
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_IDLE;
                end 
            Before_XFFT_3_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_BEGIN;
                  else
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_IDLE;
                 end 
           Before_XFFT_3_Rd_BEGIN:
                 begin
                    if (Before_XFFT_3_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_END;
                    else if((Before_XFFT_3_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_Wait;
                    else
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_BEGIN;
                 end

             Before_XFFT_3_Rd_Wait:
                 begin 
                    if ( XFFT_3_W_Done) 
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_BEGIN;
                    else
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_Wait;
                 end                  
                 
             Before_XFFT_3_Rd_END:
                   begin 
                      Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_IDLE;               
                   end 
         default:     Before_XFFT_3_Rd_State <=Before_XFFT_3_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_3_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_3_Rd_State == Before_XFFT_3_Rd_BEGIN&& Before_XFFT_3_Rd_Loop_Num <=Loop_times)   
           Before_XFFT_3_Rd_Loop_Num         <=   Before_XFFT_3_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_XFFT_3_Rd_State == Before_XFFT_3_Rd_END)     
           Before_XFFT_3_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_3_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_3_Rd_State == Before_XFFT_3_Rd_BEGIN)
            Before_3_XFFT_Rd_addr         <=   Before_XFFT_3_Rd_Loop_Num  ;      
      else  if( Before_XFFT_3_Rd_State == Before_XFFT_3_Rd_END)     
            Before_3_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_Before_en        <= 1'b0 ;                       
      else if (Before_XFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
           XFFT_3_Before_en        <= 1'b1 ;            
      else   
           XFFT_3_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_3_vaild_en          <= 1'b0 ;                 
      else if  (Before_XFFT_3_Rd_Loop_Num[5:0]  == Loop_times_Before)
            XFFT_3_vaild_en          <= 1'b1 ;        
      else   
            XFFT_3_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_3_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_3_Rd_State == Before_XFFT_3_Rd_END)
           Before_XFFT_3_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_3_Rd_Done          <= 1'b0 ;                          
      end
      
 localparam [5:0]
           Before_XFFT_4_Rd_RST   = 6'b000001	,
           Before_XFFT_4_Rd_IDLE  = 6'b000010	,
           Before_XFFT_4_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_4_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_4_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_4_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_4_Rd_State)  
            Before_XFFT_4_Rd_RST :
                begin
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_IDLE;
                end 
            Before_XFFT_4_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_BEGIN;
                  else
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_IDLE;
                 end 
           Before_XFFT_4_Rd_BEGIN:
                 begin
                    if (Before_XFFT_4_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_END;
                    else if((Before_XFFT_4_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_Wait;
                    else
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_BEGIN;
                 end

             Before_XFFT_4_Rd_Wait:
                 begin 
                    if ( XFFT_4_W_Done) 
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_BEGIN;
                    else
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_Wait;
                 end                  
                 
                 
             Before_XFFT_4_Rd_END:
                   begin 
                      Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_IDLE;               
                   end 
         default:     Before_XFFT_4_Rd_State <=Before_XFFT_4_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_4_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_4_Rd_State == Before_XFFT_4_Rd_BEGIN&& Before_XFFT_4_Rd_Loop_Num <=Loop_times)   
           Before_XFFT_4_Rd_Loop_Num         <=   Before_XFFT_4_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_XFFT_4_Rd_State ==Before_XFFT_4_Rd_END)     
           Before_XFFT_4_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_4_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_4_Rd_State == Before_XFFT_4_Rd_BEGIN)
            Before_4_XFFT_Rd_addr         <=   Before_XFFT_4_Rd_Loop_Num  ;      
      else  if( Before_XFFT_4_Rd_State ==Before_XFFT_4_Rd_END)     
            Before_4_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_Before_en        <= 1'b0 ;                       
      else if(Before_XFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           XFFT_4_Before_en        <= 1'b1 ;            
      else   
           XFFT_4_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_4_vaild_en          <= 1'b0 ;                 
      else if (Before_XFFT_4_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            XFFT_4_vaild_en          <= 1'b1 ;        
      else   
            XFFT_4_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_4_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_4_Rd_State == Before_XFFT_4_Rd_END)
           Before_XFFT_4_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_4_Rd_Done          <= 1'b0 ;                          
      end

localparam [5:0]
           Before_XFFT_5_Rd_RST   = 6'b000001	,
           Before_XFFT_5_Rd_IDLE  = 6'b000010	,
           Before_XFFT_5_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_5_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_5_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_5_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_5_Rd_State)  
            Before_XFFT_5_Rd_RST :
                begin
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_IDLE;
                end 
            Before_XFFT_5_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_BEGIN;
                  else
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_IDLE;
                 end 
        Before_XFFT_5_Rd_BEGIN:
                 begin
                    if (Before_XFFT_5_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_END;
                    else if((Before_XFFT_5_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_Wait;
                    else
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_BEGIN;
                 end

             Before_XFFT_5_Rd_Wait:
                 begin 
                    if ( XFFT_5_W_Done) 
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_BEGIN;
                    else
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_Wait;
                 end                  
                 
                    
                 
             Before_XFFT_5_Rd_END:
                   begin 
                      Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_IDLE;               
                   end 
         default:     Before_XFFT_5_Rd_State <=Before_XFFT_5_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_5_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_5_Rd_State == Before_XFFT_5_Rd_BEGIN&& Before_XFFT_5_Rd_Loop_Num <=Loop_times)    
           Before_XFFT_5_Rd_Loop_Num         <=   Before_XFFT_5_Rd_Loop_Num + 1'b1 ;      
      else   if( Before_XFFT_5_Rd_State == Before_XFFT_5_Rd_END)    
           Before_XFFT_5_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_5_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_5_Rd_State == Before_XFFT_5_Rd_BEGIN)
            Before_5_XFFT_Rd_addr         <=   Before_XFFT_5_Rd_Loop_Num  ;      
      else  if( Before_XFFT_5_Rd_State == Before_XFFT_5_Rd_END)     
            Before_5_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_Before_en        <= 1'b0 ;                       
      else if (Before_XFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           XFFT_5_Before_en        <= 1'b1 ;            
      else   
           XFFT_5_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_5_vaild_en          <= 1'b0 ;                 
      else if(Before_XFFT_5_Rd_Loop_Num[5:0]  == Loop_times_Before) 
            XFFT_5_vaild_en          <= 1'b1 ;        
      else   
            XFFT_5_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_5_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_5_Rd_State == Before_XFFT_5_Rd_END)
           Before_XFFT_5_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_5_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_XFFT_6_Rd_RST   = 6'b000001	,
           Before_XFFT_6_Rd_IDLE  = 6'b000010	,
           Before_XFFT_6_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_6_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_6_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_6_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_6_Rd_State)  
            Before_XFFT_6_Rd_RST :
                begin
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_IDLE;
                end 
            Before_XFFT_6_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_BEGIN;
                  else
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_IDLE;
                 end 
             Before_XFFT_6_Rd_BEGIN:
                 begin
                    if (Before_XFFT_6_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_END;
                    else if((Before_XFFT_6_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_Wait;
                    else
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_BEGIN;
                 end

             Before_XFFT_6_Rd_Wait:
                 begin 
                    if ( XFFT_6_W_Done) 
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_BEGIN;
                    else
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_Wait;
                 end                  
                 
                 
             Before_XFFT_6_Rd_END:
                   begin 
                      Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_IDLE;               
                   end 
         default:     Before_XFFT_6_Rd_State <=Before_XFFT_6_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_6_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_6_Rd_State == Before_XFFT_6_Rd_BEGIN&& Before_XFFT_6_Rd_Loop_Num <=Loop_times)    
           Before_XFFT_6_Rd_Loop_Num         <=   Before_XFFT_6_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_XFFT_6_Rd_State ==Before_XFFT_6_Rd_END)     
           Before_XFFT_6_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_6_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_6_Rd_State == Before_XFFT_6_Rd_BEGIN)
            Before_6_XFFT_Rd_addr         <=   Before_XFFT_6_Rd_Loop_Num  ;      
      else  if( Before_XFFT_6_Rd_State ==Before_XFFT_6_Rd_END)     
            Before_6_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_Before_en        <= 1'b0 ;                       
      else if (Before_XFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before) 
           XFFT_6_Before_en        <= 1'b1 ;            
      else   
           XFFT_6_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_6_vaild_en          <= 1'b0 ;                 
      else if  (Before_XFFT_6_Rd_Loop_Num[5:0]  == Loop_times_Before)
            XFFT_6_vaild_en          <= 1'b1 ;        
      else   
            XFFT_6_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_6_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_6_Rd_State == Before_XFFT_6_Rd_END)
           Before_XFFT_6_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_6_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_XFFT_7_Rd_RST   = 6'b000001	,
           Before_XFFT_7_Rd_IDLE  = 6'b000010	,
           Before_XFFT_7_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_7_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_7_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_7_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_7_Rd_State)  
            Before_XFFT_7_Rd_RST :
                begin
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_IDLE;
                end 
            Before_XFFT_7_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_BEGIN;
                  else
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_IDLE;
                 end 
            Before_XFFT_7_Rd_BEGIN:
                 begin
                    if (Before_XFFT_7_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_END;
                    else if((Before_XFFT_7_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_Wait;
                    else
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_BEGIN;
                 end

             Before_XFFT_7_Rd_Wait:
                 begin 
                    if ( XFFT_7_W_Done) 
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_BEGIN;
                    else
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_Wait;
                 end                  
                 
             Before_XFFT_7_Rd_END:
                   begin 
                      Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_IDLE;               
                   end 
         default:     Before_XFFT_7_Rd_State <=Before_XFFT_7_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_7_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_7_Rd_State == Before_XFFT_7_Rd_BEGIN&& Before_XFFT_7_Rd_Loop_Num <=Loop_times)   
           Before_XFFT_7_Rd_Loop_Num         <=   Before_XFFT_7_Rd_Loop_Num + 1'b1 ;      
      else if( Before_XFFT_7_Rd_State ==Before_XFFT_7_Rd_END)      
           Before_XFFT_7_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_7_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_7_Rd_State == Before_XFFT_7_Rd_BEGIN)
            Before_7_XFFT_Rd_addr         <=   Before_XFFT_7_Rd_Loop_Num  ;      
      else  if( Before_XFFT_7_Rd_State ==Before_XFFT_7_Rd_END)     
            Before_7_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_Before_en        <= 1'b0 ;                       
      else if (Before_XFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
           XFFT_7_Before_en        <= 1'b1 ;            
      else   
           XFFT_7_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_7_vaild_en          <= 1'b0 ;                 
      else if  (Before_XFFT_7_Rd_Loop_Num[5:0]  == Loop_times_Before)
            XFFT_7_vaild_en          <= 1'b1 ;        
      else   
            XFFT_7_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_7_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_7_Rd_State == Before_XFFT_7_Rd_END)
           Before_XFFT_7_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_7_Rd_Done          <= 1'b0 ;                          
      end
      
      localparam [5:0]
           Before_XFFT_8_Rd_RST   = 6'b000001	,
           Before_XFFT_8_Rd_IDLE  = 6'b000010	,
           Before_XFFT_8_Rd_BEGIN = 6'b000100	, 
           Before_XFFT_8_Rd_BUF   = 6'b001000 	,     
           Before_XFFT_8_Rd_Wait  = 6'b010000 	,      
           Before_XFFT_8_Rd_END   = 6'b100000 	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_RST;
     end 
      else begin 
           case( Before_XFFT_8_Rd_State)  
            Before_XFFT_8_Rd_RST :
                begin
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_IDLE;
                end 
            Before_XFFT_8_Rd_IDLE:
                begin
                  if (XFFT_ALL_wr_Done  ) 
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_BEGIN;
                  else
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_IDLE;
                 end 
            Before_XFFT_8_Rd_BEGIN:
                 begin
                    if (Before_XFFT_8_Rd_Loop_Num  ==  Loop_times) 
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_END;
                    else if((Before_XFFT_8_Rd_Loop_Num[11:6]< Loop_times_Before )&& (Before_XFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before) )
                    
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_Wait;
                    else
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_BEGIN;
                 end

             Before_XFFT_8_Rd_Wait:
                 begin 
                    if ( XFFT_8_W_Done) 
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_BEGIN;
                    else
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_Wait;
                 end                  
                      
                 
             Before_XFFT_8_Rd_END:
                   begin 
                      Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_IDLE;               
                   end 
         default:     Before_XFFT_8_Rd_State <=Before_XFFT_8_Rd_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_8_Rd_Loop_Num         <=   16'd0  ;                
      else if (  Before_XFFT_8_Rd_State == Before_XFFT_8_Rd_BEGIN&& Before_XFFT_8_Rd_Loop_Num <=Loop_times)    
           Before_XFFT_8_Rd_Loop_Num         <=   Before_XFFT_8_Rd_Loop_Num + 1'b1 ;      
      else  if( Before_XFFT_8_Rd_State ==Before_XFFT_8_Rd_END)     
           Before_XFFT_8_Rd_Loop_Num         <=   16'd0  ;              
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Before_8_XFFT_Rd_addr         <=   16'd0  ;                
      else if ( Before_XFFT_8_Rd_State == Before_XFFT_8_Rd_BEGIN)
            Before_8_XFFT_Rd_addr         <=   Before_XFFT_8_Rd_Loop_Num  ;      
      else  if( Before_XFFT_8_Rd_State ==Before_XFFT_8_Rd_END)     
            Before_8_XFFT_Rd_addr         <=   16'd0  ;              
      end 
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_Before_en        <= 1'b0 ;                       
      else if  (Before_XFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
           XFFT_8_Before_en        <= 1'b1 ;            
      else   
           XFFT_8_Before_en        <= 1'b0 ;                     
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_8_vaild_en          <= 1'b0 ;                 
      else if   (Before_XFFT_8_Rd_Loop_Num[5:0]  == Loop_times_Before)
            XFFT_8_vaild_en          <= 1'b1 ;        
      else   
            XFFT_8_vaild_en          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_XFFT_8_Rd_Done          <= 1'b0 ;                    
      else if ( Before_XFFT_8_Rd_State == Before_XFFT_8_Rd_END)
           Before_XFFT_8_Rd_Done          <= 1'b1 ;      
      else   
           Before_XFFT_8_Rd_Done          <= 1'b0 ;                          
      end                                                               
         
//////////////////////////////////////////////////////////////////////////////////
//   after fft ip buffer to ram                                                 //
//////////////////////////////////////////////////////////////////////////////////    
    
 localparam [4:0]
           XFFT_1_W_RST   = 5'b00001	,
           XFFT_1_W_IDLE  = 5'b00010	,
           XFFT_1_W_BEGIN = 5'b00100	, 
           XFFT_1_W_Wait  = 5'b01000	,                 
           XFFT_1_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_1_W_State <=XFFT_1_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_1_W_State)  
            XFFT_1_W_RST :
                begin
                      AFTER_XFFT_1_W_State <=XFFT_1_W_IDLE;
                end 
            XFFT_1_W_IDLE:
                begin
                  if ( XFFT_1_Before_en) /// to fft ip  
                      AFTER_XFFT_1_W_State <=XFFT_1_W_Wait;
                  else
                      AFTER_XFFT_1_W_State <=XFFT_1_W_IDLE;
                 end 
           XFFT_1_W_Wait :    
                 begin
                    if ( XFFT_1_Done) /// response from fft ip
                      AFTER_XFFT_1_W_State <=XFFT_1_W_BEGIN;
                    else
                      AFTER_XFFT_1_W_State <=XFFT_1_W_Wait;
                 end 
                 
            XFFT_1_W_BEGIN:
                 begin
                    if (XFFT_1_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_1_W_State <=XFFT_1_W_END;
                    else
                      AFTER_XFFT_1_W_State <=XFFT_1_W_IDLE;
                 end                  
             XFFT_1_W_END:
                   begin 
                      AFTER_XFFT_1_W_State <=XFFT_1_W_IDLE;               
                   end 
         default:     AFTER_XFFT_1_W_State <=XFFT_1_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_1_W_State == XFFT_1_W_BEGIN)
           XFFT_1_W_Loop_Num         <=   XFFT_1_W_Loop_Num + 8'd64 ;     
      else  if (AFTER_XFFT_1_W_State ==XFFT_1_W_END)       
           XFFT_1_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_1_W_State == XFFT_1_W_Wait&& XFFT_1_Done)
           XFFT_1_W_Done          <= 1'b1 ;      
      else   
           XFFT_1_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_1_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_1_W_State ==XFFT_1_W_END  )
           XFFT_1_W_Finish          <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_1_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_2_W_RST   = 5'b00001	,
           XFFT_2_W_IDLE  = 5'b00010	,
           XFFT_2_W_BEGIN = 5'b00100	, 
           XFFT_2_W_Wait  = 5'b01000	,                 
           XFFT_2_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_2_W_State <=XFFT_2_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_2_W_State)  
            XFFT_2_W_RST :
                begin
                      AFTER_XFFT_2_W_State <=XFFT_2_W_IDLE;
                end 
            XFFT_2_W_IDLE:
                begin
                  if ( XFFT_2_Before_en) 
                      AFTER_XFFT_2_W_State <=XFFT_2_W_BEGIN;
                  else
                      AFTER_XFFT_2_W_State <=XFFT_2_W_IDLE;
                 end 
          XFFT_2_W_Wait :    
                 begin
                    if ( XFFT_2_Done) 
                      AFTER_XFFT_2_W_State <=XFFT_2_W_BEGIN;
                    else
                      AFTER_XFFT_2_W_State <=XFFT_2_W_Wait;
                 end 
                 
            XFFT_2_W_BEGIN:
                 begin
                    if (XFFT_2_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_2_W_State <=XFFT_2_W_END;
                    else
                      AFTER_XFFT_2_W_State <=XFFT_2_W_IDLE;
                 end 

                 
             XFFT_2_W_END:
                   begin 
                      AFTER_XFFT_2_W_State <=XFFT_2_W_IDLE;               
                   end 
         default:     AFTER_XFFT_2_W_State <=XFFT_2_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_2_W_State == XFFT_2_W_BEGIN)
           XFFT_2_W_Loop_Num         <=   XFFT_2_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_XFFT_2_W_State ==XFFT_2_W_END)       
           XFFT_2_W_Loop_Num         <=   8'd0  ;              
      end     

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_2_W_State == XFFT_2_W_Wait&& XFFT_2_Done)
           XFFT_2_W_Done          <= 1'b1 ;      
      else   
           XFFT_2_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_2_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_2_W_State ==XFFT_2_W_END  )
           XFFT_2_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_2_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_3_W_RST   = 5'b00001	,
           XFFT_3_W_IDLE  = 5'b00010	,
           XFFT_3_W_BEGIN = 5'b00100	, 
           XFFT_3_W_Wait  = 5'b01000	,                 
           XFFT_3_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_3_W_State <=XFFT_3_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_3_W_State)  
            XFFT_3_W_RST :
                begin
                      AFTER_XFFT_3_W_State <=XFFT_3_W_IDLE;
                end 
            XFFT_3_W_IDLE:
                begin
                  if ( XFFT_3_Before_en) 
                      AFTER_XFFT_3_W_State <=XFFT_3_W_BEGIN;
                  else
                      AFTER_XFFT_3_W_State <=XFFT_3_W_IDLE;
                 end 
           XFFT_3_W_Wait :    
                 begin
                    if ( XFFT_3_Done) 
                      AFTER_XFFT_3_W_State <=XFFT_3_W_BEGIN;
                    else
                      AFTER_XFFT_3_W_State <=XFFT_3_W_Wait;
                 end 
                 
            XFFT_3_W_BEGIN:
                 begin
                    if (XFFT_3_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_3_W_State <=XFFT_3_W_END;
                    else
                      AFTER_XFFT_3_W_State <=XFFT_3_W_IDLE;
                 end 

                 
             XFFT_3_W_END:
                   begin 
                      AFTER_XFFT_3_W_State <=XFFT_3_W_IDLE;               
                   end 
         default:     AFTER_XFFT_3_W_State <=XFFT_3_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_3_W_State == XFFT_3_W_BEGIN)
           XFFT_3_W_Loop_Num         <=   XFFT_3_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_XFFT_3_W_State ==XFFT_3_W_END)       
           XFFT_3_W_Loop_Num         <=   8'd0  ;              
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_3_W_State == XFFT_3_W_Wait&& XFFT_3_Done)
           XFFT_3_W_Done          <= 1'b1 ;      
      else   
           XFFT_3_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_3_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_3_W_State ==XFFT_3_W_END  )
           XFFT_3_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_3_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_4_W_RST   = 5'b00001	,
           XFFT_4_W_IDLE  = 5'b00010	,
           XFFT_4_W_BEGIN = 5'b00100	, 
           XFFT_4_W_Wait  = 5'b01000	,                 
           XFFT_4_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_4_W_State <=XFFT_4_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_4_W_State)  
            XFFT_4_W_RST :
                begin
                      AFTER_XFFT_4_W_State <=XFFT_4_W_IDLE;
                end 
            XFFT_4_W_IDLE:
                begin
                  if ( XFFT_4_Before_en) 
                      AFTER_XFFT_4_W_State <=XFFT_4_W_BEGIN;
                  else
                      AFTER_XFFT_4_W_State <=XFFT_4_W_IDLE;
                 end 
            XFFT_4_W_Wait :    
                 begin
                    if ( XFFT_4_Done) 
                      AFTER_XFFT_4_W_State <=XFFT_4_W_BEGIN;
                    else
                      AFTER_XFFT_4_W_State <=XFFT_4_W_Wait;
                 end 
                 
            XFFT_4_W_BEGIN:
                 begin
                    if (XFFT_4_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_4_W_State <=XFFT_4_W_END;
                    else
                      AFTER_XFFT_4_W_State <=XFFT_4_W_IDLE;
                 end 

                 
             XFFT_4_W_END:
                   begin 
                      AFTER_XFFT_4_W_State <=XFFT_4_W_IDLE;               
                   end 
         default:     AFTER_XFFT_4_W_State <=XFFT_4_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_4_W_State == XFFT_4_W_BEGIN)
           XFFT_4_W_Loop_Num         <=   XFFT_4_W_Loop_Num + 8'd64 ;         
      else  if (AFTER_XFFT_4_W_State ==XFFT_4_W_END)       
           XFFT_4_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_4_W_State == XFFT_4_W_Wait&& XFFT_4_Done)
           XFFT_4_W_Done          <= 1'b1 ;      
      else   
           XFFT_4_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_4_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_4_W_State ==XFFT_4_W_END  )
           XFFT_4_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_4_W_Finish          <= 1'b0 ;                          
      end
      
    localparam [4:0]
           XFFT_5_W_RST   = 5'b00001	,
           XFFT_5_W_IDLE  = 5'b00010	,
           XFFT_5_W_BEGIN = 5'b00100	, 
           XFFT_5_W_Wait  = 5'b01000	,                 
           XFFT_5_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_5_W_State <=XFFT_5_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_5_W_State)  
            XFFT_5_W_RST :
                begin
                      AFTER_XFFT_5_W_State <=XFFT_5_W_IDLE;
                end 
            XFFT_5_W_IDLE:
                begin
                  if ( XFFT_5_Before_en) 
                      AFTER_XFFT_5_W_State <=XFFT_5_W_BEGIN;
                  else
                      AFTER_XFFT_5_W_State <=XFFT_5_W_IDLE;
                 end 
            XFFT_5_W_Wait :    
                 begin
                    if ( XFFT_5_Done) 
                      AFTER_XFFT_5_W_State <=XFFT_5_W_BEGIN;
                    else
                      AFTER_XFFT_5_W_State <=XFFT_5_W_Wait;
                 end 
                 
            XFFT_5_W_BEGIN:
                 begin
                    if (XFFT_5_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_5_W_State <=XFFT_5_W_END;
                    else
                      AFTER_XFFT_5_W_State <=XFFT_5_W_IDLE;
                 end 

                 
             XFFT_5_W_END:
                   begin 
                      AFTER_XFFT_5_W_State <=XFFT_5_W_IDLE;               
                   end 
         default:     AFTER_XFFT_5_W_State <=XFFT_5_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_5_W_State == XFFT_5_W_BEGIN)
           XFFT_5_W_Loop_Num         <=   XFFT_5_W_Loop_Num + 8'd64 ;          
      else if (AFTER_XFFT_5_W_State ==XFFT_5_W_END)     
           XFFT_5_W_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_5_W_State == XFFT_5_W_Wait&& XFFT_5_Done)
           XFFT_5_W_Done          <= 1'b1 ;      
      else   
           XFFT_5_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_5_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_5_W_State ==XFFT_5_W_END  )
           XFFT_5_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_5_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_6_W_RST   = 5'b00001	,
           XFFT_6_W_IDLE  = 5'b00010	,
           XFFT_6_W_BEGIN = 5'b00100	, 
           XFFT_6_W_Wait  = 5'b01000	,                 
           XFFT_6_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_6_W_State <=XFFT_6_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_6_W_State)  
            XFFT_6_W_RST :
                begin
                      AFTER_XFFT_6_W_State <=XFFT_6_W_IDLE;
                end 
            XFFT_6_W_IDLE:
                begin
                  if ( XFFT_6_Before_en) 
                      AFTER_XFFT_6_W_State <=XFFT_6_W_BEGIN;
                  else
                      AFTER_XFFT_6_W_State <=XFFT_6_W_IDLE;
                 end 
           XFFT_6_W_Wait :    
                 begin
                    if ( XFFT_6_Done) 
                      AFTER_XFFT_6_W_State <=XFFT_6_W_BEGIN;
                    else
                      AFTER_XFFT_6_W_State <=XFFT_6_W_Wait;
                 end 
                 
            XFFT_6_W_BEGIN:
                 begin
                    if (XFFT_6_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_6_W_State <=XFFT_6_W_END;
                    else
                      AFTER_XFFT_6_W_State <=XFFT_6_W_IDLE;
                 end 

                 
             XFFT_6_W_END:
                   begin 
                      AFTER_XFFT_6_W_State <=XFFT_6_W_IDLE;               
                   end 
         default:     AFTER_XFFT_6_W_State <=XFFT_6_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_6_W_State == XFFT_6_W_BEGIN)
           XFFT_6_W_Loop_Num         <=   XFFT_6_W_Loop_Num+ 8'd64 ;        
      else  if (AFTER_XFFT_6_W_State ==XFFT_6_W_END)   
           XFFT_6_W_Loop_Num         <=   8'd0  ;              
      end       

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_6_W_State == XFFT_6_W_Wait&& XFFT_6_Done)
           XFFT_6_W_Done          <= 1'b1 ;      
      else   
           XFFT_6_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_6_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_6_W_State ==XFFT_6_W_END  )
           XFFT_6_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_6_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_7_W_RST   = 5'b00001	,
           XFFT_7_W_IDLE  = 5'b00010	,
           XFFT_7_W_BEGIN = 5'b00100	, 
           XFFT_7_W_Wait  = 5'b01000	,                 
           XFFT_7_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_7_W_State <=XFFT_7_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_7_W_State)  
            XFFT_7_W_RST :
                begin
                      AFTER_XFFT_7_W_State <=XFFT_7_W_IDLE;
                end 
            XFFT_7_W_IDLE:
                begin
                  if ( XFFT_7_Before_en) 
                      AFTER_XFFT_7_W_State <=XFFT_7_W_BEGIN;
                  else
                      AFTER_XFFT_7_W_State <=XFFT_7_W_IDLE;
                 end 
          XFFT_7_W_Wait :    
                 begin
                    if ( XFFT_7_Done) 
                      AFTER_XFFT_7_W_State <=XFFT_7_W_BEGIN;
                    else
                      AFTER_XFFT_7_W_State <=XFFT_7_W_Wait;
                 end 
                 
            XFFT_7_W_BEGIN:
                 begin
                    if (XFFT_7_W_Loop_Num ==  Loop_times_AFTER) 
                      AFTER_XFFT_7_W_State <=XFFT_7_W_END;
                    else
                      AFTER_XFFT_7_W_State <=XFFT_7_W_IDLE;
                 end 

                 
             XFFT_7_W_END:
                   begin 
                      AFTER_XFFT_7_W_State <=XFFT_7_W_IDLE;               
                   end 
         default:     AFTER_XFFT_7_W_State <=XFFT_7_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_7_W_State == XFFT_7_W_BEGIN)
           XFFT_7_W_Loop_Num         <=   XFFT_7_W_Loop_Num + 8'd64 ;         
      else   if (AFTER_XFFT_7_W_State ==XFFT_7_W_END)  
           XFFT_7_W_Loop_Num         <=   8'd0  ;              
      end      

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_7_W_State == XFFT_7_W_Wait&& XFFT_7_Done)
           XFFT_7_W_Done          <= 1'b1 ;      
      else   
           XFFT_7_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_7_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_7_W_State ==XFFT_7_W_END  )
           XFFT_7_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_7_W_Finish          <= 1'b0 ;                          
      end

 localparam [4:0]
           XFFT_8_W_RST   = 5'b00001	,
           XFFT_8_W_IDLE  = 5'b00010	,
           XFFT_8_W_BEGIN = 5'b00100	, 
           XFFT_8_W_Wait  = 5'b01000	,                 
           XFFT_8_W_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      AFTER_XFFT_8_W_State <=XFFT_8_W_RST;
     end 
      else begin 
           case( AFTER_XFFT_8_W_State)  
            XFFT_8_W_RST :
                begin
                      AFTER_XFFT_8_W_State <=XFFT_8_W_IDLE;
                end 
            XFFT_8_W_IDLE:
                begin
                  if ( XFFT_8_Before_en) 
                      AFTER_XFFT_8_W_State <=XFFT_8_W_BEGIN;
                  else
                      AFTER_XFFT_8_W_State <=XFFT_8_W_IDLE;
                 end 
          XFFT_8_W_Wait :    
                 begin
                    if ( XFFT_8_Done) 
                      AFTER_XFFT_8_W_State <=XFFT_8_W_BEGIN;
                    else
                      AFTER_XFFT_8_W_State <=XFFT_8_W_Wait;
                 end 
                 
            XFFT_8_W_BEGIN:
                 begin
                    if (XFFT_8_W_Loop_Num ==  Loop_times_Before) 
                      AFTER_XFFT_8_W_State <=XFFT_8_W_END;
                    else
                      AFTER_XFFT_8_W_State <=XFFT_8_W_IDLE;
                 end 

                 
             XFFT_8_W_END:
                   begin 
                      AFTER_XFFT_8_W_State <=XFFT_8_W_IDLE;               
                   end 
         default:     AFTER_XFFT_8_W_State <=XFFT_8_W_IDLE;
     endcase
   end 
 end   
 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_W_Loop_Num         <=   8'd0  ;                
      else if (AFTER_XFFT_8_W_State == XFFT_8_W_BEGIN)
           XFFT_8_W_Loop_Num         <=   XFFT_8_W_Loop_Num + 8'd64 ;      
      else  if (AFTER_XFFT_8_W_State ==XFFT_8_W_END) 
           XFFT_8_W_Loop_Num         <=   8'd0  ;              
      end   

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_W_Done          <= 1'b0 ;                    
      else if (AFTER_XFFT_8_W_State == XFFT_8_W_Wait&& XFFT_8_Done)
           XFFT_8_W_Done          <= 1'b1 ;      
      else   
           XFFT_8_W_Done          <= 1'b0 ;                          
      end

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_8_W_Finish          <= 1'b0 ;                    
      else if (AFTER_XFFT_8_W_State ==XFFT_8_W_END  )
           XFFT_8_W_Finish         <= 1'b1 ;      
      else if (XFFT_W_Finish)  
           XFFT_8_W_Finish          <= 1'b0 ;                          
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_Forward_end          <= 1'b0 ;                    
      else if (XFFT_8_W_Finish  )
           XFFT_Forward_end         <= 1'b1 ;      
      else 
           XFFT_Forward_end          <= 1'b0 ;                          
      end    
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           XFFT_Backward_end          <= 1'b0 ;                    
      else if (FFT_Backward_begin  )
           XFFT_Backward_end         <= 1'b1 ;      
      else 
           XFFT_Backward_end          <= 1'b0 ;                          
      end     
endmodule