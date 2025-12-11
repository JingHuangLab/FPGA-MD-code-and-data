`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2022 08:02:37 AM
// Design Name: 
// Module Name: Xdma_T_top
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


module Xdma_T_top(

             input                      Sys_Clk,
             input                      Sys_Rst_n,  
             input                      Test_en
        
    );
//wire                     Sys_Clk            ; 
wire                    locked              ;
wire            S_AXIS_ram_rd_en            ;
wire  [11:0]    S_AXIS_ram_Rd_addr          ;
wire  [223:0]   S_AXIS_ram_rd_data          ;
wire            M_AXIS_New_tDone            ;
wire            reading_Done                ;
wire            M_AXIS_Update_ram_wr_en     ;
wire  [11:0]    M_AXIS_Update_cnt           ;
wire  [255:0]   M_AXIS_Update_ram_rd_data   ;
wire  ram_file_cnt_en;


Read_fifo_test U_Read_fifo_test(
    .Sys_Clk                                 (Sys_Clk                    )      ,
    .Sys_Rst_n                               (Sys_Rst_n                  )      , 
    .Test_en                                 (Test_en                    )      ,  //just for test ,write data to ram
                                              
    //.S_AXIS_ram_rd_en                        (S_AXIS_ram_rd_en           )      ,                     //read from pinpang module to subram
    .S_AXIS_ram_Rd_addr                      (S_AXIS_ram_Rd_addr         )      ,
    .S_AXIS_ram_rd_data                      (S_AXIS_ram_rd_data         )      ,  
    .M_AXIS_New_tDone                        (M_AXIS_New_tDone           )               // write to pingpangram
    );

Write_fifo_test U_Write_fifo_test(
    . Sys_Clk                                (Sys_Clk                     )      ,
    . Sys_Rst_n                              (Sys_Rst_n                   )      ,       
                                                                        
    . reading_Done                           (reading_Done                )      ,                     //read from pinpang module to subram
    . M_AXIS_Update_ram_wr_en                ( M_AXIS_Update_ram_wr_en    )      ,
    . M_AXIS_Update_cnt                      ( M_AXIS_Update_cnt          )      ,  
    . M_AXIS_Update_ram_rd_data              ( M_AXIS_Update_ram_rd_data  )                         // write to pingpangram
    );
     
LJ_13_TOP  U_LJ_13_TOP(

  . Sys_Clk                                  (Sys_Clk                     )       ,
  . Sys_Rst_n                                (Sys_Rst_n                   )       ,
                                            
  .  reading_Done                            ( reading_Done                )       ,
  .  M_AXIS_Update_ram_wr_en                 ( M_AXIS_Update_ram_wr_en    )       ,
  .  M_AXIS_Update_cnt                       ( M_AXIS_Update_cnt          )       ,                   //write to RAM 
  .  M_AXIS_Update_ram_rd_data               ( M_AXIS_Update_ram_rd_data  )       ,
                                            
  //. S_AXIS_ram_rd_en                         (S_AXIS_ram_rd_en            )       ,
//  . ParaM_A_LJ                               (ParaM_A_LJ      )  ,   
//  . ParaM_B_LJ                               (ParaM_B_LJ      )  ,   
//  . ParaM_A_LJ_Force                         (ParaM_A_LJ_Force)  ,   
//  . ParaM_B_LJ_Force                         (ParaM_B_LJ_Force)  ,   
  
                       //read from pinpang module to subram
  .ram_file_cnt_en                           (ram_file_cnt_en)        ,            
  . S_AXIS_ram_Rd_addr                       (S_AXIS_ram_Rd_addr          )       ,
  . S_AXIS_ram_rd_data                       (S_AXIS_ram_rd_data          )       ,  
  . M_AXIS_New_tDone                         (M_AXIS_New_tDone            )                             // write to pingpangram
    );

    
endmodule
