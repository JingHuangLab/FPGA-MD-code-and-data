`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2023 10:41:33 AM
// Design Name: 
// Module Name: Filter_Eight_top
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


module Filter_Eight_top(

      input                Sys_Clk               ,
      input                Sys_Rst_n             ,
      input                Home0_cell_cal_finish ,
      input                S_AXIS_COMP_Begin     ,   
      input                S_AXIS_COMP_2_Begin   ,      
     
      input    [1:0]       filter_num_connect  , 
      input    [5:0]       filter_num   ,
     
      output wire           Sum_rr_done           ,
      output wire[127:0]    M_AXIS_RR_data        ,
      
      input [31:0]         X_Pos_buf_nei, 
      input [31:0]         Y_Pos_buf_nei, 
      input [31:0]         Z_Pos_buf_nei, 
  
      input [31:0]         X_Pos_buf,     
      input [31:0]         Y_Pos_buf,     
      input [31:0]         Z_Pos_buf,     
      
      input [159:0]        S_AXIS_home_Index_buf, 
      input [159:0]        S_AXIS_Index_buf      
    );
    
wire [127:0]     M_AXIS_RR_data_1;    
wire [127:0]     M_AXIS_RR_data_2;
wire [127:0]     M_AXIS_RR_data_3;
wire [127:0]     M_AXIS_RR_data_4;
wire [127:0]     M_AXIS_RR_data_5;
wire [127:0]     M_AXIS_RR_data_6;
wire [127:0]     M_AXIS_RR_data_7;
wire [127:0]     M_AXIS_RR_data_8;
 
    
    Filter_TOP  U_Filter_TOP_1(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_1          ),
     . M_AXIS_RR_data        ( M_AXIS_RR_data_1       ) , 
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
        Filter_TOP  U_Filter_TOP_2(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_2      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_2   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
    
            Filter_TOP  U_Filter_TOP_3(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_3      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_3   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
    
            Filter_TOP  U_Filter_TOP_4(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_4      ),         
     . M_AXIS_RR_data        ( M_AXIS_RR_data_4   ) ,        
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
            Filter_TOP  U_Filter_TOP_5(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_5      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_5   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
            Filter_TOP  U_Filter_TOP_6(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_6      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_6   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
            Filter_TOP  U_Filter_TOP_7(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_7      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_7   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
            Filter_TOP  U_Filter_TOP_8(

     .Sys_Clk               (Sys_Clk               ),
     .Sys_Rst_n             (Sys_Rst_n             ),
     .Home0_cell_cal_finish (Home0_cell_cal_finish ),
     .S_AXIS_COMP_Begin     (S_AXIS_COMP_Begin     ),   
     .S_AXIS_COMP_2_Begin   (S_AXIS_COMP_2_Begin   ),      
   
     . Sum_rr_done           ( Sum_rr_done_8      ),          
     . M_AXIS_RR_data        ( M_AXIS_RR_data_8   ) ,         
     
     .X_Pos_buf_nei         (X_Pos_buf_nei         ) , 
     .Y_Pos_buf_nei         (Y_Pos_buf_nei         ) , 
     .Z_Pos_buf_nei         (Z_Pos_buf_nei         ) , 
 
     .X_Pos_buf             (X_Pos_buf             ) ,     
     .Y_Pos_buf             (Y_Pos_buf             ) ,     
     .Z_Pos_buf             (Z_Pos_buf             ) ,     
     .S_AXIS_home_Index_buf (S_AXIS_home_Index_buf )  , 
     .S_AXIS_Index_buf      (S_AXIS_Index_buf      )          
          
      
    );
    
 Arbiter_filter_Top U_Arbiter_filter_Top(
     .   Sys_Clk                 (   Sys_Clk                )  ,
     .   Sys_Rst_n               (   Sys_Rst_n              )  , 
     .   Force_cal_finish        (   Force_cal_finish       ),
     .   Filter_1_data_to_cal    (   Filter_1_data_to_cal   )  ,    //output     
     .   Filter_2_data_to_cal    (   Filter_2_data_to_cal   )  ,    //output     
     .   Filter_3_data_to_cal    (   Filter_3_data_to_cal   )  ,    //output     
     .   Filter_4_data_to_cal    (   Filter_4_data_to_cal   )  ,    //output     
     .   Filter_5_data_to_cal    (   Filter_5_data_to_cal   )  ,    //output     
     .   Filter_6_data_to_cal    (   Filter_6_data_to_cal   )  ,    //output     
     .   Filter_7_data_to_cal    (   Filter_7_data_to_cal   )  ,    //output     
     .   Filter_8_data_to_cal    (   Filter_8_data_to_cal   )  ,    //output     
                                                                       
     .   Filter_1_Ture           (   Filter_1_Ture          )  ,
     .   Filter_2_Ture           (   Filter_2_Ture          )  ,
     .   Filter_3_Ture           (   Filter_3_Ture          )  ,
     .   Filter_4_Ture           (   Filter_4_Ture          )  ,
     .   Filter_5_Ture           (   Filter_5_Ture          )  ,
     .   Filter_6_Ture           (   Filter_6_Ture          )  ,
     .   Filter_7_Ture           (   Filter_7_Ture          )  ,
     .   Filter_8_Ture           (   Filter_8_Ture          )  ,
 
     .   Filter_RC               (   Filter_RC                   )  ,    //input    
     .   Filter_1_R2             (   M_AXIS_RR_data_1[127:96]    )  ,    //input    
     .   Filter_2_R2             (   M_AXIS_RR_data_2[127:96]    )  ,    //input    
     .   Filter_3_R2             (   M_AXIS_RR_data_3[127:96]    )  ,    //input    
     .   Filter_4_R2             (   M_AXIS_RR_data_4[127:96]    )  ,    //input    
     .   Filter_5_R2             (   M_AXIS_RR_data_5[127:96]    )  ,    //input    
     .   Filter_6_R2             (   M_AXIS_RR_data_6[127:96]    )  ,    //input    
     .   Filter_7_R2             (   M_AXIS_RR_data_7[127:96]    )  ,    //input    
     .   Filter_8_R2             (   M_AXIS_RR_data_8[127:96]    )       //input       
    );
    
    
  Filter_datainout_control U_Filter_datainout_control(
     .  Sys_Clk                (Sys_Clk              ),
     .  Sys_Rst_n              (Sys_Rst_n            ),
     .  Home0_cell_cal_finish  (Home0_cell_cal_finish),
     .  Force_cal_finish       (Force_cal_finish     ),
 
     .  S_AXIS_COMP_Begin      (S_AXIS_COMP_Begin    ) ,   
     .  S_AXIS_COMP_2_Begin    (S_AXIS_COMP_2_Begin  ) , 
     
     .  filter_num_connect     (filter_num_connect   ) , 
     .  filter_num             (filter_num           ) ,

     .  X_Pos_buf_nei          (X_Pos_buf_nei        ) , 
     .  Y_Pos_buf_nei          (Y_Pos_buf_nei        ) , 
     .  Z_Pos_buf_nei          (Z_Pos_buf_nei        ) , 

     .  X_Pos_buf              (X_Pos_buf            ) ,     
     .  Y_Pos_buf              (Y_Pos_buf            ) ,     
     .  Z_Pos_buf              (Z_Pos_buf            ) ,  

     .  S_AXIS_home_Index_buf  (S_AXIS_home_Index_buf)  , 
     .  S_AXIS_Index_buf       (S_AXIS_Index_buf     ) ,

     .  X_Pos_buf_1            (X_Pos_buf_1          ) ,     
     .  Y_Pos_buf_1            (Y_Pos_buf_1          ) ,     
     .  Z_Pos_buf_1            (Z_Pos_buf_1          ) ,  

     .  X_Pos_buf_nei_1        (X_Pos_buf_nei_1      )  , 
     .  Y_Pos_buf_nei_1        (Y_Pos_buf_nei_1      )  , 
     .  Z_Pos_buf_nei_1        (Z_Pos_buf_nei_1      )  , 

     .  X_Pos_buf_nei_2        (X_Pos_buf_nei_2      )  , 
     .  Y_Pos_buf_nei_2        (Y_Pos_buf_nei_2      )  , 
     .  Z_Pos_buf_nei_2        (Z_Pos_buf_nei_2      )  , 

     .  X_Pos_buf_nei_3        (X_Pos_buf_nei_3      )  , 
     .  Y_Pos_buf_nei_3        (Y_Pos_buf_nei_3      )  , 
     .  Z_Pos_buf_nei_3        (Z_Pos_buf_nei_3      )  ,  

     .  X_Pos_buf_nei_4        (X_Pos_buf_nei_4      )  , 
     .  Y_Pos_buf_nei_4        (Y_Pos_buf_nei_4      )  , 
     .  Z_Pos_buf_nei_4        (Z_Pos_buf_nei_4      )  ,             

     .  X_Pos_buf_nei_5        (X_Pos_buf_nei_5      )  , 
     .  Y_Pos_buf_nei_5        (Y_Pos_buf_nei_5      )  , 
     .  Z_Pos_buf_nei_5        (Z_Pos_buf_nei_5      )  , 
 
     .  X_Pos_buf_nei_6        (X_Pos_buf_nei_6      )  , 
     .  Y_Pos_buf_nei_6        (Y_Pos_buf_nei_6      )  , 
     .  Z_Pos_buf_nei_6        (Z_Pos_buf_nei_6      )  , 

     .  X_Pos_buf_nei_7        (X_Pos_buf_nei_7      )  , 
     .  Y_Pos_buf_nei_7        (Y_Pos_buf_nei_7      )  , 
     .  Z_Pos_buf_nei_7        (Z_Pos_buf_nei_7      )  ,  

     .  X_Pos_buf_nei_8        (X_Pos_buf_nei_8      )  , 
     .  Y_Pos_buf_nei_8        (Y_Pos_buf_nei_8      )  , 
     .  Z_Pos_buf_nei_8        (Z_Pos_buf_nei_8      )
      
         
    );
       
    
    
endmodule
