`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 12:10:59 AM
// Design Name: 
// Module Name: XYZ_Point_Mul_Top
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


module XYZ_Point_Mul_Top(

    );
    
       
XYZ_Point_Mul    U_XYZ_Point_Mul  (
     . Sys_Clk                     ( Sys_Clk              )  ,
     . Sys_Rst_n                   ( Sys_Rst_n            )  ,                
  
          
     . X_Add_A_out                   (X_Add_A_out   ), 
     . Y_Add_B_out                   (Y_Add_B_out   ), 
     . X_Add_A_Vil                   (X_Add_A_Vil   ),
     . Y_Add_B_Vil                   (Y_Add_B_Vil   ),    
    
     . XY_Add_C_out                  (XY_Add_C_out)  ,
     . XY_Add_C_Vil                  (XY_Add_C_Vil)  ,
     . Z_Add_C_out                   (Z_Add_C_out )  ,
     . Z_Add_C_Vil                   (Z_Add_C_Vil )  ,
   
     . RR_Add_get_r                  (RR_Add_get_r      ),
     . RR_Add_get_vil                (RR_Add_get_vil    ),
     . RR_Add_get_XY_R               (RR_Add_get_XY_R   ),  //get R
     . XY_Add_get_vil                (XY_Add_get_vil    ),        
                                   //X to caculation mul unit 
     . X_Mul_A_out                   (X_Mul_A_out  ),
     . X_Mul_A_Vil                   (X_Mul_A_Vil  ),
     . X_Mul_B_Vil                   (X_Mul_B_Vil  ),
     . X_Mul_B_out                   (X_Mul_B_out  ),
     . X_Mul_get_r                   (X_Mul_get_r  ),
     . X_Mul_get_vil                 (X_Mul_get_vil),
                                 //X to caculation sub unit 

     . Y_Mul_A_out                   (Y_Mul_A_out  ),
     . Y_Mul_A_Vil                   (Y_Mul_A_Vil  ),
     . Y_Mul_B_Vil                   (Y_Mul_B_Vil  ),
     . Y_Mul_B_out                   (Y_Mul_B_out  ),
     . Y_Mul_get_r                   (Y_Mul_get_r  ),
     . Y_Mul_get_vil                 (Y_Mul_get_vil),
                 
                                               //Z to caculation mul unit 
     .Z_Mul_A_out                    (Z_Mul_A_out  ),
     .Z_Mul_A_Vil                    (Z_Mul_A_Vil  ),
     .Z_Mul_B_Vil                    (Z_Mul_B_Vil  ),
     .Z_Mul_B_out                    (Z_Mul_B_out  ),
     .Z_Mul_get_r                    (Z_Mul_get_r  ),
     .Z_Mul_get_vil                  (Z_Mul_get_vil) 

     );  
    
    
endmodule
