`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 10:33:25 PM
// Design Name: 
// Module Name: Pme_Index_FractionXYZ_Top
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


module Pme_Index_FractionXYZ_Top# (
                 parameter  RecipBoxVector       =  32'H0,
                 parameter  Ngrid                =  32'H64,
                 parameter  RecipBoxVector_HEX   =  32'H3ECCCCCC,
                 parameter  Ngrid_HEX            =  32'H42800000  )
 
(
    input                    Sys_Clk      ,
    input                    Sys_Rst_n    ,  
    input                    Pme_Index_Fraction_en    , //
    output  wire             Pme_Index_Fraction_Done ,
    input         [95:0]     atomCoorn                , //x y z
    output  wire  [95:0]     atomCoorn_Index          , //x y z
    output  wire  [95:0]     atomCoorn_Fraction         //x y z
    );
    
    
    
    Pme_Index_Fraction_Top U_Pme_Index_Fraction_Top_X(

  . Sys_Clk                 (Sys_Clk                  ) ,
  . Sys_Rst_n               (Sys_Rst_n                ) ,  
  . Pme_Index_Fraction_en   (Pme_Index_Fraction_en    ) ,
  . Pme_Index_Fraction_Done  (Pme_Index_Fraction_Done ),
  . atomCoorn               (atomCoorn[31:0]                ) , //x
  . RecipBoxVector          (RecipBoxVector_HEX             ) , //x
  . Ngrid                   (Ngrid                          ) , //x
  . Ngrid_HEX              (Ngrid_HEX                       ) , //x
  . atomCoorn_Index         (atomCoorn_Index[31:0]          ) , //x
  . atomCoorn_Fraction      (atomCoorn_Fraction[31:0]       )   

    );
    
       
    Pme_Index_Fraction_Top U_Pme_Index_Fraction_Top_Y(

  . Sys_Clk                 (Sys_Clk                         ) ,
  . Sys_Rst_n               (Sys_Rst_n                       ) ,  
  . Pme_Index_Fraction_en   (Pme_Index_Fraction_en           ) ,
    . Pme_Index_Fraction_Done  (Pme_Index_Fraction_Done      ),
  . atomCoorn               (atomCoorn[63:32]                ) , //y
  . RecipBoxVector          (RecipBoxVector_HEX              ) , //y
  . Ngrid                   (Ngrid                           ) , //y
  . Ngrid_HEX               (Ngrid_HEX                       ) , //x
  . atomCoorn_Index         (atomCoorn_Index[63:32]          ) , //y
  . atomCoorn_Fraction      (atomCoorn_Fraction[63:32]       )   

    );
    
        
    Pme_Index_Fraction_Top U_Pme_Index_Fraction_Top_Z(

  . Sys_Clk                 (Sys_Clk                  ) ,
  . Sys_Rst_n               (Sys_Rst_n                ) ,  
  . Pme_Index_Fraction_en   (Pme_Index_Fraction_en    )  ,
   . Pme_Index_Fraction_Done  (Pme_Index_Fraction_Done ),
  . atomCoorn               (atomCoorn[95:64]                ) , //z
  . RecipBoxVector          (RecipBoxVector_HEX          ) , //z
  . Ngrid                   (Ngrid                    ) , //z
    . Ngrid_HEX             (Ngrid_HEX                     ) , //x
  . atomCoorn_Index         (atomCoorn_Index[95:64]          ) , //z
  . atomCoorn_Fraction      (atomCoorn_Fraction[95:64]       )   

    ); 
    
endmodule
