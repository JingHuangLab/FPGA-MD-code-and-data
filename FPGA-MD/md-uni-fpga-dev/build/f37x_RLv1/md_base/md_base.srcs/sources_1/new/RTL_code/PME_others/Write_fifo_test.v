`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2022 08:21:22 AM
// Design Name: 
// Module Name: Write_fifo_test
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


module Write_fifo_test(
          input                              Sys_Clk   ,
          input                              Sys_Rst_n , 
 
          input                              Update_ALL_Force_Ram_done      ,
          input                              M_AXIS_Update_ram_wr_en  ,
          input                  [11:0]      M_AXIS_Update_cnt        ,
          output wire            [255:0]     M_AXIS_Update_ram_rd_data   
          

    );

//-----------------------------------------------------------------------------------------------//
//   read
//-----------------------------------------------------------------------------------------------//

  Test_ram U_PinPang_Ram_Out (
  .clka (        Sys_Clk                               ),              // input wire clka
  .ena  (        Sys_Rst_n                             ),              // input wire ena
  .wea  (        M_AXIS_Update_ram_wr_en               ),              // input wire [0 : 0] wea
  .addra(        M_AXIS_Update_cnt                     ),              // input wire [11 : 0] addra
  .dina (        M_AXIS_Update_ram_rd_data             ),              // input wire [223 : 0] dina
  .clkb (        Sys_Clk                               ),               // input wire clkb
  .enb  (        Sys_Rst_n                             ),               // input wire enb
  .addrb(                                              ),       // input wire [11 : 0] addrb
  .doutb(                                              )        // output wire [223 : 0] doutb
);    

endmodule