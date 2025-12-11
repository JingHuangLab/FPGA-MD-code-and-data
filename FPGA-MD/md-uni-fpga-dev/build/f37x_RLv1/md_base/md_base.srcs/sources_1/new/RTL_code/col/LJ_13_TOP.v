`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 05:43:05 PM
// Design Name: 
// Module Name: LJ_13_TOP
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

module LJ_13_TOP(
       input                         Sys_Clk                   ,  // system clock with 300mHz
       input                         Sys_Rst_n                 ,  // system rest
       input                         work_en                   ,
       input            [15  : 0]    Par_num                    , 
  
       output  wire                   WR_ALL_Force_Ram_done    ,   // reading all new force to ram       
         
       output  wire                   S_AXIS_ram_WR_en         ,
       output  wire    [13  : 0]      S_AXIS_ram_WR_addr       ,
       output  wire    [255 : 0]      S_AXIS_ram_WR_data        ,  
                                                                  //read from pinpang module to subram
       output  wire    [11 : 0]       S_AXIS_ram_Rd_addr        ,
       input           [255 : 0]      S_AXIS_ram_rd_data        ,  
       
       input                           M_AXIS_New_tDone                 // write to pingpangram
    );    

      wire                  M_AXIS_Update_col_ram_wr_en   ;  // buff data to XDMA ram 
      wire    [12:0]     M_AXIS_Update_col_cnt         ;
      wire    [255 : 0]     M_AXIS_Update_col_ram_rd_data ;
      wire                  M_AXIS_Update_ram_wr_en   ;  // buff data to XDMA ram 
      wire     [12:0]     M_AXIS_Update_cnt         ;
      wire    [255 : 0]     M_AXIS_Update_ram_rd_data ;         

wire            Update_ALL_Force_Ram_done;
wire            Update_Col_ALL_Force_Ram_done;
wire            Subcell_pass_done       ;
wire  [12:0]    Home0_Ptcal_Num         ;
wire  [12:0]    Home1_Ptcal_Num         ;
wire  [12:0]    Nei1_Ptcal_Num          ;   
wire  [12:0]    Nei2_Ptcal_Num          ;  
wire  [12:0]    Nei3_Ptcal_Num          ;  
wire  [12:0]    Nei4_Ptcal_Num          ;  
wire  [12:0]    Nei5_Ptcal_Num          ;   
wire  [12:0]    Nei6_Ptcal_Num          ;  
wire  [12:0]    Nei7_Ptcal_Num          ;  
wire  [12:0]    Nei8_Ptcal_Num          ;  
wire  [12:0]    Nei9_Ptcal_Num          ;  
wire  [12:0]    Nei10_Ptcal_Num         ;  
wire  [12:0]    Nei11_Ptcal_Num         ;  
wire  [12:0]    Nei12_Ptcal_Num         ;  
wire  [12:0]    Nei13_Ptcal_Num         ;  
wire            Home0cell_cal_finish    ;

wire  [11:0]     M_AXIS_home0Ram_rd_Addr ;
wire  [255:0]   S_AXIS_home0Ram_tData   ;

wire  [11:0]     M_AXIS_home1Ram_rd_Addr ;
wire  [255:0]   S_AXIS_home1Ram_tData   ;

wire  [11:0]     M_AXIS_Nei1Ram_rd_Addr  ;
wire  [255:0]   S_AXIS_Nei1Ram_tData    ;

wire  [11:0]     M_AXIS_Nei2Ram_rd_Addr  ;
wire  [255:0]   S_AXIS_Nei2Ram_tData    ;

wire  [11:0]     M_AXIS_Nei3Ram_rd_Addr  ;
wire  [255:0]   S_AXIS_Nei3Ram_tData    ;
  
wire  [11:0]     M_AXIS_Nei4Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei4Ram_tData    ;  

wire  [11:0]     M_AXIS_Nei5Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei5Ram_tData    ;  
 
wire  [11:0]     M_AXIS_Nei6Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei6Ram_tData    ;  

wire  [11:0]     M_AXIS_Nei7Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei7Ram_tData    ;  

wire  [11:0]     M_AXIS_Nei8Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei8Ram_tData    ;  
 
wire  [11:0]     M_AXIS_Nei9Ram_rd_Addr  ;  
wire  [255:0]   S_AXIS_Nei9Ram_tData    ;  

wire  [11:0]     M_AXIS_Nei10Ram_rd_Addr ;  
wire  [255:0]   S_AXIS_Nei10Ram_tData   ;  

wire  [11:0]     M_AXIS_Nei11Ram_rd_Addr ;  
wire  [255:0]   S_AXIS_Nei11Ram_tData   ;  

wire  [11:0]     M_AXIS_Nei12Ram_rd_Addr ;  
wire  [255:0]   S_AXIS_Nei12Ram_tData   ;  

wire  [11:0]     M_AXIS_Nei13Ram_rd_Addr ;  
wire  [255:0]   S_AXIS_Nei13Ram_tData   ;  

wire  [31:0]    M_home0_X_Pos_buf       ;
wire  [31:0]    M_home0_Y_Pos_buf       ;
wire  [31:0]    M_home0_Z_Pos_buf       ;
wire  [159:0]   M_home0_Index_buf       ;

wire  [31:0]    M_home1_X_Pos_buf       ;
wire  [31:0]    M_home1_Y_Pos_buf       ;
wire  [31:0]    M_home1_Z_Pos_buf       ;
wire  [159:0]   M_home1_Index_buf       ;

wire  [31:0]    M_Nei1_X_Pos_buf        ;
wire  [31:0]    M_Nei1_Y_Pos_buf        ;
wire  [31:0]    M_Nei1_Z_Pos_buf        ;
wire  [159:0]   M_Nei1_Index_buf        ;

wire  [31:0]    M_Nei2_X_Pos_buf        ;
wire  [31:0]    M_Nei2_Y_Pos_buf        ;
wire  [31:0]    M_Nei2_Z_Pos_buf        ;
wire  [159:0]   M_Nei2_Index_buf        ;

wire  [31:0]    M_Nei3_X_Pos_buf        ;
wire  [31:0]    M_Nei3_Y_Pos_buf        ;
wire  [31:0]    M_Nei3_Z_Pos_buf        ;
wire  [159:0]   M_Nei3_Index_buf        ;

wire  [31:0]    M_Nei4_X_Pos_buf        ;
wire  [31:0]    M_Nei4_Y_Pos_buf        ;
wire  [31:0]    M_Nei4_Z_Pos_buf        ;
wire  [159:0]   M_Nei4_Index_buf        ;

wire  [31:0]    M_Nei5_X_Pos_buf        ;
wire  [31:0]    M_Nei5_Y_Pos_buf        ;
wire  [31:0]    M_Nei5_Z_Pos_buf        ;
wire  [159:0]   M_Nei5_Index_buf        ;

wire  [31:0]    M_Nei6_X_Pos_buf        ;
wire  [31:0]    M_Nei6_Y_Pos_buf        ;
wire  [31:0]    M_Nei6_Z_Pos_buf        ;
wire  [159:0]   M_Nei6_Index_buf        ;

wire  [31:0]    M_Nei7_X_Pos_buf        ;
wire  [31:0]    M_Nei7_Y_Pos_buf        ;
wire  [31:0]    M_Nei7_Z_Pos_buf        ;
wire  [159:0]   M_Nei7_Index_buf        ;

wire  [31:0]    M_Nei8_X_Pos_buf        ;
wire  [31:0]    M_Nei8_Y_Pos_buf        ;
wire  [31:0]    M_Nei8_Z_Pos_buf        ;
wire  [159:0]   M_Nei8_Index_buf        ;

wire  [31:0]    M_Nei9_X_Pos_buf        ;
wire  [31:0]    M_Nei9_Y_Pos_buf        ;
wire  [31:0]    M_Nei9_Z_Pos_buf        ;
wire  [159:0]   M_Nei9_Index_buf        ;

wire  [31:0]    M_Nei10_X_Pos_buf       ;
wire  [31:0]    M_Nei10_Y_Pos_buf       ;
wire  [31:0]    M_Nei10_Z_Pos_buf       ;
wire  [159:0]   M_Nei10_Index_buf       ;

wire  [31:0]    M_Nei11_X_Pos_buf       ; 
wire  [31:0]    M_Nei11_Y_Pos_buf       ; 
wire  [31:0]    M_Nei11_Z_Pos_buf       ; 
wire  [159:0]   M_Nei11_Index_buf       ; 
                                          
wire  [31:0]    M_Nei12_X_Pos_buf       ; 
wire  [31:0]    M_Nei12_Y_Pos_buf       ; 
wire  [31:0]    M_Nei12_Z_Pos_buf       ; 
wire  [159:0]   M_Nei12_Index_buf       ; 

wire  [31:0]    M_Nei13_X_Pos_buf       ; 
wire  [31:0]    M_Nei13_Y_Pos_buf       ; 
wire  [31:0]    M_Nei13_Z_Pos_buf       ; 
wire  [159:0]   M_Nei13_Index_buf       ; 

wire  [255:0]   M_AXIS_LJ_EnE_Force1     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force2     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force3     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force4     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force5     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force6     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force7     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force8     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force9     ;
wire  [255:0]   M_AXIS_LJ_EnE_Force10    ;
wire  [255:0]   M_AXIS_LJ_EnE_Force11    ;
wire  [255:0]   M_AXIS_LJ_EnE_Force12    ;
wire  [255:0]   M_AXIS_LJ_EnE_Force13    ;
wire  [255:0]   M_AXIS_LJ_EnE_Force14    ;

wire  [255:0]   M_AXIS_Col_EnE_Force1 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force2 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force3 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force4 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force5 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force6 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force7 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force8 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force9 ;  
wire  [255:0]   M_AXIS_Col_EnE_Force10;  
wire  [255:0]   M_AXIS_Col_EnE_Force11;  
wire  [255:0]   M_AXIS_Col_EnE_Force12;  
wire  [255:0]   M_AXIS_Col_EnE_Force13;  
wire  [255:0]   M_AXIS_Col_EnE_Force14;  

wire             h0_COMP_Begin           ;
wire             h1_COMP_Begin           ;
wire             n1_COMP_Begin           ;
wire             n2_COMP_Begin           ;
wire             n3_COMP_Begin           ;
wire             n4_COMP_Begin           ;
wire             n5_COMP_Begin           ;
wire             n6_COMP_Begin           ;
wire             n7_COMP_Begin           ;
wire             n8_COMP_Begin           ;
wire             n9_COMP_Begin           ;
wire             n10_COMP_Begin          ;
wire             n11_COMP_Begin          ;
wire             n12_COMP_Begin          ;
wire             n13_COMP_Begin          ;

wire             M_AXIS_Hom1Force_done  ; 
wire             M_AXIS_Nei1Force_done  ;
wire             M_AXIS_Nei2Force_done  ;
wire             M_AXIS_Nei3Force_done  ;
wire             M_AXIS_Nei4Force_done  ;
wire             M_AXIS_Nei5Force_done  ;
wire             M_AXIS_Nei6Force_done  ;
wire             M_AXIS_Nei7Force_done  ;      
wire             M_AXIS_Nei8Force_done  ;
wire             M_AXIS_Nei9Force_done  ;
wire             M_AXIS_Nei10Force_done ;
wire             M_AXIS_Nei11Force_done ;
wire             M_AXIS_Nei12Force_done ;
wire             M_AXIS_Nei13Force_done  ; 

wire             M_AXIS_col_Hom1Force_done  ;  
wire             M_AXIS_col_Nei1Force_done  ;  
wire             M_AXIS_col_Nei2Force_done  ;  
wire             M_AXIS_col_Nei3Force_done  ;  
wire             M_AXIS_col_Nei4Force_done  ;  
wire             M_AXIS_col_Nei5Force_done  ;  
wire             M_AXIS_col_Nei6Force_done  ;  
wire             M_AXIS_col_Nei7Force_done  ;  
wire             M_AXIS_col_Nei8Force_done  ;  
wire             M_AXIS_col_Nei9Force_done  ;  
wire             M_AXIS_col_Nei10Force_done ;  
wire             M_AXIS_col_Nei11Force_done ;  
wire             M_AXIS_col_Nei12Force_done ;  
wire             M_AXIS_col_Nei13Force_done  ; 

wire             Home0_cell_Rd_module_en ;
wire             Home1_cell_Rd_module_en ;
wire             Nei1_cell_Rd_module_en  ;
wire             Nei2_cell_Rd_module_en  ;
wire             Nei3_cell_Rd_module_en  ;
wire             Nei4_cell_Rd_module_en  ;
wire             Nei5_cell_Rd_module_en  ;
wire             Nei6_cell_Rd_module_en  ;
wire             Nei7_cell_Rd_module_en  ;
wire             Nei8_cell_Rd_module_en  ;
wire             Nei9_cell_Rd_module_en  ;
wire             Nei10_cell_Rd_module_en ;
wire             Nei11_cell_Rd_module_en ;
wire             Nei12_cell_Rd_module_en ;
wire             Nei13_cell_Rd_module_en ;

wire             Home1_subcell_finish    ;
wire             Nei1_subcell_finish     ;
wire             Nei2_subcell_finish     ;
wire             Nei3_subcell_finish     ;
wire             Nei4_subcell_finish     ;
wire             Nei5_subcell_finish     ;
wire             Nei6_subcell_finish     ;
wire             Nei7_subcell_finish     ;
wire             Nei8_subcell_finish     ;
wire             Nei9_subcell_finish     ;
wire             Nei10_subcell_finish    ;
wire             Nei11_subcell_finish    ;
wire             Nei12_subcell_finish    ;
wire             Nei13_subcell_finish    ;
 //==========================================================================================================     
    
Ram_to_Subcell_Ram  U_Ram_to_Subcell_Ram(
  . Sys_Clk                          ( Sys_Clk                        )    ,
  . Sys_Rst_n                        ( Sys_Rst_n                      )    ,
  . Update_ALL_Force_Ram_done        ( Update_ALL_Force_Ram_done      )    ,
  . Subcell_pass_done                ( Subcell_pass_done              )    ,
  
  . Home0_Ptcal_Num                  (   Home0_Ptcal_Num              )    ,
  . Home1_Ptcal_Num                  (   Home1_Ptcal_Num              )    ,
  . Nei1_Ptcal_Num                   (   Nei1_Ptcal_Num               )    ,
  . Nei2_Ptcal_Num                   (   Nei2_Ptcal_Num               ),
  . Nei3_Ptcal_Num                   (   Nei3_Ptcal_Num               ),
  . Nei4_Ptcal_Num                   (   Nei4_Ptcal_Num               ),
  . Nei5_Ptcal_Num                   (   Nei5_Ptcal_Num               ),
  . Nei6_Ptcal_Num                   (   Nei6_Ptcal_Num               ),
  . Nei7_Ptcal_Num                   (   Nei7_Ptcal_Num               ),
  . Nei8_Ptcal_Num                   (   Nei8_Ptcal_Num               ),
  . Nei9_Ptcal_Num                   (   Nei9_Ptcal_Num               ),
  . Nei10_Ptcal_Num                  (   Nei10_Ptcal_Num              ),
  . Nei11_Ptcal_Num                  (   Nei11_Ptcal_Num              ),
  . Nei12_Ptcal_Num                  (   Nei12_Ptcal_Num              ),
  . Nei13_Ptcal_Num                  (   Nei13_Ptcal_Num              ),
  . Home0_cell_cal_finish            (   Home0cell_cal_finish         )    ,
  
  .  Home0_cell_Rd_module_en         ( Home0_cell_Rd_module_en ) ,   
  .  Home1_cell_Rd_module_en         ( Home1_cell_Rd_module_en ) ,   
  .  Nei1_cell_Rd_module_en          ( Nei1_cell_Rd_module_en  ) ,   
  .  Nei2_cell_Rd_module_en          ( Nei2_cell_Rd_module_en  ) ,   
  .  Nei3_cell_Rd_module_en          ( Nei3_cell_Rd_module_en  ) ,   
  .  Nei4_cell_Rd_module_en          ( Nei4_cell_Rd_module_en  ) ,   
  .  Nei5_cell_Rd_module_en          ( Nei5_cell_Rd_module_en  ) ,   
  .  Nei6_cell_Rd_module_en          ( Nei6_cell_Rd_module_en  ) ,   
  .  Nei7_cell_Rd_module_en          ( Nei7_cell_Rd_module_en  ) ,   
  .  Nei8_cell_Rd_module_en          ( Nei8_cell_Rd_module_en  ) ,   
  .  Nei9_cell_Rd_module_en          ( Nei9_cell_Rd_module_en  ) ,   
  .  Nei10_cell_Rd_module_en         ( Nei10_cell_Rd_module_en ) ,   
  .  Nei11_cell_Rd_module_en         ( Nei11_cell_Rd_module_en ) ,   
  .  Nei12_cell_Rd_module_en         ( Nei12_cell_Rd_module_en ) ,   
  .  Nei13_cell_Rd_module_en         ( Nei13_cell_Rd_module_en ) ,                                                                      

  . S_AXIS_Hom1Force_done             ( M_AXIS_Hom1Force_done  ), 
  . S_AXIS_Nei1Force_done             ( M_AXIS_Nei1Force_done  ),
  . S_AXIS_Nei2Force_done             ( M_AXIS_Nei2Force_done  ),
  . S_AXIS_Nei3Force_done             ( M_AXIS_Nei3Force_done  ),
  . S_AXIS_Nei4Force_done             ( M_AXIS_Nei4Force_done  ),
  . S_AXIS_Nei5Force_done             ( M_AXIS_Nei5Force_done  ),
  . S_AXIS_Nei6Force_done             ( M_AXIS_Nei6Force_done  ),
  . S_AXIS_Nei7Force_done             ( M_AXIS_Nei7Force_done  ),
  . S_AXIS_Nei8Force_done             ( M_AXIS_Nei8Force_done  ),
  . S_AXIS_Nei9Force_done             ( M_AXIS_Nei9Force_done  ),
  . S_AXIS_Nei10Force_done            ( M_AXIS_Nei10Force_done ),
  . S_AXIS_Nei11Force_done            ( M_AXIS_Nei11Force_done ),
  . S_AXIS_Nei12Force_done            ( M_AXIS_Nei12Force_done ),
  . S_AXIS_Nei13Force_done            ( M_AXIS_Nei13Force_done ),
  
   . Home1_subcell_finish             (Home1_subcell_finish      ),
   . Nei1_subcell_finish              (Nei1_subcell_finish       ),
   . Nei2_subcell_finish              (Nei2_subcell_finish       ),
   . Nei3_subcell_finish              (Nei3_subcell_finish       ),
   . Nei4_subcell_finish              (Nei4_subcell_finish       ),
   . Nei5_subcell_finish              (Nei5_subcell_finish       ),
   . Nei6_subcell_finish              (Nei6_subcell_finish       ),
   . Nei7_subcell_finish              (Nei7_subcell_finish       ),
   . Nei8_subcell_finish              (Nei8_subcell_finish       ),
   . Nei9_subcell_finish              (Nei9_subcell_finish       ),
   . Nei10_subcell_finish             (Nei10_subcell_finish      ),
   . Nei11_subcell_finish             (Nei11_subcell_finish      ),
   . Nei12_subcell_finish             (Nei12_subcell_finish      ),
   . Nei13_subcell_finish             (Nei13_subcell_finish      ) 
  
  
    
    );
    

  //==========================================================================================================    
  //==========================================================================================================    
   
INIT_DATA_TO_SUBCELLRAM U_INIT_DATA_TO_SUBCELLRAM(    
   . Sys_Clk                            (    Sys_Clk                   ),    
   . Sys_Rst_n                          (    Sys_Rst_n                 ),    
  . work_en  (work_en),
  . Par_num                             (    Par_num                   ),
   . Home0_Ptcal_Num                    (    Home0_Ptcal_Num           ),    
   . Home1_Ptcal_Num                    (    Home1_Ptcal_Num           ),    
   . Nei1_Ptcal_Num                     (    Nei1_Ptcal_Num            ),
   . Nei2_Ptcal_Num                     (    Nei2_Ptcal_Num            ),      
   . Nei3_Ptcal_Num                     (    Nei3_Ptcal_Num            ),
   . Nei4_Ptcal_Num                     (    Nei4_Ptcal_Num            ),
   . Nei5_Ptcal_Num                     (    Nei5_Ptcal_Num            ),
   . Nei6_Ptcal_Num                     (    Nei6_Ptcal_Num            ),
   . Nei7_Ptcal_Num                     (    Nei7_Ptcal_Num            ),
   . Nei8_Ptcal_Num                     (    Nei8_Ptcal_Num            ),
   . Nei9_Ptcal_Num                     (    Nei9_Ptcal_Num            ),
   . Nei10_Ptcal_Num                    (    Nei10_Ptcal_Num           ),
   . Nei11_Ptcal_Num                    (    Nei11_Ptcal_Num           ),
   . Nei12_Ptcal_Num                    (    Nei12_Ptcal_Num           ),
   . Nei13_Ptcal_Num                    (    Nei13_Ptcal_Num           ),  
                             
   . M_AXIS_New_tDone                   (    M_AXIS_New_tDone          ) ,                
   . Subcell_pass_done                  (    Subcell_pass_done         ) ,  
   
   . S_AXIS_ram_Rd_addr                 (    S_AXIS_ram_Rd_addr        ),
   . S_AXIS_ram_rd_data                 (    S_AXIS_ram_rd_data        ),

   . S_AXIS_home0ram_Rd_addr            (    M_AXIS_home0Ram_rd_Addr   ),
   . S_AXIS_home0ram_rd_data            (    S_AXIS_home0Ram_tData     ),

   . S_AXIS_home1ram_Rd_addr            (    M_AXIS_home1Ram_rd_Addr   ),
   . S_AXIS_home1ram_rd_data            (    S_AXIS_home1Ram_tData     ),
      
   . S_AXIS_Nei1ram_Rd_addr             (    M_AXIS_Nei1Ram_rd_Addr   ),
   . S_AXIS_Nei1ram_rd_data             (    S_AXIS_Nei1Ram_tData     ),
                                                 
   .S_AXIS_Nei2ram_Rd_addr              (M_AXIS_Nei2Ram_rd_Addr )  , 
   .S_AXIS_Nei2ram_rd_data              (S_AXIS_Nei2Ram_tData   )  , 
                                                           
   .S_AXIS_Nei3ram_Rd_addr              (M_AXIS_Nei3Ram_rd_Addr )  , 
   .S_AXIS_Nei3ram_rd_data              (S_AXIS_Nei3Ram_tData   )  , 
                                                           
   .S_AXIS_Nei4ram_Rd_addr              (M_AXIS_Nei4Ram_rd_Addr  )  , 
   .S_AXIS_Nei4ram_rd_data              (S_AXIS_Nei4Ram_tData    )  , 
                                                       
   .S_AXIS_Nei5ram_Rd_addr              (M_AXIS_Nei5Ram_rd_Addr  )  , 
   .S_AXIS_Nei5ram_rd_data              (S_AXIS_Nei5Ram_tData    )  , 
                                                          
   .S_AXIS_Nei6ram_Rd_addr              (M_AXIS_Nei6Ram_rd_Addr  )  , 
   .S_AXIS_Nei6ram_rd_data              (S_AXIS_Nei6Ram_tData    )  , 
                                                    
   .S_AXIS_Nei7ram_Rd_addr              (M_AXIS_Nei7Ram_rd_Addr )  , 
   .S_AXIS_Nei7ram_rd_data              (S_AXIS_Nei7Ram_tData   )  , 

   .S_AXIS_Nei8ram_Rd_addr              (M_AXIS_Nei8Ram_rd_Addr )  , 
   .S_AXIS_Nei8ram_rd_data              (S_AXIS_Nei8Ram_tData   )  , 
                                                           
   .S_AXIS_Nei9ram_Rd_addr              (M_AXIS_Nei9Ram_rd_Addr  )  , 
   .S_AXIS_Nei9ram_rd_data              (S_AXIS_Nei9Ram_tData    )  , 
                                                            
   .S_AXIS_Nei10ram_Rd_addr             (M_AXIS_Nei10Ram_rd_Addr )   ,
   .S_AXIS_Nei10ram_rd_data             (S_AXIS_Nei10Ram_tData   )   ,
                                                           
   .S_AXIS_Nei11ram_Rd_addr             (M_AXIS_Nei11Ram_rd_Addr)   ,
   .S_AXIS_Nei11ram_rd_data             (S_AXIS_Nei11Ram_tData  )   ,
              
   .S_AXIS_Nei12ram_Rd_addr             (M_AXIS_Nei12Ram_rd_Addr)          ,
   .S_AXIS_Nei12ram_rd_data             (S_AXIS_Nei12Ram_tData  )          ,
                                                                          
   .S_AXIS_Nei13ram_Rd_addr             (M_AXIS_Nei13Ram_rd_Addr)          ,
   .S_AXIS_Nei13ram_rd_data             (S_AXIS_Nei13Ram_tData  )
                            
    );
 //==========================================================================================================
 //==========================================================================================================  
 Subram_Rd_cotr  home0_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Home0_cell_Rd_module_en      )      ,//when new cell position updata
    .Subcell_finish                  ( Home0cell_cal_finish         )      ,
    . Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_home0Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_home0Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_home0_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_home0_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_home0_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_home0_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( h0_COMP_Begin                 )            //                                                                                          
    );
 
 Subram_Rd_cotr  home1_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Home1_cell_Rd_module_en      )      ,//when new cell position updata
    .Subcell_finish                  (  Home1_subcell_finish        )      ,  
    .Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_home1Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_home1Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_home1_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_home1_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_home1_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_home1_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( h1_COMP_Begin                 )              //                          
                                                     
    );
 
 Subram_Rd_cotr  Nei1_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei1_cell_Rd_module_en     )      ,//when new cell position updata
    .Subcell_finish                  ( Nei1_subcell_finish       )    ,      
    .Home0_cell_cal_finish           ( Home0cell_cal_finish         )      ,
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei1Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei1Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei1_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei1_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei1_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei1_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n1_COMP_Begin               )              //                          
                                                         
    );
 
  
 Subram_Rd_cotr  Nei2_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei2_cell_Rd_module_en      )      ,//when new cell position updata
    .Subcell_finish                  ( Nei2_subcell_finish        )    ,   
    .Home0_cell_cal_finish           ( Home0cell_cal_finish         )      ,      
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei2Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei2Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei2_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei2_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei2_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei2_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n2_COMP_Begin               )               //                          
                                                               
    );
 
   
 Subram_Rd_cotr  Nei3_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei3_cell_Rd_module_en      )      ,//when new cell position updata
    . Subcell_finish                 ( Nei3_subcell_finish      )    ,   
    . Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,   

    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei3Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei3Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei3_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei3_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei3_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei3_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n3_COMP_Begin               )              //                          
                                                   
    );
 
 
  Subram_Rd_cotr  Nei4_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    . Subcell_Rd_en                   ( Nei4_cell_Rd_module_en    )      ,//when new cell position updata
    . Subcell_finish                 ( Nei4_subcell_finish      )    ,    
    . Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,

    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei4Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei4Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei4_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei4_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei4_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei4_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n4_COMP_Begin               )               //                          
                                                          
    );
 
 
  Subram_Rd_cotr  Nei5_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei5_cell_Rd_module_en     )      ,//when new cell position updata
    .Subcell_finish                  ( Nei5_subcell_finish        )    ,   
    .Home0_cell_cal_finish           ( Home0cell_cal_finish         )      ,
 
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei5Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei5Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei5_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei5_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei5_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei5_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n5_COMP_Begin               )              //                          
                                                                
    );
 
  Subram_Rd_cotr  Nei6_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                    ( Nei6_cell_Rd_module_en    )      ,//when new cell position updata
    .Subcell_finish                   ( Nei6_subcell_finish      )    ,     
    .Home0_cell_cal_finish            ( Home0cell_cal_finish         )      ,
    .M_AXIS_homeRam_rd_Addr           ( M_AXIS_Nei6Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData             ( S_AXIS_Nei6Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei6_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei6_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei6_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei6_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n6_COMP_Begin               )              //                          
                                                            
    );
    
    
 
  Subram_Rd_cotr  Nei7_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei7_cell_Rd_module_en     )      ,//when new cell position updata
    .Subcell_finish                  ( Nei7_subcell_finish      )    ,    
    .Home0_cell_cal_finish           ( Home0cell_cal_finish         )      ,     
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei7Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei7Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei7_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei7_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei7_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei7_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n7_COMP_Begin               )               //                          
                                                               
    );
 
 
   Subram_Rd_cotr  Nei8_Rd_cotr(
    . Sys_Clk                         ( Sys_Clk                      )      ,
    . Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    . Subcell_Rd_en                  ( Nei8_cell_Rd_module_en     )      ,//when new cell position updata
    . Subcell_finish                 ( Nei8_subcell_finish        )    ,     
    . Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,

    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei8Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei8Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei8_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei8_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei8_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei8_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n8_COMP_Begin               )               //                          
                                                              
    );
 
 
    Subram_Rd_cotr  Nei9_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    . Subcell_Rd_en                  (   Nei9_cell_Rd_module_en      )      ,//when new cell position updata
    . Subcell_finish                 (   Nei9_subcell_finish         )    , 
    . Home0_cell_cal_finish          (   Home0cell_cal_finish        )      ,              

    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei9Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei9Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei9_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei9_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei9_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei9_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n9_COMP_Begin               )              //                          
                                                                 
    );
    
 
     Subram_Rd_cotr  Nei10_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    . Subcell_Rd_en                  ( Nei10_cell_Rd_module_en     )      ,//when new cell position updata
    . Subcell_finish                 ( Nei10_subcell_finish        )    ,      
    . Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,        

    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei10Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei10Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei10_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei10_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei10_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei10_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n10_COMP_Begin               )               //                          
                                                         
    );
    
    
    
     Subram_Rd_cotr  Nei11_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                   ( Nei11_cell_Rd_module_en      )      ,//when new cell position updata
    .Subcell_finish                  ( Nei11_subcell_finish         )      , 
    .Home0_cell_cal_finish           ( Home0cell_cal_finish         )      ,       
 
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei11Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei11Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei11_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei11_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei11_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei11_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n11_COMP_Begin               )              //                          
                                                                
    );
 
     
     Subram_Rd_cotr  Nei12_Rd_cotr(
    . Sys_Clk                         ( Sys_Clk                      )      ,
    . Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    . Subcell_Rd_en                  (   Nei12_cell_Rd_module_en      )      , //when new cell position updata
    . Subcell_finish                 (   Nei12_subcell_finish         )      ,   
    . Home0_cell_cal_finish          (   Home0cell_cal_finish         )      ,      

    . M_AXIS_homeRam_rd_Addr         ( M_AXIS_Nei12Ram_rd_Addr      )       ,
    . S_AXIS_homeRam_tData           ( S_AXIS_Nei12Ram_tData        )       ,
                                      
    . M_AXIS_X_Pos_buf                ( M_Nei12_X_Pos_buf             )        ,
    . M_AXIS_Y_Pos_buf                ( M_Nei12_Y_Pos_buf             )        ,
    . M_AXIS_Z_Pos_buf                ( M_Nei12_Z_Pos_buf             )        ,     
    . M_AXIS_Index_buf                ( M_Nei12_Index_buf             )        ,              
                                     
    . M_AXIS_COMP_Begin               ( n12_COMP_Begin               )             //                          
                                                               
    );
 
 
      Subram_Rd_cotr  Nei13_Rd_cotr(
    .Sys_Clk                         ( Sys_Clk                      )      ,
    .Sys_Rst_n                       ( Sys_Rst_n                    )      ,              
                                     
    .Subcell_Rd_en                  ( Nei13_cell_Rd_module_en     )      ,//when new cell position updata
    .Subcell_finish                 (  Nei13_subcell_finish      )    ,    
    .Home0_cell_cal_finish          ( Home0cell_cal_finish         )      ,  
    .M_AXIS_homeRam_rd_Addr          ( M_AXIS_Nei13Ram_rd_Addr      )       ,
    .S_AXIS_homeRam_tData            ( S_AXIS_Nei13Ram_tData        )       ,
                                       
    .M_AXIS_X_Pos_buf                ( M_Nei13_X_Pos_buf             )        ,
    .M_AXIS_Y_Pos_buf                ( M_Nei13_Y_Pos_buf             )        ,
    .M_AXIS_Z_Pos_buf                ( M_Nei13_Z_Pos_buf             )        ,     
    .M_AXIS_Index_buf                ( M_Nei13_Index_buf             )        ,              
                                     
    .M_AXIS_COMP_Begin               ( n13_COMP_Begin               )               //                          
                                                               
    );



 //========================================================================================================== 
 //==========================================================================================================  
         
COMP_Module_top home0_home1_COMP(
      . Sys_Clk                   ( Sys_Clk                  )     ,
      . Sys_Rst_n                 ( Sys_Rst_n                )     ,
      . Home0_cell_cal_finish     ( Home0cell_cal_finish)      ,                                                                //to next caculation unit           
      . S_AXIS_COMP_Begin         ( h0_COMP_Begin            )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin       ( h1_COMP_Begin            )     ,     
 
      . M_AXIS_Force_done         ( M_AXIS_Hom1Force_done    )     ,
      . M_AXIS_col_Force_done      ( M_AXIS_col_Hom1Force_done    )     ,
      
      . M_AXIS_LJ_EnE_Force       ( M_AXIS_LJ_EnE_Force1 ),   
    . M_AXIS_Col_EnE_Force        ( M_AXIS_Col_EnE_Force1  ),       
      . X_Pos_buf                 ( M_home0_X_Pos_buf        )     ,    
      . Y_Pos_buf                 ( M_home0_Y_Pos_buf        )     ,    
      . Z_Pos_buf                 ( M_home0_Z_Pos_buf        )     ,    
                                                    
      . X_Pos_buf_nei             ( M_home1_X_Pos_buf        )     ,
      . Y_Pos_buf_nei             ( M_home1_Y_Pos_buf        )     ,
      . Z_Pos_buf_nei             ( M_home1_Z_Pos_buf        )     ,  
       
    .  S_AXIS_home_Index_buf      (M_home0_Index_buf), 
    .  S_AXIS_Index_buf           (M_home1_Index_buf)            
        
    
    );    
    



COMP_Module_top home0_Nei1_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
       .Home0_cell_cal_finish    (Home0cell_cal_finish    )      ,                                                              //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin           )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n1_COMP_Begin           )     ,     
 
     
      . M_AXIS_Force_done       (M_AXIS_Nei1Force_done ) ,
       . M_AXIS_col_Force_done      ( M_AXIS_col_Nei1Force_done    )     ,
      . S_AXIS_home_Index_buf   (M_home0_Index_buf), 
      . S_AXIS_Index_buf        (M_Nei1_Index_buf),              
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                  
      . X_Pos_buf_nei           ( M_Nei1_X_Pos_buf      ) ,
      . Y_Pos_buf_nei           ( M_Nei1_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei           ( M_Nei1_Z_Pos_buf      ) ,   
       
      . M_AXIS_LJ_EnE_Force     (M_AXIS_LJ_EnE_Force2 )  ,
     . M_AXIS_Col_EnE_Force    ( M_AXIS_Col_EnE_Force2  )                                                                                   
  
    );    
    

    
    
  COMP_Module_top   home0_Nei2_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      . Home0_cell_cal_finish    (Home0cell_cal_finish   )      ,                                                          //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin          )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n2_COMP_Begin          )     ,     
  
      . M_AXIS_Force_done        (M_AXIS_Nei2Force_done ) ,
    . M_AXIS_col_Force_done      ( M_AXIS_col_Nei2Force_done    )     ,
      .  S_AXIS_home_Index_buf   (M_home0_Index_buf), 
      .  S_AXIS_Index_buf        (M_Nei2_Index_buf),             
       . X_Pos_buf               (M_home0_X_Pos_buf    ),    
       . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
       . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                     
       . X_Pos_buf_nei           ( M_Nei2_X_Pos_buf      ) ,
       . Y_Pos_buf_nei           ( M_Nei2_Y_Pos_buf      ) ,
       . Z_Pos_buf_nei           ( M_Nei2_Z_Pos_buf      ) ,  
       . M_AXIS_LJ_EnE_Force     (M_AXIS_LJ_EnE_Force3 )   ,
     . M_AXIS_Col_EnE_Force    ( M_AXIS_Col_EnE_Force3  )                                                          
    
    );    
      

    
   COMP_Module_top  home0_Nei3_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      .Home0_cell_cal_finish     (Home0cell_cal_finish )      ,                                                       //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin        )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n3_COMP_Begin        )     ,     
   
      . M_AXIS_Force_done        (M_AXIS_Nei3Force_done ) ,
      . M_AXIS_col_Force_done   ( M_AXIS_col_Nei3Force_done    )     ,
      . S_AXIS_home_Index_buf    (M_home0_Index_buf), 
      . S_AXIS_Index_buf         (M_Nei3_Index_buf),           
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                  
      . X_Pos_buf_nei           ( M_Nei3_X_Pos_buf      ) ,
      . Y_Pos_buf_nei           ( M_Nei3_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei           ( M_Nei3_Z_Pos_buf      ) ,        
      . M_AXIS_LJ_EnE_Force     (M_AXIS_LJ_EnE_Force4 )   ,                                                  
     . M_AXIS_Col_EnE_Force    ( M_AXIS_Col_EnE_Force4  )                             
     
    );    
      
    

 
 
COMP_Module_top home0_Nei4_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      .Home0_cell_cal_finish     (Home0cell_cal_finish)      ,                                                           //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin           )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n4_COMP_Begin           )     ,     
  
      . M_AXIS_Force_done       (M_AXIS_Nei4Force_done ) ,
        . M_AXIS_col_Force_done      ( M_AXIS_col_Nei4Force_done    )     ,
      . S_AXIS_home_Index_buf   (M_home0_Index_buf), 
      
      . S_AXIS_Index_buf        (M_Nei4_Index_buf),              
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                  
      . X_Pos_buf_nei           ( M_Nei4_X_Pos_buf      ) ,
      . Y_Pos_buf_nei           ( M_Nei4_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei           ( M_Nei4_Z_Pos_buf      ) ,    
      . M_AXIS_LJ_EnE_Force      (M_AXIS_LJ_EnE_Force5 )   ,
      . M_AXIS_Col_EnE_Force     ( M_AXIS_Col_EnE_Force5  )                                                     
  
    );    
    
 
 COMP_Module_top  home0_Nei5_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      . Home0_cell_cal_finish    (Home0cell_cal_finish)      ,                                                            //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin              )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n5_COMP_Begin              )     ,     

        . M_AXIS_Force_done       (M_AXIS_Nei5Force_done ) ,
       . M_AXIS_col_Force_done      ( M_AXIS_col_Nei5Force_done    )     ,
        . S_AXIS_home_Index_buf   (M_home0_Index_buf), 
        . S_AXIS_Index_buf        (M_Nei5_Index_buf),           
         . X_Pos_buf               (M_home0_X_Pos_buf    ),    
         . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
         . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                     
         . X_Pos_buf_nei           ( M_Nei5_X_Pos_buf      ) ,
         . Y_Pos_buf_nei           ( M_Nei5_Y_Pos_buf      ) ,
         . Z_Pos_buf_nei           ( M_Nei5_Z_Pos_buf      ) ,       
         . M_AXIS_LJ_EnE_Force     (  M_AXIS_LJ_EnE_Force6 )  ,
       . M_AXIS_Col_EnE_Force    (   M_AXIS_Col_EnE_Force6  )                                                        
                             
 
    );    
     
    
    
 
  COMP_Module_top  home0_Nei6_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      . Home0_cell_cal_finish    (Home0cell_cal_finish)      ,                                                            //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin           )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n6_COMP_Begin           )     ,     
        
      . M_AXIS_Force_done        (M_AXIS_Nei6Force_done ) ,
     . M_AXIS_col_Force_done      ( M_AXIS_col_Nei6Force_done    )     ,
      . S_AXIS_home_Index_buf    (M_home0_Index_buf), 
      . S_AXIS_Index_buf         (M_Nei6_Index_buf),           
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                  
      . X_Pos_buf_nei           ( M_Nei6_X_Pos_buf      ) ,
      . Y_Pos_buf_nei           ( M_Nei6_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei           ( M_Nei6_Z_Pos_buf      ) ,      
      . M_AXIS_LJ_EnE_Force     ( M_AXIS_LJ_EnE_Force7 )  ,
     . M_AXIS_Col_EnE_Force    (   M_AXIS_Col_EnE_Force7  )                                                  
                             
    
    );    
    

 
  COMP_Module_top  home0_Nei7_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      .Home0_cell_cal_finish       (Home0cell_cal_finish)      ,                                                          //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin           )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n7_COMP_Begin           )     ,     
    
      . M_AXIS_Force_done        (M_AXIS_Nei7Force_done ) ,
      . M_AXIS_col_Force_done      ( M_AXIS_col_Nei7Force_done    )     ,
       . S_AXIS_home_Index_buf   (M_home0_Index_buf), 
       . S_AXIS_Index_buf        (M_Nei7_Index_buf),           
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                  
      . X_Pos_buf_nei           ( M_Nei7_X_Pos_buf      ) ,
      . Y_Pos_buf_nei           ( M_Nei7_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei           ( M_Nei7_Z_Pos_buf      ) ,     
      . M_AXIS_LJ_EnE_Force     ( M_AXIS_LJ_EnE_Force8 )   ,                                                
     . M_AXIS_Col_EnE_Force    (   M_AXIS_Col_EnE_Force8 )             

    );    
    
    

 
  COMP_Module_top  home0_Nei8_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      .Home0_cell_cal_finish       (Home0cell_cal_finish)      ,                                                          //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin            )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n8_COMP_Begin            )     ,     
 
      . M_AXIS_Force_done        (M_AXIS_Nei8Force_done ) ,
     . M_AXIS_col_Force_done      ( M_AXIS_col_Nei8Force_done    )     ,
      . S_AXIS_home_Index_buf    (M_home0_Index_buf), 
       . S_AXIS_Index_buf         (M_Nei8_Index_buf),           
         . X_Pos_buf               (M_home0_X_Pos_buf    ),    
         . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
         . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                     
         . X_Pos_buf_nei           ( M_Nei8_X_Pos_buf      ) ,
         . Y_Pos_buf_nei           ( M_Nei8_Y_Pos_buf      ) ,
         . Z_Pos_buf_nei           ( M_Nei8_Z_Pos_buf      ) ,     
        
         . M_AXIS_LJ_EnE_Force       (M_AXIS_LJ_EnE_Force9)   ,                                                   
       . M_AXIS_Col_EnE_Force      (   M_AXIS_Col_EnE_Force9  )                        

    );    
     
    
  
 
  COMP_Module_top home0_Nei9_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      .Home0_cell_cal_finish     (Home0cell_cal_finish)      ,                                                           //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin          )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n9_COMP_Begin          )     ,     
   
      .  M_AXIS_Force_done         (M_AXIS_Nei9Force_done ) , 
     . M_AXIS_col_Force_done      ( M_AXIS_col_Nei9Force_done    )     , 
      .  S_AXIS_home_Index_buf    (M_home0_Index_buf), 
      .  S_AXIS_Index_buf         (M_Nei9_Index_buf),           
      . X_Pos_buf               (M_home0_X_Pos_buf    ),    
      . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
      . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                     
         . X_Pos_buf_nei           ( M_Nei9_X_Pos_buf      ) ,
         . Y_Pos_buf_nei           ( M_Nei9_Y_Pos_buf      ) ,
         . Z_Pos_buf_nei           ( M_Nei9_Z_Pos_buf      ) ,    
        
        . M_AXIS_LJ_EnE_Force       (M_AXIS_LJ_EnE_Force10 )   ,                                                
        . M_AXIS_Col_EnE_Force    (M_AXIS_Col_EnE_Force10  )           
  
    );    
    

  COMP_Module_top  home0_Nei10_COMP(
         . Sys_Clk                  (Sys_Clk                  )     ,
         . Sys_Rst_n                (Sys_Rst_n                )     ,
         . Home0_cell_cal_finish    (Home0cell_cal_finish    )      ,      
                                                            //to next caculation unit           
        . S_AXIS_COMP_Begin        (h0_COMP_Begin           )     ,         //previous input, enable XYZ buf  
        . S_AXIS_COMP_2_Begin      (n10_COMP_Begin          )     ,     
    
        . M_AXIS_Force_done        (M_AXIS_Nei10Force_done ) ,
        . M_AXIS_col_Force_done    ( M_AXIS_col_Nei10Force_done    )     ,
        . S_AXIS_home_Index_buf    (M_home0_Index_buf), 
        . S_AXIS_Index_buf         (M_Nei10_Index_buf),     
              
         . X_Pos_buf               (M_home0_X_Pos_buf    ),    
         . Y_Pos_buf               (M_home0_Y_Pos_buf    ),    
         . Z_Pos_buf               (M_home0_Z_Pos_buf    ),    
                                                     
         . X_Pos_buf_nei           ( M_Nei10_X_Pos_buf      ) ,
         . Y_Pos_buf_nei           ( M_Nei10_Y_Pos_buf      ) ,
         . Z_Pos_buf_nei           ( M_Nei10_Z_Pos_buf      ) ,    
       
         . M_AXIS_LJ_EnE_Force     ( M_AXIS_LJ_EnE_Force11    )      ,                                               
       . M_AXIS_Col_EnE_Force    ( M_AXIS_Col_EnE_Force11  )                      
   
    );    
       

  COMP_Module_top  home0_Nei11_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      . Home0_cell_cal_finish    (Home0cell_cal_finish     )      ,                                                           //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin            )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n11_COMP_Begin           )     ,     
    
     . M_AXIS_Force_done       (M_AXIS_Nei11Force_done ) ,
     . M_AXIS_col_Force_done   ( M_AXIS_col_Nei11Force_done    )     ,
     . S_AXIS_home_Index_buf   (M_home0_Index_buf), 
     . S_AXIS_Index_buf        (M_Nei11_Index_buf),               
     . X_Pos_buf               (M_home0_X_Pos_buf      ),    
     . Y_Pos_buf               (M_home0_Y_Pos_buf      ),    
     . Z_Pos_buf               (M_home0_Z_Pos_buf      ),    
                                                 
     . X_Pos_buf_nei           ( M_Nei11_X_Pos_buf      ) ,
     . Y_Pos_buf_nei           ( M_Nei11_Y_Pos_buf      ) ,
     . Z_Pos_buf_nei           ( M_Nei11_Z_Pos_buf      ) ,    
     . M_AXIS_LJ_EnE_Force       (M_AXIS_LJ_EnE_Force12 )       ,                                              
     . M_AXIS_Col_EnE_Force      (M_AXIS_Col_EnE_Force12  )           
                             
    
    );    
       
    
 
 
  COMP_Module_top home0_Nei12_COMP(
      . Sys_Clk                  (Sys_Clk                  )     ,
      . Sys_Rst_n                (Sys_Rst_n                )     ,
      . Home0_cell_cal_finish     (Home0cell_cal_finish)      ,                                                            //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin             )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n12_COMP_Begin            )     ,     

      . M_AXIS_Force_done        (M_AXIS_Nei12Force_done    ) ,  
      . M_AXIS_col_Force_done      ( M_AXIS_col_Nei12Force_done    )     ,  
      . S_AXIS_home_Index_buf    (M_home0_Index_buf          ), 
      . S_AXIS_Index_buf         (M_Nei12_Index_buf          ),                 
      . X_Pos_buf                (M_home0_X_Pos_buf          ),    
      . Y_Pos_buf                (M_home0_Y_Pos_buf          ),    
      . Z_Pos_buf                (M_home0_Z_Pos_buf          ),    
                                                  
      . X_Pos_buf_nei            ( M_Nei12_X_Pos_buf      ) ,
      . Y_Pos_buf_nei            ( M_Nei12_Y_Pos_buf      ) ,
      . Z_Pos_buf_nei            ( M_Nei12_Z_Pos_buf      ) ,    
      
      . M_AXIS_LJ_EnE_Force      (M_AXIS_LJ_EnE_Force13 )   ,                                                  
      . M_AXIS_Col_EnE_Force     (M_AXIS_Col_EnE_Force13  )           
     
    );    
    

 
  COMP_Module_top  home0_Nei13_COMP(
      . Sys_Clk                  (Sys_Clk                    )     ,
      . Sys_Rst_n                (Sys_Rst_n                  )     ,
      . Home0_cell_cal_finish    (Home0cell_cal_finish)      ,                                                          //to next caculation unit           
      . S_AXIS_COMP_Begin        (h0_COMP_Begin              )     ,         //previous input, enable XYZ buf  
      . S_AXIS_COMP_2_Begin      (n13_COMP_Begin             )     ,     
     
      . M_AXIS_Force_done        (M_AXIS_Nei13Force_done     )     ,
      . M_AXIS_col_Force_done      ( M_AXIS_col_Nei13Force_done    )     ,
      . S_AXIS_home_Index_buf    (M_home0_Index_buf), 
      . S_AXIS_Index_buf         (M_Nei13_Index_buf),     
                  
      . X_Pos_buf                (M_home0_X_Pos_buf           ),      
      . Y_Pos_buf                (M_home0_Y_Pos_buf           ),      
      . Z_Pos_buf                (M_home0_Z_Pos_buf           ),      
                                                    
      . X_Pos_buf_nei            ( M_Nei13_X_Pos_buf          ) ,  
      . Y_Pos_buf_nei            ( M_Nei13_Y_Pos_buf          ) ,  
      . Z_Pos_buf_nei            ( M_Nei13_Z_Pos_buf          ) ,      
   
      . M_AXIS_LJ_EnE_Force       (M_AXIS_LJ_EnE_Force14 )    ,                                                                       
      . M_AXIS_Col_EnE_Force     ( M_AXIS_Col_EnE_Force14  )           
   
    );    
    
 //========================================================================================================== 
 //==========================================================================================================  
    
    
 Buff_2_fifo_top  U_Buff_2_fifo_top (
 . Sys_Clk                        (  Sys_Clk                     )            ,
 . Sys_Rst_n                      (  Sys_Rst_n                   )            ,
 . Subcell_pass_done              (  Subcell_pass_done           )            ,      
 . Update_ALL_Force_Ram_done      (  Update_ALL_Force_Ram_done   )            ,
 . Home0_cell_cal_finish          (  Home0cell_cal_finish        ),

 . M_AXIS_LJ_EnE_Force1           (M_AXIS_LJ_EnE_Force1          )            ,
 . M_AXIS_LJ_EnE_Force2           (M_AXIS_LJ_EnE_Force2          )            ,
 . M_AXIS_LJ_EnE_Force3           (M_AXIS_LJ_EnE_Force3          )            ,
 . M_AXIS_LJ_EnE_Force4           (M_AXIS_LJ_EnE_Force4          )            ,
 . M_AXIS_LJ_EnE_Force5           (M_AXIS_LJ_EnE_Force5          )            ,
 . M_AXIS_LJ_EnE_Force6           (M_AXIS_LJ_EnE_Force6          )            ,
 . M_AXIS_LJ_EnE_Force7           (M_AXIS_LJ_EnE_Force7          )            ,
 . M_AXIS_LJ_EnE_Force8           (M_AXIS_LJ_EnE_Force8          )            ,
 . M_AXIS_LJ_EnE_Force9           (M_AXIS_LJ_EnE_Force9          )            ,
 . M_AXIS_LJ_EnE_Force10          (M_AXIS_LJ_EnE_Force10         )            ,
 . M_AXIS_LJ_EnE_Force11          (M_AXIS_LJ_EnE_Force11         )            ,
 . M_AXIS_LJ_EnE_Force12          (M_AXIS_LJ_EnE_Force12         )            ,
 . M_AXIS_LJ_EnE_Force13          (M_AXIS_LJ_EnE_Force13         )            ,
 . M_AXIS_LJ_EnE_Force14          (M_AXIS_LJ_EnE_Force14         )            ,

.  Home0_Ptcal_Num                (Home0_Ptcal_Num               ),
.  Home1_Ptcal_Num                (Home1_Ptcal_Num               ),
.  Nei1_Ptcal_Num                 (Nei1_Ptcal_Num                ),
.  Nei2_Ptcal_Num                 (Nei2_Ptcal_Num                ),
.  Nei3_Ptcal_Num                 (Nei3_Ptcal_Num                ),
.  Nei4_Ptcal_Num                 (Nei4_Ptcal_Num                ),   
.  Nei5_Ptcal_Num                 (Nei5_Ptcal_Num                ),  
.  Nei6_Ptcal_Num                 (Nei6_Ptcal_Num                ),
.  Nei7_Ptcal_Num                 (Nei7_Ptcal_Num                ),            
.  Nei8_Ptcal_Num                 (Nei8_Ptcal_Num                ),           
.  Nei9_Ptcal_Num                 (Nei9_Ptcal_Num                ),            
.  Nei10_Ptcal_Num                (Nei10_Ptcal_Num               ),
.  Nei11_Ptcal_Num                (Nei11_Ptcal_Num               ),
.  Nei12_Ptcal_Num                (Nei12_Ptcal_Num               ),
.  Nei13_Ptcal_Num                (Nei13_Ptcal_Num               ),

 . S_AXIS_update_One_Done1        ( M_AXIS_Hom1Force_done        )           ,
 . S_AXIS_update_One_Done2        ( M_AXIS_Nei1Force_done        )           ,
 . S_AXIS_update_One_Done3        ( M_AXIS_Nei2Force_done        )           ,
 . S_AXIS_update_One_Done4        ( M_AXIS_Nei3Force_done        )           ,
 . S_AXIS_update_One_Done5        ( M_AXIS_Nei4Force_done        )           ,
 . S_AXIS_update_One_Done6        ( M_AXIS_Nei5Force_done        )           ,
 . S_AXIS_update_One_Done7        ( M_AXIS_Nei6Force_done        )           ,
 . S_AXIS_update_One_Done8        ( M_AXIS_Nei7Force_done        )           ,
 . S_AXIS_update_One_Done9        ( M_AXIS_Nei8Force_done        )           ,
 . S_AXIS_update_One_Done10       ( M_AXIS_Nei9Force_done        )           ,
 . S_AXIS_update_One_Done11       ( M_AXIS_Nei10Force_done       )           ,
 . S_AXIS_update_One_Done12       ( M_AXIS_Nei11Force_done       )           ,
 . S_AXIS_update_One_Done13       ( M_AXIS_Nei12Force_done       )           ,
 . S_AXIS_update_One_Done14       ( M_AXIS_Nei13Force_done       )           ,
 
 . M_AXIS_Update_ram_wr_en        ( M_AXIS_Update_ram_wr_en      )  ,
 . M_AXIS_Update_cnt              ( M_AXIS_Update_cnt            )  ,                        
 . M_AXIS_Update_ram_rd_data      ( M_AXIS_Update_ram_rd_data    )
    );    
    
    
    
 Buff_col_2_fifo_top Buff_col_2_fifo_top (
.  Sys_Clk                          (  Sys_Clk                         )            ,
.  Sys_Rst_n                        (  Sys_Rst_n                       )            ,
.  Subcell_pass_done                (  Subcell_pass_done               )            ,      
.  Update_Col_ALL_Force_Ram_done    (  Update_Col_ALL_Force_Ram_done   )            ,
.  Home0_cell_cal_finish            (  Home0cell_cal_finish            ),
.  Update_ALL_Force_Ram_done        (  Update_ALL_Force_Ram_done       ),
.  M_AXIS_Col_EnE_Force1            (M_AXIS_Col_EnE_Force1             ),
.  M_AXIS_Col_EnE_Force2            (M_AXIS_Col_EnE_Force2             ),
.  M_AXIS_Col_EnE_Force3            (M_AXIS_Col_EnE_Force3             ),
.  M_AXIS_Col_EnE_Force4            (M_AXIS_Col_EnE_Force4             ),
.  M_AXIS_Col_EnE_Force5            (M_AXIS_Col_EnE_Force5             ),
.  M_AXIS_Col_EnE_Force6            (M_AXIS_Col_EnE_Force6             ),
.  M_AXIS_Col_EnE_Force7            (M_AXIS_Col_EnE_Force7             ),
.  M_AXIS_Col_EnE_Force8            (M_AXIS_Col_EnE_Force8             ),
.  M_AXIS_Col_EnE_Force9            (M_AXIS_Col_EnE_Force9             ),
.  M_AXIS_Col_EnE_Force10           (M_AXIS_Col_EnE_Force10            ),
.  M_AXIS_Col_EnE_Force11           (M_AXIS_Col_EnE_Force11            ),
.  M_AXIS_Col_EnE_Force12           (M_AXIS_Col_EnE_Force12            ),
.  M_AXIS_Col_EnE_Force13           (M_AXIS_Col_EnE_Force13            ),
.  M_AXIS_Col_EnE_Force14           (M_AXIS_Col_EnE_Force14            ),
                             
.  Home0_Ptcal_Num                  (Home0_Ptcal_Num                   ),
.  Home1_Ptcal_Num                  (Home1_Ptcal_Num                   ),
.  Nei1_Ptcal_Num                   (Nei1_Ptcal_Num                    ),
.  Nei2_Ptcal_Num                   (Nei2_Ptcal_Num                    ),
.  Nei3_Ptcal_Num                   (Nei3_Ptcal_Num                    ),
.  Nei4_Ptcal_Num                   (Nei4_Ptcal_Num                    ),   
.  Nei5_Ptcal_Num                   (Nei5_Ptcal_Num                    ),  
.  Nei6_Ptcal_Num                   (Nei6_Ptcal_Num                    ),
.  Nei7_Ptcal_Num                   (Nei7_Ptcal_Num                    ),            
.  Nei8_Ptcal_Num                   (Nei8_Ptcal_Num                    ),           
.  Nei9_Ptcal_Num                   (Nei9_Ptcal_Num                    ),            
.  Nei10_Ptcal_Num                  (Nei10_Ptcal_Num                   ),
.  Nei11_Ptcal_Num                  (Nei11_Ptcal_Num                   ),
.  Nei12_Ptcal_Num                  (Nei12_Ptcal_Num                   ),
.  Nei13_Ptcal_Num                  (Nei13_Ptcal_Num                   ),

 . S_AXIS_update_Col_One_Done1      ( M_AXIS_col_Hom1Force_done        )           ,
 . S_AXIS_update_Col_One_Done2      ( M_AXIS_col_Nei1Force_done        )           ,
 . S_AXIS_update_Col_One_Done3      ( M_AXIS_col_Nei2Force_done        )           ,
 . S_AXIS_update_Col_One_Done4      ( M_AXIS_col_Nei3Force_done        )           ,
 . S_AXIS_update_Col_One_Done5      ( M_AXIS_col_Nei4Force_done        )           ,
 . S_AXIS_update_Col_One_Done6      ( M_AXIS_col_Nei5Force_done        )           ,
 . S_AXIS_update_Col_One_Done7      ( M_AXIS_col_Nei6Force_done        )           ,
 . S_AXIS_update_Col_One_Done8      ( M_AXIS_col_Nei7Force_done        )           ,
 . S_AXIS_update_Col_One_Done9      ( M_AXIS_col_Nei8Force_done        )           ,
 . S_AXIS_update_Col_One_Done10     ( M_AXIS_col_Nei9Force_done        )           ,
 . S_AXIS_update_Col_One_Done11     ( M_AXIS_col_Nei10Force_done       )           ,
 . S_AXIS_update_Col_One_Done12     ( M_AXIS_col_Nei11Force_done       )           ,
 . S_AXIS_update_Col_One_Done13     ( M_AXIS_col_Nei12Force_done       )           ,
 . S_AXIS_update_Col_One_Done14     ( M_AXIS_col_Nei13Force_done       )           ,

 . M_AXIS_Update_col_ram_wr_en       (   M_AXIS_Update_col_ram_wr_en     ),
 . M_AXIS_Update_col_cnt             (   M_AXIS_Update_col_cnt           )  ,                        
 . M_AXIS_Update_col_ram_rd_data     (   M_AXIS_Update_col_ram_rd_data   )
    );    
    
    
 WR_Data_2_RAM U_WR_Data_2_RAM(
  .Sys_Clk                       (Sys_Clk                       ) ,
  .Sys_Rst_n                     (Sys_Rst_n                     ) , 
  .Home0_cell_cal_finish         (Home0cell_cal_finish          ) ,
  .Update_ALL_Force_Ram_done     (Update_ALL_Force_Ram_done     ) ,
  .Update_Col_ALL_Force_Ram_done (Update_Col_ALL_Force_Ram_done ) , 
  .WR_ALL_Force_Ram_done         (WR_ALL_Force_Ram_done          ),
  .S_AXIS_ram_WR_en              (S_AXIS_ram_WR_en              ),     
  .S_AXIS_ram_WR_addr            (S_AXIS_ram_WR_addr            ) ,
  .S_AXIS_ram_WR_data            (S_AXIS_ram_WR_data            ) ,
  .M_AXIS_Update_ram_wr_en       (M_AXIS_Update_ram_wr_en       ) ,
  .M_AXIS_Update_cnt             (M_AXIS_Update_cnt             ) ,
  .M_AXIS_Update_ram_rd_data     (M_AXIS_Update_ram_rd_data     ) ,          
  .M_AXIS_Update_col_ram_wr_en   (M_AXIS_Update_col_ram_wr_en   ) ,
  .M_AXIS_Update_col_cnt         (M_AXIS_Update_col_cnt         ) ,
  .M_AXIS_Update_col_ram_rd_data (M_AXIS_Update_col_ram_rd_data )   
    );
       
 endmodule  
