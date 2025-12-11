 `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 04:20:45 PM
// Design Name: 
// Module Name: Buff_2_Fifo
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


module Buff_2_Fifo(
      input                        Sys_Clk                   ,
      input                        Sys_Rst_n                 ,
      input                        Subcell_pass_done         ,
      output reg                   Update_ALL_Force_Ram_done ,
      input                        Home0_cell_cal_finish     ,      
      
      input         [255:0]        M_AXIS_EnE_Force          ,         
      input                        S_AXIS_update_One_Done    ,
   
      output reg                   M_AXIS_Home1_wr_en        , 
      output reg     [255:0]       M_AXIS_Home1_wr_data      , 
      output reg       [11:0]      M_AXIS_Home1_ram_addr      
      
     
    );
reg                  Home1ram_wr_one_Done;
reg  [4:0]           Home1_Update_wr_flow_State;
reg                  Home1_reading;
reg  [11:0]          Home1_Read_cnt;
reg  [4:0]           Home1_Update_Flow_State;
            
//-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Home1_Update_wr_flow_RST   = 5'b00001	,
           Home1_Update_wr_flow_Wait  = 5'b00010	,
           Home1_Update_wr_flow_IDLE  = 5'b00100	,
           Home1_Update_wr_flow_BEGIN = 5'b01000	,
           Home1_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Home1_Update_wr_flow_State <= Home1_Update_wr_flow_RST;
     end 
      else begin 
           case( Home1_Update_wr_flow_State)  
            Home1_Update_wr_flow_RST :
                begin
                      Home1_Update_wr_flow_State  <=Home1_Update_wr_flow_Wait;
                end 
           Home1_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                      Home1_Update_wr_flow_State  <=Home1_Update_wr_flow_IDLE;                 
                end 
            Home1_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Home1_Update_wr_flow_State  <=Home1_Update_wr_flow_Wait;
                  else if (S_AXIS_update_One_Done )
                      Home1_Update_wr_flow_State <=Home1_Update_wr_flow_BEGIN;
                  else
                      Home1_Update_wr_flow_State <=Home1_Update_wr_flow_IDLE;
                  end 
            Home1_Update_wr_flow_BEGIN:
                 begin
                      Home1_Update_wr_flow_State <=Home1_Update_wr_flow_END;
                 end 
  
            Home1_Update_wr_flow_END:
                 begin        
                      Home1_Update_wr_flow_State <=Home1_Update_wr_flow_IDLE;
                 end     
                 
       default:       Home1_Update_wr_flow_State <=Home1_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Home1ram_wr_one_Done    <= 1'b0 ;       
      else if (  Home1_Update_wr_flow_State ==Home1_Update_wr_flow_END )
             Home1ram_wr_one_Done    <= 1'b1 ; 
      else       
             Home1ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Home1_wr_en    <= 1'b0 ;       
      else if ( Home1_Update_wr_flow_State ==Home1_Update_wr_flow_BEGIN )
             M_AXIS_Home1_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Home1_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Home1_wr_data <= 256'd0 ;     
      else if ( Home1_Update_wr_flow_State ==Home1_Update_wr_flow_BEGIN )
             M_AXIS_Home1_wr_data <=M_AXIS_EnE_Force;
      else       
             M_AXIS_Home1_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Home1_ram_addr<= 12'd0 ;   
      else if ( Home1_Update_wr_flow_State ==Home1_Update_wr_flow_BEGIN)
                 M_AXIS_Home1_ram_addr<= M_AXIS_Home1_ram_addr +   1'b1 ;
      else       
                M_AXIS_Home1_ram_addr<= 12'd0 ;       
      end 

 


endmodule       
