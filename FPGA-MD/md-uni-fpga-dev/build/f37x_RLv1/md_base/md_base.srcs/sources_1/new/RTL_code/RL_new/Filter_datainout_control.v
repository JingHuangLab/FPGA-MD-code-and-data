`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2023 03:48:15 PM
// Design Name: 
// Module Name: Filter_datainout_control
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


module Filter_datainout_control(
      input                     Sys_Clk              ,
      input                     Sys_Rst_n            ,
      input                     Home0_cell_cal_finish,
      input                     Force_cal_finish     , // force calculation done
      
      input                     S_AXIS_COMP_Begin     ,   
      input                     S_AXIS_COMP_2_Begin   , 
               
      input      [1:0]          filter_num_connect  , 
      input      [5:0]          filter_num   ,
          
      input      [31:0]         X_Pos_buf_nei, 
      input      [31:0]         Y_Pos_buf_nei, 
      input      [31:0]         Z_Pos_buf_nei, 

      input      [31:0]         X_Pos_buf    ,     
      input      [31:0]         Y_Pos_buf    ,     
      input      [31:0]         Z_Pos_buf    ,  
   
      input      [159:0]        S_AXIS_home_Index_buf, 
      input      [159:0]        S_AXIS_Index_buf    ,
      
      output reg [31:0]         X_Pos_buf_1,     
      output reg [31:0]         Y_Pos_buf_1,     
      output reg [31:0]         Z_Pos_buf_1,  
      
      output reg [31:0]         X_Pos_buf_nei_1, 
      output reg [31:0]         Y_Pos_buf_nei_1, 
      output reg [31:0]         Z_Pos_buf_nei_1, 
      
      output reg [31:0]         X_Pos_buf_nei_2, 
      output reg [31:0]         Y_Pos_buf_nei_2, 
      output reg [31:0]         Z_Pos_buf_nei_2, 
      
      output reg [31:0]         X_Pos_buf_nei_3, 
      output reg [31:0]         Y_Pos_buf_nei_3, 
      output reg [31:0]         Z_Pos_buf_nei_3,  
      
      output reg [31:0]         X_Pos_buf_nei_4, 
      output reg [31:0]         Y_Pos_buf_nei_4, 
      output reg [31:0]         Z_Pos_buf_nei_4,             
       
      output reg [31:0]         X_Pos_buf_nei_5, 
      output reg [31:0]         Y_Pos_buf_nei_5, 
      output reg [31:0]         Z_Pos_buf_nei_5, 
      
      output reg [31:0]         X_Pos_buf_nei_6, 
      output reg [31:0]         Y_Pos_buf_nei_6, 
      output reg [31:0]         Z_Pos_buf_nei_6, 
      
      output reg [31:0]         X_Pos_buf_nei_7, 
      output reg [31:0]         Y_Pos_buf_nei_7, 
      output reg [31:0]         Z_Pos_buf_nei_7,  
      
      output reg [31:0]         X_Pos_buf_nei_8, 
      output reg [31:0]         Y_Pos_buf_nei_8, 
      output reg [31:0]         Z_Pos_buf_nei_8  
      
         
    );
    
   always@(posedge Sys_Clk or negedge Sys_Rst_n) begin
 if (!Sys_Rst_n) begin

 case(filter_num )
14'b0: begin 
                 X_Pos_buf_nei_1 <= X_Pos_buf_nei  ;
                 Y_Pos_buf_nei_1 <= Y_Pos_buf_nei  ; 
                 Z_Pos_buf_nei_1 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ;                 
         end
14'd1: begin 
                 X_Pos_buf_nei_2 <= X_Pos_buf_nei  ;
                 Y_Pos_buf_nei_2 <= Y_Pos_buf_nei  ; 
                 Z_Pos_buf_nei_2 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ; 
         end
14'd2: begin 
               X_Pos_buf_nei_3 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_3 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_3 <= Z_Pos_buf_nei  ;
                  X_Pos_buf_1 <= X_Pos_buf   ;
                  Y_Pos_buf_1 <= Y_Pos_buf   ;
                  Z_Pos_buf_1 <= Z_Pos_buf   ; 
        end
14'd3:begin 
               X_Pos_buf_nei_4 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_4 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_4 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ; 
      end
14'd4:begin 
               X_Pos_buf_nei_5 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_5 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_5 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ; 
     end
14'd5: begin 
               X_Pos_buf_nei_6 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_6 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_6 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ; 
   end 
14'd6: begin 
               X_Pos_buf_nei_7 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_7 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_7 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ; 
   end
 14'd7: begin 
               X_Pos_buf_nei_8 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_8 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_8 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ;                 
         end  
          
  default:begin
               X_Pos_buf_nei_8 <= X_Pos_buf_nei  ;
               Y_Pos_buf_nei_8 <= Y_Pos_buf_nei  ; 
               Z_Pos_buf_nei_8 <= Z_Pos_buf_nei  ;
                 X_Pos_buf_1 <= X_Pos_buf   ;
                 Y_Pos_buf_1 <= Y_Pos_buf   ;
                 Z_Pos_buf_1 <= Z_Pos_buf   ;  
          end                                                                 
  endcase
end   
end      
    
    
    
    
endmodule
