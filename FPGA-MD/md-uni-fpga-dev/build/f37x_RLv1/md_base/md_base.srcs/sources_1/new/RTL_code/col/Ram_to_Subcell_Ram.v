`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2022 12:54:56 PM
// Design Name: 
// Module Name: Ram_to_Subcell_Ram
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


module Ram_to_Subcell_Ram(
      input               Sys_Clk,
      input               Sys_Rst_n,
      input               Update_ALL_Force_Ram_done,
      input               Subcell_pass_done,
     input [11:0]        Home0_Ptcal_Num,
     input [11:0]        Home1_Ptcal_Num,
     input [11:0]        Nei1_Ptcal_Num ,
      input [11:0]        Nei2_Ptcal_Num ,       
      input [11:0]        Nei3_Ptcal_Num ,       
      input [11:0]        Nei4_Ptcal_Num ,       
      input [11:0]        Nei5_Ptcal_Num ,       
      input [11:0]        Nei6_Ptcal_Num ,       
      input [11:0]        Nei7_Ptcal_Num ,       
      input [11:0]        Nei8_Ptcal_Num ,       
      input [11:0]        Nei9_Ptcal_Num ,       
      input [11:0]        Nei10_Ptcal_Num,      
      input [11:0]        Nei11_Ptcal_Num,      
      input [11:0]        Nei12_Ptcal_Num,      
      input [11:0]        Nei13_Ptcal_Num,  
      
     output    reg       Home0_cell_Rd_module_en ,
     output    reg       Home1_cell_Rd_module_en ,
     output    reg       Nei1_cell_Rd_module_en  ,
      output    reg       Nei2_cell_Rd_module_en  ,   
      output    reg       Nei3_cell_Rd_module_en  ,
      output    reg       Nei4_cell_Rd_module_en  ,  
      output    reg       Nei5_cell_Rd_module_en  ,
      output    reg       Nei6_cell_Rd_module_en  ,
      output    reg       Nei7_cell_Rd_module_en  ,
      output    reg       Nei8_cell_Rd_module_en  ,   
      output    reg       Nei9_cell_Rd_module_en  ,
      output    reg       Nei10_cell_Rd_module_en ,    
      output    reg       Nei11_cell_Rd_module_en ,   
      output    reg       Nei12_cell_Rd_module_en ,    
      output    reg       Nei13_cell_Rd_module_en ,   

      output    reg      Home0_cell_cal_finish,

      input              S_AXIS_Hom1Force_done  , 
      input              S_AXIS_Nei1Force_done  ,
      input              S_AXIS_Nei2Force_done  ,
      input              S_AXIS_Nei3Force_done  ,
      input              S_AXIS_Nei4Force_done  ,
      input              S_AXIS_Nei5Force_done  ,
      input              S_AXIS_Nei6Force_done  ,
      input              S_AXIS_Nei7Force_done  ,      
      input              S_AXIS_Nei8Force_done  ,
      input              S_AXIS_Nei9Force_done  ,
      input              S_AXIS_Nei10Force_done ,
      input              S_AXIS_Nei11Force_done ,
      input              S_AXIS_Nei12Force_done ,
      input              S_AXIS_Nei13Force_done  ,
      
      output  reg         Home1_subcell_finish ,
      output  reg         Nei1_subcell_finish  ,
      output  reg         Nei2_subcell_finish  ,
      output  reg         Nei3_subcell_finish  ,
      output  reg         Nei4_subcell_finish  ,
      output  reg         Nei5_subcell_finish  ,
      output  reg         Nei6_subcell_finish  ,
      output  reg         Nei7_subcell_finish  ,
      output  reg         Nei8_subcell_finish  ,
      output  reg         Nei9_subcell_finish  ,
      output  reg         Nei10_subcell_finish ,
      output  reg         Nei11_subcell_finish ,
      output  reg         Nei12_subcell_finish ,
      output  reg         Nei13_subcell_finish 
      
         
                
    );
 
  reg [2:0]        SubCell_Cotr_flow_State;
  reg [5:0]        Home0_State_flow_State;
  reg [5:0]        Home1_State_flow_State;
  reg [5:0]        Nei1_State_flow_State;
reg [5:0]        Nei2_State_flow_State;
reg [5:0]        Nei3_State_flow_State;
reg [5:0]        Nei4_State_flow_State;
reg [5:0]        Nei5_State_flow_State;
reg [5:0]        Nei6_State_flow_State;
reg [5:0]        Nei7_State_flow_State;
reg [5:0]        Nei8_State_flow_State;
reg [5:0]        Nei9_State_flow_State;
reg [5:0]        Nei10_State_flow_State;
reg [5:0]        Nei11_State_flow_State;
reg [5:0]        Nei12_State_flow_State;
reg [5:0]        Nei13_State_flow_State;

 reg              Home02wait_en       ;
 reg              Home02Sub_Com_en    ; 
 reg              OneP_home0Par_Done  ;
 reg              ALL_home0Par_Done   ;
 
 
 reg [11:0]       Home0_Ptcal_cnt;
 reg [11:0]       Home1_Ptcal_cnt;
 (*syn_keep="true", mark_debug="true"*) reg [11:0]       Nei1_Ptcal_cnt;
 reg [11:0]       Nei2_Ptcal_cnt; 
reg [11:0]       Nei3_Ptcal_cnt; 
reg [11:0]       Nei4_Ptcal_cnt; 
reg [11:0]       Nei5_Ptcal_cnt; 
reg [11:0]       Nei6_Ptcal_cnt; 
reg [11:0]       Nei7_Ptcal_cnt; 
reg [11:0]       Nei8_Ptcal_cnt; 
reg [11:0]       Nei9_Ptcal_cnt; 
reg [11:0]       Nei10_Ptcal_cnt; 
reg [11:0]       Nei11_Ptcal_cnt; 
reg [11:0]       Nei12_Ptcal_cnt; 
reg [11:0]       Nei13_Ptcal_cnt; 

 reg [11:0]        Home0_Ptcal_Num_buf;
 reg [11:0]        Home1_Ptcal_Num_buf ;  
 reg [11:0]        Nei1_Ptcal_Num_buf ;  
 reg [11:0]        Nei2_Ptcal_Num_buf ;  
reg [11:0]        Nei3_Ptcal_Num_buf ;  
reg [11:0]        Nei4_Ptcal_Num_buf ;  
reg [11:0]        Nei5_Ptcal_Num_buf ;  
reg [11:0]        Nei6_Ptcal_Num_buf ;  
reg [11:0]        Nei7_Ptcal_Num_buf ;  
reg [11:0]        Nei8_Ptcal_Num_buf ;  
reg [11:0]        Nei9_Ptcal_Num_buf ;  
reg [11:0]        Nei10_Ptcal_Num_buf;  
reg [11:0]        Nei11_Ptcal_Num_buf;  
reg [11:0]        Nei12_Ptcal_Num_buf;  
reg [11:0]        Nei13_Ptcal_Num_buf;  



 reg             subcell_finish;
 reg             subcell_finish_rise ;
 reg             subcell_finish_rise_buf;
  reg    subcell_finish_En;
 //------------------------------------------------------------
 //------------------------------------------------------------
   always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin    
        subcell_finish <= 1'b0 ;  
        end 
      else 
        subcell_finish= Home1_subcell_finish    &  Nei1_subcell_finish &  Nei2_subcell_finish
                       &Nei3_subcell_finish     &  Nei4_subcell_finish &  Nei5_subcell_finish
                       &Nei6_subcell_finish     &  Nei7_subcell_finish &  Nei8_subcell_finish
                       &Nei9_subcell_finish     &  Nei10_subcell_finish&  Nei11_subcell_finish
                       &Nei12_subcell_finish    &  Nei13_subcell_finish;
      end 
     
              always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)   
           subcell_finish_rise <= 1'b0 ;         
     else if (subcell_finish)
           subcell_finish_rise <= 1'b1 ;
     else  
           subcell_finish_rise <= 1'b0 ;         
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)   
           subcell_finish_rise_buf <= 1'b0 ;         
     else if (subcell_finish_rise)
           subcell_finish_rise_buf <= 1'b1 ;
     else  
           subcell_finish_rise_buf <= 1'b0 ;         
      end 
      
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)   
           subcell_finish_En <= 1'b0 ;         
     else if ((subcell_finish == 1'b1 )&& (subcell_finish_rise == 1'b1) && (subcell_finish_rise_buf== 1'b0))    
           subcell_finish_En <= 1'b1 ;
     else  
           subcell_finish_En <= 1'b0 ;         
      end 

      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
         Home0_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Home0_Ptcal_Num_buf <= Home0_Ptcal_Num ;
      else if (Home0_cell_cal_finish   )
        Home0_Ptcal_Num_buf <= 12'd0; 
      end 
      
            always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
         Home1_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Home1_Ptcal_Num_buf <= Home1_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
          Home1_Ptcal_Num_buf <= 12'd0;
      end   
       
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei1_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei1_Ptcal_Num_buf <= Nei1_Ptcal_Num ;
          else if (Home0_cell_cal_finish   )
           Nei1_Ptcal_Num_buf <= 12'd0;
      end 

     
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei2_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei2_Ptcal_Num_buf <= Nei2_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
             Nei2_Ptcal_Num_buf <= 12'd0;
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei3_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei3_Ptcal_Num_buf <= Nei3_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
            Nei3_Ptcal_Num_buf <= 12'd0;
      end 
     
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei4_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei4_Ptcal_Num_buf <= Nei4_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
            Nei4_Ptcal_Num_buf <= 12'd0;
      end 
      
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei5_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
         Nei5_Ptcal_Num_buf <= Nei5_Ptcal_Num;
           else if (Home0_cell_cal_finish   )
            Nei5_Ptcal_Num_buf <= 12'd0;
      end 
     
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei6_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei6_Ptcal_Num_buf <= Nei6_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
            Nei6_Ptcal_Num_buf <= 12'd0;
      end 
     
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei7_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei7_Ptcal_Num_buf <= Nei7_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
           Nei7_Ptcal_Num_buf <= 12'd0;
      end 
     
     
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei8_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei8_Ptcal_Num_buf <= Nei8_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
           Nei8_Ptcal_Num_buf <= 12'd0;
      end 
     
             always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei9_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei9_Ptcal_Num_buf <= Nei9_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
           Nei9_Ptcal_Num_buf <= 12'd0;
      end 
     
    
             always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei10_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei10_Ptcal_Num_buf <= Nei10_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
           Nei10_Ptcal_Num_buf <= 12'd0;
      end 
     
      
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei11_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei11_Ptcal_Num_buf <= Nei11_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
           Nei11_Ptcal_Num_buf <= 12'd0;
      end 
      
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei12_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei12_Ptcal_Num_buf <= Nei12_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
              Nei12_Ptcal_Num_buf <= 12'd0;
      end 
        
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
         Nei13_Ptcal_Num_buf <= 12'd0;
      else if (Subcell_pass_done)
        Nei13_Ptcal_Num_buf <= Nei13_Ptcal_Num;
          else if (Home0_cell_cal_finish   )
             Nei13_Ptcal_Num_buf <= 12'd0;
      end  
      
      

 //------------------------------------------------------------   
 //------------------------------------------------------------   
 
 localparam [2:0]
           SubCell_Cotr_flow_RST   = 3'b001	,
           SubCell_Cotr_flow_IDLE  = 3'b010	,
           SubCell_Cotr_flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      SubCell_Cotr_flow_State <=SubCell_Cotr_flow_RST;
     end 
      else begin 
           case( SubCell_Cotr_flow_State)  
            SubCell_Cotr_flow_RST :
                begin
                  SubCell_Cotr_flow_State <=SubCell_Cotr_flow_IDLE;
                end 
            SubCell_Cotr_flow_IDLE:
                begin
                  if (Subcell_pass_done ) 
                      SubCell_Cotr_flow_State <=SubCell_Cotr_flow_BEGIN;
                  else
                      SubCell_Cotr_flow_State <=SubCell_Cotr_flow_IDLE;
                 end 
            SubCell_Cotr_flow_BEGIN:
                  if (ALL_home0Par_Done ) 
                      SubCell_Cotr_flow_State <=SubCell_Cotr_flow_IDLE;
                  else
                      SubCell_Cotr_flow_State <=SubCell_Cotr_flow_BEGIN;
                      
         default:     SubCell_Cotr_flow_State <=SubCell_Cotr_flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home02wait_en          <= 1'b0 ;                 
      else if (Subcell_pass_done &&( SubCell_Cotr_flow_State ==SubCell_Cotr_flow_IDLE))
           Home02wait_en          <= 1'b1 ;        
      else       
           Home02wait_en          <= 1'b0 ;     
      end 
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home0_cell_cal_finish          <= 1'b0 ;                 
      else if (ALL_home0Par_Done)
           Home0_cell_cal_finish          <= 1'b1 ;        
      else       
           Home0_cell_cal_finish          <= 1'b0 ;     
      end 
 //------------------------------------------------------------   
 //------------------------------------------------------------

   
 localparam [4:0]
           Home0_Cotr_flow_RST   = 5'b00001	,
           Home0_Cotr_flow_IDLE  = 5'b00010	,
           Home0_Cotr_flow_BEGIN = 5'b00100	,
           Home0_Cotr_flow_COTR  = 5'b01000	,
           Home0_Cotr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home0_State_flow_State <=Home0_Cotr_flow_RST;
     end 
      else begin 
           case( Home0_State_flow_State)  
            Home0_Cotr_flow_RST :
                begin
                      Home0_State_flow_State    <=Home0_Cotr_flow_IDLE;
                end 
            Home0_Cotr_flow_IDLE:
                begin
                  if (Home02wait_en ) 
                      Home0_State_flow_State <=Home0_Cotr_flow_BEGIN;
                  else
                      Home0_State_flow_State <=Home0_Cotr_flow_IDLE;
                 end 
            Home0_Cotr_flow_BEGIN:
                 begin
                    if ( Home0_Ptcal_Num_buf == Home0_Ptcal_cnt) 
                      Home0_State_flow_State <=Home0_Cotr_flow_IDLE;
                    else
                      Home0_State_flow_State <=Home0_Cotr_flow_COTR;
                 end 
           Home0_Cotr_flow_COTR:
                 begin        
                      Home0_State_flow_State <=Home0_Cotr_flow_END;
                 end     
             Home0_Cotr_flow_END:
                  if (subcell_finish_En ) 
                      Home0_State_flow_State <=Home0_Cotr_flow_BEGIN;
                  else
                      Home0_State_flow_State <=Home0_Cotr_flow_END;     
                 
       default:     Home0_State_flow_State <=Home0_Cotr_flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ALL_home0Par_Done          <= 1'b0 ;                 
      else if (Home0_Ptcal_Num_buf == Home0_Ptcal_cnt && Home0_State_flow_State== Home0_Cotr_flow_BEGIN)
           ALL_home0Par_Done          <= 1'b1 ;        
      else  if   ( Home0_State_flow_State== Home0_Cotr_flow_IDLE)
           ALL_home0Par_Done          <= 1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home0_Ptcal_cnt          <=   12'd0;            
      else if ( Home0_State_flow_State==Home0_Cotr_flow_BEGIN )
           Home0_Ptcal_cnt          <=  Home0_Ptcal_cnt + 12'd1;     
      else if ( Home0_State_flow_State==Home0_Cotr_flow_IDLE )
            Home0_Ptcal_cnt          <=   12'd0;           
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Home02Sub_Com_en  <=   1'b0;           
      else if ( Home0_State_flow_State==Home0_Cotr_flow_COTR )
            Home02Sub_Com_en  <=   1'b1;    
      else   
            Home02Sub_Com_en  <=   1'b0;                    
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Home0_cell_Rd_module_en  <=   1'b0;           
      else if ( Home0_State_flow_State==Home0_Cotr_flow_COTR )
            Home0_cell_Rd_module_en  <=   1'b1;    
      else       
            Home0_cell_Rd_module_en  <=   1'b0;                    
      end 
  
   
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            OneP_home0Par_Done  <=   1'b0;        
      else if (subcell_finish_En )
            OneP_home0Par_Done  <=   1'b1;
      else       
            OneP_home0Par_Done  <=   1'b0;                   
      end 
//------------------------------------------------------------
//  Home1
//------------------------------------------------------------    

localparam [5:0]
           Home1_Cotr_flow_RST   = 6'b000001	,
           Home1_Cotr_flow_IDLE  = 6'b000010	,
           Home1_Cotr_flow_BEGIN = 6'b000100	,
           Home1_Cotr_flow_COTR  = 6'b001000	,
           Home1_Cotr_flow_CHCK  = 6'b010000	,
           Home1_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home1_State_flow_State <=Home1_Cotr_flow_RST;
     end 
      else begin 
           case( Home1_State_flow_State)  
            Home1_Cotr_flow_RST :
                begin
                      Home1_State_flow_State    <=Home1_Cotr_flow_IDLE;
                end 
            Home1_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Home1_State_flow_State <=Home1_Cotr_flow_BEGIN;
                  else
                      Home1_State_flow_State <=Home1_Cotr_flow_IDLE;
                 end 
            Home1_Cotr_flow_BEGIN:
                 begin
                    if (Home1_Ptcal_Num_buf ==  Home1_Ptcal_cnt) 
                      Home1_State_flow_State <=Home1_Cotr_flow_END;
                    else
                      Home1_State_flow_State <=Home1_Cotr_flow_COTR;
                 end 
           Home1_Cotr_flow_COTR:
                 begin        
                      Home1_State_flow_State <=Home1_Cotr_flow_CHCK;
                 end    
            Home1_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Hom1Force_done ) 
                      Home1_State_flow_State <=Home1_Cotr_flow_BEGIN;
                    else
                      Home1_State_flow_State <=Home1_Cotr_flow_CHCK;     
                 end    
           Home1_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Home1_State_flow_State <=Home1_Cotr_flow_IDLE;
                    else
                      Home1_State_flow_State <=Home1_Cotr_flow_END;     
                 end    
             
       default:     Home1_State_flow_State <=Home1_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home1_subcell_finish     <=  1'b0;          
      else if (  Home1_State_flow_State ==Home1_Cotr_flow_END      )
           Home1_subcell_finish     <=  1'b1;   
      else if ( Home1_State_flow_State ==Home1_Cotr_flow_IDLE       )      
           Home1_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home1_cell_Rd_module_en     <=  1'b0;          
      else if (  Home1_State_flow_State ==Home1_Cotr_flow_COTR      )
           Home1_cell_Rd_module_en     <=  1'b1;   
      else   
           Home1_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home1_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Hom1Force_done       )
           Home1_Ptcal_cnt    <=  Home1_Ptcal_cnt + 12'd1;
      else if   (Home1_State_flow_State ==Home1_Cotr_flow_IDLE)    
           Home1_Ptcal_cnt      <=   12'd0;                    
      end 


 //------------------------------------------------------------
//  Nei1
//------------------------------------------------------------    

localparam [5:0]
           Nei1_Cotr_flow_RST   = 6'b000001	,
           Nei1_Cotr_flow_IDLE  = 6'b000010	,
           Nei1_Cotr_flow_BEGIN = 6'b000100	,
           Nei1_Cotr_flow_COTR  = 6'b001000	,
           Nei1_Cotr_flow_CHCK  = 6'b010000	,
           Nei1_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei1_State_flow_State <=Nei1_Cotr_flow_RST;
     end 
      else begin 
           case( Nei1_State_flow_State)  
            Nei1_Cotr_flow_RST :
                begin
                      Nei1_State_flow_State    <=Nei1_Cotr_flow_IDLE;
                end 
            Nei1_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei1_State_flow_State <=Nei1_Cotr_flow_BEGIN;
                  else
                      Nei1_State_flow_State <=Nei1_Cotr_flow_IDLE;
                 end 
            Nei1_Cotr_flow_BEGIN:
                 begin
                    if (Nei1_Ptcal_Num_buf ==  Nei1_Ptcal_cnt) 
                      Nei1_State_flow_State <=Nei1_Cotr_flow_END;
                    else
                      Nei1_State_flow_State <=Nei1_Cotr_flow_COTR;
                 end 
           Nei1_Cotr_flow_COTR:
                 begin        
                      Nei1_State_flow_State <=Nei1_Cotr_flow_CHCK;
                 end    
            Nei1_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei1Force_done ) 
                      Nei1_State_flow_State <=Nei1_Cotr_flow_BEGIN;
                    else
                      Nei1_State_flow_State <=Nei1_Cotr_flow_CHCK;     
                 end    
           Nei1_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei1_State_flow_State <=Nei1_Cotr_flow_IDLE;
                    else
                      Nei1_State_flow_State <=Nei1_Cotr_flow_END;     
                 end    
             
       default:     Nei1_State_flow_State <=Nei1_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei1_subcell_finish     <=  1'b0;          
      else if (  Nei1_State_flow_State ==Nei1_Cotr_flow_END      )
           Nei1_subcell_finish     <=  1'b1;   
      else       
           Nei1_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei1_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei1_State_flow_State ==Nei1_Cotr_flow_COTR      )
           Nei1_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei1_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei1_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei1Force_done       )
           Nei1_Ptcal_cnt    <=  Nei1_Ptcal_cnt + 12'd1;
      else if   (Nei1_State_flow_State ==Nei1_Cotr_flow_IDLE)    
           Nei1_Ptcal_cnt      <=   12'd0;                    
      end 

  //------------------------------------------------------------
//  Nei2
//------------------------------------------------------------    

localparam [5:0]
           Nei2_Cotr_flow_RST   = 6'b000001	,
           Nei2_Cotr_flow_IDLE  = 6'b000010	,
           Nei2_Cotr_flow_BEGIN = 6'b000100	,
           Nei2_Cotr_flow_COTR  = 6'b001000	,
           Nei2_Cotr_flow_CHCK  = 6'b010000	,
           Nei2_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei2_State_flow_State <=Nei2_Cotr_flow_RST;
     end 
      else begin 
           case( Nei2_State_flow_State)  
            Nei2_Cotr_flow_RST :
                begin
                      Nei2_State_flow_State    <=Nei2_Cotr_flow_IDLE;
                end 
            Nei2_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei2_State_flow_State <=Nei2_Cotr_flow_BEGIN;
                  else
                      Nei2_State_flow_State <=Nei2_Cotr_flow_IDLE;
                 end 
            Nei2_Cotr_flow_BEGIN:
                 begin
                    if (Nei2_Ptcal_Num_buf ==  Nei2_Ptcal_cnt) 
                      Nei2_State_flow_State <=Nei2_Cotr_flow_END;
                    else
                      Nei2_State_flow_State <=Nei2_Cotr_flow_COTR;
                 end 
           Nei2_Cotr_flow_COTR:
                 begin        
                      Nei2_State_flow_State <=Nei2_Cotr_flow_CHCK;
                 end    
            Nei2_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei2Force_done ) 
                      Nei2_State_flow_State <=Nei2_Cotr_flow_BEGIN;
                    else
                      Nei2_State_flow_State <=Nei2_Cotr_flow_CHCK;     
                 end    
           Nei2_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei2_State_flow_State <=Nei2_Cotr_flow_IDLE;
                    else
                      Nei2_State_flow_State <=Nei2_Cotr_flow_END;     
                 end    
             
       default:     Nei2_State_flow_State <=Nei2_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei2_subcell_finish     <=  1'b0;          
      else if (  Nei2_State_flow_State ==Nei2_Cotr_flow_END      )
           Nei2_subcell_finish     <=  1'b1;   
      else       
           Nei2_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei2_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei2_State_flow_State ==Nei2_Cotr_flow_COTR      )
           Nei2_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei2_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei2_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei2Force_done       )
           Nei2_Ptcal_cnt    <=  Nei2_Ptcal_cnt + 12'd1;
      else if   (Nei2_State_flow_State ==Nei2_Cotr_flow_IDLE)    
           Nei2_Ptcal_cnt      <=   12'd0;                    
      end 

   //------------------------------------------------------------
//  Nei3
//------------------------------------------------------------    

localparam [5:0]
           Nei3_Cotr_flow_RST   = 6'b000001	,
           Nei3_Cotr_flow_IDLE  = 6'b000010	,
           Nei3_Cotr_flow_BEGIN = 6'b000100	,
           Nei3_Cotr_flow_COTR  = 6'b001000	,
           Nei3_Cotr_flow_CHCK  = 6'b010000	,
           Nei3_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei3_State_flow_State <=Nei3_Cotr_flow_RST;
     end 
      else begin 
           case( Nei3_State_flow_State)  
            Nei3_Cotr_flow_RST :
                begin
                      Nei3_State_flow_State    <=Nei3_Cotr_flow_IDLE;
                end 
            Nei3_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei3_State_flow_State <=Nei3_Cotr_flow_BEGIN;
                  else
                      Nei3_State_flow_State <=Nei3_Cotr_flow_IDLE;
                 end 
            Nei3_Cotr_flow_BEGIN:
                 begin
                    if ( Nei3_Ptcal_cnt == Nei3_Ptcal_Num_buf) 
                      Nei3_State_flow_State <=Nei3_Cotr_flow_END;
                    else
                      Nei3_State_flow_State <=Nei3_Cotr_flow_COTR;
                 end 
            Nei3_Cotr_flow_COTR:
                 begin        
                      Nei3_State_flow_State <=Nei3_Cotr_flow_CHCK;
                 end    
            Nei3_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei3Force_done ) 
                      Nei3_State_flow_State <=Nei3_Cotr_flow_BEGIN;
                    else
                      Nei3_State_flow_State <=Nei3_Cotr_flow_CHCK;     
                 end    
            Nei3_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei3_State_flow_State <=Nei3_Cotr_flow_IDLE;
                    else
                      Nei3_State_flow_State <=Nei3_Cotr_flow_END;     
                 end    
             
       default:     Nei3_State_flow_State <=Nei3_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei3_subcell_finish     <=  1'b0;          
      else if (  Nei3_State_flow_State ==Nei3_Cotr_flow_END      )
           Nei3_subcell_finish     <=  1'b1;   
      else       
           Nei3_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei3_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei3_State_flow_State ==Nei3_Cotr_flow_COTR      )
           Nei3_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei3_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei3_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei3Force_done       )
           Nei3_Ptcal_cnt    <=  Nei3_Ptcal_cnt + 12'd1;
      else if   (Nei3_State_flow_State == Nei3_Cotr_flow_IDLE)    
           Nei3_Ptcal_cnt      <=   12'd0;                    
      end 

   //------------------------------------------------------------
//  Nei4
//------------------------------------------------------------    

localparam [5:0]
           Nei4_Cotr_flow_RST   = 6'b000001	,
           Nei4_Cotr_flow_IDLE  = 6'b000010	,
           Nei4_Cotr_flow_BEGIN = 6'b000100	,
           Nei4_Cotr_flow_COTR  = 6'b001000	,
           Nei4_Cotr_flow_CHCK  = 6'b010000	,
           Nei4_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei4_State_flow_State <=Nei4_Cotr_flow_RST;
     end 
      else begin 
           case( Nei4_State_flow_State)  
            Nei4_Cotr_flow_RST :
                begin
                      Nei4_State_flow_State    <=Nei4_Cotr_flow_IDLE;
                end 
            Nei4_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei4_State_flow_State <=Nei4_Cotr_flow_BEGIN;
                  else
                      Nei4_State_flow_State <=Nei4_Cotr_flow_IDLE;
                 end 
            Nei4_Cotr_flow_BEGIN:
                 begin
                    if (Nei4_Ptcal_Num_buf ==  Nei4_Ptcal_cnt) 
                      Nei4_State_flow_State <=Nei4_Cotr_flow_END;
                    else
                      Nei4_State_flow_State <=Nei4_Cotr_flow_COTR;
                 end 
           Nei4_Cotr_flow_COTR:
                 begin        
                      Nei4_State_flow_State <=Nei4_Cotr_flow_CHCK;
                 end    
            Nei4_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei4Force_done ) 
                      Nei4_State_flow_State <=Nei4_Cotr_flow_BEGIN;
                    else
                      Nei4_State_flow_State <=Nei4_Cotr_flow_CHCK;     
                 end    
           Nei4_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei4_State_flow_State <=Nei4_Cotr_flow_IDLE;
                    else
                      Nei4_State_flow_State <=Nei4_Cotr_flow_END;     
                 end    
             
       default:     Nei4_State_flow_State <=Nei4_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei4_subcell_finish     <=  1'b0;          
      else if (  Nei4_State_flow_State ==Nei4_Cotr_flow_END      )
           Nei4_subcell_finish     <=  1'b1;   
      else       
           Nei4_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei4_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei4_State_flow_State ==Nei4_Cotr_flow_COTR      )
           Nei4_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei4_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei4_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei4Force_done       )
           Nei4_Ptcal_cnt    <=  Nei4_Ptcal_cnt + 12'd1;
      else if   (Nei4_State_flow_State == Nei4_Cotr_flow_IDLE)    
           Nei4_Ptcal_cnt      <=   12'd0;                    
      end 

   //------------------------------------------------------------
//  Nei5
//------------------------------------------------------------    

localparam [5:0]
           Nei5_Cotr_flow_RST   = 6'b000001	,
           Nei5_Cotr_flow_IDLE  = 6'b000010	,
           Nei5_Cotr_flow_BEGIN = 6'b000100	,
           Nei5_Cotr_flow_COTR  = 6'b001000	,
           Nei5_Cotr_flow_CHCK  = 6'b010000	,
           Nei5_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei5_State_flow_State <=Nei5_Cotr_flow_RST;
     end 
      else begin 
           case( Nei5_State_flow_State)  
            Nei5_Cotr_flow_RST :
                begin
                      Nei5_State_flow_State    <=Nei5_Cotr_flow_IDLE;
                end 
            Nei5_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei5_State_flow_State <=Nei5_Cotr_flow_BEGIN;
                  else
                      Nei5_State_flow_State <=Nei5_Cotr_flow_IDLE;
                 end 
            Nei5_Cotr_flow_BEGIN:
                 begin
                    if (Nei5_Ptcal_Num_buf ==  Nei5_Ptcal_cnt) 
                      Nei5_State_flow_State <=Nei5_Cotr_flow_END;
                    else
                      Nei5_State_flow_State <=Nei5_Cotr_flow_COTR;
                 end 
           Nei5_Cotr_flow_COTR:
                 begin        
                      Nei5_State_flow_State <=Nei5_Cotr_flow_CHCK;
                 end    
            Nei5_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei5Force_done ) 
                      Nei5_State_flow_State <=Nei5_Cotr_flow_BEGIN;
                    else
                      Nei5_State_flow_State <=Nei5_Cotr_flow_CHCK;     
                 end    
           Nei5_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei5_State_flow_State <=Nei5_Cotr_flow_IDLE;
                    else
                      Nei5_State_flow_State <=Nei5_Cotr_flow_END;     
                 end    
             
       default:     Nei5_State_flow_State <=Nei5_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei5_subcell_finish     <=  1'b0;          
      else if (  Nei5_State_flow_State ==Nei5_Cotr_flow_END      )
           Nei5_subcell_finish     <=  1'b1;   
      else       
           Nei5_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei5_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei5_State_flow_State ==Nei5_Cotr_flow_COTR      )
           Nei5_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei5_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei5_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei5Force_done       )
           Nei5_Ptcal_cnt    <=  Nei5_Ptcal_cnt + 12'd1;
      else if   (Nei5_State_flow_State ==Nei5_Cotr_flow_IDLE)    
           Nei5_Ptcal_cnt      <=   12'd0;                    
      end 

     
  //------------------------------------------------------------
//  Nei6
//------------------------------------------------------------    

localparam [5:0]
           Nei6_Cotr_flow_RST   = 6'b000001	,
           Nei6_Cotr_flow_IDLE  = 6'b000010	,
           Nei6_Cotr_flow_BEGIN = 6'b000100	,
           Nei6_Cotr_flow_COTR  = 6'b001000	,
           Nei6_Cotr_flow_CHCK  = 6'b010000	,
           Nei6_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei6_State_flow_State <=Nei6_Cotr_flow_RST;
     end 
      else begin 
           case( Nei6_State_flow_State)  
            Nei6_Cotr_flow_RST :
                begin
                      Nei6_State_flow_State    <=Nei6_Cotr_flow_IDLE;
                end 
            Nei6_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei6_State_flow_State <=Nei6_Cotr_flow_BEGIN;
                  else
                      Nei6_State_flow_State <=Nei6_Cotr_flow_IDLE;
                 end 
            Nei6_Cotr_flow_BEGIN:
                 begin
                    if (Nei6_Ptcal_Num_buf ==  Nei6_Ptcal_cnt) 
                      Nei6_State_flow_State <=Nei6_Cotr_flow_END;
                    else
                      Nei6_State_flow_State <=Nei6_Cotr_flow_COTR;
                 end 
           Nei6_Cotr_flow_COTR:
                 begin        
                      Nei6_State_flow_State <=Nei6_Cotr_flow_CHCK;
                 end    
           Nei6_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei6Force_done ) 
                      Nei6_State_flow_State <=Nei6_Cotr_flow_BEGIN;
                    else
                      Nei6_State_flow_State <=Nei6_Cotr_flow_CHCK;     
                 end    
           Nei6_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei6_State_flow_State <=Nei6_Cotr_flow_IDLE;
                    else
                      Nei6_State_flow_State <=Nei6_Cotr_flow_END;     
                 end    
             
       default:     Nei6_State_flow_State <=Nei6_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei6_subcell_finish     <=  1'b0;          
      else if (  Nei6_State_flow_State ==Nei6_Cotr_flow_END      )
           Nei6_subcell_finish     <=  1'b1;   
      else       
           Nei6_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei6_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei6_State_flow_State ==Nei6_Cotr_flow_COTR      )
           Nei6_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei6_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei6_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei6Force_done       )
           Nei6_Ptcal_cnt    <=  Nei6_Ptcal_cnt + 12'd1;
      else if   (Nei6_State_flow_State ==Nei6_Cotr_flow_IDLE)    
           Nei6_Ptcal_cnt      <=   12'd0;                    
      end 

    //------------------------------------------------------------
//  Nei7
//------------------------------------------------------------    

localparam [5:0]
           Nei7_Cotr_flow_RST   = 6'b000001	,
           Nei7_Cotr_flow_IDLE  = 6'b000010	,
           Nei7_Cotr_flow_BEGIN = 6'b000100	,
           Nei7_Cotr_flow_COTR  = 6'b001000	,
           Nei7_Cotr_flow_CHCK  = 6'b010000	,
           Nei7_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei7_State_flow_State <=Nei7_Cotr_flow_RST;
     end 
      else begin 
           case( Nei7_State_flow_State)  
            Nei7_Cotr_flow_RST :
                begin
                      Nei7_State_flow_State    <=Nei7_Cotr_flow_IDLE;
                end 
            Nei7_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei7_State_flow_State <=Nei7_Cotr_flow_BEGIN;
                  else
                      Nei7_State_flow_State <=Nei7_Cotr_flow_IDLE;
                 end 
            Nei7_Cotr_flow_BEGIN:
                 begin
                    if (Nei7_Ptcal_Num_buf ==  Nei7_Ptcal_cnt) 
                      Nei7_State_flow_State <=Nei7_Cotr_flow_END;
                    else
                      Nei7_State_flow_State <=Nei7_Cotr_flow_COTR;
                 end 
           Nei7_Cotr_flow_COTR:
                 begin        
                      Nei7_State_flow_State <=Nei7_Cotr_flow_CHCK;
                 end    
            Nei7_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei7Force_done ) 
                      Nei7_State_flow_State <=Nei7_Cotr_flow_BEGIN;
                    else
                      Nei7_State_flow_State <=Nei7_Cotr_flow_CHCK;     
                 end    
           Nei7_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei7_State_flow_State <=Nei7_Cotr_flow_IDLE;
                    else
                      Nei7_State_flow_State <=Nei7_Cotr_flow_END;     
                 end    
             
       default:     Nei7_State_flow_State <=Nei7_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei7_subcell_finish     <=  1'b0;          
      else if (  Nei7_State_flow_State ==Nei7_Cotr_flow_END      )
           Nei7_subcell_finish     <=  1'b1;   
      else       
           Nei7_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei7_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei7_State_flow_State ==Nei7_Cotr_flow_COTR      )
           Nei7_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei7_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei7_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei7Force_done       )
           Nei7_Ptcal_cnt    <=  Nei7_Ptcal_cnt + 12'd1;
      else if   (Nei7_State_flow_State ==Nei7_Cotr_flow_IDLE)    
           Nei7_Ptcal_cnt      <=   12'd0;                    
      end 

  //------------------------------------------------------------
//  Nei8
//------------------------------------------------------------    

localparam [5:0]
           Nei8_Cotr_flow_RST   = 6'b000001	,
           Nei8_Cotr_flow_IDLE  = 6'b000010	,
           Nei8_Cotr_flow_BEGIN = 6'b000100	,
           Nei8_Cotr_flow_COTR  = 6'b001000	,
           Nei8_Cotr_flow_CHCK  = 6'b010000	,
           Nei8_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei8_State_flow_State <=Nei8_Cotr_flow_RST;
     end 
      else begin 
           case( Nei8_State_flow_State)  
            Nei8_Cotr_flow_RST :
                begin
                      Nei8_State_flow_State    <=Nei8_Cotr_flow_IDLE;
                end 
            Nei8_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei8_State_flow_State <=Nei8_Cotr_flow_BEGIN;
                  else
                      Nei8_State_flow_State <=Nei8_Cotr_flow_IDLE;
                 end 
            Nei8_Cotr_flow_BEGIN:
                 begin
                    if (Nei8_Ptcal_Num_buf ==  Nei8_Ptcal_cnt) 
                      Nei8_State_flow_State <=Nei8_Cotr_flow_END;
                    else
                      Nei8_State_flow_State <=Nei8_Cotr_flow_COTR;
                 end 
            Nei8_Cotr_flow_COTR:
                 begin        
                      Nei8_State_flow_State <=Nei8_Cotr_flow_CHCK;
                 end    
            Nei8_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei8Force_done ) 
                      Nei8_State_flow_State <=Nei8_Cotr_flow_BEGIN;
                    else
                      Nei8_State_flow_State <=Nei8_Cotr_flow_CHCK;     
                 end    
            Nei8_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei8_State_flow_State <=Nei8_Cotr_flow_IDLE;
                    else
                      Nei8_State_flow_State <=Nei8_Cotr_flow_END;     
                 end    
             
       default:     Nei8_State_flow_State <=Nei8_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei8_subcell_finish     <=  1'b0;          
      else if (  Nei8_State_flow_State ==Nei8_Cotr_flow_END      )
           Nei8_subcell_finish     <=  1'b1;   
      else       
           Nei8_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei8_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei8_State_flow_State ==Nei8_Cotr_flow_COTR      )
           Nei8_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei8_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei8_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei8Force_done       )
           Nei8_Ptcal_cnt    <=  Nei8_Ptcal_cnt + 12'd1;
      else if   (Nei8_State_flow_State ==Nei8_Cotr_flow_IDLE)    
           Nei8_Ptcal_cnt      <=   12'd0;                    
      end 

  
   //------------------------------------------------------------
//  Nei9
//------------------------------------------------------------    

localparam [5:0]
           Nei9_Cotr_flow_RST   = 6'b000001	,
           Nei9_Cotr_flow_IDLE  = 6'b000010	,
           Nei9_Cotr_flow_BEGIN = 6'b000100	,
           Nei9_Cotr_flow_COTR  = 6'b001000	,
           Nei9_Cotr_flow_CHCK  = 6'b010000	,
           Nei9_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei9_State_flow_State <=Nei9_Cotr_flow_RST;
     end 
      else begin 
           case( Nei9_State_flow_State)  
            Nei9_Cotr_flow_RST :
                begin
                      Nei9_State_flow_State    <=Nei9_Cotr_flow_IDLE;
                end 
            Nei9_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei9_State_flow_State <=Nei9_Cotr_flow_BEGIN;
                  else
                      Nei9_State_flow_State <=Nei9_Cotr_flow_IDLE;
                 end 
            Nei9_Cotr_flow_BEGIN:
                 begin
                    if (Nei9_Ptcal_Num_buf ==  Nei9_Ptcal_cnt) 
                      Nei9_State_flow_State <=Nei9_Cotr_flow_END;
                    else
                      Nei9_State_flow_State <=Nei9_Cotr_flow_COTR;
                 end 
           Nei9_Cotr_flow_COTR:
                 begin        
                      Nei9_State_flow_State <=Nei9_Cotr_flow_CHCK;
                 end    
            Nei9_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei9Force_done ) 
                      Nei9_State_flow_State <=Nei9_Cotr_flow_BEGIN;
                    else
                      Nei9_State_flow_State <=Nei9_Cotr_flow_CHCK;     
                 end    
           Nei9_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei9_State_flow_State <=Nei9_Cotr_flow_IDLE;
                    else
                      Nei9_State_flow_State <=Nei9_Cotr_flow_END;     
                 end    
             
       default:     Nei9_State_flow_State <=Nei9_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei9_subcell_finish     <=  1'b0;          
      else if (  Nei9_State_flow_State ==Nei9_Cotr_flow_END      )
           Nei9_subcell_finish     <=  1'b1;   
      else       
           Nei9_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei9_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei9_State_flow_State ==Nei9_Cotr_flow_COTR      )
           Nei9_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei9_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei9_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei9Force_done       )
           Nei9_Ptcal_cnt    <=  Nei9_Ptcal_cnt + 12'd1;
      else if   (Nei9_State_flow_State ==Nei9_Cotr_flow_IDLE)    
           Nei9_Ptcal_cnt      <=   12'd0;                    
      end 
   //------------------------------------------------------------
//  Nei10
//------------------------------------------------------------    

localparam [5:0]
           Nei10_Cotr_flow_RST   = 6'b000001	,
           Nei10_Cotr_flow_IDLE  = 6'b000010	,
           Nei10_Cotr_flow_BEGIN = 6'b000100	,
           Nei10_Cotr_flow_COTR  = 6'b001000	,
           Nei10_Cotr_flow_CHCK  = 6'b010000	,
           Nei10_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei10_State_flow_State <=Nei10_Cotr_flow_RST;
     end 
      else begin 
           case( Nei10_State_flow_State)  
            Nei10_Cotr_flow_RST :
                begin
                      Nei10_State_flow_State    <=Nei10_Cotr_flow_IDLE;
                end 
            Nei10_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei10_State_flow_State <=Nei10_Cotr_flow_BEGIN;
                  else
                      Nei10_State_flow_State <=Nei10_Cotr_flow_IDLE;
                 end 
            Nei10_Cotr_flow_BEGIN:
                 begin
                    if (Nei10_Ptcal_Num_buf ==  Nei10_Ptcal_cnt) 
                      Nei10_State_flow_State <=Nei10_Cotr_flow_END;
                    else
                      Nei10_State_flow_State <=Nei10_Cotr_flow_COTR;
                 end 
           Nei10_Cotr_flow_COTR:
                 begin        
                      Nei10_State_flow_State <=Nei10_Cotr_flow_CHCK;
                 end    
            Nei10_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei10Force_done ) 
                      Nei10_State_flow_State <=Nei10_Cotr_flow_BEGIN;
                    else
                      Nei10_State_flow_State <=Nei10_Cotr_flow_CHCK;     
                 end    
           Nei10_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei10_State_flow_State <=Nei10_Cotr_flow_IDLE;
                    else
                      Nei10_State_flow_State <=Nei10_Cotr_flow_END;     
                 end    
             
       default:     Nei10_State_flow_State <=Nei10_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei10_subcell_finish     <=  1'b0;          
      else if (  Nei10_State_flow_State ==Nei10_Cotr_flow_END      )
           Nei10_subcell_finish     <=  1'b1;   
      else       
           Nei10_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei10_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei10_State_flow_State ==Nei10_Cotr_flow_COTR      )
           Nei10_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei10_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei10_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei10Force_done       )
           Nei10_Ptcal_cnt    <=  Nei10_Ptcal_cnt + 12'd1;
      else if   (Nei10_State_flow_State ==Nei10_Cotr_flow_IDLE)    
           Nei10_Ptcal_cnt      <=   12'd0;                    
      end 
//------------------------------------------------------------
//  Nei11
//------------------------------------------------------------    

localparam [5:0]
           Nei11_Cotr_flow_RST   = 6'b000001	,
           Nei11_Cotr_flow_IDLE  = 6'b000010	,
           Nei11_Cotr_flow_BEGIN = 6'b000100	,
           Nei11_Cotr_flow_COTR  = 6'b001000	,
           Nei11_Cotr_flow_CHCK  = 6'b010000	,
           Nei11_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei11_State_flow_State <=Nei11_Cotr_flow_RST;
     end 
      else begin 
           case( Nei11_State_flow_State)  
            Nei11_Cotr_flow_RST :
                begin
                      Nei11_State_flow_State    <=Nei11_Cotr_flow_IDLE;
                end 
            Nei11_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei11_State_flow_State <=Nei11_Cotr_flow_BEGIN;
                  else
                      Nei11_State_flow_State <=Nei11_Cotr_flow_IDLE;
                 end 
            Nei11_Cotr_flow_BEGIN:
                 begin
                    if (Nei11_Ptcal_Num_buf ==  Nei11_Ptcal_cnt) 
                      Nei11_State_flow_State <=Nei11_Cotr_flow_END;
                    else
                      Nei11_State_flow_State <=Nei11_Cotr_flow_COTR;
                 end 
           Nei11_Cotr_flow_COTR:
                 begin        
                      Nei11_State_flow_State <=Nei11_Cotr_flow_CHCK;
                 end    
            Nei11_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei11Force_done ) 
                      Nei11_State_flow_State <=Nei11_Cotr_flow_BEGIN;
                    else
                      Nei11_State_flow_State <=Nei11_Cotr_flow_CHCK;     
                 end    
           Nei11_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei11_State_flow_State <=Nei11_Cotr_flow_IDLE;
                    else
                      Nei11_State_flow_State <=Nei11_Cotr_flow_END;     
                 end    
             
       default:     Nei11_State_flow_State <=Nei11_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei11_subcell_finish     <=  1'b0;          
      else if (  Nei11_State_flow_State ==Nei11_Cotr_flow_END      )
           Nei11_subcell_finish     <=  1'b1;   
      else       
           Nei11_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei11_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei11_State_flow_State ==Nei11_Cotr_flow_COTR      )
           Nei11_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei11_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei11_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei11Force_done       )
           Nei11_Ptcal_cnt    <=  Nei11_Ptcal_cnt + 12'd1;
      else if   (Nei11_State_flow_State ==Nei11_Cotr_flow_IDLE)    
           Nei11_Ptcal_cnt      <=   12'd0;                    
      end 

    //------------------------------------------------------------
//  Nei12
//------------------------------------------------------------    

localparam [5:0]
           Nei12_Cotr_flow_RST   = 6'b000001	,
           Nei12_Cotr_flow_IDLE  = 6'b000010	,
           Nei12_Cotr_flow_BEGIN = 6'b000100	,
           Nei12_Cotr_flow_COTR  = 6'b001000	,
           Nei12_Cotr_flow_CHCK  = 6'b010000	,
           Nei12_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei12_State_flow_State <=Nei12_Cotr_flow_RST;
     end 
      else begin 
           case( Nei12_State_flow_State)  
            Nei12_Cotr_flow_RST :
                begin
                      Nei12_State_flow_State    <=Nei12_Cotr_flow_IDLE;
                end 
            Nei12_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei12_State_flow_State <=Nei12_Cotr_flow_BEGIN;
                  else
                      Nei12_State_flow_State <=Nei12_Cotr_flow_IDLE;
                 end 
            Nei12_Cotr_flow_BEGIN:
                 begin
                    if (Nei12_Ptcal_Num_buf ==  Nei12_Ptcal_cnt) 
                      Nei12_State_flow_State <=Nei12_Cotr_flow_END;
                    else
                      Nei12_State_flow_State <=Nei12_Cotr_flow_COTR;
                 end 
           Nei12_Cotr_flow_COTR:
                 begin        
                      Nei12_State_flow_State <=Nei12_Cotr_flow_CHCK;
                 end    
            Nei12_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei12Force_done ) 
                      Nei12_State_flow_State <=Nei12_Cotr_flow_BEGIN;
                    else
                      Nei12_State_flow_State <=Nei12_Cotr_flow_CHCK;     
                 end    
           Nei12_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei12_State_flow_State <=Nei12_Cotr_flow_IDLE;
                    else
                      Nei12_State_flow_State <=Nei12_Cotr_flow_END;     
                 end    
             
       default:     Nei12_State_flow_State <=Nei12_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei12_subcell_finish     <=  1'b0;          
      else if (  Nei12_State_flow_State ==Nei12_Cotr_flow_END      )
           Nei12_subcell_finish     <=  1'b1;   
      else       
           Nei12_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei12_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei12_State_flow_State ==Nei12_Cotr_flow_COTR      )
           Nei12_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei12_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei12_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei12Force_done       )
           Nei12_Ptcal_cnt    <=  Nei12_Ptcal_cnt + 12'd1;
      else if   (Nei12_State_flow_State ==Nei12_Cotr_flow_IDLE)    
           Nei12_Ptcal_cnt      <=   12'd0;                    
      end 
     //------------------------------------------------------------
//  Nei13
//------------------------------------------------------------    

localparam [5:0]
           Nei13_Cotr_flow_RST   = 6'b000001	,
           Nei13_Cotr_flow_IDLE  = 6'b000010	,
           Nei13_Cotr_flow_BEGIN = 6'b000100	,
           Nei13_Cotr_flow_COTR  = 6'b001000	,
           Nei13_Cotr_flow_CHCK  = 6'b010000	,
           Nei13_Cotr_flow_END   = 6'b100000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei13_State_flow_State <=Nei13_Cotr_flow_RST;
     end 
      else begin 
           case( Nei13_State_flow_State)  
            Nei13_Cotr_flow_RST :
                begin
                      Nei13_State_flow_State    <=Nei13_Cotr_flow_IDLE;
                end 
            Nei13_Cotr_flow_IDLE:
                begin
                  if (Home02Sub_Com_en ) 
                      Nei13_State_flow_State <=Nei13_Cotr_flow_BEGIN;
                  else
                      Nei13_State_flow_State <=Nei13_Cotr_flow_IDLE;
                 end 
            Nei13_Cotr_flow_BEGIN:
                 begin
                    if (Nei13_Ptcal_Num_buf ==  Nei13_Ptcal_cnt) 
                      Nei13_State_flow_State <=Nei13_Cotr_flow_END;
                    else
                      Nei13_State_flow_State <=Nei13_Cotr_flow_COTR;
                 end 
           Nei13_Cotr_flow_COTR:
                 begin        
                      Nei13_State_flow_State <=Nei13_Cotr_flow_CHCK;
                 end    
            Nei13_Cotr_flow_CHCK:   
                 begin        
                     if (S_AXIS_Nei13Force_done ) 
                      Nei13_State_flow_State <=Nei13_Cotr_flow_BEGIN;
                    else
                      Nei13_State_flow_State <=Nei13_Cotr_flow_CHCK;     
                 end    
           Nei13_Cotr_flow_END: 
                 begin        
                     if (OneP_home0Par_Done ) 
                      Nei13_State_flow_State <=Nei13_Cotr_flow_IDLE;
                    else
                      Nei13_State_flow_State <=Nei13_Cotr_flow_END;     
                 end    
             
       default:     Nei13_State_flow_State <=Nei13_Cotr_flow_IDLE;
     endcase
   end 
 end   

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei13_subcell_finish     <=  1'b0;          
      else if (  Nei13_State_flow_State ==Nei13_Cotr_flow_END      )
           Nei13_subcell_finish     <=  1'b1;   
      else       
           Nei13_subcell_finish     <=  1'b0;                 
      end 
  
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei13_cell_Rd_module_en     <=  1'b0;          
      else if (  Nei13_State_flow_State ==Nei13_Cotr_flow_COTR      )
           Nei13_cell_Rd_module_en     <=  1'b1;   
      else       
           Nei13_cell_Rd_module_en     <=  1'b0;                 
      end 

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei13_Ptcal_cnt      <=   12'd0;      
      else if (  S_AXIS_Nei13Force_done       )
           Nei13_Ptcal_cnt    <=  Nei13_Ptcal_cnt + 12'd1;
      else if   (Nei13_State_flow_State ==Nei13_Cotr_flow_IDLE)    
           Nei13_Ptcal_cnt      <=   12'd0;                    
      end 

endmodule
