`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 01:39:28 PM
// Design Name: 
// Module Name: ZFFT_TOP
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


module ZFFT_TOP 
  #                        (parameter Loop_times   =  9'd256,
                            parameter  X_K_value   =  9'd64,
                            parameter  Y_K_value   =  9'd64,
                            parameter  Z_K_value   =  9'd64)
(
 input                         Sys_Clk       , 
 input                         Sys_Rst_n     ,
                                            
  input                         RD_1_ZFFT_en,
  input                         RD_2_ZFFT_en,
  input                         RD_3_ZFFT_en,
  input                         RD_4_ZFFT_en,
  input                         RD_5_ZFFT_en,
  input                         RD_6_ZFFT_en,
  input                         RD_7_ZFFT_en,
  input                         RD_8_ZFFT_en,
 
 input       wire [511:0]       After_Data_1_ZFFT ,
 input       wire [511:0]       After_Data_2_ZFFT ,
 input       wire [511:0]       After_Data_3_ZFFT ,
 input       wire [511:0]       After_Data_4_ZFFT ,
 input       wire [511:0]       After_Data_5_ZFFT ,
 input       wire [511:0]       After_Data_6_ZFFT ,
 input       wire [511:0]       After_Data_7_ZFFT ,
 input       wire [511:0]       After_Data_8_ZFFT , 
    
 output      wire [511:0]       Before_Data_1_ZFFT,
 output      wire [511:0]       Before_Data_2_ZFFT,
 output      wire [511:0]       Before_Data_3_ZFFT, 
 output      wire [511:0]       Before_Data_4_ZFFT,
 output      wire [511:0]       Before_Data_5_ZFFT,
 output      wire [511:0]       Before_Data_6_ZFFT,
 output      wire [511:0]       Before_Data_7_ZFFT,
 output      wire [511:0]       Before_Data_8_ZFFT,

  input          [511:0]       M_AXIS_1_ZFFT_Rd_data  ,
  output reg       [7:0]       M_AXIS_1_ZFFT_Rd_addr ,
   
  input          [511:0]       M_AXIS_2_ZFFT_Rd_data  ,
  output reg       [7:0]       M_AXIS_2_ZFFT_Rd_addr ,
  
  input          [511:0]       M_AXIS_3_ZFFT_Rd_data  ,
  output reg       [7:0]       M_AXIS_3_ZFFT_Rd_addr ,
  
  input          [511:0]       M_AXIS_4_ZFFT_Rd_data  ,
  output reg       [7:0]       M_AXIS_4_ZFFT_Rd_addr ,
                                    
  input          [511:0]       M_AXIS_5_ZFFT_Rd_data  ,         
  output reg       [7:0]       M_AXIS_5_ZFFT_Rd_addr ,          
                                                                
  input          [511:0]       M_AXIS_6_ZFFT_Rd_data  ,         
  output reg       [7:0]       M_AXIS_6_ZFFT_Rd_addr ,          
                                                                
  input          [511:0]       M_AXIS_7_ZFFT_Rd_data  ,         
  output reg       [7:0]       M_AXIS_7_ZFFT_Rd_addr ,          
                                                                
  input          [511:0]       M_AXIS_8_ZFFT_Rd_data  ,         
  output reg       [7:0]       M_AXIS_8_ZFFT_Rd_addr     
    );

    
wire  [8:0]        ZFFT_1_Loop_Num    ;
wire               ZFFT_1_wr_Done     ;

wire  [8:0]        ZFFT_2_Loop_Num;
wire               ZFFT_2_wr_Done;

wire    [8:0]      ZFFT_3_Loop_Num;
wire               ZFFT_3_wr_Done;

wire  [8:0]        ZFFT_4_Loop_Num;
wire               ZFFT_4_wr_Done;

wire  [8:0]        ZFFT_5_Loop_Num; 
wire               ZFFT_5_wr_Done;

wire    [8:0]      ZFFT_6_Loop_Num;
wire               ZFFT_6_wr_Done;

wire   [8:0]       ZFFT_7_Loop_Num;
wire               ZFFT_7_wr_Done;

wire  [8:0]         ZFFT_8_Loop_Num;
wire                ZFFT_8_wr_Done ; 

 
    
    ZFFT_2RAM_Module  # ( . Loop_times   (  9'd256),
                          . X_K_value  ( 9'd64),
                          . Y_K_value (  9'd64),
                          . Z_K_value   ( 9'd64)
                          )
U_ZFFT_2RAM_Module(
 .  Sys_Clk    (Sys_Clk  ), 
 .  Sys_Rst_n  (Sys_Rst_n), 
 
 .   Before_Data_1_ZFFT      (  Before_Data_1_ZFFT                   ),
 .  After_Data_1_ZFFT        ( After_Data_1_ZFFT                     ),
 .  ZFFT_1_Loop_Num          ( ZFFT_1_Loop_Num                        ),
 .  RD_1_ZFFT_en             ( RD_1_ZFFT_en                          ),
 .  ZFFT_1_wr_Done           ( ZFFT_1_wr_Done                       ),
 
 .  Before_Data_2_ZFFT       ( Before_Data_2_ZFFT                    ),
 .  After_Data_2_ZFFT         ( After_Data_2_ZFFT                      ),
 .  ZFFT_2_Loop_Num           ( ZFFT_2_Loop_Num                        ),
 .  RD_2_ZFFT_en            ( RD_2_ZFFT_en                          ),
 .  ZFFT_2_wr_Done            ( ZFFT_2_wr_Done                        ),
                       
 .  Before_Data_3_ZFFT       ( Before_Data_3_ZFFT                     ),
 .  After_Data_3_ZFFT         ( After_Data_3_ZFFT                      ),
 .  ZFFT_3_Loop_Num           ( ZFFT_3_Loop_Num                      ),
 .  RD_3_ZFFT_en              ( RD_3_ZFFT_en                          ),
 .  ZFFT_3_wr_Done             (ZFFT_3_wr_Done                        ),
               
 .  Before_Data_4_ZFFT        ( Before_Data_4_ZFFT                    ),
 .  After_Data_4_ZFFT          ( After_Data_4_ZFFT                    ),
 .  ZFFT_4_Loop_Num           ( ZFFT_4_Loop_Num                       ),
 .  RD_4_ZFFT_en              ( RD_4_ZFFT_en                          ),
 .  ZFFT_4_wr_Done            ( ZFFT_4_wr_Done                        ),
                               
 .  Before_Data_5_ZFFT     (   Before_Data_5_ZFFT                 ),
 .  After_Data_5_ZFFT      (   After_Data_5_ZFFT                   ),
 .  ZFFT_5_Loop_Num            ( ZFFT_5_Loop_Num                     ),
 .  RD_5_ZFFT_en            ( RD_5_ZFFT_en                         ),
 .  ZFFT_5_wr_Done          ( ZFFT_5_wr_Done                        ),
                           
 .  Before_Data_6_ZFFT     (   Before_Data_6_ZFFT                 ),
 .  After_Data_6_ZFFT      (   After_Data_6_ZFFT                 ),
 .  ZFFT_6_Loop_Num          ( ZFFT_6_Loop_Num                     ),
 .  RD_6_ZFFT_en            ( RD_6_ZFFT_en                         ),
 .  ZFFT_6_wr_Done          ( ZFFT_6_wr_Done                       ),
                               
 .  Before_Data_7_ZFFT        ( Before_Data_7_ZFFT                   ),
 .  After_Data_7_ZFFT        ( After_Data_7_ZFFT                    ),
 .  ZFFT_7_Loop_Num          ( ZFFT_7_Loop_Num                    ),
 .  RD_7_ZFFT_en            ( RD_7_ZFFT_en                        ),
 .  ZFFT_7_wr_Done          ( ZFFT_7_wr_Done                      ),
                    
 .   Before_Data_8_ZFFT      (    Before_Data_8_ZFFT               ),
 .   After_Data_8_ZFFT       (    After_Data_8_ZFFT                 ),
 .   ZFFT_8_Loop_Num         (  ZFFT_8_Loop_Num              ),
 .   RD_8_ZFFT_en             (  RD_8_ZFFT_en                       ),
 .   ZFFT_8_wr_Done            (  ZFFT_8_wr_Done                        ) 

    );
    
    
    
endmodule