`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 03:03:43 PM
// Design Name: 
// Module Name: XDMA_TOP
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


module XDMA_TOP(  
       
             input                      Sys_Clk,
             input                      Sys_Rst_n,  
             input                      Test_en
        
    );
wire                  locked                      ;
wire                  S_AXIS_ram_rd_en            ;
wire    [11:0]        S_AXIS_ram_Rd_addr          ;
wire    [255:0]       S_AXIS_ram_rd_data          ;
wire                  M_AXIS_New_tDone            ;
wire                  Update_ALL_Force_Ram_done     ;
wire                  M_AXIS_Update_ram_wr_en        ;
wire    [11  : 0]     M_AXIS_Update_cnt              ;
wire    [255 : 0]     M_AXIS_Update_ram_rd_data      ;
 
localparam  [11  : 0]  parnum = 12'd2700;
 

wire  ram_file_cnt_en;

    
Read_fifo_test U_Read_fifo_test(
    .Sys_Clk                                 (Sys_Clk                    )      ,
    .Sys_Rst_n                               (Sys_Rst_n                  )      , 
    .Test_en                                 (Test_en                    )      ,  //just for test ,write data to ram                                              
                                                                                    //read from pinpang module to subram
    .S_AXIS_ram_Rd_addr                      (S_AXIS_ram_Rd_addr         )      ,
    .S_AXIS_ram_rd_data                      (S_AXIS_ram_rd_data         )      ,  
    .M_AXIS_New_tDone                        (M_AXIS_New_tDone           )               // write to pingpangram
    );

Write_fifo_test U_Write_fifo_test(
    . Sys_Clk                                (Sys_Clk                     )      ,
    . Sys_Rst_n                              (Sys_Rst_n                   )      ,       
                                                                        
    . Update_ALL_Force_Ram_done              (Update_ALL_Force_Ram_done                )      ,                     //read from pinpang module to subram
    . M_AXIS_Update_ram_wr_en                (M_AXIS_Update_ram_wr_en   )      ,
    . M_AXIS_Update_cnt                      (M_AXIS_Update_cnt         )      ,  
    . M_AXIS_Update_ram_rd_data              (M_AXIS_Update_ram_rd_data )                         // write to pingpangram
    );
     
PME_TOP  U_PME_TOP(

  . Sys_Clk                                  (Sys_Clk                     )       ,
  . Sys_Rst_n                                (Sys_Rst_n                   )       ,
                                            
  . Update_ALL_Force_Ram_done               ( Update_ALL_Force_Ram_done                )       ,

  . M_AXIS_Update_ram_wr_en                   (M_AXIS_Update_ram_wr_en   )   ,
  . M_AXIS_Update_cnt                         (M_AXIS_Update_cnt         )   ,
  . M_AXIS_Update_ram_rd_data                 (M_AXIS_Update_ram_rd_data )   ,
  . Par_num                                     (parnum),
  
  
                       //read from pinpang module to subram      
  . S_AXIS_ram_Rd_addr                       (S_AXIS_ram_Rd_addr          )       ,
  . S_AXIS_ram_rd_data                       (S_AXIS_ram_rd_data          )       ,  
  . M_AXIS_New_tDone                         (M_AXIS_New_tDone            )                             // write to pingpangram
    );

    
endmodule