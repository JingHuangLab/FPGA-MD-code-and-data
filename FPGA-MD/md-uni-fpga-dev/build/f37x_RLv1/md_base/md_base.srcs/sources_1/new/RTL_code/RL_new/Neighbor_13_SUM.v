`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2023 07:44:03 AM
// Design Name: 
// Module Name: Neighbor_13_SUM
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


module Neighbor_13_SUM(
 input                   Sys_Clk  ,
 input                   Sys_Rst_n,
 input                   Get_XYZ,
 
 input                 Home_Nei_Sum_Done,
 
  input [159:0]          Fx_Nei1_in  ,
  input [159:0]          Fy_Nei1_in  ,
  input [159:0]          Fz_Nei1_in  ,
 
  input [159:0]          Fx_Nei2_in  ,
  input [159:0]          Fy_Nei2_in  ,
  input [159:0]          Fz_Nei2_in  ,
   
  input [159:0]          Fx_Nei3_in  ,
  input [159:0]          Fy_Nei3_in  ,
  input [159:0]          Fz_Nei3_in  ,
 
  input [159:0]          Fx_Nei4_in  ,
  input [159:0]          Fy_Nei4_in  ,
  input [159:0]          Fz_Nei4_in  ,   
   
  input [159:0]          Fx_Nei5_in  ,
  input [159:0]          Fy_Nei5_in  ,
  input [159:0]          Fz_Nei5_in  ,
 
  input [159:0]          Fx_Nei6_in  ,
  input [159:0]          Fy_Nei6_in  ,
  input [159:0]          Fz_Nei6_in  ,  
   
  input [159:0]          Fx_Nei7_in  ,
  input [159:0]          Fy_Nei7_in  ,
  input [159:0]          Fz_Nei7_in  ,
 
  input [159:0]          Fx_Nei8_in  ,
  input [159:0]          Fy_Nei8_in  ,
  input [159:0]          Fz_Nei8_in  ,
   
  input [159:0]          Fx_Nei9_in  ,
  input [159:0]          Fy_Nei9_in  ,
  input [159:0]          Fz_Nei9_in  ,
 
  input [159:0]          Fx_Nei10_in  ,
  input [159:0]          Fy_Nei10_in  ,
  input [159:0]          Fz_Nei10_in  ,   
   
  input [159:0]          Fx_Nei11_in  ,
  input [159:0]          Fy_Nei11_in  ,
  input [159:0]          Fz_Nei11_in  ,
 
  input [159:0]          Fx_Nei12_in  ,
  input [159:0]          Fy_Nei12_in  ,
  input [159:0]          Fz_Nei12_in  ,    
   
  input [159:0]          Fx_Nei13_in  ,   
  input [159:0]          Fy_Nei13_in  ,   
  input [159:0]          Fz_Nei13_in  ,
  
    //X to caculation mul unit 
 output reg [31:0]      Fx_Nei_A_out ,
 output reg             Fx_Nei_A_Vil ,
 output reg             Fx_Nei_B_Vil ,
 output reg [31:0]      Fx_Nei_B_out ,
 input      [31:0]      Fx_Nei_get_r ,
 input                  Fx_Nei_get_vil  ,
 
  //X to caculation mul unit 
 output reg [31:0]      Fy_Nei_A_out ,          
 output reg             Fy_Nei_A_Vil ,     
 output reg             Fy_Nei_B_Vil ,
 output reg [31:0]      Fy_Nei_B_out ,
 input      [31:0]      Fy_Nei_get_r ,
 input                  Fy_Nei_get_vil  ,

  //X to caculation mul unit 
 output reg [31:0]      Fz_Nei_A_out ,
 output reg             Fz_Nei_A_Vil ,
 output reg             Fz_Nei_B_Vil ,
 output reg [31:0]      Fz_Nei_B_out ,
 input      [31:0]      Fz_Nei_get_r ,
 input                  Fz_Nei_get_vil     
   
      );
reg [6:0]    Fx_Nei_flow_cnt_State;
reg [6:0]    Fy_Nei_flow_cnt_State;
reg [6:0]    Fz_Nei_flow_cnt_State;
  
reg         Fx_Nei_en;
reg         Fy_Nei_en;
reg         Fz_Nei_en;
reg [6:0]   Fx_Nei_CNT;
reg [6:0]   Fy_Nei_CNT;
reg [6:0]   Fz_Nei_CNT;
reg         Home_Aum_Done;
reg         Home_accm_finish;
reg [31:0]  Home_Index_BUF;
reg [31:0]  Fx_Nei_BUF;
reg [31:0]  Fy_Nei_BUF;
reg [31:0]  Fz_Nei_BUF;
reg [31:0]  Fx_Nei_ACUM;
reg [31:0]  Fy_Nei_ACUM;
reg [31:0]  Fz_Nei_ACUM;
reg         Next_partical_ID_en  ;
reg         This_partical_ID_en  ;

reg         partical_ADD_en;
 reg [6:0]  Home_accm_Rd_State;    
 
//      //-----------------------------------------------------------------------------------------------// 
//     // home 1 
//     //-----------------------------------------------------------------------------------------------//     

//        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//          if (!Sys_Rst_n)    
//                 Fx_Nei_order_CNT  <= 6'b0;         
//           else if ( Home_Nei_Sum_Done)
//                 Fx_Nei_order_CNT <=Fx_Nei_order_CNT + 1'b1;  
//           else              
//                 Fx_Nei_order_CNT  <= 6'b0;            
//           end 
 
//        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
//          if (!Sys_Rst_n)    
//                 Fx_Nei2_en  <= 1'b0;         
//           else if ( Fx_Nei1_Done)
//                 Fx_Nei2_en <= 1'b1;  
//           else              
//                 Fx_Nei2_en  <= 1'b0;             
//           end 
 
 
     //-----------------------------------------------------------------------------------------------// 
     // home 1 
     //-----------------------------------------------------------------------------------------------//     

       localparam [4:0]
                Fx_Nei_flow_cnt_RST   = 5'b00001	,
                Fx_Nei_flow_cnt_IDLE  = 5'b00010	,
                Fx_Nei_flow_cnt_BEGIN = 5'b00100	,
                Fx_Nei_flow_cnt_CHK   = 5'b01000	,
                Fx_Nei_flow_cnt_END   = 5'b10000	;

      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n) begin   
            Fx_Nei_flow_cnt_State <= Fx_Nei_flow_cnt_RST;
          end 
           else begin 
                case( Fx_Nei_flow_cnt_State)  
                 Fx_Nei_flow_cnt_RST :
                     begin
                           Fx_Nei_flow_cnt_State  <=Fx_Nei_flow_cnt_IDLE;
                     end 
                 Fx_Nei_flow_cnt_IDLE:
                     begin
                       if (Get_XYZ)
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_BEGIN;
                       else
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_IDLE;
                       end 
                 Fx_Nei_flow_cnt_BEGIN:
                      begin
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_CHK;
                      end 
                 Fx_Nei_flow_cnt_CHK:
                       begin
                          if ( Fx_Nei_get_vil &&( Fx_Nei_CNT == 5'd12))
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_END;
                          else
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_CHK;
                        end 
                 Fx_Nei_flow_cnt_END:
                      begin        
                         if  ( Home_Aum_Done )        
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_IDLE;
                           else
                           Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_END;
                      end     

            default:       Fx_Nei_flow_cnt_State <=Fx_Nei_flow_cnt_IDLE;
          endcase
        end 
      end   

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fx_Nei_A_out  <=  32'd0;         
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_BEGIN)      
                 Fx_Nei_A_out  <=  Fx_Nei_BUF    ;
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_IDLE)      
                 Fx_Nei_A_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fx_Nei_B_out  <=  32'd0;         
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_BEGIN)
                 Fx_Nei_B_out  <= Fx_Nei_ACUM     ;
           else   if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_IDLE)           
                 Fx_Nei_B_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fx_Nei_A_Vil  <= 1'b0;          
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_BEGIN)
                 Fx_Nei_A_Vil <= 1'b1;  
           else  if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_IDLE)            
                 Fx_Nei_A_Vil  <= 1'b0;               
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fx_Nei_CNT <= 1'b0;         
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_BEGIN)
                 Fx_Nei_CNT <=Fx_Nei_CNT + 1'b1;  
           else              
                 Fx_Nei_CNT  <= 1'b0;             
           end 

          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fx_Nei_B_Vil <= 1'b0;         
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_BEGIN)
                 Fx_Nei_B_Vil <= 1'b1;  
           else              
                 Fx_Nei_B_Vil  <= 1'b0;             
           end    
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Home_Aum_Done <= 1'b0;         
           else if ( Fx_Nei_flow_cnt_State  ==Fx_Nei_flow_cnt_END)
                 Home_Aum_Done <= 1'b1;  
           else              
                 Home_Aum_Done  <= 1'b0;             
           end 
      //-----------------------------------------------------------------------------------------------//
     // home 1
     //-----------------------------------------------------------------------------------------------//      
     localparam [4:0]
                Fy_Nei_flow_cnt_RST   = 5'b00001	,
                Fy_Nei_flow_cnt_IDLE  = 5'b00010	,
                Fy_Nei_flow_cnt_BEGIN = 5'b00100	,
                Fy_Nei_flow_cnt_CHK   = 5'b01000	,
                Fy_Nei_flow_cnt_END   = 5'b10000	;

      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n) begin   
            Fy_Nei_flow_cnt_State <= Fy_Nei_flow_cnt_RST;
          end 
           else begin 
                case( Fy_Nei_flow_cnt_State)  
                 Fy_Nei_flow_cnt_RST :
                     begin
                           Fy_Nei_flow_cnt_State  <=Fy_Nei_flow_cnt_IDLE;
                     end 
                 Fy_Nei_flow_cnt_IDLE:
                     begin
                       if (Get_XYZ)
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_BEGIN;
                       else
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_IDLE;
                       end 
                 Fy_Nei_flow_cnt_BEGIN:
                      begin
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_CHK;
                      end 
                 Fy_Nei_flow_cnt_CHK:
                       begin
                          if ( Fy_Nei_get_vil &&( Fy_Nei_CNT == 5'd12))
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_END;
                          else
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_CHK;
                        end 
                 Fy_Nei_flow_cnt_END:
                      begin        
                         if  ( Home_Aum_Done )        
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_IDLE;
                           else
                           Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_END;
                      end     

            default:       Fy_Nei_flow_cnt_State <=Fy_Nei_flow_cnt_IDLE;
          endcase
        end 
      end   


       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fy_Nei_A_out  <=  32'd0;         
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_BEGIN)      
                 Fy_Nei_A_out  <=  Fy_Nei_BUF    ;
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_IDLE)      
                 Fy_Nei_A_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fy_Nei_B_out  <=  32'd0;         
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_BEGIN)
                 Fy_Nei_B_out  <=  Fy_Nei_ACUM    ;
           else   if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_IDLE)           
                 Fy_Nei_B_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fy_Nei_A_Vil  <= 1'b0;          
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_BEGIN)
                 Fy_Nei_A_Vil <= 1'b1;  
           else  if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_IDLE)            
                 Fy_Nei_A_Vil  <= 1'b0;               
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fy_Nei_B_Vil <= 1'b0;         
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_BEGIN)
                 Fy_Nei_B_Vil <= 1'b1;  
           else              
                 Fy_Nei_B_Vil  <= 1'b0;             
           end 

           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fy_Nei_CNT <= 1'b0;         
           else if ( Fy_Nei_flow_cnt_State  ==Fy_Nei_flow_cnt_BEGIN)
                 Fy_Nei_CNT <= Fy_Nei_CNT + 1'b1;  
           else              
                 Fy_Nei_CNT  <= 1'b0;             
           end 

         //-----------------------------------------------------------------------------------------------//
     // home 1
     //-----------------------------------------------------------------------------------------------//   
     localparam [4:0]
                Fz_Nei_flow_cnt_RST   = 5'b00001	,
                Fz_Nei_flow_cnt_IDLE  = 5'b00010	,
                Fz_Nei_flow_cnt_BEGIN = 5'b00100	,
                Fz_Nei_flow_cnt_CHK   = 5'b01000	,
                Fz_Nei_flow_cnt_END   = 5'b10000	;

      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n) begin   
            Fz_Nei_flow_cnt_State <= Fz_Nei_flow_cnt_RST;
          end 
           else begin 
                case( Fz_Nei_flow_cnt_State)  
                 Fz_Nei_flow_cnt_RST :
                     begin
                           Fz_Nei_flow_cnt_State  <=Fz_Nei_flow_cnt_IDLE;
                     end 
                 Fz_Nei_flow_cnt_IDLE:
                     begin
                       if (Get_XYZ)
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_BEGIN;
                       else
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_IDLE;
                       end 
                 Fz_Nei_flow_cnt_BEGIN:
                      begin
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_CHK;
                      end 
                 Fz_Nei_flow_cnt_CHK:
                       begin
                          if ( Fz_Nei_get_vil &&( Fz_Nei_CNT == 5'd12))
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_END;
                          else
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_CHK;
                        end 
                 Fz_Nei_flow_cnt_END:
                      begin        
                         if  ( Home_Aum_Done  )        
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_IDLE;
                           else
                           Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_END;
                      end     

            default:       Fz_Nei_flow_cnt_State <=Fz_Nei_flow_cnt_IDLE;
          endcase
        end 
      end   


       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fz_Nei_A_out  <=  32'd0;         
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_BEGIN)      
                 Fz_Nei_A_out  <=  Fz_Nei_BUF    ;
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_IDLE)      
                 Fz_Nei_A_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fz_Nei_B_out  <=  32'd0;         
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_BEGIN)
                 Fz_Nei_B_out  <= Fy_Nei_ACUM     ;
           else   if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_IDLE)           
                 Fz_Nei_B_out  <= 32'd0;             
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fz_Nei_A_Vil  <= 1'b0;          
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_BEGIN)
                 Fz_Nei_A_Vil <= 1'b1;  
           else  if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_IDLE)            
                 Fz_Nei_A_Vil  <= 1'b0;               
           end 

       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fz_Nei_B_Vil <= 1'b0;         
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_BEGIN)
                 Fz_Nei_B_Vil <= 1'b1;  
           else              
                 Fz_Nei_B_Vil  <= 1'b0;             
           end 

          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
          if (!Sys_Rst_n)    
                 Fz_Nei_CNT <= 1'b0;         
           else if ( Fz_Nei_flow_cnt_State  ==Fz_Nei_flow_cnt_BEGIN)
                 Fz_Nei_CNT <= Fz_Nei_CNT + 1'b1;  
           else              
                 Fz_Nei_CNT  <= 1'b0;             
           end  
endmodule