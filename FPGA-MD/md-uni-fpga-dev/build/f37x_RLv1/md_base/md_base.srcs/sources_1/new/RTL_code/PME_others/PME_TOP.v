`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2022 05:16:37 PM
// Design Name: 
// Module Name: PME_TOP
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


module PME_TOP(    input                                           Sys_Clk      ,
                   input                                           Sys_Rst_n    ,
                   input                                           M_AXIS_New_tDone   , 
                   input           [11:0]                          Par_num                       , 
                   output  wire                                    Update_ALL_Force_Ram_done   ,  // reading all new force to ram  
                   output  wire                                    M_AXIS_Update_ram_wr_en   ,  // buff data to XDMA ram 
                   output  wire    [11:0]                          M_AXIS_Update_cnt         ,
                   output  wire    [255:0]                         M_AXIS_Update_ram_rd_data ,
                                     
                   output  wire    [11  : 0]                       S_AXIS_ram_Rd_addr        ,
                   input           [255 : 0]                       S_AXIS_ram_rd_data                           
    );
    
 
wire            ALL_Par_pass_done  ;
wire            One_partical_BfFFT_Cal_Done  ;
wire            One_Part_Get_Done  ;
wire [159:0]    M_AXIS_Index_buf   ;
wire            Pme_Index_Fraction_en   ; 
wire [95:0]     atomCoorn               ; 
wire [95:0]     atomCoorn_Index         ; 
wire [95:0]     atomCoorn_Fraction      ; 
wire            Pme_Index_Fraction_Done;
wire [127:0]    Data_Output_X   ;
wire [127:0]    D_Data_input_X  ;                    
wire [127:0]    Data_Output_Y   ;
wire [127:0]    D_Data_input_Y  ;              
wire [127:0]    Data_Output_Z   ;
wire [127:0]    D_Data_input_Z  ;
wire            D_Data_Data_Done;

  INIT_DATA_2_RAM U_INIT_DATA_2_RAM(
      .   Sys_Clk                      ( Sys_Clk                    ),
      .   Sys_Rst_n                    ( Sys_Rst_n                  ),
      .   ALL_Par_pass_done            ( ALL_Par_pass_done          ),          
      .   M_AXIS_New_tDone             ( M_AXIS_New_tDone           ),  
      .   One_partical_BfFFT_Cal_Done  ( One_partical_BfFFT_Cal_Done),
      .   Par_num                      ( Par_num                    ),
                                   
      .   S_AXIS_ram_Rd_addr           ( S_AXIS_ram_Rd_addr         ),
      .   S_AXIS_ram_rd_data           ( S_AXIS_ram_rd_data         ), 
                               
      .   One_Part_Get_Done            (  One_Part_Get_Done          ),                                   
      .   atomCoorn                    (  atomCoorn                 ),
      .   M_AXIS_Index_buf             (  M_AXIS_Index_buf          ) 
              
    );

 //loop atoms
 
 Pme_Index_FractionXYZ_Top U_Pme_Index_FractionXYZ_Top(
     .   Sys_Clk                      ( Sys_Clk                 ),
     .   Sys_Rst_n                    ( Sys_Rst_n               ),  
    .    Pme_Index_Fraction_Done      (Pme_Index_Fraction_Done  ),                               
     .   Pme_Index_Fraction_en        ( One_Part_Get_Done       ),
     .   atomCoorn                    ( atomCoorn               ),  
     .   atomCoorn_Index              ( atomCoorn_Index         ),  
     .   atomCoorn_Fraction           ( atomCoorn_Fraction      )  
    );

        
Update_Bspline_Parallel  U_Update_Bspline_Parallel(
 
     .   Sys_Clk                      ( Sys_Clk                       ),
     .   Sys_Rst_n                    ( Sys_Rst_n                     ),  
                                                                             // input x y z 
     .   Update_Bspline_en            (  Pme_Index_Fraction_Done       ),
     .   Fraction_D                   (  atomCoorn_Fraction            ),    
     .   D_Data_Data_Done             (  D_Data_Data_Done              ),   
                    
     .   Data_Output_X                (  Data_Output_X          ), 
     .   D_Data_input_X               (  D_Data_input_X         ), 

     .   Data_Output_Y                (  Data_Output_Y          ), 
     .   D_Data_input_Y               (  D_Data_input_Y         ), 

     .   Data_Output_Z                (  Data_Output_Z          ), 
     .   D_Data_input_Z               (  D_Data_input_Z         ) 
    );  

    
Q_3Ord_Mul_TOP  U_Q_3Ord_Mul_TOP(
     .    Sys_Clk                  ( Sys_Clk                )        ,
     .    Sys_Rst_n                ( Sys_Rst_n              )           , 
     .    Q_Calculater_en          ( One_Part_Get_Done       )          ,                                
     .    atomCoorn_Index          ( atomCoorn_Index         )          ,                
     .   Pme_Index_Fraction_Done   ( Pme_Index_Fraction_Done),
     .    Q_KKK_get                ( M_AXIS_Index_buf[31:0]  )          ,           
              
     .    thetaX_GetBspline_vil    (  D_Data_Data_Done       )          , 
     .    thetaY_GetBspline_vil    (  D_Data_Data_Done       )          ,
     .    thetaZ_GetBspline_vil    (  D_Data_Data_Done       )       ,
     .    X_GetBspline             (  Data_Output_X          )         ,
     .    Y_GetBspline             (  Data_Output_Y          )          ,
     .    Z_GetBspline             (  Data_Output_Z          )

    );
    

    
//     Grid_Force_Order3Module_Top   U_Grid_Force_Order3Module_Top(
//      .   Sys_Clk                (      Sys_Clk             ),
//      .   Sys_Rst_n              (      Sys_Rst_n           ) ,
                                 
//      .   atomCoorn_Index         (  atomCoorn_Index         ) ,
//      .   thetaX_GetBspline_vil   (  thetaX_GetBspline_vil   ) ,
//      .   thetaY_GetBspline_vil   (  thetaY_GetBspline_vil   ) ,  
//      .   thetaZ_GetBspline_vil   (  thetaZ_GetBspline_vil   ) ,  
//      .   thetaX_GetBspline       (    thetaX_GetBspline     ) ,
//      .   thetaY_GetBspline       (  thetaY_GetBspline       )  , //index Grie
//      .   thetaZ_GetBspline       (  thetaZ_GetBspline       )  ,//get FFT + Convoluted + Ifft Q value 
//      .   DthetaX_GetBspline_vil  (  DthetaX_GetBspline_vil  )  ,
//      .   DthetaY_GetBspline_vil  (  DthetaY_GetBspline_vil  )  ,
//      .   DthetaZ_GetBspline_vil  (  DthetaZ_GetBspline_vil  )  ,
//      .   DthetaX_GetBspline      (  DthetaX_GetBspline      )  ,
//      .   DthetaY_GetBspline      (  DthetaY_GetBspline      )  ,
//      .   DthetaZ_GetBspline      (  DthetaZ_GetBspline      )

//    );
    
   
    
//    ConV_module_Top  
//     U_ConV_module_Top(
//   .       Sys_Clk            (    Sys_Clk            )         ,
//   .       Sys_Rst_n          (    Sys_Rst_n          )         ,  
//   .        eterm_input        (     eterm_input      ),  
   
//  .        Ptr_Q_ADDR          (    Ptr_Q_ADDR        ), 
//  .        Ptr_eterm_ADDR      (    Ptr_eterm_ADDR    ), 
//  .        Ptr_Q_Get           (    Ptr_Q_Get         ), 
   
//  .        ConV_module_en      (    ConV_module_en    ), 
//  .        Bspline_module_X    (    Bspline_module_X  ), 
//  .        Bspline_module_Y    (    Bspline_module_Y  ), 
//  .        Bspline_module_Z    (    Bspline_module_Z  )  

//    );
   
   
  
   
   
   
// Three_D_FFT_Module  U_Three_D_FFT_Module(
//. Sys_Clk             (Sys_Clk           ), 
//. Sys_Rst_n           (Sys_Rst_n         ),
//. FFT_Forward    (   FFT_Forward    ),
//. FFT_Backward   (   FFT_Backward   ),

//. M_AXIS_Q_Rd_en      (M_AXIS_Q_Rd_en    ),
//. M_AXIS_Q_Rd_data    (M_AXIS_Q_Rd_data  ),
//. M_AXIS_Q_Rd_addr    (M_AXIS_Q_Rd_addr  )
// );
   
   
   
   
endmodule
