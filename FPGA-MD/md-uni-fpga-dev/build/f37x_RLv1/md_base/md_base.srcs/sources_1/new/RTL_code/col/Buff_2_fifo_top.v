`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 06:54:40 PM
// Design Name: 
// Module Name: Buff_2_fifo_top
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


module Buff_2_fifo_top(
      input                             Sys_Clk              ,
      input                             Sys_Rst_n            ,
      input                             Subcell_pass_done    ,  
      input                             work_en,
      
      output         wire               Update_ALL_Force_Ram_done           , 
      input                             Home0_cell_cal_finish,
      
      input         [11:0]              Home0_Ptcal_Num ,
      input         [11:0]              Home1_Ptcal_Num ,
      input         [11:0]              Nei1_Ptcal_Num  ,
      input         [11:0]              Nei2_Ptcal_Num  ,
      input         [11:0]              Nei3_Ptcal_Num  ,
      input         [11:0]              Nei4_Ptcal_Num  ,   
      input         [11:0]              Nei5_Ptcal_Num  ,  
      input         [11:0]              Nei6_Ptcal_Num  ,
      input         [11:0]              Nei7_Ptcal_Num  ,            
      input         [11:0]              Nei8_Ptcal_Num  ,           
      input         [11:0]              Nei9_Ptcal_Num  ,            
      input         [11:0]              Nei10_Ptcal_Num ,
      input         [11:0]              Nei11_Ptcal_Num ,
      input         [11:0]              Nei12_Ptcal_Num ,
      input         [11:0]              Nei13_Ptcal_Num ,

      input         [255:0]             M_AXIS_LJ_EnE_Force1 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force2 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force3 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force4 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force5 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force6 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force7 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force8 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force9 ,
      input         [255:0]             M_AXIS_LJ_EnE_Force10,
      input         [255:0]             M_AXIS_LJ_EnE_Force11,
      input         [255:0]             M_AXIS_LJ_EnE_Force12,
      input         [255:0]             M_AXIS_LJ_EnE_Force13,
      input         [255:0]             M_AXIS_LJ_EnE_Force14,
                 
      input                             S_AXIS_update_One_Done1,
      input                             S_AXIS_update_One_Done2,
      input                             S_AXIS_update_One_Done3,
      input                             S_AXIS_update_One_Done4,
      input                             S_AXIS_update_One_Done5,
      input                             S_AXIS_update_One_Done6,
      input                             S_AXIS_update_One_Done7,
      input                             S_AXIS_update_One_Done8,
      input                             S_AXIS_update_One_Done9,
      input                             S_AXIS_update_One_Done10,
      input                             S_AXIS_update_One_Done11,
      input                             S_AXIS_update_One_Done12,
      input                             S_AXIS_update_One_Done13,
      input                             S_AXIS_update_One_Done14, 
      
      output  wire                      M_AXIS_Update_ram_wr_en   ,
      output  wire         [15:0]       M_AXIS_Update_cnt         ,
      output  wire         [255:0]      M_AXIS_Update_ram_rd_data 

    );   

 wire                      M_AXIS_home1_wr_en     ;
 wire    [255:0]           M_AXIS_home1_wr_data   ;
 wire    [9:0]             M_AXIS_home1_ram_addr  ;
                                        
 wire                      M_AXIS_Nei1_wr_en      ;
 wire    [255:0]           M_AXIS_Nei1_wr_data    ;
 wire    [9:0]             M_AXIS_Nei1_ram_addr   ;

 wire                      M_AXIS_Nei2_wr_en      ;
 wire    [255:0]           M_AXIS_Nei2_wr_data    ;
 wire    [9:0]             M_AXIS_Nei2_ram_addr   ;
 
 wire                      M_AXIS_Nei3_wr_en      ;
wire    [255:0]           M_AXIS_Nei3_wr_data    ;
wire    [9:0]             M_AXIS_Nei3_ram_addr   ;
 
 wire                      M_AXIS_Nei4_wr_en      ;
 wire    [255:0]           M_AXIS_Nei4_wr_data    ;
 wire    [9:0]             M_AXIS_Nei4_ram_addr   ;
 
 wire                      M_AXIS_Nei5_wr_en      ;
 wire    [255:0]           M_AXIS_Nei5_wr_data    ;
 wire    [9:0]             M_AXIS_Nei5_ram_addr   ;
 
 wire                      M_AXIS_Nei6_wr_en      ;
 wire    [255:0]           M_AXIS_Nei6_wr_data    ;
 wire    [9:0]             M_AXIS_Nei6_ram_addr   ;
 
 wire                      M_AXIS_Nei7_wr_en      ;
 wire    [255:0]           M_AXIS_Nei7_wr_data    ;
 wire    [9:0]             M_AXIS_Nei7_ram_addr   ;
 
 wire                      M_AXIS_Nei8_wr_en      ;
 wire    [255:0]           M_AXIS_Nei8_wr_data    ;
 wire    [9:0]             M_AXIS_Nei8_ram_addr   ;
 
 wire                      M_AXIS_Nei9_wr_en      ;
 wire    [255:0]           M_AXIS_Nei9_wr_data    ;
 wire    [9:0]             M_AXIS_Nei9_ram_addr   ;
 
 wire                      M_AXIS_Nei10_wr_en      ;
 wire    [255:0]           M_AXIS_Nei10_wr_data    ;
 wire    [9:0]             M_AXIS_Nei10_ram_addr   ;
 
 wire                      M_AXIS_Nei11_wr_en      ;
 wire    [255:0]           M_AXIS_Nei11_wr_data    ;
 wire    [9:0]             M_AXIS_Nei11_ram_addr   ;  
 
 wire                      M_AXIS_Nei12_wr_en      ;
 wire    [255:0]           M_AXIS_Nei12_wr_data    ;
 wire    [9:0]             M_AXIS_Nei12_ram_addr   ; 

 wire                      M_AXIS_Nei13_wr_en      ;
(*syn_keep="true", mark_debug="true"*)  wire    [255:0]           M_AXIS_Nei13_wr_data    ;
 (*syn_keep="true", mark_debug="true"*) wire    [9:0]             M_AXIS_Nei13_ram_addr   ; 
  
 wire    [9:0]             S_AXIS_Update_Home1_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Home1_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei1_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei1_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei2_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei2_rd_data ;

wire    [9:0]             S_AXIS_Update_Nei3_Rd_addr ;
wire    [255:0]           S_AXIS_Update_Nei3_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei4_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei4_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei5_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei5_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei6_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei6_rd_data ;

 wire    [9:0]             S_AXIS_Update_Nei7_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei7_rd_data ;
 
 wire    [9:0]             S_AXIS_Update_Nei8_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei8_rd_data ;
 
 wire    [9:0]             S_AXIS_Update_Nei9_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei9_rd_data ;
 
 wire    [9:0]             S_AXIS_Update_Nei10_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei10_rd_data ;
 
 wire    [9:0]             S_AXIS_Update_Nei11_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei11_rd_data ;
 
 wire    [9:0]             S_AXIS_Update_Nei12_Rd_addr ;
 wire    [255:0]           S_AXIS_Update_Nei12_rd_data ;
 
(*syn_keep="true", mark_debug="true"*)  wire    [9:0]             S_AXIS_Update_Nei13_Rd_addr ;
 (*syn_keep="true", mark_debug="true"*) wire    [255:0]           S_AXIS_Update_Nei13_rd_data ;
 
 //ram for subcell module
 Bram_mem_cell U_Bram_update_Home1_cell(
     .   clka (Sys_Clk),               
     .   ena  (Sys_Rst_n),              
     .   wea  ( M_AXIS_home1_wr_en     ),              
     .   addra( M_AXIS_home1_ram_addr  ),          
     .   dina ( M_AXIS_home1_wr_data  ),            
     .   clkb (Sys_Clk),               
     .   enb  (Sys_Rst_n),     
     .   addrb(S_AXIS_Update_Home1_Rd_addr ), 
     .   doutb(S_AXIS_Update_Home1_rd_data )  
);
 
  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei1_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei1_wr_en     ),              
     .   addra(  M_AXIS_Nei1_ram_addr ),          
     .   dina (  M_AXIS_Nei1_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei1_Rd_addr  ), 
     .   doutb( S_AXIS_Update_Nei1_rd_data  )  
);
     
  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei2_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei2_wr_en     ),              
     .   addra(  M_AXIS_Nei2_ram_addr ),          
     .   dina (  M_AXIS_Nei2_wr_data ),            
     .   clkb (  Sys_Clk),               
     .   enb  (  Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei2_Rd_addr), 
     .   doutb( S_AXIS_Update_Nei2_rd_data)  
);     

  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei3_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei3_wr_en     ),              
     .   addra(  M_AXIS_Nei3_ram_addr ),          
     .   dina (  M_AXIS_Nei3_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei3_Rd_addr ), 
     .   doutb( S_AXIS_Update_Nei3_rd_data )  
);     
        
  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei4_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei4_wr_en     ),              
     .   addra(  M_AXIS_Nei4_ram_addr ),          
     .   dina (  M_AXIS_Nei4_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(   Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei4_Rd_addr ), 
     .   doutb( S_AXIS_Update_Nei4_rd_data )  
);     
        
  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei5_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei5_wr_en     ),              
     .   addra(  M_AXIS_Nei5_ram_addr ),          
     .   dina (  M_AXIS_Nei5_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei5_Rd_addr  ), 
     .   doutb( S_AXIS_Update_Nei5_rd_data  )  
);            
  //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei6_cell(
     .   clka (  Sys_Clk),               
     .   ena  (  Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei6_wr_en     ),              
     .   addra(  M_AXIS_Nei6_ram_addr ),          
     .   dina (  M_AXIS_Nei6_wr_data ),            
     .   clkb (  Sys_Clk),               
     .   enb  (  Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei6_Rd_addr  ), 
     .   doutb(  S_AXIS_Update_Nei6_rd_data  )  
);            
    
   //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei7_cell(
     .   clka(Sys_Clk),               
     .   ena (  Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei7_wr_en     ),              
     .   addra(  M_AXIS_Nei7_ram_addr ),          
     .   dina (  M_AXIS_Nei7_wr_data ),            
     .   clkb  (Sys_Clk),               
     .   enb  (Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei7_Rd_addr  ), 
     .   doutb(  S_AXIS_Update_Nei7_rd_data  )  
);            
   
   
     //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei8_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei8_wr_en     ),              
     .   addra(  M_AXIS_Nei8_ram_addr  ),          
     .   dina (  M_AXIS_Nei8_wr_data   ),            
     .   clkb (  Sys_Clk),               
     .   enb  (  Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei8_Rd_addr), 
     .   doutb( S_AXIS_Update_Nei8_rd_data)  
);            
    
  
    //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei9_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei9_wr_en     ),              
     .   addra(  M_AXIS_Nei9_ram_addr ),          
     .   dina (  M_AXIS_Nei9_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei9_Rd_addr  ), 
     .   doutb(  S_AXIS_Update_Nei9_rd_data  )  
);            
   
    //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei10_cell(
     .   clka(  Sys_Clk),               
     .   ena (  Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei10_wr_en     ),              
     .   addra(  M_AXIS_Nei10_ram_addr ),          
     .   dina (  M_AXIS_Nei10_wr_data ),            
     .   clkb(   Sys_Clk),               
     .   enb (   Sys_Rst_n),     
     .   addrb( S_AXIS_Update_Nei10_Rd_addr ), 
     .   doutb( S_AXIS_Update_Nei10_rd_data )  
);            
   

    //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei11_cell(
     .   clka(   Sys_Clk),               
     .   ena (   Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei11_wr_en     ),              
     .   addra(  M_AXIS_Nei11_ram_addr ),          
     .   dina (  M_AXIS_Nei11_wr_data ),            
     .   clkb ( Sys_Clk),               
     .   enb  ( Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei11_Rd_addr), 
     .   doutb(  S_AXIS_Update_Nei11_rd_data)  
);            
   
    //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei12_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei12_wr_en     ),              
     .   addra(  M_AXIS_Nei12_ram_addr ),          
     .   dina (  M_AXIS_Nei12_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei12_Rd_addr ), 
     .   doutb(  S_AXIS_Update_Nei12_rd_data )  
); 
 
     //ram for subcell module
 Bram_mem_cell U_Bram_update_Nei13_cell(
     .   clka(  Sys_Clk),               
     .   ena(  Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei13_wr_en     ),              
     .   addra(  M_AXIS_Nei13_ram_addr ),          
     .   dina (  M_AXIS_Nei13_wr_data ),            
     .   clkb(  Sys_Clk),               
     .   enb(  Sys_Rst_n),     
     .   addrb(  S_AXIS_Update_Nei13_Rd_addr  ), 
     .   doutb(  S_AXIS_Update_Nei13_rd_data  )  
); 
       
           
 Buff_2_Fifo U_Buff_2_Fifo(
        .  Sys_Clk                    ( Sys_Clk                )   ,
        .  Sys_Rst_n                  ( Sys_Rst_n              )   ,
        .  Subcell_pass_done          ( Subcell_pass_done      )   ,
        .   work_en                   (work_en),
        
        .  Home0_Ptcal_Num            (   Home0_Ptcal_Num      ),
        .  Home1_Ptcal_Num            (   Home1_Ptcal_Num      ),
        .  Nei1_Ptcal_Num             (   Nei1_Ptcal_Num       ),
        .  Nei2_Ptcal_Num             (   Nei2_Ptcal_Num       ),
        .  Nei3_Ptcal_Num             (   Nei3_Ptcal_Num       ),
        .  Nei4_Ptcal_Num             (   Nei4_Ptcal_Num       ),
        .  Nei5_Ptcal_Num             (   Nei5_Ptcal_Num       ),
        .  Nei6_Ptcal_Num             (   Nei6_Ptcal_Num       ),
        .  Nei7_Ptcal_Num             (   Nei7_Ptcal_Num       ),
        .  Nei8_Ptcal_Num             (   Nei8_Ptcal_Num       ),
        .  Nei9_Ptcal_Num             (   Nei9_Ptcal_Num       ),
        .  Nei10_Ptcal_Num            (   Nei10_Ptcal_Num      ),
        .  Nei11_Ptcal_Num            (   Nei11_Ptcal_Num      ),
        .  Nei12_Ptcal_Num            (   Nei12_Ptcal_Num      ),
        .  Nei13_Ptcal_Num            (   Nei13_Ptcal_Num      ),
         
        .  Update_ALL_Force_Ram_done   (  Update_ALL_Force_Ram_done           ),
       .   Home0_cell_cal_finish   (  Home0_cell_cal_finish           ),
      
        . M_AXIS_LJ_EnE_Force1        ( M_AXIS_LJ_EnE_Force1    )   ,
        . M_AXIS_LJ_EnE_Force2        ( M_AXIS_LJ_EnE_Force2    )   ,
        . M_AXIS_LJ_EnE_Force3        ( M_AXIS_LJ_EnE_Force3    )   ,
        . M_AXIS_LJ_EnE_Force4        ( M_AXIS_LJ_EnE_Force4    )   ,
        . M_AXIS_LJ_EnE_Force5        ( M_AXIS_LJ_EnE_Force5    )   ,
        . M_AXIS_LJ_EnE_Force6        ( M_AXIS_LJ_EnE_Force6    )   ,
        . M_AXIS_LJ_EnE_Force7        ( M_AXIS_LJ_EnE_Force7    )   ,
        . M_AXIS_LJ_EnE_Force8        ( M_AXIS_LJ_EnE_Force8    )   ,
        . M_AXIS_LJ_EnE_Force9        ( M_AXIS_LJ_EnE_Force9    )   ,
        . M_AXIS_LJ_EnE_Force10       ( M_AXIS_LJ_EnE_Force10   )   ,
        . M_AXIS_LJ_EnE_Force11       ( M_AXIS_LJ_EnE_Force11   )   ,
        . M_AXIS_LJ_EnE_Force12       ( M_AXIS_LJ_EnE_Force12   )   ,
        . M_AXIS_LJ_EnE_Force13       ( M_AXIS_LJ_EnE_Force13   )   ,
        . M_AXIS_LJ_EnE_Force14       ( M_AXIS_LJ_EnE_Force14   )   ,
 
       
        . S_AXIS_update_One_Done1     ( S_AXIS_update_One_Done1 ),
        . S_AXIS_update_One_Done2     ( S_AXIS_update_One_Done2 ),
        . S_AXIS_update_One_Done3     ( S_AXIS_update_One_Done3 ),
        . S_AXIS_update_One_Done4     ( S_AXIS_update_One_Done4 ),
        . S_AXIS_update_One_Done5     ( S_AXIS_update_One_Done5 ),
        . S_AXIS_update_One_Done6     ( S_AXIS_update_One_Done6 ),
        . S_AXIS_update_One_Done7     ( S_AXIS_update_One_Done7 ),
        . S_AXIS_update_One_Done8     ( S_AXIS_update_One_Done8 ),
        . S_AXIS_update_One_Done9     ( S_AXIS_update_One_Done9 ),
        . S_AXIS_update_One_Done10    ( S_AXIS_update_One_Done10),
        . S_AXIS_update_One_Done11    ( S_AXIS_update_One_Done11),
        . S_AXIS_update_One_Done12    ( S_AXIS_update_One_Done12),
        . S_AXIS_update_One_Done13    ( S_AXIS_update_One_Done13),
        . S_AXIS_update_One_Done14    ( S_AXIS_update_One_Done14),
                    
        . M_AXIS_Home1_wr_en          ( M_AXIS_home1_wr_en      )    , 
        . M_AXIS_Home1_wr_data        ( M_AXIS_home1_wr_data    )    , 
        . M_AXIS_Home1_ram_addr       ( M_AXIS_home1_ram_addr   )    , 
       
        . M_AXIS_Nei1_wr_en           ( M_AXIS_Nei1_wr_en       )   , 
        . M_AXIS_Nei1_wr_data         ( M_AXIS_Nei1_wr_data     )   , 
        . M_AXIS_Nei1_ram_addr        ( M_AXIS_Nei1_ram_addr    )   , 
      
        . M_AXIS_Nei2_wr_en           ( M_AXIS_Nei2_wr_en       )   ,  
        . M_AXIS_Nei2_wr_data         ( M_AXIS_Nei2_wr_data     )   , 
        . M_AXIS_Nei2_ram_addr        ( M_AXIS_Nei2_ram_addr    )   ,      
       
        . M_AXIS_Nei3_wr_en           ( M_AXIS_Nei3_wr_en       )   ,  
        . M_AXIS_Nei3_wr_data         ( M_AXIS_Nei3_wr_data     )   , 
        . M_AXIS_Nei3_ram_addr        ( M_AXIS_Nei3_ram_addr    )   ,     
        
        . M_AXIS_Nei4_wr_en           ( M_AXIS_Nei4_wr_en       ) ,  
        . M_AXIS_Nei4_wr_data         ( M_AXIS_Nei4_wr_data     ) , 
        . M_AXIS_Nei4_ram_addr        ( M_AXIS_Nei4_ram_addr    )  ,      
     
        . M_AXIS_Nei5_wr_en           ( M_AXIS_Nei5_wr_en       ) ,  
        . M_AXIS_Nei5_wr_data         ( M_AXIS_Nei5_wr_data     ) , 
        . M_AXIS_Nei5_ram_addr        ( M_AXIS_Nei5_ram_addr    )  ,     
      
        . M_AXIS_Nei6_wr_en           ( M_AXIS_Nei6_wr_en       ) ,  
        . M_AXIS_Nei6_wr_data         ( M_AXIS_Nei6_wr_data     ) , 
        . M_AXIS_Nei6_ram_addr        ( M_AXIS_Nei6_ram_addr    )  ,   
       
        . M_AXIS_Nei7_wr_en           ( M_AXIS_Nei7_wr_en       ) ,  
        . M_AXIS_Nei7_wr_data         ( M_AXIS_Nei7_wr_data     ) , 
        . M_AXIS_Nei7_ram_addr        ( M_AXIS_Nei7_ram_addr    )  ,      
        
        . M_AXIS_Nei8_wr_en           ( M_AXIS_Nei8_wr_en       ) ,  
        . M_AXIS_Nei8_wr_data         ( M_AXIS_Nei8_wr_data     ) , 
        . M_AXIS_Nei8_ram_addr        ( M_AXIS_Nei8_ram_addr    )  ,     
       
        . M_AXIS_Nei9_wr_en           ( M_AXIS_Nei9_wr_en       ) ,  
        . M_AXIS_Nei9_wr_data         ( M_AXIS_Nei9_wr_data     ) , 
        . M_AXIS_Nei9_ram_addr        ( M_AXIS_Nei9_ram_addr    )  ,    
       
        . M_AXIS_Nei10_wr_en          ( M_AXIS_Nei10_wr_en      )  ,  
        . M_AXIS_Nei10_wr_data        ( M_AXIS_Nei10_wr_data    )  , 
        . M_AXIS_Nei10_ram_addr       ( M_AXIS_Nei10_ram_addr   )   ,          
        
        . M_AXIS_Nei11_wr_en          ( M_AXIS_Nei11_wr_en      )  ,  
        . M_AXIS_Nei11_wr_data        ( M_AXIS_Nei11_wr_data    )  , 
        . M_AXIS_Nei11_ram_addr       ( M_AXIS_Nei11_ram_addr   )   ,     
     
        . M_AXIS_Nei12_wr_en          ( M_AXIS_Nei12_wr_en      )  ,  
        . M_AXIS_Nei12_wr_data        ( M_AXIS_Nei12_wr_data    )  , 
        . M_AXIS_Nei12_ram_addr       ( M_AXIS_Nei12_ram_addr   )  ,           
        
        . M_AXIS_Nei13_wr_en          ( M_AXIS_Nei13_wr_en      )  ,  
        . M_AXIS_Nei13_wr_data        ( M_AXIS_Nei13_wr_data    )  , 
        . M_AXIS_Nei13_ram_addr       ( M_AXIS_Nei13_ram_addr   )   ,
        
        . M_AXIS_Update_ram_wr_en     ( M_AXIS_Update_ram_wr_en  )  ,
        . M_AXIS_Update_cnt           ( M_AXIS_Update_cnt        )  ,
        . M_AXIS_Update_ram_rd_data   ( M_AXIS_Update_ram_rd_data)  ,                
        
        . S_AXIS_Update_Home1_Rd_addr ( S_AXIS_Update_Home1_Rd_addr)  ,
        . S_AXIS_Update_Home1_rd_data ( S_AXIS_Update_Home1_rd_data)  ,
        
        . S_AXIS_Update_Nei1_Rd_addr  ( S_AXIS_Update_Nei1_Rd_addr )  ,
        . S_AXIS_Update_Nei1_rd_data  ( S_AXIS_Update_Nei1_rd_data )  ,
        
        . S_AXIS_Update_Nei2_Rd_addr  ( S_AXIS_Update_Nei2_Rd_addr )  ,
        . S_AXIS_Update_Nei2_rd_data  ( S_AXIS_Update_Nei2_rd_data )  ,
        
        . S_AXIS_Update_Nei3_Rd_addr  ( S_AXIS_Update_Nei3_Rd_addr )  ,
        . S_AXIS_Update_Nei3_rd_data  ( S_AXIS_Update_Nei3_rd_data )  ,
        
        . S_AXIS_Update_Nei4_Rd_addr  ( S_AXIS_Update_Nei4_Rd_addr )  ,
        . S_AXIS_Update_Nei4_rd_data  ( S_AXIS_Update_Nei4_rd_data )  ,
        
        . S_AXIS_Update_Nei5_Rd_addr  ( S_AXIS_Update_Nei5_Rd_addr )  ,
        . S_AXIS_Update_Nei5_rd_data  ( S_AXIS_Update_Nei5_rd_data )  ,
        
        . S_AXIS_Update_Nei6_Rd_addr  ( S_AXIS_Update_Nei6_Rd_addr )  ,
        . S_AXIS_Update_Nei6_rd_data  ( S_AXIS_Update_Nei6_rd_data )  ,
        
        . S_AXIS_Update_Nei7_Rd_addr  ( S_AXIS_Update_Nei7_Rd_addr )  ,
        . S_AXIS_Update_Nei7_rd_data  ( S_AXIS_Update_Nei7_rd_data )  ,
        
        . S_AXIS_Update_Nei8_Rd_addr  ( S_AXIS_Update_Nei8_Rd_addr )  ,
        . S_AXIS_Update_Nei8_rd_data  ( S_AXIS_Update_Nei8_rd_data )  ,
        
        . S_AXIS_Update_Nei9_Rd_addr  ( S_AXIS_Update_Nei9_Rd_addr )  ,
        . S_AXIS_Update_Nei9_rd_data  ( S_AXIS_Update_Nei9_rd_data )  ,
        
        . S_AXIS_Update_Nei10_Rd_addr ( S_AXIS_Update_Nei10_Rd_addr)  ,
        . S_AXIS_Update_Nei10_rd_data ( S_AXIS_Update_Nei10_rd_data)  ,
        
        . S_AXIS_Update_Nei11_Rd_addr ( S_AXIS_Update_Nei11_Rd_addr)  ,
        . S_AXIS_Update_Nei11_rd_data ( S_AXIS_Update_Nei11_rd_data)  ,
        
        . S_AXIS_Update_Nei12_Rd_addr ( S_AXIS_Update_Nei12_Rd_addr)  ,
        . S_AXIS_Update_Nei12_rd_data ( S_AXIS_Update_Nei12_rd_data)  ,
        
        . S_AXIS_Update_Nei13_Rd_addr ( S_AXIS_Update_Nei13_Rd_addr)  ,
        . S_AXIS_Update_Nei13_rd_data ( S_AXIS_Update_Nei13_rd_data)  
      
    );   
   
endmodule