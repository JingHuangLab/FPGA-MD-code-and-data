`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2022 09:23:20 PM
// Design Name: 
// Module Name: INIT_DATA_TO_SUBCELLRAM
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


module INIT_DATA_TO_SUBCELLRAM(
    input                               Sys_Clk,
    input                               Sys_Rst_n,
 
    output wire  [11:0]                 Home0_Ptcal_Num ,
    output wire  [11:0]                 Home1_Ptcal_Num ,
    output wire  [11:0]                 Nei1_Ptcal_Num  ,
    output wire  [11:0]                 Nei2_Ptcal_Num  ,
    output wire  [11:0]                 Nei3_Ptcal_Num  ,
    output wire  [11:0]                 Nei4_Ptcal_Num  ,   
    output wire  [11:0]                 Nei5_Ptcal_Num  ,  
    output wire  [11:0]                 Nei6_Ptcal_Num  ,
    output wire  [11:0]                 Nei7_Ptcal_Num  ,            
    output wire  [11:0]                 Nei8_Ptcal_Num  ,           
    output wire  [11:0]                 Nei9_Ptcal_Num  ,            
    output wire  [11:0]                 Nei10_Ptcal_Num ,
    output wire  [11:0]                 Nei11_Ptcal_Num ,
    output wire  [11:0]                 Nei12_Ptcal_Num ,
    output wire  [11:0]                 Nei13_Ptcal_Num ,
   
    output wire    [15:0]               S_AXIS_ram_Rd_addr , 
    input          [255:0]              S_AXIS_ram_rd_data ,
    
    input         [7:0]                 S_AXIS_home0ram_Rd_addr ,
    output wire   [255:0]               S_AXIS_home0ram_rd_data ,
  
    input         [7:0]                 S_AXIS_home1ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_home1ram_rd_data , 
    
    input         [7:0]                 S_AXIS_Nei1ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei1ram_rd_data , 
    
    input         [7:0]                 S_AXIS_Nei2ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei2ram_rd_data , 
    
     input         [7:0]                S_AXIS_Nei3ram_Rd_addr , 
     output wire   [255:0]              S_AXIS_Nei3ram_rd_data , 
    
    input         [7:0]                 S_AXIS_Nei4ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei4ram_rd_data , 
    
    input         [7:0]                 S_AXIS_Nei5ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei5ram_rd_data ,    
    
    input         [7:0]                 S_AXIS_Nei6ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei6ram_rd_data , 
    
    input         [7:0]                 S_AXIS_Nei7ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei7ram_rd_data ,    
     
    input         [7:0]                 S_AXIS_Nei8ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei8ram_rd_data ,       
      
    input         [7:0]                 S_AXIS_Nei9ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei9ram_rd_data ,      
       
    input         [7:0]                 S_AXIS_Nei10ram_Rd_addr , 
    output wire   [255:0]               S_AXIS_Nei10ram_rd_data ,     
        
    input         [7:0]                 S_AXIS_Nei11ram_Rd_addr ,     
    output wire   [255:0]               S_AXIS_Nei11ram_rd_data ,     
      
    input         [7:0]                 S_AXIS_Nei12ram_Rd_addr ,     
    output wire   [255:0]               S_AXIS_Nei12ram_rd_data ,     
    
    input         [7:0]                 S_AXIS_Nei13ram_Rd_addr ,     
    output wire   [255:0]               S_AXIS_Nei13ram_rd_data ,     
        
    input                               New_Homecell_begin_en ,   
    output wire                         Subcell_pass_done       
   
    );

    
    wire                      M_AXIS_home_wr_en   ;
    wire     [255:0]          M_AXIS_home_wr_data ;
    wire     [7:0]            M_AXIS_home_ram_addr;
              
    wire                      M_AXIS_home1_wr_en     ;
    wire    [255:0]           M_AXIS_home1_wr_data   ;
    wire    [7:0]             M_AXIS_home1_ram_addr  ;
                                           
    wire                      M_AXIS_Nei1_wr_en      ;
    wire    [255:0]           M_AXIS_Nei1_wr_data    ;
    wire    [7:0]             M_AXIS_Nei1_ram_addr   ;
 
    wire                      M_AXIS_Nei2_wr_en      ;
    wire    [255:0]           M_AXIS_Nei2_wr_data    ;
    wire    [7:0]             M_AXIS_Nei2_ram_addr   ;
  
    wire                      M_AXIS_Nei3_wr_en      ;
  wire    [255:0]             M_AXIS_Nei3_wr_data    ;
  wire    [7:0]               M_AXIS_Nei3_ram_addr   ;
    
    wire                      M_AXIS_Nei4_wr_en      ;
    wire    [255:0]           M_AXIS_Nei4_wr_data    ;
    wire    [7:0]             M_AXIS_Nei4_ram_addr   ;
    
    wire                      M_AXIS_Nei5_wr_en      ;
    wire    [255:0]           M_AXIS_Nei5_wr_data    ;
    wire    [7:0]             M_AXIS_Nei5_ram_addr   ;
    
    wire                      M_AXIS_Nei6_wr_en      ;
    wire    [255:0]           M_AXIS_Nei6_wr_data    ;
    wire    [7:0]             M_AXIS_Nei6_ram_addr   ;
    
    wire                      M_AXIS_Nei7_wr_en      ;
    wire    [255:0]           M_AXIS_Nei7_wr_data    ;
    wire    [7:0]             M_AXIS_Nei7_ram_addr   ;
    
    wire                      M_AXIS_Nei8_wr_en      ;
    wire    [255:0]           M_AXIS_Nei8_wr_data    ;
    wire    [7:0]             M_AXIS_Nei8_ram_addr   ;
    
    wire                      M_AXIS_Nei9_wr_en      ;
    wire    [255:0]           M_AXIS_Nei9_wr_data    ;
    wire    [7:0]             M_AXIS_Nei9_ram_addr   ;
    
    wire                      M_AXIS_Nei10_wr_en      ;
    wire    [255:0]           M_AXIS_Nei10_wr_data    ;
    wire    [7:0]             M_AXIS_Nei10_ram_addr   ;
    
    wire                      M_AXIS_Nei11_wr_en      ;
    wire    [255:0]           M_AXIS_Nei11_wr_data    ;
    wire    [7:0]             M_AXIS_Nei11_ram_addr   ;  
    
   wire                       M_AXIS_Nei12_wr_en      ;
    wire    [255:0]           M_AXIS_Nei12_wr_data    ;
    wire    [7:0]             M_AXIS_Nei12_ram_addr   ; 

    wire                      M_AXIS_Nei13_wr_en      ;
    wire    [255:0]           M_AXIS_Nei13_wr_data    ;
    wire    [7:0]             M_AXIS_Nei13_ram_addr   ; 




      
   INIT_DATA_2_RAM   U_INIT_DATA_2_RAM(
      .  Sys_Clk               (  Sys_Clk         ),
      .  Sys_Rst_n             (  Sys_Rst_n       ),
      
      .  Subcell_pass_done     (  Subcell_pass_done),     
      .  New_Homecell_begin_en      (  New_Homecell_begin_en),                             
 
      .  S_AXIS_ram_Rd_addr     ( S_AXIS_ram_Rd_addr     ),   
      .  S_AXIS_ram_rd_data    ( S_AXIS_ram_rd_data     ), 
       
      .  M_AXIS_home_wr_en       ( M_AXIS_home_wr_en      )  ,     
      .  M_AXIS_home_wr_data   ( M_AXIS_home_wr_data    )  ,
      .  M_AXIS_home_ram_addr  ( M_AXIS_home_ram_addr   )  ,
                           
      .  M_AXIS_home1_wr_en      ( M_AXIS_home1_wr_en     ) ,
      .  M_AXIS_home1_wr_data  ( M_AXIS_home1_wr_data   ) ,
      .  M_AXIS_home1_ram_addr ( M_AXIS_home1_ram_addr  ) ,
                             
      .  M_AXIS_Nei1_wr_en     ( M_AXIS_Nei1_wr_en      )  ,  
      .  M_AXIS_Nei1_wr_data   ( M_AXIS_Nei1_wr_data    )  , 
      .  M_AXIS_Nei1_ram_addr  ( M_AXIS_Nei1_ram_addr   )  ,
      
     .  M_AXIS_Nei2_wr_en     ( M_AXIS_Nei2_wr_en      )  , 
     .  M_AXIS_Nei2_wr_data   ( M_AXIS_Nei2_wr_data    )  , 
     .  M_AXIS_Nei2_ram_addr  ( M_AXIS_Nei2_ram_addr   )  , 
      
     .  M_AXIS_Nei3_wr_en     ( M_AXIS_Nei3_wr_en      )  , 
     .  M_AXIS_Nei3_wr_data   ( M_AXIS_Nei3_wr_data    )  , 
     .  M_AXIS_Nei3_ram_addr  ( M_AXIS_Nei3_ram_addr   )  , 
      
     .  M_AXIS_Nei4_wr_en     ( M_AXIS_Nei4_wr_en      )  , 
     .  M_AXIS_Nei4_wr_data   ( M_AXIS_Nei4_wr_data    )  , 
     .  M_AXIS_Nei4_ram_addr  ( M_AXIS_Nei4_ram_addr   )  , 
      
     .  M_AXIS_Nei5_wr_en     ( M_AXIS_Nei5_wr_en      )  , 
     .  M_AXIS_Nei5_wr_data   ( M_AXIS_Nei5_wr_data    )  , 
     .  M_AXIS_Nei5_ram_addr  ( M_AXIS_Nei5_ram_addr   )  , 
     
     .  M_AXIS_Nei6_wr_en     ( M_AXIS_Nei6_wr_en      )  , 
     .  M_AXIS_Nei6_wr_data   ( M_AXIS_Nei6_wr_data    )  , 
     .  M_AXIS_Nei6_ram_addr  ( M_AXIS_Nei6_ram_addr   )  , 
      
     .  M_AXIS_Nei7_wr_en     ( M_AXIS_Nei7_wr_en      )  , 
     .  M_AXIS_Nei7_wr_data   ( M_AXIS_Nei7_wr_data    )  , 
     .  M_AXIS_Nei7_ram_addr  ( M_AXIS_Nei7_ram_addr   )  , 
     
     .  M_AXIS_Nei8_wr_en     ( M_AXIS_Nei8_wr_en      )  , 
     .  M_AXIS_Nei8_wr_data   ( M_AXIS_Nei8_wr_data    )  , 
     .  M_AXIS_Nei8_ram_addr  ( M_AXIS_Nei8_ram_addr   )  , 
      
     .  M_AXIS_Nei9_wr_en     ( M_AXIS_Nei9_wr_en      )  , 
     .  M_AXIS_Nei9_wr_data   ( M_AXIS_Nei9_wr_data    )  , 
     .  M_AXIS_Nei9_ram_addr  ( M_AXIS_Nei9_ram_addr   )  ,   
      
     .  M_AXIS_Nei10_wr_en     ( M_AXIS_Nei10_wr_en      )  , 
     .  M_AXIS_Nei10_wr_data   ( M_AXIS_Nei10_wr_data    )  , 
     .  M_AXIS_Nei10_ram_addr  ( M_AXIS_Nei10_ram_addr   )  ,       
      
     .  M_AXIS_Nei11_wr_en     ( M_AXIS_Nei11_wr_en      )  , 
     .  M_AXIS_Nei11_wr_data   ( M_AXIS_Nei11_wr_data    )  , 
     .  M_AXIS_Nei11_ram_addr  ( M_AXIS_Nei11_ram_addr   )  ,   
     
     .  M_AXIS_Nei12_wr_en     ( M_AXIS_Nei12_wr_en      )  , 
     .  M_AXIS_Nei12_wr_data   ( M_AXIS_Nei12_wr_data    )  , 
     .  M_AXIS_Nei12_ram_addr  ( M_AXIS_Nei12_ram_addr   )  ,   
     
     .  M_AXIS_Nei13_wr_en     ( M_AXIS_Nei13_wr_en      )  , 
     .  M_AXIS_Nei13_wr_data   ( M_AXIS_Nei13_wr_data    )  , 
     .  M_AXIS_Nei13_ram_addr  ( M_AXIS_Nei13_ram_addr   )  ,   
     
      
      .   Home0_Ptcal_Num      ( Home0_Ptcal_Num )   ,   
      .   Home1_Ptcal_Num      ( Home1_Ptcal_Num )   ,   
      .   Nei1_Ptcal_Num       ( Nei1_Ptcal_Num  )   ,     
      .   Nei2_Ptcal_Num       ( Nei2_Ptcal_Num  )   ,     
      .   Nei3_Ptcal_Num       ( Nei3_Ptcal_Num  )   ,     
      .   Nei4_Ptcal_Num       ( Nei4_Ptcal_Num  )   ,     
      .   Nei5_Ptcal_Num       ( Nei5_Ptcal_Num  )   ,     
      .   Nei6_Ptcal_Num       ( Nei6_Ptcal_Num  )   ,  
      .   Nei7_Ptcal_Num       ( Nei7_Ptcal_Num  )   ,         
      .   Nei8_Ptcal_Num       ( Nei8_Ptcal_Num  )   ,  
      .   Nei9_Ptcal_Num       ( Nei9_Ptcal_Num  )   ,  
      .   Nei10_Ptcal_Num       ( Nei10_Ptcal_Num  )   ,  
      .   Nei11_Ptcal_Num       ( Nei11_Ptcal_Num  )   ,    
      .   Nei12_Ptcal_Num       ( Nei12_Ptcal_Num  )   ,   
      .   Nei13_Ptcal_Num       ( Nei13_Ptcal_Num  )  
                                                                        
);   
     
       
//ram for subcell module
 Bram_mem_cell U_Bram_mem_Home0_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (M_AXIS_home_wr_en),              
     .   addra(M_AXIS_home_ram_addr),          
     .   dina (M_AXIS_home_wr_data),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_home0ram_Rd_addr ), 
     .   doutb(S_AXIS_home0ram_rd_data )  
);
 
 //ram for subcell module
 Bram_mem_cell U_Bram_mem_Home1_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (M_AXIS_home1_wr_en     ),              
     .   addra( M_AXIS_home1_ram_addr  ),          
     .   dina ( M_AXIS_home1_wr_data  ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_home1ram_Rd_addr ), 
     .   doutb(S_AXIS_home1ram_rd_data )  
);
 
  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei1_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei1_wr_en     ),              
     .   addra(  M_AXIS_Nei1_ram_addr ),          
     .   dina (  M_AXIS_Nei1_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei1ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei1ram_rd_data )  
);
     
  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei2_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei2_wr_en     ),              
     .   addra(  M_AXIS_Nei2_ram_addr ),          
     .   dina (  M_AXIS_Nei2_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei2ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei2ram_rd_data )  
);     

  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei3_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei3_wr_en     ),              
     .   addra(  M_AXIS_Nei3_ram_addr ),          
     .   dina (  M_AXIS_Nei3_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei3ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei3ram_rd_data )  
);     
        
  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei4_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei4_wr_en     ),              
     .   addra(  M_AXIS_Nei4_ram_addr ),          
     .   dina (  M_AXIS_Nei4_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei4ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei4ram_rd_data )  
);     
        
  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei5_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei5_wr_en     ),              
     .   addra(  M_AXIS_Nei5_ram_addr ),          
     .   dina (  M_AXIS_Nei5_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei5ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei5ram_rd_data )  
);            
  //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei6_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei6_wr_en     ),              
     .   addra(  M_AXIS_Nei6_ram_addr ),          
     .   dina (  M_AXIS_Nei6_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei6ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei6ram_rd_data )  
);            
    
   //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei7_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei7_wr_en     ),              
     .   addra(  M_AXIS_Nei7_ram_addr ),          
     .   dina (  M_AXIS_Nei7_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei7ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei7ram_rd_data )  
);            
   
   
     //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei8_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei8_wr_en     ),              
     .   addra(  M_AXIS_Nei8_ram_addr ),          
     .   dina (  M_AXIS_Nei8_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei8ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei8ram_rd_data )  
);            
    
  
    //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei9_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei9_wr_en     ),              
     .   addra(  M_AXIS_Nei9_ram_addr ),          
     .   dina (  M_AXIS_Nei9_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei9ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei9ram_rd_data )  
);            
   
    //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei10_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei10_wr_en     ),              
     .   addra(  M_AXIS_Nei10_ram_addr ),          
     .   dina (  M_AXIS_Nei10_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei10ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei10ram_rd_data )  
);            
   

    //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei11_cell(
     .   clka(Sys_Clk),               
     .   ena (Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei11_wr_en     ),              
     .   addra(  M_AXIS_Nei11_ram_addr ),          
     .   dina (  M_AXIS_Nei11_wr_data ),            
     .   clkb (Sys_Clk),               
     .   enb  (Sys_Rst_n),     
     .   addrb(S_AXIS_Nei11ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei11ram_rd_data )  
);            
   
    //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei12_cell(
     .   clka(Sys_Clk),               
     .   ena(Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei12_wr_en     ),              
     .   addra(  M_AXIS_Nei12_ram_addr ),          
     .   dina (  M_AXIS_Nei12_wr_data ),            
     .   clkb(Sys_Clk),               
     .   enb(Sys_Rst_n),     
     .   addrb(S_AXIS_Nei12ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei12ram_rd_data )  
); 
 
     //ram for subcell module
 Bram_mem_cell U_Bram_mem_Nei13_cell(
     .   clka(  Sys_Clk),               
     .   ena(  Sys_Rst_n),              
     .   wea  (  M_AXIS_Nei13_wr_en     ),              
     .   addra(  M_AXIS_Nei13_ram_addr ),          
     .   dina (  M_AXIS_Nei13_wr_data ),            
     .   clkb(  Sys_Clk),               
     .   enb(  Sys_Rst_n),     
     .   addrb(S_AXIS_Nei13ram_Rd_addr ), 
     .   doutb(S_AXIS_Nei13ram_rd_data )  
); 
     
endmodule

