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
      wire    [12:0]        M_AXIS_Update_col_cnt         ;
      wire    [255 : 0]     M_AXIS_Update_col_ram_rd_data ;
      wire                  M_AXIS_Update_ram_wr_en   ;  // buff data to XDMA ram 
      wire     [12:0]       M_AXIS_Update_cnt         ;
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
wire  [255:0]    S_AXIS_home0Ram_tData   ;

wire  [11:0]     M_AXIS_home1Ram_rd_Addr ;
wire  [255:0]    S_AXIS_home1Ram_tData   ;

wire  [11:0]     M_AXIS_Nei1Ram_rd_Addr  ;
wire  [255:0]    S_AXIS_Nei1Ram_tData    ;

wire  [11:0]     M_AXIS_Nei2Ram_rd_Addr  ;
wire  [255:0]    S_AXIS_Nei2Ram_tData    ;

wire  [11:0]     M_AXIS_Nei3Ram_rd_Addr  ;
wire  [255:0]    S_AXIS_Nei3Ram_tData    ;
  
wire  [11:0]     M_AXIS_Nei4Ram_rd_Addr  ;  
wire  [255:0]    S_AXIS_Nei4Ram_tData    ;  

wire  [11:0]     M_AXIS_Nei5Ram_rd_Addr  ;  
wire  [255:0]    S_AXIS_Nei5Ram_tData    ;  
 
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
  
.  Home0_cell_Rd_module_en     (  Home0_cell_Rd_module_en     )   ,
.  Neighber_cell_Rd_module_en    (Neighber_cell_Rd_module_en    )   ,
 
.Neighbor_ram_Rd_addr          (Neighbor_ram_Rd_addr          )   ,  
.Neighbor_ram_rd_data          (Neighbor_ram_rd_data          )   ,  
 
.S_AXIS_home0ram_Rd_addr       (S_AXIS_home0ram_Rd_addr       )   ,
.S_AXIS_home0ram_rd_data       (S_AXIS_home0ram_rd_data       )   ,
 
.S_AXIS_home1ram_Rd_addr       (S_AXIS_home1ram_Rd_addr       )   , 
.S_AXIS_home1ram_rd_data       (S_AXIS_home1ram_rd_data       )   , 
 
.S_AXIS_Nei1ram_Rd_addr        (S_AXIS_Nei1ram_Rd_addr        )   , 
.S_AXIS_Nei1ram_rd_data        (S_AXIS_Nei1ram_rd_data        )   , 
 
.S_AXIS_Nei2ram_Rd_addr        (S_AXIS_Nei2ram_Rd_addr        )   , 
.S_AXIS_Nei2ram_rd_data        (S_AXIS_Nei2ram_rd_data        )   , 
 
.S_AXIS_Nei3ram_Rd_addr        (S_AXIS_Nei3ram_Rd_addr        )   , 
.S_AXIS_Nei3ram_rd_data        (S_AXIS_Nei3ram_rd_data        )   , 
 
.S_AXIS_Nei4ram_Rd_addr        (S_AXIS_Nei4ram_Rd_addr        )   , 
.S_AXIS_Nei4ram_rd_data        (S_AXIS_Nei4ram_rd_data        )   , 
 
.S_AXIS_Nei5ram_Rd_addr        (S_AXIS_Nei5ram_Rd_addr        )   , 
.S_AXIS_Nei5ram_rd_data        (S_AXIS_Nei5ram_rd_data        )   ,    
 
.S_AXIS_Nei6ram_Rd_addr        (S_AXIS_Nei6ram_Rd_addr        )   , 
.S_AXIS_Nei6ram_rd_data        (S_AXIS_Nei6ram_rd_data        )   , 
 
.S_AXIS_Nei7ram_Rd_addr        (S_AXIS_Nei7ram_Rd_addr        )   , 
.S_AXIS_Nei7ram_rd_data        (S_AXIS_Nei7ram_rd_data        )   ,    
 
.S_AXIS_Nei8ram_Rd_addr        (S_AXIS_Nei8ram_Rd_addr        )   , 
.S_AXIS_Nei8ram_rd_data        (S_AXIS_Nei8ram_rd_data        )   ,       
 
.S_AXIS_Nei9ram_Rd_addr        (S_AXIS_Nei9ram_Rd_addr        )   , 
.S_AXIS_Nei9ram_rd_data        (S_AXIS_Nei9ram_rd_data        )   ,      
 
.S_AXIS_Nei10ram_Rd_addr       (S_AXIS_Nei10ram_Rd_addr       )   , 
.S_AXIS_Nei10ram_rd_data       (S_AXIS_Nei10ram_rd_data       )   ,     
 
