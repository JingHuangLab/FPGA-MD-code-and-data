`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 01:51:23 PM
// Design Name: 
// Module Name: Three_D_FFT_Module
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


module Three_D_FFT_Module(
 input                         Sys_Clk             , 
 input                         Sys_Rst_n           ,

 input                         FFT_Forward_begin   ,
 output    wire                FFT_Forward_end     ,
  
 input                         FFT_Backward_begin  ,
 output    wire                FFT_Backward_end    ,
 
 output    reg                 M_AXIS_Q_Rd_en      ,
 input          [63:0]         M_AXIS_Q_Rd_data    ,
 output    reg  [31:0]         M_AXIS_Q_Rd_addr    ,
 
 output    wire [31:0]         RAM_Q_ADDR     , 
 output    wire [63:0]         Get_ONE_Value    
 );              
 
wire                   XFFT_M_AXIS_Q_Rd_en   ;
reg     [63:0]         XFFT_M_AXIS_Q_Rd_data ;
wire    [31:0]         XFFT_M_AXIS_Q_Rd_addr ;

wire                   YFFT_M_AXIS_Q_Rd_en   ;
reg     [63:0]         YFFT_M_AXIS_Q_Rd_data ;
wire    [31:0]         YFFT_M_AXIS_Q_Rd_addr ;

wire                   ZFFT_M_AXIS_Q_Rd_en   ;
reg     [63:0]         ZFFT_M_AXIS_Q_Rd_data ;
wire    [31:0]         ZFFT_M_AXIS_Q_Rd_addr ;
 
wire                   XFFT_Running  ;
wire                   YFFT_Running  ;
wire                   ZFFT_Running  ; 

wire                   XFFT_Forward_end  ;
wire                   XFFT_Backward_end ;  
wire                   YFFT_Backward_end;
wire                   ZFFT_Backward_end;  
wire                   YFFT_Forward_end;
wire                   ZFFT_Forward_end;
reg                    FFT_Forward ;
reg                    FFT_Backward;

 wire    [14:0]        After_1_FFT_R_addr     ; 
 wire   [511:0]        After_1_FFT_R_data     ;                 
 wire   [14:0]         After_2_FFT_R_addr     ;  
 wire   [511:0]        After_2_FFT_R_data     ;                   
 wire   [14:0]         After_3_FFT_R_addr     ; 
 wire   [511:0]        After_3_FFT_R_data     ;                   
 wire   [14:0]         After_4_FFT_R_addr     ; 
 wire   [511:0]        After_4_FFT_R_data     ;                
 wire   [14:0]         After_5_FFT_R_addr     ; 
 wire   [511:0]        After_5_FFT_R_data     ;                  
 wire   [14:0]         After_6_FFT_R_addr     ; 
 wire   [511:0]        After_6_FFT_R_data     ;                  
 wire   [14:0]         After_7_FFT_R_addr     ; 
 wire   [511:0]        After_7_FFT_R_data     ;               
 wire   [14:0]         After_8_FFT_R_addr     ; 
 wire   [511:0]        After_8_FFT_R_data     ; 

reg  [14:0]            FFT_1_Loop_Num;
reg  [14:0]            FFT_2_Loop_Num;
reg  [14:0]            FFT_3_Loop_Num;
reg  [14:0]            FFT_4_Loop_Num;
reg  [14:0]            FFT_5_Loop_Num;
reg  [14:0]            FFT_6_Loop_Num;
reg  [14:0]            FFT_7_Loop_Num;
reg  [14:0]            FFT_8_Loop_Num;

wire  [511:0]          After_Data_1_FFT;
wire  [511:0]          After_Data_2_FFT;
wire  [511:0]          After_Data_3_FFT;   
wire  [511:0]          After_Data_4_FFT; 
wire  [511:0]          After_Data_5_FFT;
wire  [511:0]          After_Data_6_FFT;
wire  [511:0]          After_Data_7_FFT;  
wire  [511:0]          After_Data_8_FFT;  

reg  [11:0]            FFT_1_After_tuser ;  
reg  [11:0]            FFT_2_After_tuser ;
reg  [11:0]            FFT_3_After_tuser ;  
reg  [11:0]            FFT_4_After_tuser ; 
reg  [11:0]            FFT_5_After_tuser ; 
reg  [11:0]            FFT_6_After_tuser ; 
reg  [11:0]            FFT_7_After_tuser ; 
reg  [11:0]            FFT_8_After_tuser ; 

wire                   FFT_1_data_tvalid;
wire                   FFT_2_data_tvalid;  
wire                   FFT_3_data_tvalid; 
wire                   FFT_4_data_tvalid; 
wire                   FFT_5_data_tvalid; 
wire                   FFT_6_data_tvalid;
wire                   FFT_7_data_tvalid; 
wire                   FFT_8_data_tvalid; 

   
wire  [511:0]          FFT_1_data_tdata;
wire  [511:0]          FFT_2_data_tdata;
wire  [511:0]          FFT_3_data_tdata;
wire  [511:0]          FFT_4_data_tdata;
wire  [511:0]          FFT_5_data_tdata;
wire  [511:0]          FFT_6_data_tdata;
wire  [511:0]          FFT_7_data_tdata;
wire  [511:0]          FFT_8_data_tdata;

wire  [511:0]          FFT_1_data_tuser;
wire  [511:0]          FFT_2_data_tuser;
wire  [511:0]          FFT_3_data_tuser;
wire  [511:0]          FFT_4_data_tuser;
wire  [511:0]          FFT_5_data_tuser;
wire  [511:0]          FFT_6_data_tuser;
wire  [511:0]          FFT_7_data_tuser;
wire  [511:0]          FFT_8_data_tuser;
 
wire [511:0]           Before_Data_1_FFT;  
wire [511:0]           Before_Data_2_FFT;  
wire [511:0]           Before_Data_3_FFT;  
wire [511:0]           Before_Data_4_FFT;  
wire [511:0]           Before_Data_5_FFT;  
wire [511:0]           Before_Data_6_FFT;  
wire [511:0]           Before_Data_7_FFT;  
wire [511:0]           Before_Data_8_FFT;  
 
reg  [14:0]            Before_1_FFT_Rd_addr;
reg  [14:0]            Before_2_FFT_Rd_addr;
reg  [14:0]            Before_3_FFT_Rd_addr;
reg  [14:0]            Before_4_FFT_Rd_addr;
reg  [14:0]            Before_5_FFT_Rd_addr;
reg  [14:0]            Before_6_FFT_Rd_addr;
reg  [14:0]            Before_7_FFT_Rd_addr;
reg  [14:0]            Before_8_FFT_Rd_addr;

wire                   FFT_1_Done;                  
wire                   FFT_2_Done;                  
wire                   FFT_3_Done;                  
wire                   FFT_4_Done;                  
wire                   FFT_5_Done;                  
wire                   FFT_6_Done;                  
wire                   FFT_7_Done;                  
wire                   FFT_8_Done;                  
                                               
reg                    FFT_1_Before_en;             
reg                    FFT_2_Before_en;             
reg                    FFT_3_Before_en;             
reg                    FFT_4_Before_en;             
reg                    FFT_5_Before_en;             
reg                    FFT_6_Before_en;             
reg                    FFT_7_Before_en;             
reg                    FFT_8_Before_en;      
  
reg                    FFT_1_vaild_en;
reg                    FFT_2_vaild_en;  
reg                    FFT_3_vaild_en;
reg                    FFT_4_vaild_en;
reg                    FFT_5_vaild_en;
reg                    FFT_6_vaild_en;
reg                    FFT_7_vaild_en;
reg                    FFT_8_vaild_en;     
  

reg                 M_AXIS_1_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_1_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_1_FFT_Wr_addr ;  
                                             
reg                 M_AXIS_2_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_2_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_2_FFT_Wr_addr ;  
                                            
reg                 M_AXIS_3_FFT_Wr_en   ;  
reg  [511:0]        M_AXIS_3_FFT_Wr_data ;  
reg    [15:0]       M_AXIS_3_FFT_Wr_addr ;  
                                            
reg                 M_AXIS_4_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_4_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_4_FFT_Wr_addr ;  
                                             
reg                 M_AXIS_5_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_5_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_5_FFT_Wr_addr ;  
                                            
reg                 M_AXIS_6_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_6_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_6_FFT_Wr_addr ;  
                                             
reg                 M_AXIS_7_FFT_Wr_en   ;  
reg   [511:0]       M_AXIS_7_FFT_Wr_data ;  
reg     [15:0]      M_AXIS_7_FFT_Wr_addr ;  
                                             
reg                 M_AXIS_8_FFT_Wr_en   ;  
reg  [511:0]        M_AXIS_8_FFT_Wr_data ;  
reg    [15:0]       M_AXIS_8_FFT_Wr_addr ;  

 //------------------------------------------------------  
 reg                XFFT_1_Done            ;
 reg                XFFT_2_Done            ;
 reg                XFFT_3_Done            ;
 reg                XFFT_4_Done            ;
 reg                XFFT_5_Done            ;
 reg                XFFT_6_Done            ;
 reg                XFFT_7_Done            ;
 reg                XFFT_8_Done            ;
  
  wire  [8:0]       XFFT_1_Loop_Num        ;                                          
  wire  [8:0]       XFFT_2_Loop_Num        ;                                           
  wire  [8:0]       XFFT_3_Loop_Num        ;                                          
  wire  [8:0]       XFFT_4_Loop_Num        ;                                           
  wire  [8:0]       XFFT_5_Loop_Num        ;                                           
  wire  [8:0]       XFFT_6_Loop_Num        ;                                           
  wire  [8:0]       XFFT_7_Loop_Num        ;                                           
  wire  [8:0]       XFFT_8_Loop_Num        ;
  
  wire              XFFT_1_Before_en       ;
  wire              XFFT_2_Before_en       ;
  wire              XFFT_3_Before_en       ;
  wire              XFFT_4_Before_en       ;
  wire              XFFT_5_Before_en       ;
  wire              XFFT_6_Before_en       ;
  wire              XFFT_7_Before_en       ;
  wire              XFFT_8_Before_en       ;

wire  [11:0]        XFFT_1_W_Loop_Num;
wire  [11:0]        XFFT_2_W_Loop_Num;
wire  [11:0]        XFFT_3_W_Loop_Num;
wire  [11:0]        XFFT_4_W_Loop_Num;
wire  [11:0]        XFFT_5_W_Loop_Num;                                              
wire  [11:0]        XFFT_6_W_Loop_Num;
wire  [11:0]        XFFT_7_W_Loop_Num;
wire  [11:0]        XFFT_8_W_Loop_Num;


   
 wire               XFFT_1_vaild_en        ;
 wire               XFFT_2_vaild_en        ;  
 wire               XFFT_3_vaild_en        ;
 wire               XFFT_4_vaild_en        ;
 wire               XFFT_5_vaild_en        ;
 wire               XFFT_6_vaild_en        ;
 wire               XFFT_7_vaild_en        ;
 wire               XFFT_8_vaild_en        ;     
              
 wire               After_1_XFFT_W_en      ; 
 wire               After_2_XFFT_W_en      ;     
 wire               After_3_XFFT_W_en      ;     
 wire               After_4_XFFT_W_en      ;     
 wire               After_5_XFFT_W_en      ;     
 wire               After_6_XFFT_W_en      ;     
 wire               After_7_XFFT_W_en      ;     
 wire               After_8_XFFT_W_en      ;     
    
 wire  [14:0]       After_1_XFFT_W_addr    ;       
 wire  [14:0]       After_2_XFFT_W_addr    ;               
 wire  [14:0]       After_3_XFFT_W_addr    ;               
 wire  [14:0]       After_4_XFFT_W_addr    ;              
 wire  [14:0]       After_5_XFFT_W_addr    ;              
 wire  [14:0]       After_6_XFFT_W_addr    ;              
 wire  [14:0]       After_7_XFFT_W_addr    ;             
 wire  [14:0]       After_8_XFFT_W_addr    ;             
    
  wire   [7:0]       Before_1_XFFT_Rd_addr ;                                        
  wire   [7:0]       Before_2_XFFT_Rd_addr ;                                         
  wire   [7:0]       Before_3_XFFT_Rd_addr ;                                        
  wire   [7:0]       Before_4_XFFT_Rd_addr ;                                         
  wire   [7:0]       Before_5_XFFT_Rd_addr ;                                          
  wire   [7:0]       Before_6_XFFT_Rd_addr ;                                         
  wire   [7:0]       Before_7_XFFT_Rd_addr ;                                          
  wire   [7:0]       Before_8_XFFT_Rd_addr ;
 
wire                 M_AXIS_1_XFFT_Wr_en  ;
wire   [511:0]       M_AXIS_1_XFFT_Wr_data;
wire     [15:0]      M_AXIS_1_XFFT_Wr_addr;
                                           
wire                 M_AXIS_2_XFFT_Wr_en  ;
wire   [511:0]       M_AXIS_2_XFFT_Wr_data;
wire     [15:0]      M_AXIS_2_XFFT_Wr_addr;
                                           
wire                 M_AXIS_3_XFFT_Wr_en   ;
wire   [511:0]       M_AXIS_3_XFFT_Wr_data ;
wire     [15:0]      M_AXIS_3_XFFT_Wr_addr ;
                                           
wire                 M_AXIS_4_XFFT_Wr_en   ;
wire   [511:0]       M_AXIS_4_XFFT_Wr_data ;
wire     [15:0]      M_AXIS_4_XFFT_Wr_addr ;
                                          
wire                 M_AXIS_5_XFFT_Wr_en  ;
wire    [511:0]      M_AXIS_5_XFFT_Wr_data;
wire      [15:0]     M_AXIS_5_XFFT_Wr_addr;
                                         
wire                 M_AXIS_6_XFFT_Wr_en   ;
wire   [511:0]       M_AXIS_6_XFFT_Wr_data ;
wire     [15:0]      M_AXIS_6_XFFT_Wr_addr ;
                                           
wire                 M_AXIS_7_XFFT_Wr_en   ;
wire   [511:0]       M_AXIS_7_XFFT_Wr_data ;
wire     [15:0]      M_AXIS_7_XFFT_Wr_addr ;
                                          
wire                 M_AXIS_8_XFFT_Wr_en   ;
wire  [511:0]        M_AXIS_8_XFFT_Wr_data ;
wire    [15:0]       M_AXIS_8_XFFT_Wr_addr ;
  //------------------------------------------------------  
reg                 YFFT_1_Done;
reg                 YFFT_2_Done;
reg                 YFFT_3_Done;
reg                 YFFT_4_Done;
reg                 YFFT_5_Done;
reg                 YFFT_6_Done;
reg                 YFFT_7_Done;
reg                 YFFT_8_Done;
  
  wire  [8:0]       YFFT_1_Loop_Num      ;                                          
  wire  [8:0]       YFFT_2_Loop_Num      ;                                           
  wire  [8:0]       YFFT_3_Loop_Num      ;                                          
  wire  [8:0]       YFFT_4_Loop_Num      ;                                           
  wire  [8:0]       YFFT_5_Loop_Num      ;                                           
  wire  [8:0]       YFFT_6_Loop_Num      ;                                           
  wire  [8:0]       YFFT_7_Loop_Num      ;                                           
  wire  [8:0]       YFFT_8_Loop_Num      ;
  
  wire              YFFT_1_Before_en     ;
  wire              YFFT_2_Before_en     ;
  wire              YFFT_3_Before_en     ;
  wire              YFFT_4_Before_en     ;
  wire              YFFT_5_Before_en     ;
  wire              YFFT_6_Before_en     ;
  wire              YFFT_7_Before_en     ;
  wire              YFFT_8_Before_en     ;
                                              

 wire               YFFT_1_vaild_en    ;
 wire               YFFT_2_vaild_en    ;  
 wire               YFFT_3_vaild_en    ;
 wire               YFFT_4_vaild_en    ;
 wire               YFFT_5_vaild_en    ;
 wire               YFFT_6_vaild_en    ;
 wire               YFFT_7_vaild_en    ;
 wire               YFFT_8_vaild_en    ;     
              
 wire               After_1_YFFT_W_en  ; 
 wire               After_2_YFFT_W_en  ;     
 wire               After_3_YFFT_W_en  ;     
 wire               After_4_YFFT_W_en  ;     
 wire               After_5_YFFT_W_en  ;     
 wire               After_6_YFFT_W_en  ;     
 wire               After_7_YFFT_W_en  ;     
 wire               After_8_YFFT_W_en  ;     
    
 wire  [14:0]       After_1_YFFT_W_addr;       
 wire  [14:0]       After_2_YFFT_W_addr;               
 wire  [14:0]       After_3_YFFT_W_addr;               
 wire  [14:0]       After_4_YFFT_W_addr;              
 wire  [14:0]       After_5_YFFT_W_addr;              
 wire  [14:0]       After_6_YFFT_W_addr;              
 wire  [14:0]       After_7_YFFT_W_addr;             
 wire  [14:0]       After_8_YFFT_W_addr;             
    
  wire   [7:0]       Before_1_YFFT_Rd_addr   ;                                        
  wire   [7:0]       Before_2_YFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_3_YFFT_Rd_addr   ;                                        
  wire   [7:0]       Before_4_YFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_5_YFFT_Rd_addr   ;                                          
  wire   [7:0]       Before_6_YFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_7_YFFT_Rd_addr   ;                                          
  wire   [7:0]       Before_8_YFFT_Rd_addr   ;
 
wire                 M_AXIS_1_YFFT_Wr_en  ;
wire   [511:0]       M_AXIS_1_YFFT_Wr_data;
wire     [15:0]      M_AXIS_1_YFFT_Wr_addr;
                                           
wire                 M_AXIS_2_YFFT_Wr_en  ;
wire   [511:0]       M_AXIS_2_YFFT_Wr_data;
wire     [15:0]      M_AXIS_2_YFFT_Wr_addr;
                                           
wire                 M_AXIS_3_YFFT_Wr_en   ;
wire   [511:0]       M_AXIS_3_YFFT_Wr_data ;
wire     [15:0]      M_AXIS_3_YFFT_Wr_addr ;
                                           
wire                 M_AXIS_4_YFFT_Wr_en   ;
wire   [511:0]       M_AXIS_4_YFFT_Wr_data ;
wire     [15:0]      M_AXIS_4_YFFT_Wr_addr ;
                                          
wire                 M_AXIS_5_YFFT_Wr_en  ;
wire    [511:0]      M_AXIS_5_YFFT_Wr_data;
wire      [15:0]     M_AXIS_5_YFFT_Wr_addr;
                                         
wire                 M_AXIS_6_YFFT_Wr_en   ;
wire   [511:0]       M_AXIS_6_YFFT_Wr_data ;
wire     [15:0]      M_AXIS_6_YFFT_Wr_addr ;
                                           
wire                 M_AXIS_7_YFFT_Wr_en   ;
wire   [511:0]       M_AXIS_7_YFFT_Wr_data ;
wire     [15:0]      M_AXIS_7_YFFT_Wr_addr ;
                                          
wire                 M_AXIS_8_YFFT_Wr_en   ;
wire  [511:0]        M_AXIS_8_YFFT_Wr_data ;
wire    [15:0]       M_AXIS_8_YFFT_Wr_addr ;

wire  [11:0]        YFFT_1_W_Loop_Num;
wire  [11:0]        YFFT_2_W_Loop_Num;
wire  [11:0]        YFFT_3_W_Loop_Num;
wire  [11:0]        YFFT_4_W_Loop_Num;
wire  [11:0]        YFFT_5_W_Loop_Num;                                              
wire  [11:0]        YFFT_6_W_Loop_Num;
wire  [11:0]        YFFT_7_W_Loop_Num;
wire  [11:0]        YFFT_8_W_Loop_Num; 
  //------------------------------------------------------  

 reg              ZFFT_1_Done;
 reg              ZFFT_2_Done;
 reg              ZFFT_3_Done;
 reg              ZFFT_4_Done;
 reg              ZFFT_5_Done;
 reg              ZFFT_6_Done;
 reg              ZFFT_7_Done;
 reg              ZFFT_8_Done;
  
  wire  [8:0]       ZFFT_1_Loop_Num      ;                                          
  wire  [8:0]       ZFFT_2_Loop_Num      ;                                           
  wire  [8:0]       ZFFT_3_Loop_Num      ;                                          
  wire  [8:0]       ZFFT_4_Loop_Num      ;                                           
  wire  [8:0]       ZFFT_5_Loop_Num      ;                                           
  wire  [8:0]       ZFFT_6_Loop_Num      ;                                           
  wire  [8:0]       ZFFT_7_Loop_Num      ;                                           
  wire  [8:0]       ZFFT_8_Loop_Num      ;
  
  wire              ZFFT_1_Before_en     ;
  wire              ZFFT_2_Before_en     ;
  wire              ZFFT_3_Before_en     ;
  wire              ZFFT_4_Before_en     ;
  wire              ZFFT_5_Before_en     ;
  wire              ZFFT_6_Before_en     ;
  wire              ZFFT_7_Before_en     ;
  wire              ZFFT_8_Before_en     ;
                                              
 wire               ZFFT_1_vaild_en    ;
 wire               ZFFT_2_vaild_en    ;  
 wire               ZFFT_3_vaild_en    ;
 wire               ZFFT_4_vaild_en    ;
 wire               ZFFT_5_vaild_en    ;
 wire               ZFFT_6_vaild_en    ;
 wire               ZFFT_7_vaild_en    ;
 wire               ZFFT_8_vaild_en    ;     
              
 wire               After_1_ZFFT_W_en  ; 
 wire               After_2_ZFFT_W_en  ;     
 wire               After_3_ZFFT_W_en  ;     
 wire               After_4_ZFFT_W_en  ;     
 wire               After_5_ZFFT_W_en  ;     
 wire               After_6_ZFFT_W_en  ;     
 wire               After_7_ZFFT_W_en  ;     
 wire               After_8_ZFFT_W_en  ;     
    
 wire  [14:0]       After_1_ZFFT_W_addr;       
 wire  [14:0]       After_2_ZFFT_W_addr;               
 wire  [14:0]       After_3_ZFFT_W_addr;               
 wire  [14:0]       After_4_ZFFT_W_addr;              
 wire  [14:0]       After_5_ZFFT_W_addr;              
 wire  [14:0]       After_6_ZFFT_W_addr;              
 wire  [14:0]       After_7_ZFFT_W_addr;             
 wire  [14:0]       After_8_ZFFT_W_addr;             
    
  wire   [7:0]       Before_1_ZFFT_Rd_addr   ;                                        
  wire   [7:0]       Before_2_ZFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_3_ZFFT_Rd_addr   ;                                        
  wire   [7:0]       Before_4_ZFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_5_ZFFT_Rd_addr   ;                                          
  wire   [7:0]       Before_6_ZFFT_Rd_addr   ;                                         
  wire   [7:0]       Before_7_ZFFT_Rd_addr   ;                                          
  wire   [7:0]       Before_8_ZFFT_Rd_addr   ;
 
wire                 M_AXIS_1_ZFFT_Wr_en  ;
wire   [511:0]       M_AXIS_1_ZFFT_Wr_data;
wire     [15:0]      M_AXIS_1_ZFFT_Wr_addr;
                                           
wire                 M_AXIS_2_ZFFT_Wr_en  ;
wire   [511:0]       M_AXIS_2_ZFFT_Wr_data;
wire     [15:0]      M_AXIS_2_ZFFT_Wr_addr;
                                           
wire                 M_AXIS_3_ZFFT_Wr_en   ;
wire   [511:0]       M_AXIS_3_ZFFT_Wr_data ;
wire     [15:0]      M_AXIS_3_ZFFT_Wr_addr ;
                                           
wire                 M_AXIS_4_ZFFT_Wr_en   ;
wire   [511:0]       M_AXIS_4_ZFFT_Wr_data ;
wire     [15:0]      M_AXIS_4_ZFFT_Wr_addr ;
                                          
wire                 M_AXIS_5_ZFFT_Wr_en  ;
wire    [511:0]      M_AXIS_5_ZFFT_Wr_data;
wire      [15:0]     M_AXIS_5_ZFFT_Wr_addr;
                                         
wire                 M_AXIS_6_ZFFT_Wr_en   ;
wire   [511:0]       M_AXIS_6_ZFFT_Wr_data ;
wire     [15:0]      M_AXIS_6_ZFFT_Wr_addr ;
                                           
wire                 M_AXIS_7_ZFFT_Wr_en   ;
wire   [511:0]       M_AXIS_7_ZFFT_Wr_data ;
wire     [15:0]      M_AXIS_7_ZFFT_Wr_addr ;
                                          
wire                 M_AXIS_8_ZFFT_Wr_en   ;
wire  [511:0]        M_AXIS_8_ZFFT_Wr_data ;
wire    [15:0]       M_AXIS_8_ZFFT_Wr_addr ;

wire  [11:0]        ZFFT_1_W_Loop_Num; 
wire  [11:0]        ZFFT_2_W_Loop_Num; 
wire  [11:0]        ZFFT_3_W_Loop_Num; 
wire  [11:0]        ZFFT_4_W_Loop_Num; 
wire  [11:0]        ZFFT_5_W_Loop_Num; 
wire  [11:0]        ZFFT_6_W_Loop_Num; 
wire  [11:0]        ZFFT_7_W_Loop_Num; 
wire  [11:0]        ZFFT_8_W_Loop_Num; 



 XYZ_AFTER #   (.Loop_times ( 14'd4096 ) ,
                .X_K_value  (9'd64 )  ,
                .Y_K_value  (9'd64 )  ,
                .Z_K_value  (9'd64 )  )
U_XYZ_AFTER
(
.   Sys_Clk            (Sys_Clk            )   , 
.   Sys_Rst_n          (Sys_Rst_n          )   , 
.   XFFT_Running       (XFFT_Running       )   ,  
.   YFFT_Running       (YFFT_Running       )   ,  
.   ZFFT_Running       (ZFFT_Running       )   ,  
.   After_1_FFT_R_addr (After_1_FFT_R_addr )   ,
.   After_1_FFT_R_data (After_1_FFT_R_data )   ,                
.   After_2_FFT_R_addr (After_2_FFT_R_addr )   ,
.   After_2_FFT_R_data (After_2_FFT_R_data )   ,                  
.   After_3_FFT_R_addr (After_3_FFT_R_addr )   ,
.   After_3_FFT_R_data (After_3_FFT_R_data )   ,                  
.   After_4_FFT_R_addr (After_4_FFT_R_addr )   ,
.   After_4_FFT_R_data (After_4_FFT_R_data )   ,               
.   After_5_FFT_R_addr (After_5_FFT_R_addr )   ,
.   After_5_FFT_R_data (After_5_FFT_R_data )   ,                 
.   After_6_FFT_R_addr (After_6_FFT_R_addr )   ,
.   After_6_FFT_R_data (After_6_FFT_R_data )   ,                 
.   After_7_FFT_R_addr (After_7_FFT_R_addr )   ,
.   After_7_FFT_R_data (After_7_FFT_R_data )   ,              
.   After_8_FFT_R_addr (After_8_FFT_R_addr )   ,
.   After_8_FFT_R_data (After_8_FFT_R_data )   ,
.   RAM_Q_ADDR         ( RAM_Q_ADDR        )   ,
.   Get_ONE_Value      ( Get_ONE_Value     )

    );
       
XFFT_2RAM_Module           # (.Loop_times ( 14'd4096 ) ,
                              .X_K_value  ( 9'd64 )  ,
                              .Y_K_value  ( 9'd64 )  ,
                              .Z_K_value  ( 9'd64 )  )
 U_XFFT_2RAM_Module                           
 
 (
 .  Sys_Clk                 (Sys_Clk             )       , 
 .  Sys_Rst_n               (Sys_Rst_n           )       , 
 .  XFFT_Running            (XFFT_Running        )       ,
                       
 .  FFT_Forward_begin       (FFT_Forward_begin   )   ,
 .  FFT_Backward_begin      (FFT_Backward_begin  )   ,
                           
 .  XFFT_Forward_end        (XFFT_Forward_end    )   ,
 .  XFFT_Backward_end       (XFFT_Backward_end   )   ,
                            
 .  M_AXIS_Q_Rd_en          (XFFT_M_AXIS_Q_Rd_en      )   ,     
 .  M_AXIS_Q_Rd_data        (XFFT_M_AXIS_Q_Rd_data    )   ,
 .  M_AXIS_Q_Rd_addr        (XFFT_M_AXIS_Q_Rd_addr    )   ,  // read data from Ram_Q

 .  M_AXIS_1_XFFT_Wr_en     ( M_AXIS_1_XFFT_Wr_en    ),    // write data to ram
 .  M_AXIS_1_XFFT_Wr_data   ( M_AXIS_1_XFFT_Wr_data  ),
 .  M_AXIS_1_XFFT_Wr_addr   ( M_AXIS_1_XFFT_Wr_addr  ),
                       
 .  M_AXIS_2_XFFT_Wr_en     ( M_AXIS_2_XFFT_Wr_en    ),
 .  M_AXIS_2_XFFT_Wr_data   ( M_AXIS_2_XFFT_Wr_data  ),
 .  M_AXIS_2_XFFT_Wr_addr   ( M_AXIS_2_XFFT_Wr_addr  ),
                        
 .  M_AXIS_3_XFFT_Wr_en     ( M_AXIS_3_XFFT_Wr_en    ),
 .  M_AXIS_3_XFFT_Wr_data   ( M_AXIS_3_XFFT_Wr_data  ),
 .  M_AXIS_3_XFFT_Wr_addr   ( M_AXIS_3_XFFT_Wr_addr  ),
                        
 .  M_AXIS_4_XFFT_Wr_en     ( M_AXIS_4_XFFT_Wr_en    ),
 .  M_AXIS_4_XFFT_Wr_data   ( M_AXIS_4_XFFT_Wr_data  ),
 .  M_AXIS_4_XFFT_Wr_addr   ( M_AXIS_4_XFFT_Wr_addr  ),
                         
 .  M_AXIS_5_XFFT_Wr_en     ( M_AXIS_5_XFFT_Wr_en    ),
 .  M_AXIS_5_XFFT_Wr_data   ( M_AXIS_5_XFFT_Wr_data  ),
 .  M_AXIS_5_XFFT_Wr_addr   ( M_AXIS_5_XFFT_Wr_addr  ),
                        
 .  M_AXIS_6_XFFT_Wr_en     ( M_AXIS_6_XFFT_Wr_en    ),
 .  M_AXIS_6_XFFT_Wr_data   ( M_AXIS_6_XFFT_Wr_data  ),
 .  M_AXIS_6_XFFT_Wr_addr   ( M_AXIS_6_XFFT_Wr_addr  ),
                       
 .  M_AXIS_7_XFFT_Wr_en     ( M_AXIS_7_XFFT_Wr_en    ),
 .  M_AXIS_7_XFFT_Wr_data   ( M_AXIS_7_XFFT_Wr_data  ),
 .  M_AXIS_7_XFFT_Wr_addr   ( M_AXIS_7_XFFT_Wr_addr  ),
                         
 .  M_AXIS_8_XFFT_Wr_en     ( M_AXIS_8_XFFT_Wr_en    ),
 .  M_AXIS_8_XFFT_Wr_data   ( M_AXIS_8_XFFT_Wr_data  ),
 .  M_AXIS_8_XFFT_Wr_addr   ( M_AXIS_8_XFFT_Wr_addr  ),
                                                             //read data to FFT 
 .  Before_1_XFFT_Rd_addr  (Before_1_XFFT_Rd_addr )   ,
 .  Before_2_XFFT_Rd_addr  (Before_2_XFFT_Rd_addr )   ,
 .  Before_3_XFFT_Rd_addr  (Before_3_XFFT_Rd_addr )   ,
 .  Before_4_XFFT_Rd_addr  (Before_4_XFFT_Rd_addr )   ,
 .  Before_5_XFFT_Rd_addr  (Before_5_XFFT_Rd_addr )   ,
 .  Before_6_XFFT_Rd_addr  (Before_6_XFFT_Rd_addr )   ,
 .  Before_7_XFFT_Rd_addr  (Before_7_XFFT_Rd_addr )   ,
 .  Before_8_XFFT_Rd_addr  (Before_8_XFFT_Rd_addr )   ,  
        
 .  XFFT_1_vaild_en        (XFFT_1_vaild_en       )  ,            
 .  XFFT_1_Loop_Num        (XFFT_1_Loop_Num       )  , 
 .  XFFT_1_Done            (XFFT_1_Done           )  ,
 .  XFFT_1_Before_en       (XFFT_1_Before_en      )  ,
                        
 .  XFFT_2_vaild_en        (XFFT_2_vaild_en       )  ,            
 .  XFFT_2_Loop_Num        (XFFT_2_Loop_Num       )  ,
 .  XFFT_2_Done            (XFFT_2_Done           )  ,
 .  XFFT_2_Before_en       (XFFT_2_Before_en      )  ,
 
 .  XFFT_3_vaild_en        (XFFT_3_vaild_en       )  ,  
 .  XFFT_3_Loop_Num        (XFFT_3_Loop_Num       )  ,
 .  XFFT_3_Done            (XFFT_3_Done           )  ,
 .  XFFT_3_Before_en       (XFFT_3_Before_en      )  ,
 
 .  XFFT_4_vaild_en        (XFFT_4_vaild_en       )  ,  
 .  XFFT_4_Loop_Num        (XFFT_4_Loop_Num       )  ,
 .  XFFT_4_Done            (XFFT_4_Done           )  ,
 .  XFFT_4_Before_en       (XFFT_4_Before_en      )  ,
 
 .  XFFT_5_vaild_en        (XFFT_5_vaild_en       )  ,  
 .  XFFT_5_Loop_Num        (XFFT_5_Loop_Num       )  ,
 .  XFFT_5_Done            (XFFT_5_Done           )  ,
 .  XFFT_5_Before_en       (XFFT_5_Before_en      )  ,
 
 .  XFFT_6_vaild_en        (XFFT_6_vaild_en       )  ,  
 .  XFFT_6_Loop_Num        (XFFT_6_Loop_Num       )  ,
 .  XFFT_6_Done            (XFFT_6_Done           )  ,
 .  XFFT_6_Before_en       (XFFT_6_Before_en      )  ,
                      
 .  XFFT_7_vaild_en        (XFFT_7_vaild_en       )  ,  
 .  XFFT_7_Loop_Num        (XFFT_7_Loop_Num       )  ,
 .  XFFT_7_Done            (XFFT_7_Done           )  ,
 .  XFFT_7_Before_en       (XFFT_7_Before_en      )  ,
                           
 .  XFFT_8_vaild_en        (XFFT_8_vaild_en       )  ,  
 .  XFFT_8_Loop_Num        (XFFT_8_Loop_Num       )  ,
 .  XFFT_8_Done            (XFFT_8_Done           )   ,
 .  XFFT_8_Before_en       (XFFT_8_Before_en      )   , 
  //------------------------------------------------------  
  
 .XFFT_1_W_Loop_Num           (XFFT_1_W_Loop_Num )   ,
 .XFFT_2_W_Loop_Num           (XFFT_2_W_Loop_Num )   ,
 .XFFT_3_W_Loop_Num           (XFFT_3_W_Loop_Num )   ,
 .XFFT_4_W_Loop_Num           (XFFT_4_W_Loop_Num )   ,
 .XFFT_5_W_Loop_Num           (XFFT_5_W_Loop_Num )   ,
 .XFFT_6_W_Loop_Num           (XFFT_6_W_Loop_Num )   ,
 .XFFT_7_W_Loop_Num           (XFFT_7_W_Loop_Num )   ,
 .XFFT_8_W_Loop_Num           (XFFT_8_W_Loop_Num )    
  
    );
    
    
   //------------------------------------------------------  
   //------------------------------------------------------   
   
     
 YFFT_2RAM_Module           # (.Loop_times ( 14'd4096 ) ,
                              .X_K_value  ( 9'd64 )  ,
                              .Y_K_value  ( 9'd64 )  ,
                              .Z_K_value  ( 9'd64 )  )
 U_YFFT_2RAM_Module                           
 
 (
 .  Sys_Clk                 (Sys_Clk             )       , 
 .  Sys_Rst_n               (Sys_Rst_n           )       , 
 .  YFFT_Running            (YFFT_Running        )       ,
                       
 .  FFT_Forward_begin       (FFT_Forward_begin   )   ,
 .  FFT_Backward_begin      (FFT_Backward_begin  )   ,
                           
 .  YFFT_Forward_end        (YFFT_Forward_end    )   ,
 .  YFFT_Backward_end       (YFFT_Backward_end   )   ,
                            
 .  M_AXIS_Q_Rd_en          (YFFT_M_AXIS_Q_Rd_en      )   ,     
 .  M_AXIS_Q_Rd_data        (YFFT_M_AXIS_Q_Rd_data    )   ,
 .  M_AXIS_Q_Rd_addr        (YFFT_M_AXIS_Q_Rd_addr    )   ,  // read data from Ram_Q

 .  M_AXIS_1_YFFT_Wr_en     ( M_AXIS_1_YFFT_Wr_en    ),    // write data to ram
 .  M_AXIS_1_YFFT_Wr_data   ( M_AXIS_1_YFFT_Wr_data  ),
 .  M_AXIS_1_YFFT_Wr_addr   ( M_AXIS_1_YFFT_Wr_addr  ),
                       
 .  M_AXIS_2_YFFT_Wr_en     ( M_AXIS_2_YFFT_Wr_en    ),
 .  M_AXIS_2_YFFT_Wr_data   ( M_AXIS_2_YFFT_Wr_data  ),
 .  M_AXIS_2_YFFT_Wr_addr   ( M_AXIS_2_YFFT_Wr_addr  ),
                        
 .  M_AXIS_3_YFFT_Wr_en     ( M_AXIS_3_YFFT_Wr_en    ),
 .  M_AXIS_3_YFFT_Wr_data   ( M_AXIS_3_YFFT_Wr_data  ),
 .  M_AXIS_3_YFFT_Wr_addr   ( M_AXIS_3_YFFT_Wr_addr  ),
                        
 .  M_AXIS_4_YFFT_Wr_en     ( M_AXIS_4_YFFT_Wr_en    ),
 .  M_AXIS_4_YFFT_Wr_data   ( M_AXIS_4_YFFT_Wr_data  ),
 .  M_AXIS_4_YFFT_Wr_addr   ( M_AXIS_4_YFFT_Wr_addr  ),
                         
 .  M_AXIS_5_YFFT_Wr_en     ( M_AXIS_5_YFFT_Wr_en    ),
 .  M_AXIS_5_YFFT_Wr_data   ( M_AXIS_5_YFFT_Wr_data  ),
 .  M_AXIS_5_YFFT_Wr_addr   ( M_AXIS_5_YFFT_Wr_addr  ),
                        
 .  M_AXIS_6_YFFT_Wr_en     ( M_AXIS_6_YFFT_Wr_en    ),
 .  M_AXIS_6_YFFT_Wr_data   ( M_AXIS_6_YFFT_Wr_data  ),
 .  M_AXIS_6_YFFT_Wr_addr   ( M_AXIS_6_YFFT_Wr_addr  ),
                       
 .  M_AXIS_7_YFFT_Wr_en     ( M_AXIS_7_YFFT_Wr_en    ),
 .  M_AXIS_7_YFFT_Wr_data   ( M_AXIS_7_YFFT_Wr_data  ),
 .  M_AXIS_7_YFFT_Wr_addr   ( M_AXIS_7_YFFT_Wr_addr  ),
                         
 .  M_AXIS_8_YFFT_Wr_en     ( M_AXIS_8_YFFT_Wr_en    ),
 .  M_AXIS_8_YFFT_Wr_data   ( M_AXIS_8_YFFT_Wr_data  ),
 .  M_AXIS_8_YFFT_Wr_addr   ( M_AXIS_8_YFFT_Wr_addr  ),
                                                             //read data to FFT 
 .  Before_1_YFFT_Rd_addr  (Before_1_YFFT_Rd_addr )   ,
 .  Before_2_YFFT_Rd_addr  (Before_2_YFFT_Rd_addr )   ,
 .  Before_3_YFFT_Rd_addr  (Before_3_YFFT_Rd_addr )   ,
 .  Before_4_YFFT_Rd_addr  (Before_4_YFFT_Rd_addr )   ,
 .  Before_5_YFFT_Rd_addr  (Before_5_YFFT_Rd_addr )   ,
 .  Before_6_YFFT_Rd_addr  (Before_6_YFFT_Rd_addr )   ,
 .  Before_7_YFFT_Rd_addr  (Before_7_YFFT_Rd_addr )   ,
 .  Before_8_YFFT_Rd_addr  (Before_8_YFFT_Rd_addr )   ,  
        
 .  YFFT_1_vaild_en        (YFFT_1_vaild_en       )  ,            
 .  YFFT_1_Loop_Num        (YFFT_1_Loop_Num       )  , 
 .  YFFT_1_Done            (YFFT_1_Done           )  ,
 .  YFFT_1_Before_en       (YFFT_1_Before_en      )  ,
                        
 .  YFFT_2_vaild_en        (YFFT_2_vaild_en       )  ,            
 .  YFFT_2_Loop_Num        (YFFT_2_Loop_Num       )  ,
 .  YFFT_2_Done            (YFFT_2_Done           )  ,
 .  YFFT_2_Before_en       (YFFT_2_Before_en      )  ,
 
 .  YFFT_3_vaild_en        (YFFT_3_vaild_en       )  ,  
 .  YFFT_3_Loop_Num        (YFFT_3_Loop_Num       )  ,
 .  YFFT_3_Done            (YFFT_3_Done           )  ,
 .  YFFT_3_Before_en       (YFFT_3_Before_en      )  ,
 
 .  YFFT_4_vaild_en        (YFFT_4_vaild_en       )  ,  
 .  YFFT_4_Loop_Num        (YFFT_4_Loop_Num       )  ,
 .  YFFT_4_Done            (YFFT_4_Done           )  ,
 .  YFFT_4_Before_en       (YFFT_4_Before_en      )  ,
 
 .  YFFT_5_vaild_en        (YFFT_5_vaild_en       )  ,  
 .  YFFT_5_Loop_Num        (YFFT_5_Loop_Num       )  ,
 .  YFFT_5_Done            (YFFT_5_Done           )  ,
 .  YFFT_5_Before_en       (YFFT_5_Before_en      )  ,
 
 .  YFFT_6_vaild_en        (YFFT_6_vaild_en       )  ,  
 .  YFFT_6_Loop_Num        (YFFT_6_Loop_Num       )  ,
 .  YFFT_6_Done            (YFFT_6_Done           )  ,
 .  YFFT_6_Before_en       (YFFT_6_Before_en      )  ,
                      
 .  YFFT_7_vaild_en        (YFFT_7_vaild_en       )  ,  
 .  YFFT_7_Loop_Num        (YFFT_7_Loop_Num       )  ,
 .  YFFT_7_Done            (YFFT_7_Done           )  ,
 .  YFFT_7_Before_en       (YFFT_7_Before_en      )  ,
                           
 .  YFFT_8_vaild_en        (YFFT_8_vaild_en       )  ,  
 .  YFFT_8_Loop_Num        (YFFT_8_Loop_Num       )  ,
 .  YFFT_8_Done            (YFFT_8_Done           )   ,
 .  YFFT_8_Before_en       (YFFT_8_Before_en      )   , 
  //------------------------------------------------------  
  
 .YFFT_1_W_Loop_Num           (YFFT_1_W_Loop_Num )   ,
 .YFFT_2_W_Loop_Num           (YFFT_2_W_Loop_Num )   ,
 .YFFT_3_W_Loop_Num           (YFFT_3_W_Loop_Num )   ,
 .YFFT_4_W_Loop_Num           (YFFT_4_W_Loop_Num )   ,
 .YFFT_5_W_Loop_Num           (YFFT_5_W_Loop_Num )   ,
 .YFFT_6_W_Loop_Num           (YFFT_6_W_Loop_Num )   ,
 .YFFT_7_W_Loop_Num           (YFFT_7_W_Loop_Num )   ,
 .YFFT_8_W_Loop_Num           (YFFT_8_W_Loop_Num )    
  
    );
    
   //------------------------------------------------------  
   //------------------------------------------------------   
   
ZFFT_2RAM_Module           # (.Loop_times ( 14'd4096 ) ,
                              .X_K_value  ( 9'd64 )  ,
                              .Y_K_value  ( 9'd64 )  ,
                              .Z_K_value  ( 9'd64 )  )
 U_ZFFT_2RAM_Module                           
 
 (
 .  Sys_Clk                 (Sys_Clk             )       , 
 .  Sys_Rst_n               (Sys_Rst_n           )       , 
 .  ZFFT_Running            (ZFFT_Running        )       ,
                       
 .  FFT_Forward_begin       (FFT_Forward_begin   )   ,
 .  FFT_Backward_begin      (FFT_Backward_begin  )   ,
                           
 .  ZFFT_Forward_end        (ZFFT_Forward_end    )   ,
 .  ZFFT_Backward_end       (ZFFT_Backward_end   )   ,
                            
 .  M_AXIS_Q_Rd_en          (ZFFT_M_AXIS_Q_Rd_en      )   ,     
 .  M_AXIS_Q_Rd_data        (ZFFT_M_AXIS_Q_Rd_data    )   ,
 .  M_AXIS_Q_Rd_addr        (ZFFT_M_AXIS_Q_Rd_addr    )   ,  // read data from Ram_Q

 .  M_AXIS_1_ZFFT_Wr_en     ( M_AXIS_1_ZFFT_Wr_en    ),    // write data to ram
 .  M_AXIS_1_ZFFT_Wr_data   ( M_AXIS_1_ZFFT_Wr_data  ),
 .  M_AXIS_1_ZFFT_Wr_addr   ( M_AXIS_1_ZFFT_Wr_addr  ),
                       
 .  M_AXIS_2_ZFFT_Wr_en     ( M_AXIS_2_ZFFT_Wr_en    ),
 .  M_AXIS_2_ZFFT_Wr_data   ( M_AXIS_2_ZFFT_Wr_data  ),
 .  M_AXIS_2_ZFFT_Wr_addr   ( M_AXIS_2_ZFFT_Wr_addr  ),
                        
 .  M_AXIS_3_ZFFT_Wr_en     ( M_AXIS_3_ZFFT_Wr_en    ),
 .  M_AXIS_3_ZFFT_Wr_data   ( M_AXIS_3_ZFFT_Wr_data  ),
 .  M_AXIS_3_ZFFT_Wr_addr   ( M_AXIS_3_ZFFT_Wr_addr  ),
                        
 .  M_AXIS_4_ZFFT_Wr_en     ( M_AXIS_4_ZFFT_Wr_en    ),
 .  M_AXIS_4_ZFFT_Wr_data   ( M_AXIS_4_ZFFT_Wr_data  ),
 .  M_AXIS_4_ZFFT_Wr_addr   ( M_AXIS_4_ZFFT_Wr_addr  ),
                         
 .  M_AXIS_5_ZFFT_Wr_en     ( M_AXIS_5_ZFFT_Wr_en    ),
 .  M_AXIS_5_ZFFT_Wr_data   ( M_AXIS_5_ZFFT_Wr_data  ),
 .  M_AXIS_5_ZFFT_Wr_addr   ( M_AXIS_5_ZFFT_Wr_addr  ),
                        
 .  M_AXIS_6_ZFFT_Wr_en     ( M_AXIS_6_ZFFT_Wr_en    ),
 .  M_AXIS_6_ZFFT_Wr_data   ( M_AXIS_6_ZFFT_Wr_data  ),
 .  M_AXIS_6_ZFFT_Wr_addr   ( M_AXIS_6_ZFFT_Wr_addr  ),
                       
 .  M_AXIS_7_ZFFT_Wr_en     ( M_AXIS_7_ZFFT_Wr_en    ),
 .  M_AXIS_7_ZFFT_Wr_data   ( M_AXIS_7_ZFFT_Wr_data  ),
 .  M_AXIS_7_ZFFT_Wr_addr   ( M_AXIS_7_ZFFT_Wr_addr  ),
                         
 .  M_AXIS_8_ZFFT_Wr_en     ( M_AXIS_8_ZFFT_Wr_en    ),
 .  M_AXIS_8_ZFFT_Wr_data   ( M_AXIS_8_ZFFT_Wr_data  ),
 .  M_AXIS_8_ZFFT_Wr_addr   ( M_AXIS_8_ZFFT_Wr_addr  ),
                                                             //read data to FFT 
 .  Before_1_ZFFT_Rd_addr  (Before_1_ZFFT_Rd_addr )   ,
 .  Before_2_ZFFT_Rd_addr  (Before_2_ZFFT_Rd_addr )   ,
 .  Before_3_ZFFT_Rd_addr  (Before_3_ZFFT_Rd_addr )   ,
 .  Before_4_ZFFT_Rd_addr  (Before_4_ZFFT_Rd_addr )   ,
 .  Before_5_ZFFT_Rd_addr  (Before_5_ZFFT_Rd_addr )   ,
 .  Before_6_ZFFT_Rd_addr  (Before_6_ZFFT_Rd_addr )   ,
 .  Before_7_ZFFT_Rd_addr  (Before_7_ZFFT_Rd_addr )   ,
 .  Before_8_ZFFT_Rd_addr  (Before_8_ZFFT_Rd_addr )   ,  
        
 .  ZFFT_1_vaild_en        (ZFFT_1_vaild_en       )  ,            
 .  ZFFT_1_Loop_Num        (ZFFT_1_Loop_Num       )  , 
 .  ZFFT_1_Done            (ZFFT_1_Done           )  ,
 .  ZFFT_1_Before_en       (ZFFT_1_Before_en      )  ,
                        
 .  ZFFT_2_vaild_en        (ZFFT_2_vaild_en       )  ,            
 .  ZFFT_2_Loop_Num        (ZFFT_2_Loop_Num       )  ,
 .  ZFFT_2_Done            (ZFFT_2_Done           )  ,
 .  ZFFT_2_Before_en       (ZFFT_2_Before_en      )  ,
 
 .  ZFFT_3_vaild_en        (ZFFT_3_vaild_en       )  ,  
 .  ZFFT_3_Loop_Num        (ZFFT_3_Loop_Num       )  ,
 .  ZFFT_3_Done            (ZFFT_3_Done           )  ,
 .  ZFFT_3_Before_en       (ZFFT_3_Before_en      )  ,
 
 .  ZFFT_4_vaild_en        (ZFFT_4_vaild_en       )  ,  
 .  ZFFT_4_Loop_Num        (ZFFT_4_Loop_Num       )  ,
 .  ZFFT_4_Done            (ZFFT_4_Done           )  ,
 .  ZFFT_4_Before_en       (ZFFT_4_Before_en      )  ,
 
 .  ZFFT_5_vaild_en        (ZFFT_5_vaild_en       )  ,  
 .  ZFFT_5_Loop_Num        (ZFFT_5_Loop_Num       )  ,
 .  ZFFT_5_Done            (ZFFT_5_Done           )  ,
 .  ZFFT_5_Before_en       (ZFFT_5_Before_en      )  ,
 
 .  ZFFT_6_vaild_en        (ZFFT_6_vaild_en       )  ,  
 .  ZFFT_6_Loop_Num        (ZFFT_6_Loop_Num       )  ,
 .  ZFFT_6_Done            (ZFFT_6_Done           )  ,
 .  ZFFT_6_Before_en       (ZFFT_6_Before_en      )  ,
                      
 .  ZFFT_7_vaild_en        (ZFFT_7_vaild_en       )  ,  
 .  ZFFT_7_Loop_Num        (ZFFT_7_Loop_Num       )  ,
 .  ZFFT_7_Done            (ZFFT_7_Done           )  ,
 .  ZFFT_7_Before_en       (ZFFT_7_Before_en      )  ,
                           
 .  ZFFT_8_vaild_en        (ZFFT_8_vaild_en       )  ,  
 .  ZFFT_8_Loop_Num        (ZFFT_8_Loop_Num       )  ,
 .  ZFFT_8_Done            (ZFFT_8_Done           )   ,
 .  ZFFT_8_Before_en       (ZFFT_8_Before_en      )   , 
  //------------------------------------------------------  
  
 .ZFFT_1_W_Loop_Num           (ZFFT_1_W_Loop_Num )   ,
 .ZFFT_2_W_Loop_Num           (ZFFT_2_W_Loop_Num )   ,
 .ZFFT_3_W_Loop_Num           (ZFFT_3_W_Loop_Num )   ,
 .ZFFT_4_W_Loop_Num           (ZFFT_4_W_Loop_Num )   ,
 .ZFFT_5_W_Loop_Num           (ZFFT_5_W_Loop_Num )   ,
 .ZFFT_6_W_Loop_Num           (ZFFT_6_W_Loop_Num )   ,
 .ZFFT_7_W_Loop_Num           (ZFFT_7_W_Loop_Num )   ,
 .ZFFT_8_W_Loop_Num           (ZFFT_8_W_Loop_Num )    
  
    );
    
 
 
 
 
 //////////////////////////////////////////////////////////////////////////////////

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_1_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_1_Loop_Num <=  XFFT_1_Loop_Num ; 
      else if (YFFT_Running)
           FFT_1_Loop_Num <=  YFFT_1_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_1_Loop_Num <=  ZFFT_1_Loop_Num ;      
      else   
           FFT_1_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_2_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_2_Loop_Num <=  XFFT_2_Loop_Num ; 
      else if (YFFT_Running)
           FFT_2_Loop_Num <=  YFFT_2_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_2_Loop_Num <=  ZFFT_2_Loop_Num ;      
      else   
           FFT_2_Loop_Num         <=   8'd0  ;              
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_3_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_3_Loop_Num <=  XFFT_3_Loop_Num ; 
      else if (YFFT_Running)
           FFT_3_Loop_Num <=  YFFT_3_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_3_Loop_Num <=  ZFFT_3_Loop_Num ;      
      else   
           FFT_3_Loop_Num         <=   8'd0  ;              
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_4_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_4_Loop_Num <=  XFFT_4_Loop_Num ; 
      else if (YFFT_Running)
           FFT_4_Loop_Num <=  YFFT_4_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_4_Loop_Num <=  ZFFT_4_Loop_Num ;      
      else   
           FFT_4_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_5_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_5_Loop_Num <=  XFFT_5_Loop_Num ; 
      else if (YFFT_Running)
           FFT_5_Loop_Num <=  YFFT_5_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_5_Loop_Num <=  ZFFT_5_Loop_Num ;      
      else   
           FFT_5_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_6_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_6_Loop_Num <=  XFFT_6_Loop_Num ; 
      else if (YFFT_Running)
           FFT_6_Loop_Num <=  YFFT_6_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_6_Loop_Num <=  ZFFT_6_Loop_Num ;      
      else   
           FFT_6_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_7_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_7_Loop_Num <=  XFFT_7_Loop_Num ; 
      else if (YFFT_Running)
           FFT_7_Loop_Num <=  YFFT_7_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_7_Loop_Num <=  ZFFT_7_Loop_Num ;      
      else   
           FFT_7_Loop_Num         <=   8'd0  ;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_8_Loop_Num         <=   8'd0  ;                
      else if (XFFT_Running)
           FFT_8_Loop_Num <=  XFFT_8_Loop_Num ; 
      else if (YFFT_Running)
           FFT_8_Loop_Num <=  YFFT_8_Loop_Num ; 
     else if (ZFFT_Running)
           FFT_8_Loop_Num <=  ZFFT_8_Loop_Num ;      
      else   
           FFT_8_Loop_Num         <=   8'd0  ;              
      end 

 //////////////////////////////////////////////////////////////////////////////////
 
//  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//      if (!Sys_Rst_n)    
//           FFT_1_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_1_After_tuser <=  FFT_1_data_tuser  ; 
//      end 
//   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//      if (!Sys_Rst_n)    
//           FFT_1_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_1_After_tuser <=  FFT_1_After_tuser + XFFT_1_W_Loop_Num ; 
//      end 
 
 
 
 
 
 
 
////  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
////     if (!Sys_Rst_n)    
////           FFT_1_After_tuser         <=   11'd0  ;                
////      else if (XFFT_Running)
////           FFT_1_After_tuser <=  FFT_1_data_tuser + XFFT_1_W_Loop_Num ; 
////      else if (YFFT_Running)
////           FFT_1_After_tuser <=  FFT_1_data_tuser + YFFT_1_W_Loop_Num ; 
////     else if (ZFFT_Running)
////           FFT_1_After_tuser <=  FFT_1_data_tuser + ZFFT_1_W_Loop_Num ;      
////      else   
////           FFT_1_After_tuser         <=   11'd0  ;              
////      end 

// always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_2_After_tuser        <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_2_After_tuser <=  FFT_2_data_tuser + XFFT_2_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_2_After_tuser <=  FFT_2_data_tuser + YFFT_2_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_2_After_tuser <=  FFT_2_data_tuser + ZFFT_2_W_Loop_Num ;      
//      else   
//           FFT_2_After_tuser        <=   11'd0  ;              
//      end 
      
//      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_3_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_3_After_tuser <=  FFT_3_data_tuser + XFFT_3_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_3_After_tuser <=  FFT_3_data_tuser + YFFT_3_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_3_After_tuser <=  FFT_3_data_tuser + ZFFT_3_W_Loop_Num ;      
//      else   
//           FFT_3_After_tuser         <=   11'd0  ;              
//      end 
      
//      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_4_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_4_After_tuser <=  FFT_4_data_tuser + XFFT_4_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_4_After_tuser <=  FFT_4_data_tuser + YFFT_4_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_4_After_tuser <=  FFT_4_data_tuser + ZFFT_4_W_Loop_Num ;      
//      else   
//           FFT_4_After_tuser         <=   11'd0  ;              
//      end 
      
//       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_5_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_5_After_tuser <=  FFT_5_data_tuser + XFFT_5_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_5_After_tuser <=  FFT_5_data_tuser + YFFT_5_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_5_After_tuser <=  FFT_5_data_tuser + ZFFT_5_W_Loop_Num ;      
//      else   
//           FFT_5_After_tuser         <=   11'd0  ;              
//      end 

// always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_6_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_6_After_tuser <=  FFT_6_data_tuser + XFFT_6_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_6_After_tuser <=  FFT_6_data_tuser + YFFT_6_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_6_After_tuser <=  FFT_6_data_tuser + ZFFT_6_W_Loop_Num ;      
//      else   
//           FFT_6_After_tuser        <=   11'd0  ;              
//      end 
      
//      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_7_After_tuser       <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_7_After_tuser <=  FFT_7_data_tuser + XFFT_7_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_7_After_tuser <=  FFT_7_data_tuser + YFFT_7_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_7_After_tuser <=  FFT_7_data_tuser + ZFFT_7_W_Loop_Num ;      
//      else   
//           FFT_7_After_tuser         <=   11'd0  ;              
//      end 
      
//      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_8_After_tuser         <=   11'd0  ;                
//      else if (XFFT_Running)
//           FFT_8_After_tuser <=  FFT_8_data_tuser + XFFT_8_W_Loop_Num ; 
//      else if (YFFT_Running)
//           FFT_8_After_tuser <=  FFT_8_data_tuser + YFFT_8_W_Loop_Num ; 
//     else if (ZFFT_Running)
//           FFT_8_After_tuser <=  FFT_8_data_tuser + ZFFT_8_W_Loop_Num ;      
//      else   
//           FFT_8_After_tuser        <=   11'd0  ;              
//      end 
//////////////////////////////////////////////////////////////////////////////////

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_1_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_1_Done <= FFT_1_Done;
      else  
            XFFT_1_Done <=  1'b0;
     end
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_2_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_2_Done <= FFT_2_Done;
      else  
            XFFT_2_Done <=  1'b0;
     end       
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_3_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_3_Done <=  FFT_3_Done;
      else  
            XFFT_3_Done <=  1'b0;
     end      
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_4_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_4_Done <=  FFT_4_Done;
      else  
            XFFT_4_Done <=  1'b0;
     end      
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_5_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_5_Done <=  FFT_5_Done;
      else  
            XFFT_5_Done <=  1'b0;
     end     
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_6_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_6_Done <=   FFT_6_Done;
      else  
            XFFT_6_Done <=  1'b0;
     end     
          
              
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_7_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_7_Done <= FFT_7_Done;
      else  
            XFFT_7_Done <=  1'b0;
     end           
          
               
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            XFFT_8_Done <=  1'b0;
      else if (XFFT_Running)
            XFFT_8_Done <=  FFT_8_Done;
      else  
            XFFT_8_Done <=  1'b0;
     end          
          
          
                  
//////////////////////////////////////////////////////////////////////////////////

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_1_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_1_Done <=  FFT_1_Done;
      else  
            YFFT_1_Done <=  1'b0;
     end
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_2_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_2_Done <= FFT_2_Done;
      else  
            YFFT_2_Done <=  1'b0;
     end       
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_3_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_3_Done <=  FFT_3_Done;
      else  
            YFFT_3_Done <=  1'b0;
     end      
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_4_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_4_Done <= FFT_4_Done;
      else  
            YFFT_4_Done <=  1'b0;
     end      
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_5_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_5_Done <=  FFT_5_Done;
      else  
            YFFT_5_Done <=  1'b0;
     end     
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_6_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_6_Done <=  FFT_6_Done;
      else  
            YFFT_6_Done <=  1'b0;
     end     
          
              
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_7_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_7_Done <= FFT_7_Done;
      else  
            YFFT_7_Done <=  1'b0;
     end           
          
               
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            YFFT_8_Done <=  1'b0;
      else if (YFFT_Running)
            YFFT_8_Done <=  FFT_8_Done;
      else  
            YFFT_8_Done <=  1'b0;
     end                  
          
                     
//////////////////////////////////////////////////////////////////////////////////

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_1_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_1_Done <= FFT_1_Done;
      else  
            ZFFT_1_Done <=  1'b0;
     end
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_2_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_2_Done <= FFT_2_Done;
      else  
            ZFFT_2_Done <=  1'b0;
     end       
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_3_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_3_Done <=  FFT_3_Done;
      else  
            ZFFT_3_Done <=  1'b0;
     end      
          
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_4_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_4_Done <=  FFT_4_Done;
      else  
            ZFFT_4_Done <=  1'b0;
     end      
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_5_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_5_Done <=  FFT_5_Done;
      else  
            ZFFT_5_Done <=  1'b0;
     end     
          
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_6_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_6_Done <=  FFT_6_Done;
      else  
            ZFFT_6_Done <=  1'b0;
     end     
          
              
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_7_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_7_Done <= FFT_7_Done;
      else  
            ZFFT_7_Done <=  1'b0;
     end           
          
               
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
             
    if (!Sys_Rst_n)    
            ZFFT_8_Done <=  1'b0;
      else if (ZFFT_Running)
            ZFFT_8_Done <=  FFT_8_Done;
      else  
            ZFFT_8_Done <=  1'b0;
     end               

  //////////////////////////////////////////////////////////////////////////////////

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_1_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_1_Before_en <=  XFFT_1_Before_en ; 
      else if (YFFT_Running)
           FFT_1_Before_en <=  YFFT_1_Before_en ; 
     else if (ZFFT_Running)
           FFT_1_Before_en <=  ZFFT_1_Before_en ;      
      else   
           FFT_1_Before_en         <=   1'd0  ;              
      end
      
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_2_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_2_Before_en <=  XFFT_2_Before_en ; 
      else if (YFFT_Running)
           FFT_2_Before_en <=  YFFT_2_Before_en ; 
     else if (ZFFT_Running)
           FFT_2_Before_en <=  ZFFT_2_Before_en ;      
      else   
           FFT_2_Before_en         <=   1'd0  ;              
      end   
      
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_3_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_3_Before_en <=  XFFT_3_Before_en ; 
      else if (YFFT_Running)
           FFT_3_Before_en <=  YFFT_3_Before_en ; 
     else if (ZFFT_Running)
           FFT_3_Before_en <=  ZFFT_3_Before_en ;      
      else   
           FFT_3_Before_en         <=   1'd0  ;              
      end
 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_4_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_4_Before_en <=  XFFT_4_Before_en ; 
      else if (YFFT_Running)
           FFT_4_Before_en <=  YFFT_4_Before_en ; 
     else if (ZFFT_Running)
           FFT_4_Before_en <=  ZFFT_4_Before_en ;      
      else   
           FFT_4_Before_en         <=   1'd0  ;              
      end   
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_5_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_5_Before_en <=  XFFT_5_Before_en ; 
      else if (YFFT_Running)
           FFT_5_Before_en <=  YFFT_5_Before_en ; 
     else if (ZFFT_Running)
           FFT_5_Before_en <=  ZFFT_5_Before_en ;      
      else   
           FFT_5_Before_en         <=   1'd0  ;              
      end
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_6_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_6_Before_en <=  XFFT_6_Before_en ; 
      else if (YFFT_Running)
           FFT_6_Before_en <=  YFFT_6_Before_en ; 
     else if (ZFFT_Running)
           FFT_6_Before_en <=  ZFFT_6_Before_en ;      
      else   
           FFT_6_Before_en         <=   1'd0  ;              
      end  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_7_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_7_Before_en <=  XFFT_7_Before_en ; 
      else if (YFFT_Running)
           FFT_7_Before_en <=  YFFT_7_Before_en ; 
     else if (ZFFT_Running)
           FFT_7_Before_en <=  ZFFT_7_Before_en ;      
      else   
           FFT_7_Before_en         <=   1'd0  ;              
      end
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_8_Before_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_8_Before_en <=  XFFT_8_Before_en ; 
      else if (YFFT_Running)
           FFT_8_Before_en <=  YFFT_8_Before_en ; 
     else if (ZFFT_Running)
           FFT_8_Before_en <=  ZFFT_8_Before_en ;      
      else   
           FFT_8_Before_en         <=   1'd0  ;              
      end     
      
       //////////////////////////////////////////////////////////////////////////////////

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_1_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_1_vaild_en <=  XFFT_1_vaild_en ; 
      else if (YFFT_Running)
           FFT_1_vaild_en <=  YFFT_1_vaild_en ; 
     else if (ZFFT_Running)
           FFT_1_vaild_en <=  ZFFT_1_vaild_en ;      
      else   
           FFT_1_vaild_en         <=   1'd0  ;              
      end
      
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_2_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_2_vaild_en <=  XFFT_2_vaild_en ; 
      else if (YFFT_Running)
           FFT_2_vaild_en <=  YFFT_2_vaild_en ; 
     else if (ZFFT_Running)
           FFT_2_vaild_en <=  ZFFT_2_vaild_en ;      
      else   
           FFT_2_vaild_en         <=   1'd0  ;              
      end   
      
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_3_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_3_vaild_en <=  XFFT_3_vaild_en ; 
      else if (YFFT_Running)
           FFT_3_vaild_en <=  YFFT_3_vaild_en ; 
     else if (ZFFT_Running)
           FFT_3_vaild_en <=  ZFFT_3_vaild_en ;      
      else   
           FFT_3_vaild_en         <=   1'd0  ;              
      end
 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_4_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_4_vaild_en <=  XFFT_4_vaild_en ; 
      else if (YFFT_Running)
           FFT_4_vaild_en <=  YFFT_4_vaild_en ; 
     else if (ZFFT_Running)
           FFT_4_vaild_en <=  ZFFT_4_vaild_en ;      
      else   
           FFT_4_vaild_en         <=   1'd0  ;              
      end   
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_5_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_5_vaild_en <=  XFFT_5_vaild_en ; 
      else if (YFFT_Running)
           FFT_5_vaild_en <=  YFFT_5_vaild_en ; 
     else if (ZFFT_Running)
           FFT_5_vaild_en <=  ZFFT_5_vaild_en ;      
      else   
           FFT_5_vaild_en         <=   1'd0  ;              
      end
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_6_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_6_vaild_en <=  XFFT_6_vaild_en ; 
      else if (YFFT_Running)
           FFT_6_vaild_en <=  YFFT_6_vaild_en ; 
     else if (ZFFT_Running)
           FFT_6_vaild_en <=  ZFFT_6_vaild_en ;      
      else   
           FFT_6_vaild_en         <=   1'd0  ;              
      end  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_7_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_7_vaild_en <=  XFFT_7_vaild_en ; 
      else if (YFFT_Running)
           FFT_7_vaild_en <=  YFFT_7_vaild_en ; 
     else if (ZFFT_Running)
           FFT_7_vaild_en <=  ZFFT_7_vaild_en ;      
      else   
           FFT_7_vaild_en         <=   1'd0  ;              
      end
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_8_vaild_en         <=   1'd0  ;                
      else if (XFFT_Running)
           FFT_8_vaild_en <=  XFFT_8_vaild_en ; 
      else if (YFFT_Running)
           FFT_8_vaild_en <=  YFFT_8_vaild_en ; 
      else if (ZFFT_Running)
           FFT_8_vaild_en <=  ZFFT_8_vaild_en ;      
      else   
           FFT_8_vaild_en         <=   1'd0  ;              
      end  
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_Forward         <=   1'd0  ;                
      else if (FFT_Forward_begin)
           FFT_Forward        <=      1'd1  ;  
      else if (FFT_Forward_end)
           FFT_Forward        <=   1'd0  ;  
              
      end        
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           FFT_Backward         <=   1'd0  ;                
      else if (FFT_Backward_begin)
           FFT_Backward        <=      1'd1  ;  
      else if (FFT_Backward_end)
           FFT_Backward        <=   1'd0  ;  
              
      end   
 //////////////////////////////////////////////////////////////////////////////////       
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_1_FFT_Wr_en <=  M_AXIS_1_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_1_FFT_Wr_en <=  M_AXIS_1_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_1_FFT_Wr_en <=  M_AXIS_1_ZFFT_Wr_en ;      
      else   
           M_AXIS_1_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_2_FFT_Wr_en <=  M_AXIS_2_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_2_FFT_Wr_en <=  M_AXIS_2_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_2_FFT_Wr_en <=  M_AXIS_2_ZFFT_Wr_en ;      
      else   
           M_AXIS_2_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_3_FFT_Wr_en <=  M_AXIS_3_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_3_FFT_Wr_en <=  M_AXIS_3_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_3_FFT_Wr_en <=  M_AXIS_3_ZFFT_Wr_en ;      
      else   
           M_AXIS_3_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_4_FFT_Wr_en <=  M_AXIS_4_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_4_FFT_Wr_en <=  M_AXIS_4_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_4_FFT_Wr_en <=  M_AXIS_4_ZFFT_Wr_en ;      
      else   
           M_AXIS_4_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_5_FFT_Wr_en <=  M_AXIS_5_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_5_FFT_Wr_en <=  M_AXIS_5_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_5_FFT_Wr_en <=  M_AXIS_5_ZFFT_Wr_en ;      
      else   
           M_AXIS_5_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_6_FFT_Wr_en <=  M_AXIS_6_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_6_FFT_Wr_en <=  M_AXIS_6_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_6_FFT_Wr_en <=  M_AXIS_6_ZFFT_Wr_en ;      
      else   
           M_AXIS_6_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_7_FFT_Wr_en <=  M_AXIS_7_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_7_FFT_Wr_en <=  M_AXIS_7_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_7_FFT_Wr_en <=  M_AXIS_7_ZFFT_Wr_en ;      
      else   
           M_AXIS_7_FFT_Wr_en         <=   1'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_FFT_Wr_en         <=   1'd0  ;                
      else if (XFFT_Running)
           M_AXIS_8_FFT_Wr_en <=  M_AXIS_8_XFFT_Wr_en ; 
      else if (YFFT_Running)
           M_AXIS_8_FFT_Wr_en <=  M_AXIS_8_YFFT_Wr_en ; 
     else if (ZFFT_Running)
           M_AXIS_8_FFT_Wr_en <=  M_AXIS_8_ZFFT_Wr_en ;      
      else   
           M_AXIS_8_FFT_Wr_en         <=   1'd0  ;              
      end 
  //////////////////////////////////////////////////////////////////////////////////       
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_1_FFT_Wr_addr <=  M_AXIS_1_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_1_FFT_Wr_addr <=  M_AXIS_1_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_1_FFT_Wr_addr <=  M_AXIS_1_ZFFT_Wr_addr ;      
      else   
           M_AXIS_1_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_2_FFT_Wr_addr <=  M_AXIS_2_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_2_FFT_Wr_addr <=  M_AXIS_2_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_2_FFT_Wr_addr <=  M_AXIS_2_ZFFT_Wr_addr ;      
      else   
           M_AXIS_2_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_3_FFT_Wr_addr <=  M_AXIS_3_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_3_FFT_Wr_addr <=  M_AXIS_3_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_3_FFT_Wr_addr <=  M_AXIS_3_ZFFT_Wr_addr ;      
      else   
           M_AXIS_3_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_4_FFT_Wr_addr <=  M_AXIS_4_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_4_FFT_Wr_addr <=  M_AXIS_4_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_4_FFT_Wr_addr <=  M_AXIS_4_ZFFT_Wr_addr ;      
      else   
           M_AXIS_4_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_5_FFT_Wr_addr <=  M_AXIS_5_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_5_FFT_Wr_addr <=  M_AXIS_5_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_5_FFT_Wr_addr <=  M_AXIS_5_ZFFT_Wr_addr ;      
      else   
           M_AXIS_5_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_6_FFT_Wr_addr <=  M_AXIS_6_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_6_FFT_Wr_addr <=  M_AXIS_6_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_6_FFT_Wr_addr <=  M_AXIS_6_ZFFT_Wr_addr ;      
      else   
           M_AXIS_6_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_7_FFT_Wr_addr <=  M_AXIS_7_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_7_FFT_Wr_addr <=  M_AXIS_7_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_7_FFT_Wr_addr <=  M_AXIS_7_ZFFT_Wr_addr ;      
      else   
           M_AXIS_7_FFT_Wr_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_FFT_Wr_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           M_AXIS_8_FFT_Wr_addr <=  M_AXIS_8_XFFT_Wr_addr ; 
      else if (YFFT_Running)
           M_AXIS_8_FFT_Wr_addr <=  M_AXIS_8_YFFT_Wr_addr ; 
     else if (ZFFT_Running)
           M_AXIS_8_FFT_Wr_addr <=  M_AXIS_8_ZFFT_Wr_addr ;      
      else   
           M_AXIS_8_FFT_Wr_addr         <=   16'd0  ;              
      end        
      
      //////////////////////////////////////////////////////////////////////////////////       
   
        //////////////////////////////////////////////////////////////////////////////////       
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_1_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_1_FFT_Rd_addr <=  Before_1_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_1_FFT_Rd_addr <=  Before_1_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_1_FFT_Rd_addr <=  Before_1_ZFFT_Rd_addr ;      
      else   
           Before_1_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_2_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_2_FFT_Rd_addr <=  Before_2_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_2_FFT_Rd_addr <=  Before_2_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_2_FFT_Rd_addr <=  Before_2_ZFFT_Rd_addr ;      
      else   
           Before_2_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_3_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_3_FFT_Rd_addr <=  Before_3_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_3_FFT_Rd_addr <=  Before_3_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_3_FFT_Rd_addr <=  Before_3_ZFFT_Rd_addr ;      
      else   
           Before_3_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_4_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_4_FFT_Rd_addr <=  Before_4_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_4_FFT_Rd_addr <=  Before_4_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_4_FFT_Rd_addr <=  Before_4_ZFFT_Rd_addr ;      
      else   
           Before_4_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_5_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_5_FFT_Rd_addr <=  Before_5_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_5_FFT_Rd_addr <=  Before_5_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_5_FFT_Rd_addr <=  Before_5_ZFFT_Rd_addr ;      
      else   
           Before_5_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_6_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_6_FFT_Rd_addr <=  Before_6_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_6_FFT_Rd_addr <=  Before_6_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_6_FFT_Rd_addr <=  Before_6_ZFFT_Rd_addr ;      
      else   
           Before_6_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_7_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_7_FFT_Rd_addr <=  Before_7_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_7_FFT_Rd_addr <=  Before_7_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_7_FFT_Rd_addr <=  Before_7_ZFFT_Rd_addr ;      
      else   
           Before_7_FFT_Rd_addr         <=   16'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Before_8_FFT_Rd_addr         <=   16'd0  ;                
      else if (XFFT_Running)
           Before_8_FFT_Rd_addr <=  Before_8_XFFT_Rd_addr ; 
      else if (YFFT_Running)
           Before_8_FFT_Rd_addr <=  Before_8_YFFT_Rd_addr ; 
     else if (ZFFT_Running)
           Before_8_FFT_Rd_addr <=  Before_8_ZFFT_Rd_addr ;      
      else   
           Before_8_FFT_Rd_addr         <=   16'd0  ;              
      end 
   
//       //////////////////////////////////////////////////////////////////////////////////       
    
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_1_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_1_data_tdata <=  XFFT_1_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_1_data_tdata <=  YFFT_1_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_1_data_tdata <=  ZFFT_1_data_tdata ;      
//      else   
//           FFT_1_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_2_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_2_data_tdata <=  XFFT_2_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_2_data_tdata <=  YFFT_2_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_2_data_tdata <=  ZFFT_2_data_tdata ;      
//      else   
//           FFT_2_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_3_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_3_data_tdata <=  XFFT_3_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_3_data_tdata <=  YFFT_3_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_3_data_tdata <=  ZFFT_3_data_tdata ;      
//      else   
//           FFT_3_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_4_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_4_data_tdata <=  XFFT_4_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_4_data_tdata <=  YFFT_4_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_4_data_tdata <=  ZFFT_4_data_tdata ;      
//      else   
//           FFT_4_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_5_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_5_data_tdata <=  XFFT_5_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_5_data_tdata <=  YFFT_5_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_5_data_tdata <=  ZFFT_5_data_tdata ;      
//      else   
//           FFT_5_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_6_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_6_data_tdata <=  XFFT_6_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_6_data_tdata <=  YFFT_6_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_6_data_tdata <=  ZFFT_6_data_tdata ;      
//      else   
//           FFT_6_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_7_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_7_data_tdata <=  XFFT_7_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_7_data_tdata <=  YFFT_7_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_7_data_tdata <=  ZFFT_7_data_tdata ;      
//      else   
//           FFT_7_data_tdata         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_8_data_tdata         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_8_data_tdata <=  XFFT_8_data_tdata ; 
//      else if (YFFT_Running)
//           FFT_8_data_tdata <=  YFFT_8_data_tdata ; 
//     else if (ZFFT_Running)
//           FFT_8_data_tdata <=  ZFFT_8_data_tdata ;      
//      else   
//           FFT_8_data_tdata         <=   512'd0  ;              
//      end 
//  //////////////////////////////////////////////////////////////////////////////////       
    
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_1_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_1_data_tuser <=  XFFT_1_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_1_data_tuser <=  YFFT_1_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_1_data_tuser <=  ZFFT_1_data_tuser ;      
//      else   
//           FFT_1_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_2_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_2_data_tuser <=  XFFT_2_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_2_data_tuser <=  YFFT_2_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_2_data_tuser <=  ZFFT_2_data_tuser ;      
//      else   
//           FFT_2_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_3_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_3_data_tuser <=  XFFT_3_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_3_data_tuser <=  YFFT_3_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_3_data_tuser <=  ZFFT_3_data_tuser ;      
//      else   
//           FFT_3_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_4_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_4_data_tuser <=  XFFT_4_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_4_data_tuser <=  YFFT_4_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_4_data_tuser <=  ZFFT_4_data_tuser ;      
//      else   
//           FFT_4_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_5_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_5_data_tuser <=  XFFT_5_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_5_data_tuser <=  YFFT_5_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_5_data_tuser <=  ZFFT_5_data_tuser ;      
//      else   
//           FFT_5_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_6_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_6_data_tuser <=  XFFT_6_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_6_data_tuser <=  YFFT_6_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_6_data_tuser <=  ZFFT_6_data_tuser ;      
//      else   
//           FFT_6_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_7_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_7_data_tuser <=  XFFT_7_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_7_data_tuser <=  YFFT_7_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_7_data_tuser <=  ZFFT_7_data_tuser ;      
//      else   
//           FFT_7_data_tuser         <=   512'd0  ;              
//      end 
 
//always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//     if (!Sys_Rst_n)    
//           FFT_8_data_tuser         <=   512'd0  ;                
//      else if (XFFT_Running)
//           FFT_8_data_tuser <=  XFFT_8_data_tuser ; 
//      else if (YFFT_Running)
//           FFT_8_data_tuser <=  YFFT_8_data_tuser ; 
//     else if (ZFFT_Running)
//           FFT_8_data_tuser <=  ZFFT_8_data_tuser ;      
//      else   
//           FFT_8_data_tuser         <=   512'd0  ;              
//      end     

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_1_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_1_FFT_Wr_data <=  M_AXIS_1_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_1_FFT_Wr_data <=  M_AXIS_1_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_1_FFT_Wr_data <=  M_AXIS_1_ZFFT_Wr_data ;      
      else   
           M_AXIS_1_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_2_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_2_FFT_Wr_data <=  M_AXIS_2_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_2_FFT_Wr_data <=  M_AXIS_2_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_2_FFT_Wr_data <=  M_AXIS_2_ZFFT_Wr_data ;      
      else   
           M_AXIS_2_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_3_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_3_FFT_Wr_data <=  M_AXIS_3_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_3_FFT_Wr_data <=  M_AXIS_3_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_3_FFT_Wr_data <=  M_AXIS_3_ZFFT_Wr_data ;      
      else   
           M_AXIS_3_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_4_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_4_FFT_Wr_data <=  M_AXIS_4_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_4_FFT_Wr_data <=  M_AXIS_4_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_4_FFT_Wr_data <=  M_AXIS_4_ZFFT_Wr_data ;      
      else   
           M_AXIS_4_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_5_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_5_FFT_Wr_data <=  M_AXIS_5_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_5_FFT_Wr_data <=  M_AXIS_5_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_5_FFT_Wr_data <=  M_AXIS_5_ZFFT_Wr_data ;      
      else   
           M_AXIS_5_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_6_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_6_FFT_Wr_data <=  M_AXIS_6_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_6_FFT_Wr_data <=  M_AXIS_6_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_6_FFT_Wr_data <=  M_AXIS_6_ZFFT_Wr_data ;      
      else   
           M_AXIS_6_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_7_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_7_FFT_Wr_data <=  M_AXIS_7_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_7_FFT_Wr_data <=  M_AXIS_7_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_7_FFT_Wr_data <=  M_AXIS_7_ZFFT_Wr_data ;      
      else   
           M_AXIS_7_FFT_Wr_data         <=   256'd0  ;              
      end 
 
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_8_FFT_Wr_data         <=   256'd0  ;                
      else if (XFFT_Running)
           M_AXIS_8_FFT_Wr_data <=  M_AXIS_8_XFFT_Wr_data ; 
      else if (YFFT_Running)
           M_AXIS_8_FFT_Wr_data <=  M_AXIS_8_YFFT_Wr_data ; 
     else if (ZFFT_Running)
           M_AXIS_8_FFT_Wr_data <=  M_AXIS_8_ZFFT_Wr_data ;      
      else   
           M_AXIS_8_FFT_Wr_data         <=   256'd0  ;              
      end       

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_en    <=      1'd0  ;            
      else if (XFFT_Running)
           M_AXIS_Q_Rd_en     <=      XFFT_M_AXIS_Q_Rd_en ;         
      else if (YFFT_Running)              
           M_AXIS_Q_Rd_en     <=      YFFT_M_AXIS_Q_Rd_en ;   
     else if (ZFFT_Running)               
           M_AXIS_Q_Rd_en     <=      ZFFT_M_AXIS_Q_Rd_en ;    
      else   
           M_AXIS_Q_Rd_en         <=  16'd0  ;              
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Q_Rd_addr    <=      32'd0  ;            
      else if (XFFT_Running)
           M_AXIS_Q_Rd_addr     <=      XFFT_M_AXIS_Q_Rd_addr ;         
      else if (YFFT_Running)
           M_AXIS_Q_Rd_addr     <=      YFFT_M_AXIS_Q_Rd_addr;   
     else if (ZFFT_Running)
           M_AXIS_Q_Rd_addr     <=      ZFFT_M_AXIS_Q_Rd_addr ;    
      else   
           M_AXIS_Q_Rd_addr         <=  32'd0  ;              
      end 
 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XFFT_M_AXIS_Q_Rd_data    <=      64'd0  ;            
      else if (XFFT_Running)
            XFFT_M_AXIS_Q_Rd_data     <=      M_AXIS_Q_Rd_data ;         
       else   
            XFFT_M_AXIS_Q_Rd_data         <=  64'd0  ;              
      end  
 
 
 
//////////////////////////////////////////////////////////////////////////////////         
  
 diver_FFT U_diver_1_FFT(
. Sys_Clk                 ( Sys_Clk               )    , 
. Sys_Rst_n               ( Sys_Rst_n             )    , 
. Before_Data_FFT         ( Before_Data_1_FFT     )    ,
. fft_m_data_tdata        ( FFT_1_data_tdata      )    ,
. fft_m_data_tvalid       ( FFT_1_data_tvalid     )    ,
. fft_m_data_tuser        ( FFT_1_data_tuser      )    ,
. FFT_Done                ( FFT_1_Done            )    ,
. FFT_Before_en           ( FFT_1_Before_en       )    ,
. FFT_Forward             ( FFT_Forward           )    , 
. FFT_Backward            ( FFT_Backward          )    
    
    );
    
 diver_FFT U_diver_2_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
//. FFT_vaild_en             (FFT_2_vaild_en    ),  
//. FFT_Loop_Num            (FFT_2_Loop_Num   )    ,
. Before_Data_FFT         (Before_Data_2_FFT)    ,
. fft_m_data_tdata         (FFT_2_data_tdata )    ,
. fft_m_data_tvalid       (FFT_2_data_tvalid),
. fft_m_data_tuser        (FFT_2_data_tuser ),
. FFT_Done                 (FFT_2_Done              )    ,
. FFT_Before_en            (FFT_2_Before_en         )   ,
. FFT_Forward             ( FFT_Forward  ) ,  
. FFT_Backward            ( FFT_Backward )      
    );
 
 diver_FFT U_diver_3_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
. Before_Data_FFT         (Before_Data_3_FFT)    ,
. fft_m_data_tdata        (FFT_3_data_tdata )    ,
. fft_m_data_tvalid       (FFT_3_data_tvalid),
. fft_m_data_tuser        (FFT_3_data_tuser ),
. FFT_Done                (FFT_3_Done            )    ,
. FFT_Before_en           (FFT_3_Before_en       )    ,
. FFT_Forward             ( FFT_Forward  ) ,  
. FFT_Backward            ( FFT_Backward )      
    );
    
     diver_FFT U_diver_4_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
. Before_Data_FFT         (Before_Data_4_FFT)    ,
. fft_m_data_tdata        (FFT_4_data_tdata )    ,
. fft_m_data_tvalid       (FFT_4_data_tvalid),
. fft_m_data_tuser        (FFT_4_data_tuser ),
. FFT_Done                (FFT_4_Done            )    ,
. FFT_Before_en           (FFT_4_Before_en       )   ,
.  FFT_Forward            ( FFT_Forward  ) ,  
.  FFT_Backward           ( FFT_Backward )      
    );
     diver_FFT U_diver_5_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
. Before_Data_FFT         (Before_Data_5_FFT)    ,
. fft_m_data_tdata        (FFT_5_data_tdata )    ,
. fft_m_data_tvalid       (FFT_5_data_tvalid),
. fft_m_data_tuser        (FFT_5_data_tuser ),
. FFT_Done                (FFT_5_Done             )    ,
. FFT_Before_en           (FFT_5_Before_en        )    ,
.  FFT_Forward            ( FFT_Forward  ) ,  
.  FFT_Backward           ( FFT_Backward )      
    );
    
    diver_FFT U_diver_6_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
. Before_Data_FFT         (Before_Data_6_FFT)    ,
. fft_m_data_tdata        (FFT_6_data_tdata )    ,
. fft_m_data_tvalid       (FFT_6_data_tvalid),
. fft_m_data_tuser        (FFT_6_data_tuser ),
. FFT_Done                (FFT_6_Done            )    ,
. FFT_Before_en           (FFT_6_Before_en       )   ,
.  FFT_Forward            ( FFT_Forward     ) ,  
.  FFT_Backward           ( FFT_Backward    )      
    );
    
    diver_FFT U_diver_7_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    ,       
. Before_Data_FFT         (Before_Data_7_FFT)    ,
. fft_m_data_tdata        (FFT_7_data_tdata )    ,
. fft_m_data_tvalid       (FFT_7_data_tvalid),
. fft_m_data_tuser        (FFT_7_data_tuser ),
. FFT_Done                (FFT_7_Done             )    ,
. FFT_Before_en           (FFT_7_Before_en        )    ,
.  FFT_Forward            ( FFT_Forward     ) ,  
.  FFT_Backward           ( FFT_Backward    )      
    );
    
    diver_FFT U_diver_8_FFT(
. Sys_Clk                 (Sys_Clk         )    , 
. Sys_Rst_n               (Sys_Rst_n       )    , 
. Before_Data_FFT         (Before_Data_8_FFT)    ,
. fft_m_data_tdata        (FFT_8_data_tdata )    ,
. fft_m_data_tvalid       (FFT_8_data_tvalid),
. fft_m_data_tuser        (FFT_8_data_tuser ),
. FFT_Done                (FFT_8_Done             )    ,
. FFT_Before_en           (FFT_8_Before_en        )    ,
. FFT_Forward             ( FFT_Forward     ) ,  
. FFT_Backward            ( FFT_Backward    )      
    );
  
  
  
  
 ////////////////////////////////////////////////////////////////////////////////
// RAM  FROM RAM_Q TO 8 FFT IP CORE, EACH ONE CONTAIN 8 CHANNELS              //
////////////////////////////////////////////////////////////////////////////////
    
    Bram_256_32_8  U_Before_1_FFT_Bram (
  .clka(Sys_Clk),        // input wire clka
  .ena( Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_1_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_1_FFT_Wr_addr),    // input wire [7 : 0] addra
  .dina (M_AXIS_1_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),       // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_1_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_1_FFT)  // output wire [511 : 0] doutb
  );             
    
  Bram_256_32_8 U_Before_2_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_2_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_2_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_2_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_2_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_2_FFT)  // output wire [511 : 0] doutb
  );  
    
   Bram_256_32_8 U_Before_3_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_3_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_3_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_3_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_3_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_3_FFT)  // output wire [511 : 0] doutb
  );     
    
   Bram_256_32_8 U_Before_4_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_4_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_4_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_4_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_4_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_4_FFT)  // output wire [511 : 0] doutb
   );    
    
   Bram_256_32_8 U_Before_5_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_5_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_5_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_5_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_5_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_5_FFT)  // output wire [511 : 0] doutb
);        
    
   Bram_256_32_8 U_Before_6_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_6_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_6_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_6_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_6_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_6_FFT)  // output wire [511 : 0] doutb
);   

   Bram_256_32_8 U_Before_7_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_7_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_7_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_7_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_7_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_7_FFT)  // output wire [511 : 0] doutb
);   

    Bram_256_32_8 U_Before_8_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (M_AXIS_8_FFT_Wr_en),      // input wire [0 : 0] wea
  .addra(M_AXIS_8_FFT_Wr_addr),  // input wire [7 : 0] addra
  .dina (M_AXIS_8_FFT_Wr_data),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(Before_8_FFT_Rd_addr),  // input wire [7 : 0] addrb
  .doutb(Before_Data_8_FFT   )  // output wire [511 : 0] doutb
); 

////////////////////////////////////////////////////////////////////////////////
// RAM  X DIRICTION AFTER FFT TRANSFORM                                       //
////////////////////////////////////////////////////////////////////////////////

  Bram_256_32_8 U_after_1_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena( Sys_Rst_n),      // input wire ena
  .wea  (FFT_1_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_1_W_Loop_Num[11:6],FFT_1_data_tuser[5:0] }),  // input wire [7 : 0] addra
  .dina (FFT_1_data_tdata ),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),        // input wire clkb
  .enb (Sys_Rst_n),      // input wire enb
  .addrb(  After_1_FFT_R_addr  ),  // input wire [7 : 0] addrb
  .doutb(  After_1_FFT_R_data  )  // output wire [511 : 0] doutb
  );             
    
  Bram_256_32_8 U_after_2_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_2_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_2_W_Loop_Num[11:6],FFT_2_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_2_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb (Sys_Rst_n),      // input wire enb
  .addrb( After_2_FFT_R_addr   ),  // input wire [7 : 0] addrb
  .doutb( After_2_FFT_R_data   )  // output wire [511 : 0] doutb
  );  
    
   Bram_256_32_8 U_after_3_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_3_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_3_W_Loop_Num[11:6],FFT_3_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_3_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb( After_3_FFT_R_addr  ),  // input wire [7 : 0] addrb
  .doutb( After_3_FFT_R_data  )  // output wire [511 : 0] doutb
  );     
    
   Bram_256_32_8 U_after_4_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_4_data_tvalid) ,      // input wire [0 : 0] wea
  .addra({XFFT_4_W_Loop_Num[11:6],FFT_4_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_4_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb( After_4_FFT_R_addr   ),  // input wire [7 : 0] addrb
  .doutb( After_4_FFT_R_data   )  // output wire [511 : 0] doutb
   );    
    
   Bram_256_32_8 U_after_5_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_5_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_5_W_Loop_Num[11:6],FFT_5_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_5_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(  After_5_FFT_R_addr  ),  // input wire [7 : 0] addrb
  .doutb(  After_5_FFT_R_data  )  // output wire [511 : 0] doutb
);        
    
   Bram_256_32_8 U_after_6_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_6_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_6_W_Loop_Num[11:6],FFT_6_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_6_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(  After_6_FFT_R_addr  ),  // input wire [7 : 0] addrb
  .doutb(  After_6_FFT_R_data  )  // output wire [511 : 0] doutb
);   

   Bram_256_32_8 U_after_7_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_7_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_7_W_Loop_Num[11:6],FFT_7_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_7_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(  After_7_FFT_R_addr  ),  // input wire [7 : 0] addrb
  .doutb(  After_7_FFT_R_data  )  // output wire [511 : 0] doutb
);   

    Bram_256_32_8 U_after_8_FFT_Bram (
  .clka(Sys_Clk),    // input wire clka
  .ena(Sys_Rst_n),      // input wire ena
  .wea  (FFT_8_data_tvalid),      // input wire [0 : 0] wea
  .addra({XFFT_8_W_Loop_Num[11:6],FFT_8_data_tuser[5:0] } ),  // input wire [7 : 0] addra
  .dina (FFT_8_data_tdata),    // input wire [511 : 0] dina
  .clkb(Sys_Clk),    // input wire clkb
  .enb(Sys_Rst_n),      // input wire enb
  .addrb(  After_8_FFT_R_addr    ),  // input wire [7 : 0] addrb
  .doutb(  After_8_FFT_R_data  )  // output wire [511 : 0] doutb
);  
  

  
       
endmodule