`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 03:23:18 PM
// Design Name: 
// Module Name: WR_Data_2_RAM
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


module WR_Data_2_RAM(
          input                               Sys_Clk   ,
          input                               Sys_Rst_n , 
 
          input                               Home0_cell_cal_finish,
          input                               Update_ALL_Force_Ram_done      ,
          input                               Update_Col_ALL_Force_Ram_done  , 
          output        reg                   WR_ALL_Force_Ram_done  ,
          output        reg                    S_AXIS_ram_WR_en      ,
          output        reg      [13:0]        S_AXIS_ram_WR_addr  ,
          output        wire     [255:0]       S_AXIS_ram_WR_data  ,
                    
          input                               M_AXIS_Update_ram_wr_en     ,
          input                   [12:0]       M_AXIS_Update_cnt           ,
          input                  [255:0]      M_AXIS_Update_ram_rd_data    , 
          
          input                               M_AXIS_Update_col_ram_wr_en    ,
          input                   [12:0]       M_AXIS_Update_col_cnt          ,
          input                  [255:0]      M_AXIS_Update_col_ram_rd_data    
    );
    
    
 reg             Update_ram_wr_en    ;
 reg   [13:0]    Update_cnt          ;    
 reg   [255:0]   Update_ram_rd_data  ;
 reg   [2:0]     LJ_Col;
 //reg             WR_ALL_Force_Ram_done;

    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              LJ_Col        <=  3'b000;  
      else if (  Home0_cell_cal_finish)
              LJ_Col        <=  3'b001;     
      else if(  Update_ALL_Force_Ram_done  )      
              LJ_Col        <=  3'b010;            
      else if(  Update_Col_ALL_Force_Ram_done  )      
               LJ_Col        <=  3'b000;            
      end  
      
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
             S_AXIS_ram_WR_en        <=  1'b0 ;  
      else if (  Update_Col_ALL_Force_Ram_done)
             S_AXIS_ram_WR_en        <=  1'b1;          
      else if(  WR_ALL_Force_Ram_done  )      
              S_AXIS_ram_WR_en         <=  1'b0 ;            
      end  
      
 
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              S_AXIS_ram_WR_addr        <=  14'd0 ; 
      else if ( S_AXIS_ram_WR_en&& (S_AXIS_ram_WR_addr <=  14'd16000    ))
              S_AXIS_ram_WR_addr        <=  S_AXIS_ram_WR_addr + 14'd1 ;          
      else  if(  WR_ALL_Force_Ram_done  )      
              S_AXIS_ram_WR_addr        <=  14'd0 ;        
      end  
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
             WR_ALL_Force_Ram_done        <=  1'b0 ;  
      else if (  S_AXIS_ram_WR_addr  ==  14'd16000 )
             WR_ALL_Force_Ram_done        <=  1'b1;          
      else      
              WR_ALL_Force_Ram_done         <=  1'b0 ;            
      end           

always@(posedge Sys_Clk or negedge Sys_Rst_n) begin
 if (!Sys_Rst_n) begin
                Update_ram_rd_data  <= 256'd0 ;
                Update_ram_wr_en    <=  1'b0 ;
                Update_cnt          <=  14'd0 ;    
 end 
else begin
 case(LJ_Col)
3'b001: begin 
                Update_ram_wr_en    <=  1'b1 ;
                Update_ram_rd_data  <= M_AXIS_Update_ram_rd_data ;   
                Update_cnt          <= M_AXIS_Update_cnt;                         
         end
3'b010: begin 
                Update_ram_wr_en      <=  1'b1 ;
                Update_ram_rd_data    <= M_AXIS_Update_col_ram_rd_data ;
                Update_cnt            <= M_AXIS_Update_col_cnt + 14'd8063;    
         end          
 default: begin 
                Update_ram_rd_data    <=  256'd0 ;
                Update_ram_wr_en      <=  1'b0 ;
                Update_cnt            <=  14'd0 ;              
              end
                                   
      endcase
   end   
end       
           
//ram for subcell module
 Bram_Cell_OUPUT U_Bram_Cell_OUPUT(
     .   clka (Sys_Clk                  ),               
     .   ena  (Sys_Rst_n                ),              
     .   wea  (Update_ram_wr_en         ),              
     .   addra(Update_cnt               ),          
     .   dina (Update_ram_rd_data       ),            
     .   clkb (Sys_Clk                  ),               
     .   enb  (S_AXIS_ram_WR_en          ),     
     .   addrb(S_AXIS_ram_WR_addr       ), 
     .   doutb(S_AXIS_ram_WR_data       )  
);

endmodule