.S_AXIS_Nei11ram_Rd_addr       (S_AXIS_Nei11ram_Rd_addr       )   ,     
.S_AXIS_Nei11ram_rd_data       (S_AXIS_Nei11ram_rd_data       )   ,     
 
.S_AXIS_Nei12ram_Rd_addr       (S_AXIS_Nei12ram_Rd_addr       )   ,     
.S_AXIS_Nei12ram_rd_data       (S_AXIS_Nei12ram_rd_data       )   ,     
 
.S_AXIS_Nei13ram_Rd_addr       (S_AXIS_Nei13ram_Rd_addr       )   ,     
.S_AXIS_Nei13ram_rd_data       (S_AXIS_Nei13ram_rd_data       )   ,     
 
.Home0_cell_cal_finish         (Home0_cell_cal_finish         )   ,
.S_AXIS_Hom1Force_done         (S_AXIS_Hom1Force_done         )   ,  // neighbor cell calculation done ,send one response signal
 
.filter_num_connect            (filter_num_connect            )   , 
.filter_num                    (filter_num                    )
  
    
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
    
 
 Subram_Rd_cotr  Nei_Rd_cotr(
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
 
 

 //========================================================================================================== 
 //==========================================================================================================  
             Filter_Eight_top  U_Filter_Eight_top(

   .Sys_Clk               (Sys_Clk               ),
   .Sys_Rst_n             (Sys_Rst_n             ),
   .Home0_cell_cal_finish (Home0_cell_cal_finish ),
   .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
   .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
 
   .filter_num_connect    (filter_num_connect    ), 
   .filter_num            (filter_num            ),
 
   .Sum_rr_done           (Sum_rr_done           ),
   .M_AXIS_RR_data        (M_AXIS_RR_data        ),
 
   .X_Pos_buf_nei         (X_Pos_buf_nei         ), 
   .Y_Pos_buf_nei         (Y_Pos_buf_nei         ), 
   .Z_Pos_buf_nei         (Z_Pos_buf_nei         ), 
 
   .X_Pos_buf             (X_Pos_buf             ),     
   .Y_Pos_buf             (Y_Pos_buf             ),     
   .Z_Pos_buf             (Z_Pos_buf             ),     
 
   .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf ), 
   .S_AXIS_Index_buf      (S_AXIS_Index_buf      )
      );

 //========================================================================================================== 
 //==========================================================================================================  
    

 Force_evaluation_TOP U_Force_evaluation_TOP(
.Sys_Clk               (Sys_Clk               ),
.Sys_Rst_n             (Sys_Rst_n             ),
 
.Sum_rr_done           (Sum_rr_done           ),
.M_AXIS_RR_data        (M_AXIS_RR_data        ),
 
.M_AXIS_EnE_Force      (M_AXIS_EnE_Force      ),
.S_AXIS_Hom1Force_done (S_AXIS_Hom1Force_done )   
    );

 //========================================================================================================== 
 //==========================================================================================================  

 Buff_2_fifo_top  U_Buff_2_fifo_top (
.Sys_Clk                   (Sys_Clk                   ),
.Sys_Rst_n                 (Sys_Rst_n                 ),
.Subcell_pass_done         (Subcell_pass_done         ),
.Update_ALL_Force_Ram_done (Update_ALL_Force_Ram_done ),
.Home0_cell_cal_finish     (Home0_cell_cal_finish     ),      
 
.M_AXIS_EnE_Force          (M_AXIS_EnE_Force          ),         
.S_AXIS_update_One_Done    (S_AXIS_update_One_Done    ),
 
.M_AXIS_Home1_wr_en        (M_AXIS_Home1_wr_en        ), 
.M_AXIS_Home1_wr_data      (M_AXIS_Home1_wr_data      ), 
.M_AXIS_Home1_ram_addr     (M_AXIS_Home1_ram_addr     ) 

    );    
    
 //========================================================================================================== 
 //==========================================================================================================  
    Homecell_ACC_TOP  U_Homecell_ACC_TOP (      
     .   Sys_Clk (Sys_Clk) ,
     . Sys_Rst_n (Sys_Rst_n)
    );

//========================================================================================================== 
//==========================================================================================================  
    Neighbor_halfshall_Top  U_Neighbor_halfshall_Top (      
     .   Sys_Clk (Sys_Clk) ,
     . Sys_Rst_n (Sys_Rst_n)
    );

//========================================================================================================== 
//==========================================================================================================  
    Motion_update_TOP  U_Motion_update_TOP (      
     .   Sys_Clk (Sys_Clk) ,
     . Sys_Rst_n (Sys_Rst_n)
    );
 endmodule  
