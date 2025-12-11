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
      input                        Sys_Clk                   ,
      input                        Sys_Rst_n                 ,
      input                        Subcell_pass_done         ,
      output reg                   Update_ALL_Force_Ram_done ,
      input                        Home0_cell_cal_finish     ,      
      
      input         [255:0]        M_AXIS_EnE_Force          ,         
      input                        S_AXIS_update_One_Done    ,
   
      output reg                   M_AXIS_Home1_wr_en        , 
      output reg     [255:0]       M_AXIS_Home1_wr_data      , 
      output reg       [11:0]      M_AXIS_Home1_ram_addr      
      
     
    );   

 wire                      M_AXIS_home1_wr_en     ;
 wire    [255:0]           M_AXIS_home1_wr_data   ;
 wire    [9:0]             M_AXIS_home1_ram_addr  ;
                                        
  
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
 
  
       
           
 Buff_2_Fifo U_Buff_2_Fifo(
 .Sys_Clk                  ( Sys_Clk                  ),
 .Sys_Rst_n                ( Sys_Rst_n                ),
 .Subcell_pass_done        ( Subcell_pass_done        ),
 .Update_ALL_Force_Ram_done( Update_ALL_Force_Ram_done),
 .Home0_cell_cal_finish    ( Home0_cell_cal_finish    ),
 
 .M_AXIS_EnE_Force         ( M_AXIS_EnE_Force         ),
 .S_AXIS_update_One_Done   ( S_AXIS_update_One_Done   ),
 
 .M_AXIS_Home1_wr_en       ( M_AXIS_Home1_wr_en       ),
 .M_AXIS_Home1_wr_data     ( M_AXIS_Home1_wr_data     ),
 .M_AXIS_Home1_ram_addr    ( M_AXIS_Home1_ram_addr    )  
       
   
      
    );   
   
endmodule
