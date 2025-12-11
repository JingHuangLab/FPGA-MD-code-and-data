`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 04:56:46 PM
// Design Name: 
// Module Name: Par_Bond_Top
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


module Par_Bond_Top(
  input                     Sys_Clk  ,
  input                     Sys_Rst_n, 
  input     [31:0]          Filter_R2, //
  input     [31:0]          Filter_R2_INDEX ,//
  output reg  [31:0]        Bond_Force 
  
  
    );
    
    
    
    
Bond_cal_Top U_Bond_cal_Top (
.Sys_Clk  (Sys_Clk  ),
.Sys_Rst_n(Sys_Rst_n),
 
.Filter_R2(Filter_R2),
.B0       (B0       ),
.KB       (KB       ) ,
. B_Add_BUF(B_Add_BUF),
.R2_Root  (R2_Root  ) // output   
    );
    
    
   Dihedral_Cal_Top U_Dihedral_Cal_Top (
. Sys_Clk  (Sys_Clk  ),
. Sys_Rst_n(Sys_Rst_n),
.  N       ( N       ),
.  Fai     ( Fai     ),     
.  R2_Root ( R2_Root ),
.  Dih_Add_BUF(Dih_Add_BUF),
.  KThate  ( KThate  ),
.  Sigma   ( Sigma   )
    ); 
    
  Angle_Cal_Top U_Angle_Cal_Top(
.      Sys_Clk    ( Sys_Clk    ) ,
.      Sys_Rst_n  ( Sys_Rst_n  ) ,
 
.       KThate    (  KThate    ) ,
.       Thate0    (  Thate0    ) ,     
 .     Angle_Add_BUF (Angle_Add_BUF),
.       R2_Root   (  R2_Root   )
 
    );
       
 Impropers_Cal_Top(
.       Sys_Clk     (   Sys_Clk   ),
.       Sys_Rst_n   (   Sys_Rst_n ),
 
.        Komiga     (    Komiga   ),
.        Omiga0     (    Omiga0   ),     
 .Impropers_Add_BUF(Impropers_Add_BUF),
.        R2_Root    (    R2_Root  )
     );   
      
  Bond_ACC_TOP U_Bond_ACC_TOP(
.    Sys_Clk         (  Sys_Clk        ) ,
 .   Sys_Rst_n       (  Sys_Rst_n      ) , 
 
.  B_Add_BUF         (B_Add_BUF        )  ,
.  Dih_Add_BUF       (Dih_Add_BUF      )  ,
.  Angle_Add_BUF     (Angle_Add_BUF    )  ,
.  Impropers_Add_BUF (Impropers_Add_BUF)  ,
.    Bond_Force      (  Bond_Force     )
    );        
    
    
  READ_from_Cache U_READ_from_Cache(
. Sys_Clk            (Sys_Clk          ) ,         
. Sys_Rst_n          (Sys_Rst_n        ) ,  
. Bond_buf_Data_en   (Bond_buf_Data_en ) ,       
. Filter_R2_INDEX    (Filter_R2_INDEX  ) ,//
 
. B0                 (B0               ) ,
. KB                 (KB               ) ,
 
. N                  (N                ) ,
. Fai                (Fai              ) ,     
. DIR_KThate         (DIR_KThate       ) ,
. Sigma              (Sigma            ) ,
 
. Angle_KThate       (Angle_KThate     ) ,
. Thate0             (Thate0           ) ,     
 
. Komiga             (Komiga           ) ,
. Omiga0             (Omiga0           )
 
    );
      
    
    
    
    
     
 endmodule
 