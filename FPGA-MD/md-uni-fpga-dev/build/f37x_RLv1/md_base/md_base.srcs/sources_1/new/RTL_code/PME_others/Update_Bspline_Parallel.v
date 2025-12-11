`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 07:59:44 PM
// Design Name: 
// Module Name: Update_Bspline_Parallel
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


module Update_Bspline_Parallel    (
 
    input                                         Sys_Clk                  ,
    input                                         Sys_Rst_n                ,  
    
    input                                         Update_Bspline_en        ,  
    input                  [95:0 ]                Fraction_D               ,              // input x y z 
    output wire                                   D_Data_Data_Done         ,    
    output wire            [127:0]                Data_Output_X            ,
    output wire            [127:0]                D_Data_input_X           ,    
       
    output wire            [127:0]                Data_Output_Y            ,
    output wire            [127:0]                D_Data_input_Y           ,  
   
    output wire            [127:0]                Data_Output_Z            ,
    output wire            [127:0]                D_Data_input_Z                    
    );            
    
        
      
     Update_Bspline_Top        U_X_Update_Bspline_Top(
     
     .Sys_Clk                  (Sys_Clk              ) ,
     .Sys_Rst_n                (Sys_Rst_n            ) ,  
     .Fraction_D               (Fraction_D[31:0]     ) ,              // input x y z 
     .Data_Output              (Data_Output_X        ) ,              //output order 4 
     .D_Data_input             (D_Data_input_X       ) ,              //output order 4 
     .Update_Bspline_en        (Update_Bspline_en    ) ,
     .D_Data_Data_Done         (D_Data_Data_Done)
       );
       
     Update_Bspline_Top         U_Y_Update_Bspline_Top(
     
     .Sys_Clk                  (Sys_Clk               ) ,
     .Sys_Rst_n                (Sys_Rst_n             ) ,  
     .Fraction_D               (Fraction_D[63:32]     ) ,              // input x y z 
     .Data_Output              (Data_Output_Y         ) ,             //output order 4 
     .D_Data_input             (D_Data_input_Y        ) ,             //output order 4    
     .Update_Bspline_en        (Update_Bspline_en     ) ,
     .D_Data_Data_Done         (D_Data_Data_Done)
       );
       
     Update_Bspline_Top        U_Z_Update_Bspline_Top(
     
     .Sys_Clk                  (Sys_Clk               ) ,
     .Sys_Rst_n                (Sys_Rst_n             ) ,  
     .Fraction_D               (Fraction_D[95:64]     ) ,              // input x y z 
     .Data_Output              (Data_Output_Z         ) ,             //output order 4 
     .D_Data_input             (D_Data_input_Z        ) ,             //output order 4 
     .Update_Bspline_en        (Update_Bspline_en     ) ,
     .D_Data_Data_Done         (D_Data_Data_Done)
       );
 

endmodule