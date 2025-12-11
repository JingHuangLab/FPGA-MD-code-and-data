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
      input                       Sys_Clk,
      input                       Sys_Rst_n,
      input                       Subcell_pass_done,
      input                       work_en,
      output reg                  Update_ALL_Force_Ram_done,
      input                       Home0_cell_cal_finish,
      
      
      input         [255:0]       M_AXIS_LJ_EnE_Force1 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force2 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force3 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force4 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force5 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force6 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force7 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force8 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force9 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force10 ,
      input         [255:0]       M_AXIS_LJ_EnE_Force11,
      input         [255:0]       M_AXIS_LJ_EnE_Force12,
      input         [255:0]       M_AXIS_LJ_EnE_Force13,
      input         [255:0]       M_AXIS_LJ_EnE_Force14,
      

      input          [11:0]       Home0_Ptcal_Num ,
      input          [11:0]       Home1_Ptcal_Num ,
      input          [11:0]       Nei1_Ptcal_Num  ,
      input          [11:0]       Nei2_Ptcal_Num  ,
      input          [11:0]       Nei3_Ptcal_Num  ,
      input          [11:0]       Nei4_Ptcal_Num  ,   
      input          [11:0]       Nei5_Ptcal_Num  ,  
      input          [11:0]       Nei6_Ptcal_Num  ,
      input          [11:0]       Nei7_Ptcal_Num  ,            
      input          [11:0]       Nei8_Ptcal_Num  ,           
      input          [11:0]       Nei9_Ptcal_Num  ,            
      input          [11:0]       Nei10_Ptcal_Num ,
      input          [11:0]       Nei11_Ptcal_Num ,
      input          [11:0]       Nei12_Ptcal_Num ,
      input          [11:0]       Nei13_Ptcal_Num ,
       
       input                       S_AXIS_update_One_Done1,
       input                       S_AXIS_update_One_Done2,
       input                       S_AXIS_update_One_Done3,
      input                       S_AXIS_update_One_Done4,
      input                       S_AXIS_update_One_Done5,
      input                       S_AXIS_update_One_Done6,
      input                       S_AXIS_update_One_Done7,
      input                       S_AXIS_update_One_Done8,
      input                       S_AXIS_update_One_Done9,
      input                       S_AXIS_update_One_Done10,
      input                       S_AXIS_update_One_Done11,
      input                       S_AXIS_update_One_Done12,
      input                       S_AXIS_update_One_Done13,
      input                       S_AXIS_update_One_Done14,
    
      output reg                  M_AXIS_Home1_wr_en        , 
      output reg     [255:0]      M_AXIS_Home1_wr_data      , 
      output reg       [11:0]      M_AXIS_Home1_ram_addr     , 
      
      output reg                  M_AXIS_Nei1_wr_en        , 
        output reg     [255:0]      M_AXIS_Nei1_wr_data      , 
      output reg       [11:0]      M_AXIS_Nei1_ram_addr     , 
                    
      output reg                  M_AXIS_Nei2_wr_en       ,  
      output reg      [255:0]     M_AXIS_Nei2_wr_data     , 
      output reg       [11:0]      M_AXIS_Nei2_ram_addr    ,      
     
      output reg                  M_AXIS_Nei3_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei3_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei3_ram_addr   ,     
         
      output reg                  M_AXIS_Nei4_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei4_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei4_ram_addr   ,      
      
      output reg                  M_AXIS_Nei5_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei5_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei5_ram_addr   ,     
       
      output reg                  M_AXIS_Nei6_wr_en       ,  
      output reg      [255:0]     M_AXIS_Nei6_wr_data     , 
      output reg       [11:0]      M_AXIS_Nei6_ram_addr    ,   
         
      output reg                  M_AXIS_Nei7_wr_en       ,  
      output reg      [255:0]     M_AXIS_Nei7_wr_data     , 
      output reg       [11:0]      M_AXIS_Nei7_ram_addr    ,      
       
      output reg                  M_AXIS_Nei8_wr_en       ,  
      output reg      [255:0]     M_AXIS_Nei8_wr_data     , 
      output reg       [11:0]      M_AXIS_Nei8_ram_addr    ,     
      
      output reg                  M_AXIS_Nei9_wr_en        ,  
      output reg      [255:0]     M_AXIS_Nei9_wr_data      , 
      output reg       [11:0]      M_AXIS_Nei9_ram_addr     ,    
         
      output reg                  M_AXIS_Nei10_wr_en       ,  
      output reg      [255:0]     M_AXIS_Nei10_wr_data     , 
      output reg       [11:0]      M_AXIS_Nei10_ram_addr    ,          
      
      output reg                  M_AXIS_Nei11_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei11_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei11_ram_addr   ,     
       
      output reg                  M_AXIS_Nei12_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei12_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei12_ram_addr   ,           
      
      output reg                  M_AXIS_Nei13_wr_en      ,  
      output reg      [255:0]     M_AXIS_Nei13_wr_data    , 
      output reg       [11:0]      M_AXIS_Nei13_ram_addr   ,
      
      output reg                  M_AXIS_Update_ram_wr_en   ,
      output reg      [15:0]      M_AXIS_Update_cnt         ,
      output reg      [255:0]     M_AXIS_Update_ram_rd_data ,
  
      output reg      [11:0]       S_AXIS_Update_Home1_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Home1_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei1_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei1_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei2_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei2_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei3_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei3_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei4_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei4_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei5_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei5_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei6_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei6_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei7_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei7_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei8_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei8_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei9_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei9_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei10_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei10_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei11_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei11_rd_data ,
      
      output reg      [11:0]       S_AXIS_Update_Nei12_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei12_rd_data ,
      
      output  reg     [11:0]       S_AXIS_Update_Nei13_Rd_addr ,
      input           [255:0]     S_AXIS_Update_Nei13_rd_data   
    );
reg                Home1ram_wr_one_Done;
reg                Nei1ram_wr_one_Done ;
reg                Nei2ram_wr_one_Done ; 
reg                Nei3ram_wr_one_Done ; 
reg                Nei4ram_wr_one_Done ; 
reg                Nei5ram_wr_one_Done ; 
reg                Nei6ram_wr_one_Done ; 
reg                Nei7ram_wr_one_Done ; 
reg                Nei8ram_wr_one_Done ; 
reg                Nei9ram_wr_one_Done ; 
reg                Nei10ram_wr_one_Done ; 
reg                Nei11ram_wr_one_Done ; 
reg                Nei12ram_wr_one_Done ; 
reg                Nei13ram_wr_one_Done ; 
 
// reg                wait_Col_force_done;
 
 reg [4:0]          Home1_Update_wr_flow_State;
 reg [4:0]          Nei1_Update_wr_flow_State ;
 reg [4:0]          Nei2_Update_wr_flow_State ; 
reg [4:0]          Nei3_Update_wr_flow_State ; 
reg [4:0]          Nei4_Update_wr_flow_State ; 
reg [4:0]          Nei5_Update_wr_flow_State ; 
reg [4:0]          Nei6_Update_wr_flow_State ; 
reg [4:0]          Nei7_Update_wr_flow_State ; 
reg [4:0]          Nei8_Update_wr_flow_State ; 
reg [4:0]          Nei9_Update_wr_flow_State ; 
reg [4:0]          Nei10_Update_wr_flow_State ; 
reg [4:0]          Nei11_Update_wr_flow_State ; 
reg [4:0]          Nei12_Update_wr_flow_State ;
reg [4:0]          Nei13_Update_wr_flow_State;  
 
reg [3:0]          Update_Home1_Rd_flow_State;
reg [3:0]          Update_Nei1_Rd_flow_State;
reg [3:0]          Update_Nei2_Rd_flow_State;
reg [3:0]          Update_Nei3_Rd_flow_State;
reg [3:0]          Update_Nei4_Rd_flow_State;
reg [3:0]          Update_Nei5_Rd_flow_State;
reg [3:0]          Update_Nei6_Rd_flow_State;
reg [3:0]          Update_Nei7_Rd_flow_State;
reg [3:0]          Update_Nei8_Rd_flow_State;
reg [3:0]          Update_Nei9_Rd_flow_State;
reg [3:0]          Update_Nei10_Rd_flow_State;
reg [3:0]          Update_Nei11_Rd_flow_State;
reg [3:0]          Update_Nei12_Rd_flow_State;
reg [3:0]          Update_Nei13_Rd_flow_State;

reg                Home1_reading;
reg                Nei1_reading;
reg                Nei2_reading;
reg                Nei3_reading;
reg                Nei4_reading;
reg                Nei5_reading;
reg                Nei6_reading;
reg                Nei7_reading;
reg                Nei8_reading;
reg                Nei9_reading;
reg                Nei10_reading;
reg                Nei11_reading;
reg                Nei12_reading;
reg                Nei13_reading;
 reg              Home1_reading_en;
reg  [11:0]         Home1_Read_cnt;
reg  [11:0]         Nei1_Read_cnt;
reg  [11:0]         Nei2_Read_cnt;
reg  [11:0]         Nei3_Read_cnt;
reg  [11:0]         Nei4_Read_cnt;
reg  [11:0]         Nei5_Read_cnt;
reg  [11:0]         Nei6_Read_cnt;
reg  [11:0]         Nei7_Read_cnt;
reg  [11:0]         Nei8_Read_cnt;
reg  [11:0]         Nei9_Read_cnt;
reg  [11:0]         Nei10_Read_cnt;
reg  [11:0]         Nei11_Read_cnt;
reg  [11:0]         Nei12_Read_cnt;
   (*syn_keep="true", mark_debug="true"*)   reg  [11:0]         Nei13_Read_cnt;

reg                Home1_Update_ALL_Force_Ram_done   ;  
reg                Nei1_Update_ALL_Force_Ram_done   ;  
reg                Nei2_Update_ALL_Force_Ram_done   ;  
reg                Nei3_Update_ALL_Force_Ram_done   ;  
reg                Nei4_Update_ALL_Force_Ram_done   ;  
reg                Nei5_Update_ALL_Force_Ram_done   ;  
reg                Nei6_Update_ALL_Force_Ram_done   ;
reg                Nei7_Update_ALL_Force_Ram_done   ;
reg                Nei8_Update_ALL_Force_Ram_done   ;
reg                Nei9_Update_ALL_Force_Ram_done   ;
reg                Nei10_Update_ALL_Force_Ram_done   ;                                           
reg                Nei11_Update_ALL_Force_Ram_done   ;   
reg                Nei12_Update_ALL_Force_Ram_done   ;   

 reg                Nei13_Update_ALL_Force_Ram_done   ;           
reg[11:0]          Home1_Update_Num    ;  
reg[11:0]          Nei1_Update_Num    ;     
reg[11:0]          Nei2_Update_Num    ;     
reg[11:0]          Nei3_Update_Num    ;     
reg[11:0]          Nei4_Update_Num    ;     
reg[11:0]          Nei5_Update_Num    ;     
reg[11:0]          Nei6_Update_Num    ;     
reg[11:0]          Nei7_Update_Num    ;     
reg[11:0]          Nei8_Update_Num    ;     
reg[11:0]          Nei9_Update_Num    ;     
reg[11:0]          Nei10_Update_Num    ;     
reg[11:0]          Nei11_Update_Num    ;     
reg[11:0]          Nei12_Update_Num    ;     
reg[11:0]          Nei13_Update_Num    ;  

reg [4:0]          Home1_Update_Flow_State    ;
reg [4:0]          Nei1_Update_Flow_State     ;
reg [4:0]          Nei2_Update_Flow_State     ; 
reg [4:0]          Nei3_Update_Flow_State     ; 
reg [4:0]          Nei4_Update_Flow_State     ; 
reg [4:0]          Nei5_Update_Flow_State     ; 
reg [4:0]          Nei6_Update_Flow_State     ; 
reg [4:0]          Nei7_Update_Flow_State     ; 
reg [4:0]          Nei8_Update_Flow_State     ; 
reg [4:0]          Nei9_Update_Flow_State     ; 
reg [4:0]          Nei10_Update_Flow_State     ; 
reg [4:0]          Nei11_Update_Flow_State     ; 
reg [4:0]          Nei12_Update_Flow_State     ; 
reg [4:0]          Nei13_Update_Flow_State     ; 

  (*syn_keep="true", mark_debug="true"*)  reg [13:0]         reading; 
   
 reg                Home1_Update_ene_force;
 reg                Nei1_Update_ene_force;
 reg                Nei2_Update_ene_force;
reg                Nei3_Update_ene_force;   
reg                Nei4_Update_ene_force;
reg                Nei5_Update_ene_force;
reg                Nei6_Update_ene_force;   
reg                Nei7_Update_ene_force;
reg                Nei8_Update_ene_force;
reg                Nei9_Update_ene_force;   
reg                Nei10_Update_ene_force; 
reg                Nei11_Update_ene_force; 
reg                Nei12_Update_ene_force; 
reg                Nei13_Update_ene_force; 
   
reg                Update_new_ene_force;
reg                Update_new_ene_force_buf;
reg                Update_new_ene_force_buf2;
 reg [11:0]         Home1_cal_times ;
 reg [11:0]         Nei1_cal_times    ; 
 reg [11:0]         Nei2_cal_times  ;
reg [11:0]         Nei3_cal_times  ; 
reg [11:0]         Nei4_cal_times  ; 
reg [11:0]         Nei5_cal_times  ;    
reg [11:0]         Nei6_cal_times  ; 
reg [11:0]         Nei7_cal_times  ; 
reg [11:0]         Nei8_cal_times  ; 
reg [11:0]         Nei9_cal_times  ;    
reg [11:0]         Nei10_cal_times  ; 
reg [11:0]         Nei11_cal_times  ; 
reg [11:0]         Nei12_cal_times  ; 
reg [11:0]         Nei13_cal_times  ; 

                      
//-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) 
       Home1_cal_times <= 12'd0;
      else if (Subcell_pass_done )
        Home1_cal_times <= (Home0_Ptcal_Num   )*(Home1_Ptcal_Num );
         else if( Update_ALL_Force_Ram_done  ) 
          Home1_cal_times <= 12'd0;
      end 
      
            always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei1_cal_times <= 12'd0;
      else if (Subcell_pass_done)
        Nei1_cal_times <=(Home0_Ptcal_Num  )*( Nei1_Ptcal_Num  );  
      else if( Update_ALL_Force_Ram_done  )
            Nei1_cal_times <= 12'd0;
      end   
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei2_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei2_cal_times <= (Home0_Ptcal_Num )*( Nei2_Ptcal_Num  ); 
      else if( Update_ALL_Force_Ram_done  ) 
           Nei2_cal_times <=  12'd0;
      end 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei3_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei3_cal_times <=(Home0_Ptcal_Num  )*( Nei3_Ptcal_Num  ); 
      else if( Update_ALL_Force_Ram_done  ) 
        Nei3_cal_times <=  12'd0; 
      end 
     
         always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei4_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei4_cal_times <=  (Home0_Ptcal_Num )*( Nei4_Ptcal_Num  );  
      else if( Update_ALL_Force_Ram_done  ) 
        Nei4_cal_times <=  12'd0;
      end 
      
       always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
        Nei5_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei5_cal_times <= (Home0_Ptcal_Num  )*( Nei5_Ptcal_Num  );  
           else if( Update_ALL_Force_Ram_done  ) 
             Nei5_cal_times <=  12'd0;
      end 
     
          always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
         Nei6_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei6_cal_times <=(Home0_Ptcal_Num  )*( Nei6_Ptcal_Num  );  
           else if( Update_ALL_Force_Ram_done  ) 
              Nei6_cal_times <=  12'd0;
      end 
     
          always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei7_cal_times <= 12'd0;
      else if (Subcell_pass_done)
        Nei7_cal_times <= (Home0_Ptcal_Num  )*( Nei7_Ptcal_Num  ); 
           else if( Update_ALL_Force_Ram_done  ) 
              Nei7_cal_times <= 12'd0; 
      end 
     
     
         always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei8_cal_times <= 12'd0;
      else if (Subcell_pass_done)
         Nei8_cal_times <= (Home0_Ptcal_Num  )*( Nei8_Ptcal_Num  );  
           else if( Update_ALL_Force_Ram_done  ) 
        Nei8_cal_times <= 12'd0;
      end 
     
         always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei9_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei9_cal_times <=  (Home0_Ptcal_Num )*( Nei9_Ptcal_Num ); 
           else if( Update_ALL_Force_Ram_done  ) 
           Nei9_cal_times <=  12'd0;
      end 
     
   
          always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei10_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei10_cal_times <=(Home0_Ptcal_Num  )*( Nei10_Ptcal_Num ); 
           else if( Update_ALL_Force_Ram_done  ) 
             Nei10_cal_times <=  12'd0;
      end 
     
      
         always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei11_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei11_cal_times <=(Home0_Ptcal_Num )*( Nei11_Ptcal_Num  ); 
           else if( Update_ALL_Force_Ram_done  ) 
            Nei11_cal_times <=  12'd0;
      end 
      
      
        always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
         Nei12_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei12_cal_times <= (Home0_Ptcal_Num  )*( Nei12_Ptcal_Num ); 
           else if( Update_ALL_Force_Ram_done  ) 
            Nei12_cal_times <=  12'd0;
      end 
        
         always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
         Nei13_cal_times <=  12'd0;
      else if (Subcell_pass_done)
        Nei13_cal_times <=(Home0_Ptcal_Num  )*( Nei13_Ptcal_Num ); 
           else if( Update_ALL_Force_Ram_done  ) 
           Nei13_cal_times <=  12'd0;
      end  

                          
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
                  else if (S_AXIS_update_One_Done1)
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
             M_AXIS_Home1_wr_data <=M_AXIS_LJ_EnE_Force1;
      else       
             M_AXIS_Home1_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Home1_ram_addr<= 12'd0 ;   
      else if ( Home1_Update_wr_flow_State ==Home1_Update_wr_flow_BEGIN)
                 M_AXIS_Home1_ram_addr<= Home1_Update_Num ;
      else       
                M_AXIS_Home1_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Home1_Update_Flow_RST   = 5'b00001	,
           Home1_Update_Flow_IDLE  = 5'b00010	,
           Home1_Update_Flow_BEGIN = 5'b00100	,
           Home1_Update_Flow_CHK   = 5'b01000	,
           Home1_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Home1_Update_Flow_State <= Home1_Update_Flow_RST;
     end 
      else begin 
           case( Home1_Update_Flow_State)  
            Home1_Update_Flow_RST :
                begin
                      Home1_Update_Flow_State  <=Home1_Update_Flow_IDLE;
                end 
            Home1_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Home1_Update_Flow_State <=Home1_Update_Flow_BEGIN;
                  else
                      Home1_Update_Flow_State <=Home1_Update_Flow_IDLE;
                  end 
            Home1_Update_Flow_BEGIN:
                 begin 
                      if ( Home1_Update_Num >= Home1_cal_times)
                       Home1_Update_Flow_State <=Home1_Update_Flow_END;    
                      else
                       Home1_Update_Flow_State <=Home1_Update_Flow_CHK;  
                 end 
            Home1_Update_Flow_CHK:
                  begin 
                      if (Home1ram_wr_one_Done)  
                     Home1_Update_Flow_State <=Home1_Update_Flow_BEGIN;
                     else
                     Home1_Update_Flow_State <=Home1_Update_Flow_CHK;  
                   end 
            Home1_Update_Flow_END:
                 begin        
                      if (Home0_cell_cal_finish)
                        Home1_Update_Flow_State <=Home1_Update_Flow_IDLE;
                      else
                       Home1_Update_Flow_State <=Home1_Update_Flow_END;
                 end     
                 
       default:       Home1_Update_Flow_State <=Home1_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Home1_Update_ene_force <=  1'b0 ;  
      else if ( Home1_Update_Flow_State ==Home1_Update_Flow_END )
              Home1_Update_ene_force <=  1'b1 ;
      else if ( Home1_Update_Flow_State ==Home1_Update_Flow_IDLE )      
               Home1_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Home1_Update_Num <= 12'd0 ;  
      else if ( Home1ram_wr_one_Done )
              Home1_Update_Num  <= Home1_Update_Num + 12'd1 ; 
      else if ( Home1_Update_Flow_State ==Home1_Update_Flow_IDLE )      
              Home1_Update_Num <= 12'd0 ;     
      end 




//-----------------------------------------------------------------------------------------------//
//  //   Nei1
//-----------------------------------------------------------------------------------------------//


localparam [4:0]
           Nei1_Update_wr_flow_RST   = 5'b00001	,
           Nei1_Update_wr_flow_Wait  = 5'b00010	,
           Nei1_Update_wr_flow_IDLE  = 5'b00100	,
           Nei1_Update_wr_flow_BEGIN = 5'b01000	,
           Nei1_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei1_Update_wr_flow_State <= Nei1_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei1_Update_wr_flow_State)  
            Nei1_Update_wr_flow_RST :
                begin
                      Nei1_Update_wr_flow_State  <=Nei1_Update_wr_flow_Wait;
                end 
            Nei1_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei1_Update_wr_flow_State  <=Nei1_Update_wr_flow_IDLE;                 
                end 
            Nei1_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei1_Update_wr_flow_State  <=Nei1_Update_wr_flow_Wait;
                  else if (S_AXIS_update_One_Done2)
                      Nei1_Update_wr_flow_State <=Nei1_Update_wr_flow_BEGIN;
                  else
                      Nei1_Update_wr_flow_State <=Nei1_Update_wr_flow_IDLE;
                  end 
            Nei1_Update_wr_flow_BEGIN:
                 begin
                      Nei1_Update_wr_flow_State <=Nei1_Update_wr_flow_END;
                 end 
  
            Nei1_Update_wr_flow_END:
                 begin        
                      Nei1_Update_wr_flow_State <=Nei1_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei1_Update_wr_flow_State <=Nei1_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei1ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei1_Update_wr_flow_State ==Nei1_Update_wr_flow_END )
             Nei1ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei1ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei1_wr_en    <= 1'b0 ;       
      else if ( Nei1_Update_wr_flow_State ==Nei1_Update_wr_flow_BEGIN )
             M_AXIS_Nei1_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei1_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei1_wr_data <= 256'd0 ;     
      else if ( Nei1_Update_wr_flow_State ==Nei1_Update_wr_flow_BEGIN )
             M_AXIS_Nei1_wr_data <=M_AXIS_LJ_EnE_Force2;
      else       
             M_AXIS_Nei1_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei1_ram_addr<= 8'd0 ;   
      else if ( Nei1_Update_wr_flow_State ==Nei1_Update_wr_flow_BEGIN)
                 M_AXIS_Nei1_ram_addr<= Nei1_Update_Num ;
      else       
                M_AXIS_Nei1_ram_addr<= 8'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei1_Update_Flow_RST   = 5'b00001	,
           Nei1_Update_Flow_IDLE  = 5'b00010	,
           Nei1_Update_Flow_BEGIN = 5'b00100	,
           Nei1_Update_Flow_CHK   = 5'b01000	,
           Nei1_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei1_Update_Flow_State <= Nei1_Update_Flow_RST;
     end 
      else begin 
           case( Nei1_Update_Flow_State)  
            Nei1_Update_Flow_RST :
                begin
                      Nei1_Update_Flow_State  <=Nei1_Update_Flow_IDLE;
                end 
                
                
            Nei1_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei1_Update_Flow_State <=Nei1_Update_Flow_BEGIN;
                  else
                      Nei1_Update_Flow_State <=Nei1_Update_Flow_IDLE;
                  end 
            Nei1_Update_Flow_BEGIN:
                 begin 
                      if ( Nei1_Update_Num == Nei1_cal_times)
                       Nei1_Update_Flow_State <=Nei1_Update_Flow_END;    
                      else
                       Nei1_Update_Flow_State <=Nei1_Update_Flow_CHK;  
                 end 
            Nei1_Update_Flow_CHK:
                  begin 
                      if (Nei1ram_wr_one_Done)  
                     Nei1_Update_Flow_State <=Nei1_Update_Flow_BEGIN;
                     else
                     Nei1_Update_Flow_State <=Nei1_Update_Flow_CHK;  
                   end 
            Nei1_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                       Nei1_Update_Flow_State <=Nei1_Update_Flow_IDLE;
                      else
                       Nei1_Update_Flow_State <=Nei1_Update_Flow_END;
                 end     
                 
       default:       Nei1_Update_Flow_State <=Nei1_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei1_Update_ene_force <=  1'b0 ;  
      else if ( Nei1_Update_Flow_State ==Nei1_Update_Flow_END )
              Nei1_Update_ene_force <=  1'b1 ;
      else if ( Nei1_Update_Flow_State ==Nei1_Update_Flow_IDLE )      
               Nei1_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei1_Update_Num <= 12'd0 ;  
      else if ( Nei1ram_wr_one_Done )
              Nei1_Update_Num <=Nei1_Update_Num + 1'b1 ; 
      else if ( Nei1_Update_Flow_State ==Nei1_Update_Flow_IDLE )      
               Nei1_Update_Num <= 12'd0 ;     
      end 



//-----------------------------------------------------------------------------------------------//
 //   Nei2
//-----------------------------------------------------------------------------------------------//


localparam [4:0]
           Nei2_Update_wr_flow_RST   = 5'b00001	,
           Nei2_Update_wr_flow_Wait  = 5'b00010	,
           Nei2_Update_wr_flow_IDLE  = 5'b00100	,
           Nei2_Update_wr_flow_BEGIN = 5'b01000	,
           Nei2_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei2_Update_wr_flow_State <= Nei2_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei2_Update_wr_flow_State)  
            Nei2_Update_wr_flow_RST :
                begin
                      Nei2_Update_wr_flow_State  <=Nei2_Update_wr_flow_Wait;
                end 
             Nei2_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                      Nei2_Update_wr_flow_State  <=Nei2_Update_wr_flow_IDLE;                 
                end 
            Nei2_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei2_Update_wr_flow_State  <=Nei2_Update_wr_flow_Wait;             
                  else if (S_AXIS_update_One_Done3)
                      Nei2_Update_wr_flow_State <=Nei2_Update_wr_flow_BEGIN;
                  else
                      Nei2_Update_wr_flow_State <=Nei2_Update_wr_flow_IDLE;
                  end 
            Nei2_Update_wr_flow_BEGIN:
                 begin
                      Nei2_Update_wr_flow_State <=Nei2_Update_wr_flow_END;
                 end 
  
            Nei2_Update_wr_flow_END:
                 begin        
                      Nei2_Update_wr_flow_State <=Nei2_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei2_Update_wr_flow_State <=Nei2_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei2ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei2_Update_wr_flow_State ==Nei2_Update_wr_flow_END )
             Nei2ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei2ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei2_wr_en    <= 1'b0 ;       
      else if ( Nei2_Update_wr_flow_State ==Nei2_Update_wr_flow_BEGIN )
             M_AXIS_Nei2_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei2_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei2_wr_data <= 256'd0 ;     
      else if ( Nei2_Update_wr_flow_State ==Nei2_Update_wr_flow_BEGIN )
             M_AXIS_Nei2_wr_data <=M_AXIS_LJ_EnE_Force3;
      else       
             M_AXIS_Nei2_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei2_ram_addr<= 12'd0 ;   
      else if ( Nei2_Update_wr_flow_State ==Nei2_Update_wr_flow_BEGIN)
                 M_AXIS_Nei2_ram_addr<= Nei2_Update_Num ;
      else       
                M_AXIS_Nei2_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei2_Update_Flow_RST   = 5'b00001	,
           Nei2_Update_Flow_IDLE  = 5'b00010	,
           Nei2_Update_Flow_BEGIN = 5'b00100	,
           Nei2_Update_Flow_CHK   = 5'b01000	,
           Nei2_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei2_Update_Flow_State <= Nei2_Update_Flow_RST;
     end 
      else begin 
           case( Nei2_Update_Flow_State)  
            Nei2_Update_Flow_RST :
                begin
                      Nei2_Update_Flow_State  <=Nei2_Update_Flow_IDLE;
                end 
            Nei2_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei2_Update_Flow_State <=Nei2_Update_Flow_BEGIN;
                  else
                      Nei2_Update_Flow_State <=Nei2_Update_Flow_IDLE;
                  end 
            Nei2_Update_Flow_BEGIN:
                 begin 
                      if ( Nei2_Update_Num >= Nei2_cal_times)
                       Nei2_Update_Flow_State <=Nei2_Update_Flow_END;    
                      else
                       Nei2_Update_Flow_State <=Nei2_Update_Flow_CHK;  
                 end 
            Nei2_Update_Flow_CHK:
                  begin 
                      if (Nei2ram_wr_one_Done)  
                     Nei2_Update_Flow_State <=Nei2_Update_Flow_BEGIN;
                     else
                     Nei2_Update_Flow_State <=Nei2_Update_Flow_CHK;  
                   end 
            Nei2_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei2_Update_Flow_State <=Nei2_Update_Flow_IDLE;
                      else
                       Nei2_Update_Flow_State <=Nei2_Update_Flow_END;
                 end     
                 
       default:       Nei2_Update_Flow_State <=Nei2_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei2_Update_ene_force <=  1'b0 ;  
      else if ( Nei2_Update_Flow_State ==Nei2_Update_Flow_END )
              Nei2_Update_ene_force <=  1'b1 ;
      else if ( Nei2_Update_Flow_State ==Nei2_Update_Flow_IDLE )      
               Nei2_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei2_Update_Num <= 12'd0 ;  
      else if ( Nei2ram_wr_one_Done )
              Nei2_Update_Num <=Nei2_Update_Num + 1'b1 ; 
      else if ( Nei2_Update_Flow_State ==Nei2_Update_Flow_IDLE )      
               Nei2_Update_Num <= 12'd0 ;     
      end 



//-----------------------------------------------------------------------------------------------//
 //   Nei3
//-----------------------------------------------------------------------------------------------//


localparam [4:0]
           Nei3_Update_wr_flow_RST   = 5'b00001	,
            Nei3_Update_wr_flow_Wait = 5'b00010	,
           Nei3_Update_wr_flow_IDLE  = 5'b00100	,
           Nei3_Update_wr_flow_BEGIN = 5'b01000	,
           Nei3_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei3_Update_wr_flow_State <= Nei3_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei3_Update_wr_flow_State)  
            Nei3_Update_wr_flow_RST :
                begin
                      Nei3_Update_wr_flow_State  <=Nei3_Update_wr_flow_Wait;
                end 
             Nei3_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei3_Update_wr_flow_State  <=Nei3_Update_wr_flow_IDLE;                 
                end 
            Nei3_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei3_Update_wr_flow_State  <=Nei3_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done4)
                      Nei3_Update_wr_flow_State <=Nei3_Update_wr_flow_BEGIN;
                  else
                      Nei3_Update_wr_flow_State <=Nei3_Update_wr_flow_IDLE;
                  end 
            Nei3_Update_wr_flow_BEGIN:
                 begin
                      Nei3_Update_wr_flow_State <=Nei3_Update_wr_flow_END;
                 end 
  
            Nei3_Update_wr_flow_END:
                 begin        
                      Nei3_Update_wr_flow_State <=Nei3_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei3_Update_wr_flow_State <=Nei3_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei3ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei3_Update_wr_flow_State ==Nei3_Update_wr_flow_END )
             Nei3ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei3ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei3_wr_en    <= 1'b0 ;       
      else if ( Nei3_Update_wr_flow_State ==Nei3_Update_wr_flow_BEGIN )
             M_AXIS_Nei3_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei3_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei3_wr_data <= 256'd0 ;     
      else if ( Nei3_Update_wr_flow_State ==Nei3_Update_wr_flow_BEGIN )
             M_AXIS_Nei3_wr_data <=M_AXIS_LJ_EnE_Force4;
      else       
             M_AXIS_Nei3_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei3_ram_addr<= 12'd0 ;   
      else if ( Nei3_Update_wr_flow_State ==Nei3_Update_wr_flow_BEGIN)
                 M_AXIS_Nei3_ram_addr<= Nei3_Update_Num ;
      else       
                M_AXIS_Nei3_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei3_Update_Flow_RST   = 5'b00001	,
           Nei3_Update_Flow_IDLE  = 5'b00010	,
           Nei3_Update_Flow_BEGIN = 5'b00100	,
           Nei3_Update_Flow_CHK   = 5'b01000	,
           Nei3_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei3_Update_Flow_State <= Nei3_Update_Flow_RST;
     end 
      else begin 
           case( Nei3_Update_Flow_State)  
            Nei3_Update_Flow_RST :
                begin
                      Nei3_Update_Flow_State  <=Nei3_Update_Flow_IDLE;
                end 
            Nei3_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei3_Update_Flow_State <=Nei3_Update_Flow_BEGIN;
                  else
                      Nei3_Update_Flow_State <=Nei3_Update_Flow_IDLE;
                  end 
            Nei3_Update_Flow_BEGIN:
                 begin 
                      if ( Nei3_Update_Num >= Nei3_cal_times)
                       Nei3_Update_Flow_State <=Nei3_Update_Flow_END;    
                      else
                       Nei3_Update_Flow_State <=Nei3_Update_Flow_CHK;  
                 end 
            Nei3_Update_Flow_CHK:
                  begin 
                      if (Nei3ram_wr_one_Done)  
                     Nei3_Update_Flow_State <=Nei3_Update_Flow_BEGIN;
                     else
                     Nei3_Update_Flow_State <=Nei3_Update_Flow_CHK;  
                   end 
            Nei3_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei3_Update_Flow_State <=Nei3_Update_Flow_IDLE;
                      else
                       Nei3_Update_Flow_State <=Nei3_Update_Flow_END;
                 end     
                 
       default:       Nei3_Update_Flow_State <=Nei3_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei3_Update_ene_force <=  1'b0 ;  
      else if ( Nei3_Update_Flow_State ==Nei3_Update_Flow_END)
              Nei3_Update_ene_force <=  1'b1 ;
      else if ( Nei3_Update_Flow_State ==Nei3_Update_Flow_IDLE )      
               Nei3_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei3_Update_Num <= 12'd0 ;  
      else if ( Nei3ram_wr_one_Done )
              Nei3_Update_Num <=Nei3_Update_Num  + 1'b1 ; 
      else if ( Nei3_Update_Flow_State ==Nei3_Update_Flow_IDLE )      
               Nei3_Update_Num <= 12'd0 ;     
      end 

       
 //-----------------------------------------------------------------------------------------------//
 //   Nei4
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei4_Update_wr_flow_RST   = 5'b00001	,
           Nei4_Update_wr_flow_Wait  = 5'b00010	,
           Nei4_Update_wr_flow_IDLE  = 5'b00100	,
           Nei4_Update_wr_flow_BEGIN = 5'b01000	,
           Nei4_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei4_Update_wr_flow_State <= Nei4_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei4_Update_wr_flow_State)  
            Nei4_Update_wr_flow_RST :
                begin
                      Nei4_Update_wr_flow_State  <=Nei4_Update_wr_flow_Wait;
                end 
             Nei4_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei4_Update_wr_flow_State  <=Nei4_Update_wr_flow_IDLE;                 
                end 
            Nei4_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei4_Update_wr_flow_State  <=Nei4_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done5)
                      Nei4_Update_wr_flow_State <=Nei4_Update_wr_flow_BEGIN;
                  else
                      Nei4_Update_wr_flow_State <=Nei4_Update_wr_flow_IDLE;
                  end 
            Nei4_Update_wr_flow_BEGIN:
                 begin
                      Nei4_Update_wr_flow_State <=Nei4_Update_wr_flow_END;
                 end 
  
            Nei4_Update_wr_flow_END:
                 begin        
                      Nei4_Update_wr_flow_State <=Nei4_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei4_Update_wr_flow_State <=Nei4_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei4ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei4_Update_wr_flow_State ==Nei4_Update_wr_flow_END )
             Nei4ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei4ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei4_wr_en    <= 1'b0 ;       
      else if ( Nei4_Update_wr_flow_State ==Nei4_Update_wr_flow_BEGIN )
             M_AXIS_Nei4_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei4_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei4_wr_data <= 256'd0 ;     
      else if ( Nei4_Update_wr_flow_State ==Nei4_Update_wr_flow_BEGIN )
             M_AXIS_Nei4_wr_data <=M_AXIS_LJ_EnE_Force5;
      else       
             M_AXIS_Nei4_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei4_ram_addr<= 12'd0 ;   
      else if ( Nei4_Update_wr_flow_State ==Nei4_Update_wr_flow_BEGIN)
                 M_AXIS_Nei4_ram_addr<= Nei4_Update_Num ;
      else       
                M_AXIS_Nei4_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei4_Update_Flow_RST   = 5'b00001	,
           Nei4_Update_Flow_IDLE  = 5'b00010	,
           Nei4_Update_Flow_BEGIN = 5'b00100	,
           Nei4_Update_Flow_CHK   = 5'b01000	,
           Nei4_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei4_Update_Flow_State <= Nei4_Update_Flow_RST;
     end 
      else begin 
           case( Nei4_Update_Flow_State)  
            Nei4_Update_Flow_RST :
                begin
                      Nei4_Update_Flow_State  <=Nei4_Update_Flow_IDLE;
                end 
            Nei4_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei4_Update_Flow_State <=Nei4_Update_Flow_BEGIN;
                  else
                      Nei4_Update_Flow_State <=Nei4_Update_Flow_IDLE;
                  end 
            Nei4_Update_Flow_BEGIN:
                 begin 
                      if ( Nei4_Update_Num >= Nei4_cal_times)
                       Nei4_Update_Flow_State <=Nei4_Update_Flow_END;    
                      else
                       Nei4_Update_Flow_State <=Nei4_Update_Flow_CHK;  
                 end 
            Nei4_Update_Flow_CHK:
                  begin 
                      if (Nei4ram_wr_one_Done)  
                     Nei4_Update_Flow_State <=Nei4_Update_Flow_BEGIN;
                     else
                     Nei4_Update_Flow_State <=Nei4_Update_Flow_CHK;  
                   end 
            Nei4_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei4_Update_Flow_State <=Nei4_Update_Flow_IDLE;
                      else
                       Nei4_Update_Flow_State <=Nei4_Update_Flow_END;
                 end     
                 
       default:       Nei4_Update_Flow_State <=Nei4_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei4_Update_ene_force <=  1'b0 ;  
      else if ( Nei4_Update_Flow_State ==Nei4_Update_Flow_END)
              Nei4_Update_ene_force <=  1'b1 ;
      else if ( Nei4_Update_Flow_State ==Nei4_Update_Flow_IDLE )      
               Nei4_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei4_Update_Num <= 12'd0 ;  
      else if ( Nei4ram_wr_one_Done )
              Nei4_Update_Num <=Nei4_Update_Num+ 1'b1 ; 
      else if ( Nei4_Update_Flow_State ==Nei4_Update_Flow_IDLE )      
               Nei4_Update_Num <= 12'd0 ;     
      end 
    
 
 
//-----------------------------------------------------------------------------------------------//
//   Nei5
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei5_Update_wr_flow_RST   = 5'b00001	,
           Nei5_Update_wr_flow_Wait  = 5'b00010	,    
           Nei5_Update_wr_flow_IDLE  = 5'b00100	,
           Nei5_Update_wr_flow_BEGIN = 5'b01000	,
           Nei5_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei5_Update_wr_flow_State <= Nei5_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei5_Update_wr_flow_State)  
            Nei5_Update_wr_flow_RST :
                begin
                      Nei5_Update_wr_flow_State  <=Nei5_Update_wr_flow_Wait;
                end 
           Nei5_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei5_Update_wr_flow_State   <=Nei5_Update_wr_flow_IDLE;                 
                end 
            Nei5_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei5_Update_wr_flow_State  <=Nei5_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done6)
                      Nei5_Update_wr_flow_State <=Nei5_Update_wr_flow_BEGIN;
                  else
                      Nei5_Update_wr_flow_State <=Nei5_Update_wr_flow_IDLE;
                  end 
            Nei5_Update_wr_flow_BEGIN:
                 begin
                      Nei5_Update_wr_flow_State <=Nei5_Update_wr_flow_END;
                 end 
  
            Nei5_Update_wr_flow_END:
                 begin        
                      Nei5_Update_wr_flow_State <=Nei5_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei5_Update_wr_flow_State <=Nei5_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei5ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei5_Update_wr_flow_State ==Nei5_Update_wr_flow_END )
             Nei5ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei5ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei5_wr_en    <= 1'b0 ;       
      else if ( Nei5_Update_wr_flow_State ==Nei5_Update_wr_flow_BEGIN )
             M_AXIS_Nei5_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei5_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei5_wr_data <= 256'd0 ;     
      else if ( Nei5_Update_wr_flow_State ==Nei5_Update_wr_flow_BEGIN )
             M_AXIS_Nei5_wr_data <=M_AXIS_LJ_EnE_Force6;
      else       
             M_AXIS_Nei5_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei5_ram_addr<= 12'd0 ;   
      else if ( Nei5_Update_wr_flow_State ==Nei5_Update_wr_flow_BEGIN)
                 M_AXIS_Nei5_ram_addr<= Nei5_Update_Num ;
      else       
                M_AXIS_Nei5_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei5_Update_Flow_RST   = 5'b00001	,
           Nei5_Update_Flow_IDLE  = 5'b00010	,
           Nei5_Update_Flow_BEGIN = 5'b00100	,
           Nei5_Update_Flow_CHK   = 5'b01000	,
           Nei5_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei5_Update_Flow_State <= Nei5_Update_Flow_RST;
     end 
      else begin 
           case( Nei5_Update_Flow_State)  
            Nei5_Update_Flow_RST :
                begin
                      Nei5_Update_Flow_State  <=Nei5_Update_Flow_IDLE;
                end 
            Nei5_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei5_Update_Flow_State <=Nei5_Update_Flow_BEGIN;
                  else
                      Nei5_Update_Flow_State <=Nei5_Update_Flow_IDLE;
                  end 
            Nei5_Update_Flow_BEGIN:
                 begin 
                      if ( Nei5_Update_Num >= Nei5_cal_times)
                       Nei5_Update_Flow_State <=Nei5_Update_Flow_END;    
                      else
                       Nei5_Update_Flow_State <=Nei5_Update_Flow_CHK;  
                 end 
            Nei5_Update_Flow_CHK:
                  begin 
                      if (Nei5ram_wr_one_Done)  
                     Nei5_Update_Flow_State <=Nei5_Update_Flow_BEGIN;
                     else
                     Nei5_Update_Flow_State <=Nei5_Update_Flow_CHK;  
                   end 
            Nei5_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei5_Update_Flow_State <=Nei5_Update_Flow_IDLE;
                      else
                       Nei5_Update_Flow_State <=Nei5_Update_Flow_END;
                 end     
                 
       default:       Nei5_Update_Flow_State <=Nei5_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei5_Update_ene_force <=  1'b0 ;  
      else if ( Nei5_Update_Flow_State ==Nei5_Update_Flow_END )
              Nei5_Update_ene_force <=  1'b1 ;
      else if ( Nei5_Update_Flow_State ==Nei5_Update_Flow_IDLE )      
               Nei5_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei5_Update_Num <= 12'd0 ;  
      else if ( Nei5ram_wr_one_Done )
              Nei5_Update_Num <=Nei5_Update_Num + 1'b1 ; 
      else if ( Nei5_Update_Flow_State ==Nei5_Update_Flow_IDLE )      
               Nei5_Update_Num <= 12'd0 ;     
      end 

//-----------------------------------------------------------------------------------------------//
//   Nei6
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei6_Update_wr_flow_RST   = 5'b00001	,
           Nei6_Update_wr_flow_Wait  = 5'b00010	,  
           Nei6_Update_wr_flow_IDLE  = 5'b00100	,
           Nei6_Update_wr_flow_BEGIN = 5'b01000	,
           Nei6_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei6_Update_wr_flow_State <= Nei6_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei6_Update_wr_flow_State)  
            Nei6_Update_wr_flow_RST :
                begin
                      Nei6_Update_wr_flow_State  <=Nei6_Update_wr_flow_Wait;
                end 
           Nei6_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei6_Update_wr_flow_State  <=Nei6_Update_wr_flow_IDLE;                 
                end 
            Nei6_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei6_Update_wr_flow_State  <=Nei6_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done7)
                      Nei6_Update_wr_flow_State <=Nei6_Update_wr_flow_BEGIN;
                  else
                      Nei6_Update_wr_flow_State <=Nei6_Update_wr_flow_IDLE;
                  end 
            Nei6_Update_wr_flow_BEGIN:
                 begin
                      Nei6_Update_wr_flow_State <=Nei6_Update_wr_flow_END;
                 end 
  
            Nei6_Update_wr_flow_END:
                 begin        
                      Nei6_Update_wr_flow_State <=Nei6_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei6_Update_wr_flow_State <=Nei6_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei6ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei6_Update_wr_flow_State ==Nei6_Update_wr_flow_END )
             Nei6ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei6ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei6_wr_en    <= 1'b0 ;       
      else if ( Nei6_Update_wr_flow_State ==Nei6_Update_wr_flow_BEGIN )
             M_AXIS_Nei6_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei6_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei6_wr_data <= 256'd0 ;     
      else if ( Nei6_Update_wr_flow_State ==Nei6_Update_wr_flow_BEGIN )
             M_AXIS_Nei6_wr_data <=M_AXIS_LJ_EnE_Force7;
      else       
             M_AXIS_Nei6_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei6_ram_addr<= 12'd0 ;   
      else if ( Nei6_Update_wr_flow_State ==Nei6_Update_wr_flow_BEGIN)
                 M_AXIS_Nei6_ram_addr<= Nei6_Update_Num ;
      else       
                M_AXIS_Nei6_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei6_Update_Flow_RST   = 5'b00001	,
           Nei6_Update_Flow_IDLE  = 5'b00010	,
           Nei6_Update_Flow_BEGIN = 5'b00100	,
           Nei6_Update_Flow_CHK   = 5'b01000	,
           Nei6_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei6_Update_Flow_State <= Nei6_Update_Flow_RST;
     end 
      else begin 
           case( Nei6_Update_Flow_State)  
            Nei6_Update_Flow_RST :
                begin
                      Nei6_Update_Flow_State  <=Nei6_Update_Flow_IDLE;
                end 
            Nei6_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei6_Update_Flow_State <=Nei6_Update_Flow_BEGIN;
                  else
                      Nei6_Update_Flow_State <=Nei6_Update_Flow_IDLE;
                  end 
            Nei6_Update_Flow_BEGIN:
                 begin 
                      if ( Nei6_Update_Num >= Nei6_cal_times)
                       Nei6_Update_Flow_State <=Nei6_Update_Flow_END;    
                      else
                       Nei6_Update_Flow_State <=Nei6_Update_Flow_CHK;  
                 end 
            Nei6_Update_Flow_CHK:
                  begin 
                      if (Nei6ram_wr_one_Done)  
                     Nei6_Update_Flow_State <=Nei6_Update_Flow_BEGIN;
                     else
                     Nei6_Update_Flow_State <=Nei6_Update_Flow_CHK;  
                   end 
            Nei6_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei6_Update_Flow_State <=Nei6_Update_Flow_IDLE;
                      else
                       Nei6_Update_Flow_State <=Nei6_Update_Flow_END;
                 end     
                 
       default:       Nei6_Update_Flow_State <=Nei6_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei6_Update_ene_force <=  1'b0 ;  
      else if ( Nei6_Update_Flow_State ==Nei6_Update_Flow_END )
              Nei6_Update_ene_force <=  1'b1 ;
      else if ( Nei6_Update_Flow_State ==Nei6_Update_Flow_IDLE )      
               Nei6_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei6_Update_Num <= 12'd0 ;  
      else if ( Nei6ram_wr_one_Done )
              Nei6_Update_Num <= Nei6_Update_Num+ 1'b1 ; 
      else if ( Nei6_Update_Flow_State ==Nei6_Update_Flow_IDLE )      
               Nei6_Update_Num <= 12'd0 ;     
      end 
        
  
 //-----------------------------------------------------------------------------------------------//
//   Nei7
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei7_Update_wr_flow_RST   = 5'b00001	,
           Nei7_Update_wr_flow_Wait  = 5'b00010	,
           Nei7_Update_wr_flow_IDLE  = 5'b00100	,
           Nei7_Update_wr_flow_BEGIN = 5'b01000	,
           Nei7_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei7_Update_wr_flow_State <= Nei7_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei7_Update_wr_flow_State)  
            Nei7_Update_wr_flow_RST :
                begin
                      Nei7_Update_wr_flow_State  <=Nei7_Update_wr_flow_Wait;
                end 
           Nei7_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei7_Update_wr_flow_State  <=Nei7_Update_wr_flow_IDLE;                 
                end 
            Nei7_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei7_Update_wr_flow_State  <=Nei7_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done8)
                      Nei7_Update_wr_flow_State <=Nei7_Update_wr_flow_BEGIN;
                  else
                      Nei7_Update_wr_flow_State <=Nei7_Update_wr_flow_IDLE;
                  end 
            Nei7_Update_wr_flow_BEGIN:
                 begin
                      Nei7_Update_wr_flow_State <=Nei7_Update_wr_flow_END;
                 end 
  
            Nei7_Update_wr_flow_END:
                 begin        
                      Nei7_Update_wr_flow_State <=Nei7_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei7_Update_wr_flow_State <=Nei7_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei7ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei7_Update_wr_flow_State ==Nei7_Update_wr_flow_END )
             Nei7ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei7ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei7_wr_en    <= 1'b0 ;       
      else if ( Nei7_Update_wr_flow_State ==Nei7_Update_wr_flow_BEGIN )
             M_AXIS_Nei7_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei7_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei7_wr_data <= 256'd0 ;     
      else if ( Nei7_Update_wr_flow_State ==Nei7_Update_wr_flow_BEGIN )
             M_AXIS_Nei7_wr_data <=M_AXIS_LJ_EnE_Force8;
      else       
             M_AXIS_Nei7_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei7_ram_addr<= 12'd0 ;   
      else if ( Nei7_Update_wr_flow_State ==Nei7_Update_wr_flow_BEGIN)
                 M_AXIS_Nei7_ram_addr<= Nei7_Update_Num ;
      else       
                M_AXIS_Nei7_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei7_Update_Flow_RST   = 5'b00001	,
           Nei7_Update_Flow_IDLE  = 5'b00010	,
           Nei7_Update_Flow_BEGIN = 5'b00100	,
           Nei7_Update_Flow_CHK   = 5'b01000	,
           Nei7_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei7_Update_Flow_State <= Nei7_Update_Flow_RST;
     end 
      else begin 
           case( Nei7_Update_Flow_State)  
            Nei7_Update_Flow_RST :
                begin
                      Nei7_Update_Flow_State  <=Nei7_Update_Flow_IDLE;
                end 
            Nei7_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei7_Update_Flow_State <=Nei7_Update_Flow_BEGIN;
                  else
                      Nei7_Update_Flow_State <=Nei7_Update_Flow_IDLE;
                  end 
            Nei7_Update_Flow_BEGIN:
                 begin 
                      if ( Nei7_Update_Num >= Nei7_cal_times)
                       Nei7_Update_Flow_State <=Nei7_Update_Flow_END;    
                      else
                       Nei7_Update_Flow_State <=Nei7_Update_Flow_CHK;  
                 end 
            Nei7_Update_Flow_CHK:
                  begin 
                      if (Nei7ram_wr_one_Done)  
                     Nei7_Update_Flow_State <=Nei7_Update_Flow_BEGIN;
                     else
                     Nei7_Update_Flow_State <=Nei7_Update_Flow_CHK;  
                   end 
            Nei7_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei7_Update_Flow_State <=Nei7_Update_Flow_IDLE;
                      else
                       Nei7_Update_Flow_State <=Nei7_Update_Flow_END;
                 end     
                 
       default:       Nei7_Update_Flow_State <=Nei7_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei7_Update_ene_force <=  1'b0 ;  
      else if ( Nei7_Update_Flow_State ==Nei7_Update_Flow_END )
              Nei7_Update_ene_force <=  1'b1 ;
      else if ( Nei7_Update_Flow_State ==Nei7_Update_Flow_IDLE )      
               Nei7_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei7_Update_Num <= 12'd0 ;  
      else if ( Nei7ram_wr_one_Done )
              Nei7_Update_Num <=Nei7_Update_Num + 1'b1 ; 
      else if ( Nei7_Update_Flow_State ==Nei7_Update_Flow_IDLE )      
               Nei7_Update_Num <= 12'd0 ;     
      end 
        
  //-----------------------------------------------------------------------------------------------//
//   Nei8
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei8_Update_wr_flow_RST   = 5'b00001	,
           Nei8_Update_wr_flow_Wait  = 5'b00010	,
           Nei8_Update_wr_flow_IDLE  = 5'b00100	,
           Nei8_Update_wr_flow_BEGIN = 5'b01000	,
           Nei8_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei8_Update_wr_flow_State <= Nei8_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei8_Update_wr_flow_State)  
            Nei8_Update_wr_flow_RST :
                begin
                      Nei8_Update_wr_flow_State  <=Nei8_Update_wr_flow_Wait;
                end 
          Nei8_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei8_Update_wr_flow_State  <=Nei8_Update_wr_flow_IDLE;                 
                end 
            Nei8_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei8_Update_wr_flow_State  <=Nei8_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done9)
                      Nei8_Update_wr_flow_State <=Nei8_Update_wr_flow_BEGIN;
                  else
                      Nei8_Update_wr_flow_State <=Nei8_Update_wr_flow_IDLE;
                  end 
            Nei8_Update_wr_flow_BEGIN:
                 begin
                      Nei8_Update_wr_flow_State <=Nei8_Update_wr_flow_END;
                 end 
  
            Nei8_Update_wr_flow_END:
                 begin        
                      Nei8_Update_wr_flow_State <=Nei8_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei8_Update_wr_flow_State <=Nei8_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei8ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei8_Update_wr_flow_State ==Nei8_Update_wr_flow_END )
             Nei8ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei8ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei8_wr_en    <= 1'b0 ;       
      else if ( Nei8_Update_wr_flow_State ==Nei8_Update_wr_flow_BEGIN )
             M_AXIS_Nei8_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei8_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei8_wr_data <= 256'd0 ;     
      else if ( Nei8_Update_wr_flow_State ==Nei8_Update_wr_flow_BEGIN )
             M_AXIS_Nei8_wr_data <=M_AXIS_LJ_EnE_Force9;
      else       
             M_AXIS_Nei8_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei8_ram_addr<= 12'd0 ;   
      else if ( Nei8_Update_wr_flow_State ==Nei8_Update_wr_flow_BEGIN)
                 M_AXIS_Nei8_ram_addr<= Nei8_Update_Num ;
      else       
                M_AXIS_Nei8_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei8_Update_Flow_RST   = 5'b00001	,
           Nei8_Update_Flow_IDLE  = 5'b00010	,
           Nei8_Update_Flow_BEGIN = 5'b00100	,
           Nei8_Update_Flow_CHK   = 5'b01000	,
           Nei8_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei8_Update_Flow_State <= Nei8_Update_Flow_RST;
     end 
      else begin 
           case( Nei8_Update_Flow_State)  
            Nei8_Update_Flow_RST :
                begin
                      Nei8_Update_Flow_State  <=Nei8_Update_Flow_IDLE;
                end 
            Nei8_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei8_Update_Flow_State <=Nei8_Update_Flow_BEGIN;
                  else
                      Nei8_Update_Flow_State <=Nei8_Update_Flow_IDLE;
                  end 
            Nei8_Update_Flow_BEGIN:
                 begin 
                      if ( Nei8_Update_Num >= Nei8_cal_times)
                       Nei8_Update_Flow_State <=Nei8_Update_Flow_END;    
                      else
                       Nei8_Update_Flow_State <=Nei8_Update_Flow_CHK;  
                 end 
            Nei8_Update_Flow_CHK:
                  begin 
                      if (Nei8ram_wr_one_Done)  
                     Nei8_Update_Flow_State <=Nei8_Update_Flow_BEGIN;
                     else
                     Nei8_Update_Flow_State <=Nei8_Update_Flow_CHK;  
                   end 
            Nei8_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei8_Update_Flow_State <=Nei8_Update_Flow_IDLE;
                      else
                       Nei8_Update_Flow_State <=Nei8_Update_Flow_END;
                 end     
                 
       default:       Nei8_Update_Flow_State <=Nei8_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei8_Update_ene_force <=  1'b0 ;  
      else if ( Nei8_Update_Flow_State ==Nei8_Update_Flow_END )
              Nei8_Update_ene_force <=  1'b1 ;
      else if ( Nei8_Update_Flow_State ==Nei8_Update_Flow_IDLE )      
               Nei8_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei8_Update_Num <= 12'd0 ;  
      else if ( Nei8ram_wr_one_Done )
              Nei8_Update_Num <=Nei8_Update_Num + 1'b1 ; 
      else if ( Nei8_Update_Flow_State ==Nei8_Update_Flow_IDLE )      
               Nei8_Update_Num <= 12'd0 ;     
      end 

//-----------------------------------------------------------------------------------------------//
//   Nei9
//-----------------------------------------------------------------------------------------------//


localparam [4:0]
           Nei9_Update_wr_flow_RST   = 5'b00001	,
           Nei9_Update_wr_flow_Wait  = 5'b00010	,    
           Nei9_Update_wr_flow_IDLE  = 5'b00100	,
           Nei9_Update_wr_flow_BEGIN = 5'b01000	,
           Nei9_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei9_Update_wr_flow_State <= Nei9_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei9_Update_wr_flow_State)  
            Nei9_Update_wr_flow_RST :
                begin
                      Nei9_Update_wr_flow_State  <=Nei9_Update_wr_flow_Wait;
                end 
            Nei9_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei9_Update_wr_flow_State  <=Nei9_Update_wr_flow_IDLE;                 
                end 
            Nei9_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei9_Update_wr_flow_State  <=Nei9_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done10)
                      Nei9_Update_wr_flow_State <=Nei9_Update_wr_flow_BEGIN;
                  else
                      Nei9_Update_wr_flow_State <=Nei9_Update_wr_flow_IDLE;
                  end 
            Nei9_Update_wr_flow_BEGIN:
                 begin
                      Nei9_Update_wr_flow_State <=Nei9_Update_wr_flow_END;
                 end 
  
            Nei9_Update_wr_flow_END:
                 begin        
                      Nei9_Update_wr_flow_State <=Nei9_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei9_Update_wr_flow_State <=Nei9_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei9ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei9_Update_wr_flow_State ==Nei9_Update_wr_flow_END )
             Nei9ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei9ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei9_wr_en    <= 1'b0 ;       
      else if ( Nei9_Update_wr_flow_State ==Nei9_Update_wr_flow_BEGIN )
             M_AXIS_Nei9_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei9_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei9_wr_data <= 256'd0 ;     
      else if ( Nei9_Update_wr_flow_State ==Nei9_Update_wr_flow_BEGIN )
             M_AXIS_Nei9_wr_data <=M_AXIS_LJ_EnE_Force10;
      else       
             M_AXIS_Nei9_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei9_ram_addr<= 12'd0 ;   
      else if ( Nei9_Update_wr_flow_State ==Nei9_Update_wr_flow_BEGIN)
                 M_AXIS_Nei9_ram_addr<= Nei9_Update_Num ;
      else       
                M_AXIS_Nei9_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei9_Update_Flow_RST   = 5'b00001	,
           Nei9_Update_Flow_IDLE  = 5'b00010	,
           Nei9_Update_Flow_BEGIN = 5'b00100	,
           Nei9_Update_Flow_CHK   = 5'b01000	,
           Nei9_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei9_Update_Flow_State <= Nei9_Update_Flow_RST;
     end 
      else begin 
           case( Nei9_Update_Flow_State)  
            Nei9_Update_Flow_RST :
                begin
                      Nei9_Update_Flow_State  <=Nei9_Update_Flow_IDLE;
                end 
            Nei9_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei9_Update_Flow_State <=Nei9_Update_Flow_BEGIN;
                  else
                      Nei9_Update_Flow_State <=Nei9_Update_Flow_IDLE;
                  end 
            Nei9_Update_Flow_BEGIN:
                 begin 
                      if ( Nei9_Update_Num >= Nei9_cal_times)
                       Nei9_Update_Flow_State <=Nei9_Update_Flow_END;    
                      else
                       Nei9_Update_Flow_State <=Nei9_Update_Flow_CHK;  
                 end 
            Nei9_Update_Flow_CHK:
                  begin 
                      if (Nei9ram_wr_one_Done)  
                     Nei9_Update_Flow_State <=Nei9_Update_Flow_BEGIN;
                     else
                     Nei9_Update_Flow_State <=Nei9_Update_Flow_CHK;  
                   end 
            Nei9_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei9_Update_Flow_State <=Nei9_Update_Flow_IDLE;
                      else
                       Nei9_Update_Flow_State <=Nei9_Update_Flow_END;
                 end     
                 
       default:       Nei9_Update_Flow_State <=Nei9_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei9_Update_ene_force <=  1'b0 ;  
      else if ( Nei9_Update_Flow_State ==Nei9_Update_Flow_END )
              Nei9_Update_ene_force <=  1'b1 ;
      else if ( Nei9_Update_Flow_State ==Nei9_Update_Flow_IDLE )      
               Nei9_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei9_Update_Num <= 12'd0 ;  
      else if ( Nei9ram_wr_one_Done )
              Nei9_Update_Num <=Nei9_Update_Num  + 1'b1 ; 
      else if ( Nei9_Update_Flow_State ==Nei9_Update_Flow_IDLE )      
               Nei9_Update_Num <= 12'd0 ;     
      end 
  
//-----------------------------------------------------------------------------------------------//
//   Nei10
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei10_Update_wr_flow_RST   = 5'b00001	,
           Nei10_Update_wr_flow_Wait  = 5'b00010	, 
           Nei10_Update_wr_flow_IDLE  = 5'b00100	,
           Nei10_Update_wr_flow_BEGIN = 5'b01000	,
           Nei10_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei10_Update_wr_flow_State <= Nei10_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei10_Update_wr_flow_State)  
            Nei10_Update_wr_flow_RST :
                begin
                      Nei10_Update_wr_flow_State  <=Nei10_Update_wr_flow_Wait;
                end 
           Nei10_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei10_Update_wr_flow_State  <=Nei10_Update_wr_flow_IDLE;                 
                end 
            Nei10_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei10_Update_wr_flow_State  <=Nei10_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done11)
                      Nei10_Update_wr_flow_State <=Nei10_Update_wr_flow_BEGIN;
                  else
                      Nei10_Update_wr_flow_State <=Nei10_Update_wr_flow_IDLE;
                  end 
            Nei10_Update_wr_flow_BEGIN:
                 begin
                      Nei10_Update_wr_flow_State <=Nei10_Update_wr_flow_END;
                 end 
  
            Nei10_Update_wr_flow_END:
                 begin        
                      Nei10_Update_wr_flow_State <=Nei10_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei10_Update_wr_flow_State <=Nei10_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei10ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei10_Update_wr_flow_State ==Nei10_Update_wr_flow_END )
             Nei10ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei10ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei10_wr_en    <= 1'b0 ;       
      else if ( Nei10_Update_wr_flow_State ==Nei10_Update_wr_flow_BEGIN )
             M_AXIS_Nei10_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei10_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei10_wr_data <= 256'd0 ;     
      else if ( Nei10_Update_wr_flow_State ==Nei10_Update_wr_flow_BEGIN )
             M_AXIS_Nei10_wr_data <=M_AXIS_LJ_EnE_Force11;
      else       
             M_AXIS_Nei10_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei10_ram_addr<= 12'd0 ;   
      else if ( Nei10_Update_wr_flow_State ==Nei10_Update_wr_flow_BEGIN)
                 M_AXIS_Nei10_ram_addr<= Nei10_Update_Num ;
      else       
                M_AXIS_Nei10_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei10_Update_Flow_RST   = 5'b00001	,
           Nei10_Update_Flow_IDLE  = 5'b00010	,
           Nei10_Update_Flow_BEGIN = 5'b00100	,
           Nei10_Update_Flow_CHK   = 5'b01000	,
           Nei10_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei10_Update_Flow_State <= Nei10_Update_Flow_RST;
     end 
      else begin 
           case( Nei10_Update_Flow_State)  
            Nei10_Update_Flow_RST :
                begin
                      Nei10_Update_Flow_State  <=Nei10_Update_Flow_IDLE;
                end 
            Nei10_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei10_Update_Flow_State <=Nei10_Update_Flow_BEGIN;
                  else
                      Nei10_Update_Flow_State <=Nei10_Update_Flow_IDLE;
                  end 
            Nei10_Update_Flow_BEGIN:
                 begin 
                      if ( Nei10_Update_Num >= Nei10_cal_times)
                       Nei10_Update_Flow_State <=Nei10_Update_Flow_END;    
                      else
                       Nei10_Update_Flow_State <=Nei10_Update_Flow_CHK;  
                 end 
            Nei10_Update_Flow_CHK:
                  begin 
                      if (Nei10ram_wr_one_Done)  
                     Nei10_Update_Flow_State <=Nei10_Update_Flow_BEGIN;
                     else
                     Nei10_Update_Flow_State <=Nei10_Update_Flow_CHK;  
                   end 
            Nei10_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei10_Update_Flow_State <=Nei10_Update_Flow_IDLE;
                      else
                       Nei10_Update_Flow_State <=Nei10_Update_Flow_END;
                 end     
                 
       default:       Nei10_Update_Flow_State <=Nei10_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei10_Update_ene_force <=  1'b0 ;  
      else if ( Nei10_Update_Flow_State ==Nei10_Update_Flow_END )
              Nei10_Update_ene_force <=  1'b1 ;
      else if ( Nei10_Update_Flow_State ==Nei10_Update_Flow_IDLE )      
               Nei10_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei10_Update_Num <= 12'd0 ;  
      else if ( Nei10ram_wr_one_Done )
              Nei10_Update_Num <=Nei10_Update_Num  + 1'b1 ; 
      else if ( Nei10_Update_Flow_State ==Nei10_Update_Flow_IDLE )      
               Nei10_Update_Num <= 12'd0 ;     
      end      
//-----------------------------------------------------------------------------------------------//
//   Nei11
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei11_Update_wr_flow_RST   = 5'b00001	,
           Nei11_Update_wr_flow_Wait  = 5'b00010	,   
           Nei11_Update_wr_flow_IDLE  = 5'b00100	,
           Nei11_Update_wr_flow_BEGIN = 5'b01000	,
           Nei11_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei11_Update_wr_flow_State <= Nei11_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei11_Update_wr_flow_State)  
            Nei11_Update_wr_flow_RST :
                begin
                      Nei11_Update_wr_flow_State  <=Nei11_Update_wr_flow_Wait;
                end 
            Nei11_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei11_Update_wr_flow_State  <=Nei11_Update_wr_flow_IDLE;                 
                end 
            Nei11_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei11_Update_wr_flow_State  <=Nei11_Update_wr_flow_Wait;    
                 else if (S_AXIS_update_One_Done12)
                      Nei11_Update_wr_flow_State <=Nei11_Update_wr_flow_BEGIN;
                  else
                      Nei11_Update_wr_flow_State <=Nei11_Update_wr_flow_IDLE;
                  end 
            Nei11_Update_wr_flow_BEGIN:
                 begin
                      Nei11_Update_wr_flow_State <=Nei11_Update_wr_flow_END;
                 end 
  
            Nei11_Update_wr_flow_END:
                 begin        
                      Nei11_Update_wr_flow_State <=Nei11_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei11_Update_wr_flow_State <=Nei11_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei11ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei11_Update_wr_flow_State ==Nei11_Update_wr_flow_END )
             Nei11ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei11ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei11_wr_en    <= 1'b0 ;       
      else if ( Nei11_Update_wr_flow_State ==Nei11_Update_wr_flow_BEGIN )
             M_AXIS_Nei11_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei11_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei11_wr_data <= 256'd0 ;     
      else if ( Nei11_Update_wr_flow_State ==Nei11_Update_wr_flow_BEGIN )
             M_AXIS_Nei11_wr_data <=M_AXIS_LJ_EnE_Force12;
      else       
             M_AXIS_Nei11_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei11_ram_addr<= 12'd0 ;   
      else if ( Nei11_Update_wr_flow_State ==Nei11_Update_wr_flow_BEGIN)
                 M_AXIS_Nei11_ram_addr<= Nei11_Update_Num ;
      else       
                M_AXIS_Nei11_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei11_Update_Flow_RST   = 5'b00001	,
           Nei11_Update_Flow_IDLE  = 5'b00010	,
           Nei11_Update_Flow_BEGIN = 5'b00100	,
           Nei11_Update_Flow_CHK   = 5'b01000	,
           Nei11_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei11_Update_Flow_State <= Nei11_Update_Flow_RST;
     end 
      else begin 
           case( Nei11_Update_Flow_State)  
            Nei11_Update_Flow_RST :
                begin
                      Nei11_Update_Flow_State  <=Nei11_Update_Flow_IDLE;
                end 
           Nei11_Update_Flow_IDLE :
                  begin
                  if (Subcell_pass_done )
                      Nei11_Update_Flow_State <=Nei11_Update_Flow_BEGIN;
                  else
                      Nei11_Update_Flow_State <=Nei11_Update_Flow_IDLE;
                  end 
            Nei11_Update_Flow_BEGIN:
                 begin 
                      if ( Nei11_Update_Num >= Nei11_cal_times)
                       Nei11_Update_Flow_State <=Nei11_Update_Flow_END;    
                      else
                       Nei11_Update_Flow_State <=Nei11_Update_Flow_CHK;  
                 end 
            Nei11_Update_Flow_CHK:
                  begin 
                      if (Nei11ram_wr_one_Done)  
                     Nei11_Update_Flow_State <=Nei11_Update_Flow_BEGIN;
                     else
                     Nei11_Update_Flow_State <=Nei11_Update_Flow_CHK;  
                   end 
            Nei11_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei11_Update_Flow_State <=Nei11_Update_Flow_IDLE;
                      else
                       Nei11_Update_Flow_State <=Nei11_Update_Flow_END;
                 end     
                 
       default:       Nei11_Update_Flow_State <=Nei11_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei11_Update_ene_force <=  1'b0 ;  
      else if ( Nei11_Update_Flow_State ==Nei11_Update_Flow_END )
              Nei11_Update_ene_force <=  1'b1 ;
      else if ( Nei11_Update_Flow_State ==Nei11_Update_Flow_IDLE )      
               Nei11_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei11_Update_Num <= 12'd0 ;  
      else if ( Nei11ram_wr_one_Done )
              Nei11_Update_Num <=Nei11_Update_Num +8'd1 ;  
      else if ( Nei11_Update_Flow_State ==Nei11_Update_Flow_IDLE )      
               Nei11_Update_Num <= 12'd0 ;     
      end 

//-----------------------------------------------------------------------------------------------//
//   Nei12
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei12_Update_wr_flow_RST   = 5'b00001	,
           Nei12_Update_wr_flow_Wait   = 5'b00010	,
           Nei12_Update_wr_flow_IDLE  = 5'b00100	,
           Nei12_Update_wr_flow_BEGIN = 5'b01000	,
           Nei12_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei12_Update_wr_flow_State <= Nei12_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei12_Update_wr_flow_State)  
            Nei12_Update_wr_flow_RST :
                begin
                      Nei12_Update_wr_flow_State  <=Nei12_Update_wr_flow_Wait;
                end 
           Nei12_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei12_Update_wr_flow_State  <=Nei12_Update_wr_flow_IDLE;                 
                end 
            Nei12_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei12_Update_wr_flow_State  <=Nei12_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done13)
                      Nei12_Update_wr_flow_State <=Nei12_Update_wr_flow_BEGIN;
                  else
                      Nei12_Update_wr_flow_State <=Nei12_Update_wr_flow_IDLE;
                  end 
            Nei12_Update_wr_flow_BEGIN:
                 begin
                      Nei12_Update_wr_flow_State <=Nei12_Update_wr_flow_END;
                 end 
  
            Nei12_Update_wr_flow_END:
                 begin        
                      Nei12_Update_wr_flow_State <=Nei12_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei12_Update_wr_flow_State <=Nei12_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei12ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei12_Update_wr_flow_State ==Nei12_Update_wr_flow_END )
             Nei12ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei12ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei12_wr_en    <= 1'b0 ;       
      else if ( Nei12_Update_wr_flow_State ==Nei12_Update_wr_flow_BEGIN )
             M_AXIS_Nei12_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei12_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei12_wr_data <= 256'd0 ;     
      else if ( Nei12_Update_wr_flow_State ==Nei12_Update_wr_flow_BEGIN )
             M_AXIS_Nei12_wr_data <=M_AXIS_LJ_EnE_Force13;
      else       
             M_AXIS_Nei12_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei12_ram_addr<= 12'd0 ;   
      else if ( Nei12_Update_wr_flow_State ==Nei12_Update_wr_flow_BEGIN)
                 M_AXIS_Nei12_ram_addr<= Nei12_Update_Num ;
      else       
                M_AXIS_Nei12_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei12_Update_Flow_RST   = 5'b00001	,
           Nei12_Update_Flow_IDLE  = 5'b00010	,
           Nei12_Update_Flow_BEGIN = 5'b00100	,
           Nei12_Update_Flow_CHK   = 5'b01000	,
           Nei12_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei12_Update_Flow_State <= Nei12_Update_Flow_RST;
     end 
      else begin 
           case( Nei12_Update_Flow_State)  
            Nei12_Update_Flow_RST :
                begin
                      Nei12_Update_Flow_State  <=Nei12_Update_Flow_IDLE;
                end 
            Nei12_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei12_Update_Flow_State <=Nei12_Update_Flow_BEGIN;
                  else
                      Nei12_Update_Flow_State <=Nei12_Update_Flow_IDLE;
                  end 
            Nei12_Update_Flow_BEGIN:
                 begin 
                      if ( Nei12_Update_Num >= Nei12_cal_times)
                       Nei12_Update_Flow_State <=Nei12_Update_Flow_END;    
                      else
                       Nei12_Update_Flow_State <=Nei12_Update_Flow_CHK;  
                 end 
            Nei12_Update_Flow_CHK:
                  begin 
                      if (Nei12ram_wr_one_Done)  
                     Nei12_Update_Flow_State <=Nei12_Update_Flow_BEGIN;
                     else
                     Nei12_Update_Flow_State <=Nei12_Update_Flow_CHK;  
                   end 
            Nei12_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei12_Update_Flow_State <=Nei12_Update_Flow_IDLE;
                      else
                       Nei12_Update_Flow_State <=Nei12_Update_Flow_END;
                 end     
                 
       default:       Nei12_Update_Flow_State <=Nei12_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei12_Update_ene_force <=  1'b0 ;  
      else if ( Nei12_Update_Flow_State ==Nei12_Update_Flow_END )
              Nei12_Update_ene_force <=  1'b1 ;
      else if ( Nei12_Update_Flow_State ==Nei12_Update_Flow_IDLE )      
               Nei12_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei12_Update_Num <= 12'd0 ;  
      else if ( Nei12ram_wr_one_Done )
              Nei12_Update_Num <=Nei12_Update_Num +8'd1 ;  
      else if ( Nei12_Update_Flow_State ==Nei12_Update_Flow_IDLE )      
               Nei12_Update_Num <= 12'd0 ;     
      end      
//-----------------------------------------------------------------------------------------------//
//   Nei13
//-----------------------------------------------------------------------------------------------//

localparam [4:0]
           Nei13_Update_wr_flow_RST   = 5'b00001	,
           Nei13_Update_wr_flow_Wait  = 5'b00010	,       
           Nei13_Update_wr_flow_IDLE  = 5'b00100	,
           Nei13_Update_wr_flow_BEGIN = 5'b01000	,
           Nei13_Update_wr_flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei13_Update_wr_flow_State <= Nei13_Update_wr_flow_RST;
     end 
      else begin 
           case( Nei13_Update_wr_flow_State)  
            Nei13_Update_wr_flow_RST :
                begin
                      Nei13_Update_wr_flow_State  <=Nei13_Update_wr_flow_Wait;
                end 
           Nei13_Update_wr_flow_Wait :
                begin
                   if (Subcell_pass_done)
                     Nei13_Update_wr_flow_State  <=Nei13_Update_wr_flow_IDLE;                 
                end 
            Nei13_Update_wr_flow_IDLE:
                begin
                  if (Home0_cell_cal_finish)
                      Nei13_Update_wr_flow_State  <=Nei13_Update_wr_flow_Wait;    
                  else if (S_AXIS_update_One_Done14)
                      Nei13_Update_wr_flow_State <=Nei13_Update_wr_flow_BEGIN;
                  else
                      Nei13_Update_wr_flow_State <=Nei13_Update_wr_flow_IDLE;
                  end 
            Nei13_Update_wr_flow_BEGIN:
                 begin
                      Nei13_Update_wr_flow_State <=Nei13_Update_wr_flow_END;
                 end 
  
            Nei13_Update_wr_flow_END:
                 begin        
                      Nei13_Update_wr_flow_State <=Nei13_Update_wr_flow_IDLE;
                 end     
                 
       default:       Nei13_Update_wr_flow_State <=Nei13_Update_wr_flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Nei13ram_wr_one_Done    <= 1'b0 ;       
      else if (  Nei13_Update_wr_flow_State ==Nei13_Update_wr_flow_END )
             Nei13ram_wr_one_Done    <= 1'b1 ; 
      else       
             Nei13ram_wr_one_Done    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei13_wr_en    <= 1'b0 ;       
      else if ( Nei13_Update_wr_flow_State ==Nei13_Update_wr_flow_BEGIN )
             M_AXIS_Nei13_wr_en    <= 1'b1 ; 
      else       
             M_AXIS_Nei13_wr_en    <= 1'b0 ;        
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             M_AXIS_Nei13_wr_data <= 256'd0 ;     
      else if ( Nei13_Update_wr_flow_State ==Nei13_Update_wr_flow_BEGIN )
             M_AXIS_Nei13_wr_data <=M_AXIS_LJ_EnE_Force14;
      else       
             M_AXIS_Nei13_wr_data <= 256'd0 ;  
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
                 M_AXIS_Nei13_ram_addr<= 12'd0 ;   
      else if ( Nei13_Update_wr_flow_State ==Nei13_Update_wr_flow_BEGIN)
                 M_AXIS_Nei13_ram_addr<= Nei13_Update_Num ;
      else       
                M_AXIS_Nei13_ram_addr<= 12'd0 ;       
      end 

//-----------------------------------------------------------------------------------------------//
localparam [4:0]
           Nei13_Update_Flow_RST   = 5'b00001	,
           Nei13_Update_Flow_IDLE  = 5'b00010	,
           Nei13_Update_Flow_BEGIN = 5'b00100	,
           Nei13_Update_Flow_CHK   = 5'b01000	,
           Nei13_Update_Flow_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei13_Update_Flow_State <= Nei13_Update_Flow_RST;
     end 
      else begin 
           case( Nei13_Update_Flow_State)  
            Nei13_Update_Flow_RST :
                begin
                      Nei13_Update_Flow_State  <=Nei13_Update_Flow_IDLE;
                end 
            Nei13_Update_Flow_IDLE:
                begin
                  if (Subcell_pass_done )
                      Nei13_Update_Flow_State <=Nei13_Update_Flow_BEGIN;
                  else
                      Nei13_Update_Flow_State <=Nei13_Update_Flow_IDLE;
                  end 
            Nei13_Update_Flow_BEGIN:
                 begin 
                      if ( Nei13_Update_Num >= Nei13_cal_times)
                       Nei13_Update_Flow_State <=Nei13_Update_Flow_END;    
                      else
                       Nei13_Update_Flow_State <=Nei13_Update_Flow_CHK;  
                 end 
            Nei13_Update_Flow_CHK:
                  begin 
                      if (Nei13ram_wr_one_Done)  
                     Nei13_Update_Flow_State <=Nei13_Update_Flow_BEGIN;
                     else
                     Nei13_Update_Flow_State <=Nei13_Update_Flow_CHK;  
                   end 
            Nei13_Update_Flow_END:
                 begin        
                     if (Home0_cell_cal_finish)
                      Nei13_Update_Flow_State <=Nei13_Update_Flow_IDLE;
                      else
                       Nei13_Update_Flow_State <=Nei13_Update_Flow_END;
                 end     
                 
       default:       Nei13_Update_Flow_State <=Nei13_Update_Flow_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei13_Update_ene_force <=  1'b0 ;  
      else if ( Nei13_Update_Flow_State ==Nei13_Update_Flow_END)
              Nei13_Update_ene_force <=  1'b1 ;
      else if ( Nei13_Update_Flow_State ==Nei13_Update_Flow_IDLE )      
               Nei13_Update_ene_force <=  1'b0 ;     
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
              Nei13_Update_Num <= 12'd0 ;  
      else if ( Nei13ram_wr_one_Done )
              Nei13_Update_Num <= Nei13_Update_Num +8'd1 ;  
      else if ( Nei13_Update_Flow_State ==Nei13_Update_Flow_IDLE )      
               Nei13_Update_Num <= 12'd0 ;     
      end 
//-----------------------------------------------------------------------------------------------//
//    
//-----------------------------------------------------------------------------------------------//


always@(posedge Sys_Clk  ) begin
       if (!Sys_Rst_n) begin   
         reading       <=  14'd0 ;   
       end 
      else begin

 reading  ={ Home1_reading,Nei1_reading,Nei2_reading,Nei3_reading,Nei4_reading,Nei5_reading,Nei6_reading ,
             Nei7_reading,Nei8_reading,Nei9_reading,Nei10_reading,Nei11_reading,Nei12_reading,Nei13_reading};
   end 
  end   
      
//-----------------------------------------------------------------------------------------------//
//                                                                                               //
//-----------------------------------------------------------------------------------------------//

always@(posedge Sys_Clk  ) begin
       if (!Sys_Rst_n) begin   
      Update_new_ene_force       <=  1'b0 ; 
        
       end 
      else begin

      Update_new_ene_force       <=  Home1_Update_ene_force   &Nei1_Update_ene_force  & Nei2_Update_ene_force
                                     &Nei3_Update_ene_force   &Nei4_Update_ene_force  & Nei5_Update_ene_force
                                     &Nei6_Update_ene_force   &Nei7_Update_ene_force  & Nei8_Update_ene_force  
                                     &Nei9_Update_ene_force   &Nei10_Update_ene_force & Nei11_Update_ene_force
                                     &Nei12_Update_ene_force  &Nei13_Update_ene_force;
   end 
  end   
  //-----------------------------------------------------------------------------------------------//

  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Update_new_ene_force_buf<= 1'b0 ;     
      else if (  Update_new_ene_force  )
              Update_new_ene_force_buf<=Update_new_ene_force;
      else       
              Update_new_ene_force_buf<= 1'b0 ;       
      end 
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Update_new_ene_force_buf2<= 1'b0 ;     
      else if (  Update_new_ene_force  )
              Update_new_ene_force_buf2<=Update_new_ene_force_buf;
      else       
              Update_new_ene_force_buf2<= 1'b0 ;       
      end 
 
      
  always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
               Home1_reading_en<= 1'b0 ;     
      else if ((Update_new_ene_force == 1'b1 )&& (Update_new_ene_force_buf == 1'b1) && (Update_new_ene_force_buf2== 1'b0))    
               Home1_reading_en<= 1'b1 ;
      else            
               Home1_reading_en<= 1'b0 ;     
      end 
 
      
//-----------------------------------------------------------------------------------------------//
//   home 1
//-----------------------------------------------------------------------------------------------//

always@(posedge Sys_Clk ) begin
 if (!Sys_Rst_n) begin
          M_AXIS_Update_ram_rd_data  <=  256'd0 ;
          M_AXIS_Update_ram_wr_en    <=  1'b0 ;
          M_AXIS_Update_cnt          <=  16'd0 ;    
 end 
else begin
 case(reading)
14'b10000000000000: begin 
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Home1_rd_data ;   
                M_AXIS_Update_cnt          <= Home1_Read_cnt;                         
                   end
14'b01000000000000: begin 
                M_AXIS_Update_ram_wr_en     <=  1'b1 ;
                M_AXIS_Update_ram_rd_data   <= S_AXIS_Update_Nei1_rd_data ;
                M_AXIS_Update_cnt           <= Home1_cal_times + Nei1_Read_cnt;    
         end
14'b00100000000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei2_rd_data ;
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_cnt          <= Home1_cal_times  +Nei1_cal_times  + Nei2_Read_cnt; 
         end
14'b00010000000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei3_rd_data ;
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_cnt          <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times + Nei3_Read_cnt; 
         end
14'b00001000000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei4_rd_data ;
                M_AXIS_Update_ram_wr_en     <=  1'b1 ;
                M_AXIS_Update_cnt           <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+ Nei3_cal_times + Nei4_Read_cnt; 
         end
14'b00000100000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei5_rd_data ;
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_cnt          <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                              + Nei5_Read_cnt;               
         end 
14'b00000010000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei6_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                     + Nei5_cal_times + Nei6_Read_cnt;
         end
14'b00000001000000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei7_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                     + Nei5_cal_times + Nei6_cal_times +Nei7_Read_cnt;
   end    
14'b00000000100000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei8_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                     + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_Read_cnt;
   end 
14'b00000000010000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei9_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  + Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                     + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_cal_times + Nei9_Read_cnt ;
   end
14'b00000000001000: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei10_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                     + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_cal_times + Nei9_cal_times+Nei10_Read_cnt ;
   end   
14'b00000000000100: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei11_rd_data ;
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times
                                    + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_cal_times +Nei9_cal_times + Nei10_cal_times+ Nei11_Read_cnt ;
   end
14'b00000000000010: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei12_rd_data ;
                M_AXIS_Update_ram_wr_en  <=  1'b1 ;
                M_AXIS_Update_cnt <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times    
                                    + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_cal_times +Nei9_cal_times + Nei10_cal_times + Nei11_cal_times+Nei12_Read_cnt;   
  
   end                
14'b00000000000001: begin 
                M_AXIS_Update_ram_rd_data  <= S_AXIS_Update_Nei13_rd_data ;
                M_AXIS_Update_ram_wr_en    <=  1'b1 ;
                M_AXIS_Update_cnt          <= Home1_cal_times  +Nei1_cal_times  + Nei2_cal_times+  Nei3_cal_times + Nei4_cal_times                                     
                                     + Nei5_cal_times + Nei6_cal_times + Nei7_cal_times + Nei8_cal_times +Nei9_cal_times + Nei10_cal_times + Nei11_cal_times +Nei12_cal_times+Nei13_Read_cnt;   
   end            
 default: begin M_AXIS_Update_ram_rd_data <= 256'd0 ;
                M_AXIS_Update_ram_wr_en   <=  1'b0 ;
                M_AXIS_Update_cnt         <=  12'd0 ;              
              end
                                   
      endcase
   end   
end
//-----------------------------------------------------------------------------------------------//
//   home 1
//-----------------------------------------------------------------------------------------------//
 localparam [3:0]
           Update_Home1_RST   = 4'b0001	,
           Update_Home1_IDLE  = 4'b0010	,
           Update_Home1_BEGIN = 4'b0100	,
           Update_Home1_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Home1_Rd_flow_State <= Update_Home1_RST;
     end 
      else begin 
           case( Update_Home1_Rd_flow_State)  
            Update_Home1_RST :
                begin
                      Update_Home1_Rd_flow_State  <=Update_Home1_IDLE;
                end 
            Update_Home1_IDLE:
                begin
                  if (Home1_reading_en)
                      Update_Home1_Rd_flow_State <=Update_Home1_BEGIN;
                  else
                      Update_Home1_Rd_flow_State <=Update_Home1_IDLE;
                  end 
            Update_Home1_BEGIN:
                 begin
                     if (Home1_Read_cnt == Home1_cal_times)
                       Update_Home1_Rd_flow_State <=Update_Home1_END;
                     else
                       Update_Home1_Rd_flow_State <=Update_Home1_BEGIN;
                 end 
 
            Update_Home1_END:
                 begin        
                      Update_Home1_Rd_flow_State <=Update_Home1_IDLE;
                 end     
                 
       default:       Update_Home1_Rd_flow_State <=Update_Home1_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Home1_reading                <=   1'b0 ;             
      else if (Home1_reading_en )
            Home1_reading                <=   1'b1 ;    
      else if (Update_Home1_Rd_flow_State ==Update_Home1_END  )   
            Home1_reading                <=   1'b0 ;                        
      end 
                
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
             Home1_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Home1_Rd_flow_State ==Update_Home1_END)
             Home1_Update_ALL_Force_Ram_done    <=   1'b1 ;  
      else if(  Update_Home1_Rd_flow_State ==Update_Home1_IDLE  )   
             Home1_Update_ALL_Force_Ram_done    <=   1'b0 ;                         
      end 
      
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Home1_Read_cnt       <=  12'd0 ;  
      else if (Update_Home1_Rd_flow_State ==Update_Home1_BEGIN)
              Home1_Read_cnt       <= Home1_Read_cnt +   8'd1  ;
      else if(  Update_Home1_Rd_flow_State ==Update_Home1_IDLE  )   
              Home1_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
             S_AXIS_Update_Home1_Rd_addr    <=  12'd0 ;  
      else if (Update_Home1_Rd_flow_State ==Update_Home1_BEGIN)
             S_AXIS_Update_Home1_Rd_addr     <= Home1_Read_cnt  ;
      else if(  Update_Home1_Rd_flow_State ==Update_Home1_IDLE  )   
             S_AXIS_Update_Home1_Rd_addr  <=  12'd0;                         
      end         
           
 
//-----------------------------------------------------------------------------------------------//
//   nei 1
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei1_RST   = 4'b0001	,
           Update_Nei1_IDLE  = 4'b0010	,
           Update_Nei1_BEGIN = 4'b0100	,
           Update_Nei1_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei1_Rd_flow_State <= Update_Nei1_RST;
     end 
      else begin 
           case( Update_Nei1_Rd_flow_State)  
            Update_Nei1_RST :
                begin
                      Update_Nei1_Rd_flow_State  <=Update_Nei1_IDLE;
                end 
            Update_Nei1_IDLE:
                begin
                  if (Home1_Update_ALL_Force_Ram_done)
                      Update_Nei1_Rd_flow_State <=Update_Nei1_BEGIN;
                  else
                      Update_Nei1_Rd_flow_State <=Update_Nei1_IDLE;
                  end 
            Update_Nei1_BEGIN:
                 begin
                     if (Nei1_Read_cnt == Nei1_cal_times)
                       Update_Nei1_Rd_flow_State <=Update_Nei1_END;
                     else
                       Update_Nei1_Rd_flow_State <=Update_Nei1_BEGIN;
                 end 
 
            Update_Nei1_END:
                 begin        
                      Update_Nei1_Rd_flow_State <=Update_Nei1_IDLE;
                 end     
                 
       default:       Update_Nei1_Rd_flow_State <=Update_Nei1_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei1_reading                <=   1'b0 ;             
      else if (Home1_Update_ALL_Force_Ram_done )
             Nei1_reading              <=   1'b1 ;    
      else if(  Update_Nei1_Rd_flow_State ==Update_Nei1_END  )   
            Nei1_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei1_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei1_Rd_flow_State ==Update_Nei1_END)
              Nei1_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei1_Rd_flow_State ==Update_Nei1_IDLE  )   
             Nei1_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei1_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei1_Rd_flow_State ==Update_Nei1_BEGIN )
              Nei1_Read_cnt       <= Nei1_Read_cnt +   12'd1  ;
      else if(  Update_Nei1_Rd_flow_State ==Update_Nei1_IDLE  )   
              Nei1_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei1_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei1_Rd_flow_State ==Update_Nei1_BEGIN)
              S_AXIS_Update_Nei1_Rd_addr     <= Nei1_Read_cnt  ;
      else if(  Update_Nei1_Rd_flow_State ==Update_Nei1_IDLE  )   
             S_AXIS_Update_Nei1_Rd_addr  <=  12'd0;                         
      end         
           
//-----------------------------------------------------------------------------------------------//
//   nei 2
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei2_RST   = 4'b0001	,
           Update_Nei2_IDLE  = 4'b0010	,
           Update_Nei2_BEGIN = 4'b0100	,
           Update_Nei2_END   = 4'b1000	;
           
  always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei2_Rd_flow_State <= Update_Nei2_RST;
     end 
      else begin 
           case( Update_Nei2_Rd_flow_State)  
            Update_Nei2_RST :
                begin
                      Update_Nei2_Rd_flow_State  <=Update_Nei2_IDLE;
                end 
            Update_Nei2_IDLE:
                begin
                  if (Nei1_Update_ALL_Force_Ram_done)
                      Update_Nei2_Rd_flow_State <=Update_Nei2_BEGIN;
                  else
                      Update_Nei2_Rd_flow_State <=Update_Nei2_IDLE;
                  end 
            Update_Nei2_BEGIN:
                 begin
                     if (Nei2_Read_cnt == Nei2_cal_times)
                       Update_Nei2_Rd_flow_State <=Update_Nei2_END;
                     else
                       Update_Nei2_Rd_flow_State <=Update_Nei2_BEGIN;
                 end 
 
            Update_Nei2_END:
                 begin        
                      Update_Nei2_Rd_flow_State <=Update_Nei2_IDLE;
                 end     
                 
       default:       Update_Nei2_Rd_flow_State <=Update_Nei2_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei2_reading                <=   1'b0 ;             
      else if (Nei1_Update_ALL_Force_Ram_done )
             Nei2_reading              <=   1'b1 ;    
      else if(  Update_Nei2_Rd_flow_State ==Update_Nei2_END  )   
            Nei2_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei2_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei2_Rd_flow_State ==Update_Nei2_END)
              Nei2_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei2_Rd_flow_State ==Update_Nei2_IDLE  )   
             Nei2_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei2_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei2_Rd_flow_State ==Update_Nei2_BEGIN)
              Nei2_Read_cnt       <= Nei2_Read_cnt +   8'd1  ;
      else if(  Update_Nei2_Rd_flow_State ==Update_Nei2_IDLE  )   
              Nei2_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei2_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei2_Rd_flow_State ==Update_Nei2_BEGIN)
              S_AXIS_Update_Nei2_Rd_addr     <= Nei2_Read_cnt  ;
      else if(  Update_Nei2_Rd_flow_State ==Update_Nei2_IDLE  )   
             S_AXIS_Update_Nei2_Rd_addr  <=  12'd0;                         
      end  

//-----------------------------------------------------------------------------------------------//
//   nei 3
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei3_RST   = 4'b0001	,
           Update_Nei3_IDLE  = 4'b0010	,
           Update_Nei3_BEGIN = 4'b0100	,
           Update_Nei3_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei3_Rd_flow_State <= Update_Nei3_RST;
     end 
      else begin 
           case( Update_Nei3_Rd_flow_State)  
            Update_Nei3_RST :
                begin
                      Update_Nei3_Rd_flow_State  <=Update_Nei3_IDLE;
                end 
            Update_Nei3_IDLE:
                begin
                  if (Nei2_Update_ALL_Force_Ram_done)
                      Update_Nei3_Rd_flow_State <=Update_Nei3_BEGIN;
                  else
                      Update_Nei3_Rd_flow_State <=Update_Nei3_IDLE;
                  end 
            Update_Nei3_BEGIN:
                 begin
                     if (Nei3_Read_cnt == Nei3_cal_times)
                       Update_Nei3_Rd_flow_State <=Update_Nei3_END;
                     else
                       Update_Nei3_Rd_flow_State <=Update_Nei3_BEGIN;
                 end 
 
            Update_Nei3_END:
                 begin        
                      Update_Nei3_Rd_flow_State <=Update_Nei3_IDLE;
                 end     
                 
       default:       Update_Nei3_Rd_flow_State <=Update_Nei3_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
           Nei3_reading                <=   1'b0 ;             
      else if (Nei2_Update_ALL_Force_Ram_done )
             Nei3_reading              <=   1'b1 ;    
      else if(  Update_Nei3_Rd_flow_State ==Update_Nei3_END  )   
            Nei3_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei3_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei3_Rd_flow_State ==Update_Nei3_END)
              Nei3_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei3_Rd_flow_State ==Update_Nei3_IDLE  )   
             Nei3_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei3_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei3_Rd_flow_State ==Update_Nei3_BEGIN)
              Nei3_Read_cnt       <= Nei3_Read_cnt +   8'd1  ;
      else if(  Update_Nei3_Rd_flow_State ==Update_Nei3_IDLE  )   
              Nei3_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei3_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei3_Rd_flow_State ==Update_Nei3_BEGIN)
              S_AXIS_Update_Nei3_Rd_addr     <= Nei3_Read_cnt  ;
      else if(  Update_Nei3_Rd_flow_State ==Update_Nei3_IDLE  )   
             S_AXIS_Update_Nei3_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 4
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei4_RST   = 4'b0001	,
           Update_Nei4_IDLE  = 4'b0010	,
           Update_Nei4_BEGIN = 4'b0100	,
           Update_Nei4_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei4_Rd_flow_State <= Update_Nei4_RST;
     end 
      else begin 
           case( Update_Nei4_Rd_flow_State)  
            Update_Nei4_RST :
                begin
                      Update_Nei4_Rd_flow_State  <=Update_Nei4_IDLE;
                end 
            Update_Nei4_IDLE:
                begin
                  if (Nei3_Update_ALL_Force_Ram_done)
                      Update_Nei4_Rd_flow_State <=Update_Nei4_BEGIN;
                  else
                      Update_Nei4_Rd_flow_State <=Update_Nei4_IDLE;
                  end 
            Update_Nei4_BEGIN:
                 begin
                     if (Nei4_Read_cnt == Nei4_cal_times)
                       Update_Nei4_Rd_flow_State <=Update_Nei4_END;
                     else
                       Update_Nei4_Rd_flow_State <=Update_Nei4_BEGIN;
                 end 
 
            Update_Nei4_END:
                 begin        
                      Update_Nei4_Rd_flow_State <=Update_Nei4_IDLE;
                 end     
                 
       default:       Update_Nei4_Rd_flow_State <=Update_Nei4_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei4_reading                <=   1'b0 ;             
      else if (Nei3_Update_ALL_Force_Ram_done )
             Nei4_reading              <=   1'b1 ;    
      else if(  Update_Nei4_Rd_flow_State ==Update_Nei4_END  )   
            Nei4_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei4_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei4_Rd_flow_State ==Update_Nei4_END)
              Nei4_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei4_Rd_flow_State ==Update_Nei4_IDLE  )   
             Nei4_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
              Nei4_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei4_Rd_flow_State ==Update_Nei4_BEGIN)
              Nei4_Read_cnt       <= Nei4_Read_cnt +   8'd1  ;
      else if(  Update_Nei4_Rd_flow_State ==Update_Nei4_IDLE  )   
              Nei4_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei4_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei4_Rd_flow_State ==Update_Nei4_BEGIN)
              S_AXIS_Update_Nei4_Rd_addr     <= Nei4_Read_cnt  ;
      else if(  Update_Nei4_Rd_flow_State ==Update_Nei4_IDLE  )   
             S_AXIS_Update_Nei4_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 5
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei5_RST   = 4'b0001	,
           Update_Nei5_IDLE  = 4'b0010	,
           Update_Nei5_BEGIN = 4'b0100	,
           Update_Nei5_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei5_Rd_flow_State <= Update_Nei5_RST;
     end 
      else begin 
           case( Update_Nei5_Rd_flow_State)  
            Update_Nei5_RST :
                begin
                      Update_Nei5_Rd_flow_State  <=Update_Nei5_IDLE;
                end 
            Update_Nei5_IDLE:
                begin
                  if (Nei4_Update_ALL_Force_Ram_done)
                      Update_Nei5_Rd_flow_State <=Update_Nei5_BEGIN;
                  else
                      Update_Nei5_Rd_flow_State <=Update_Nei5_IDLE;
                  end 
            Update_Nei5_BEGIN:
                 begin
                     if (Nei5_Read_cnt == Nei5_cal_times)
                       Update_Nei5_Rd_flow_State <=Update_Nei5_END;
                     else
                       Update_Nei5_Rd_flow_State <=Update_Nei5_BEGIN;
                 end 
 
            Update_Nei5_END:
                 begin        
                      Update_Nei5_Rd_flow_State <=Update_Nei5_IDLE;
                 end     
                 
       default:       Update_Nei5_Rd_flow_State <=Update_Nei5_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei5_reading                <=   1'b0 ;             
      else if (Nei4_Update_ALL_Force_Ram_done )
             Nei5_reading              <=   1'b1 ;    
      else if(  Update_Nei5_Rd_flow_State ==Update_Nei5_END  )   
            Nei5_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei5_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei5_Rd_flow_State ==Update_Nei5_END)
              Nei5_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei5_Rd_flow_State ==Update_Nei5_IDLE  )   
             Nei5_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
              Nei5_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei5_Rd_flow_State ==Update_Nei5_BEGIN)
              Nei5_Read_cnt       <= Nei5_Read_cnt +   8'd1  ;
      else if(  Update_Nei5_Rd_flow_State ==Update_Nei5_IDLE  )   
              Nei5_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei5_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei5_Rd_flow_State ==Update_Nei5_BEGIN)
              S_AXIS_Update_Nei5_Rd_addr     <= Nei5_Read_cnt  ;
      else if(  Update_Nei5_Rd_flow_State ==Update_Nei5_IDLE  )   
             S_AXIS_Update_Nei5_Rd_addr  <=  12'd0;                         
      end 


//-----------------------------------------------------------------------------------------------//
//   nei 6
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei6_RST   = 4'b0001	,
           Update_Nei6_IDLE  = 4'b0010	,
           Update_Nei6_BEGIN = 4'b0100	,
           Update_Nei6_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei6_Rd_flow_State <= Update_Nei6_RST;
     end 
      else begin 
           case( Update_Nei6_Rd_flow_State)  
            Update_Nei6_RST :
                begin
                      Update_Nei6_Rd_flow_State  <=Update_Nei6_IDLE;
                end 
            Update_Nei6_IDLE:
                begin
                  if (Nei5_Update_ALL_Force_Ram_done)
                      Update_Nei6_Rd_flow_State <=Update_Nei6_BEGIN;
                  else
                      Update_Nei6_Rd_flow_State <=Update_Nei6_IDLE;
                  end 
            Update_Nei6_BEGIN:
                 begin
                     if (Nei6_Read_cnt == Nei6_cal_times)
                       Update_Nei6_Rd_flow_State <=Update_Nei6_END;
                     else
                       Update_Nei6_Rd_flow_State <=Update_Nei6_BEGIN;
                 end 
 
            Update_Nei6_END:
                 begin        
                      Update_Nei6_Rd_flow_State <=Update_Nei6_IDLE;
                 end     
                 
       default:       Update_Nei6_Rd_flow_State <=Update_Nei6_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
           Nei6_reading                <=   1'b0 ;             
      else if (Nei5_Update_ALL_Force_Ram_done )
             Nei6_reading              <=   1'b1 ;    
      else if(  Update_Nei6_Rd_flow_State ==Update_Nei6_END  )   
            Nei6_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei6_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei6_Rd_flow_State ==Update_Nei6_END)
              Nei6_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei6_Rd_flow_State ==Update_Nei6_IDLE  )   
             Nei6_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei6_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei6_Rd_flow_State ==Update_Nei6_BEGIN)
              Nei6_Read_cnt       <= Nei6_Read_cnt +   8'd1  ;
      else if(  Update_Nei6_Rd_flow_State ==Update_Nei6_IDLE  )   
              Nei6_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei6_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei6_Rd_flow_State ==Update_Nei6_BEGIN)
              S_AXIS_Update_Nei6_Rd_addr     <= Nei6_Read_cnt  ;
      else if(  Update_Nei6_Rd_flow_State ==Update_Nei6_IDLE  )   
             S_AXIS_Update_Nei6_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 7
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei7_RST   = 4'b0001	,
           Update_Nei7_IDLE  = 4'b0010	,
           Update_Nei7_BEGIN = 4'b0100	,
           Update_Nei7_END   = 4'b1000	;
           
  always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei7_Rd_flow_State <= Update_Nei7_RST;
     end 
      else begin 
           case( Update_Nei7_Rd_flow_State)  
            Update_Nei7_RST :
                begin
                      Update_Nei7_Rd_flow_State  <=Update_Nei7_IDLE;
                end 
            Update_Nei7_IDLE:
                begin
                  if (Nei6_Update_ALL_Force_Ram_done)
                      Update_Nei7_Rd_flow_State <=Update_Nei7_BEGIN;
                  else
                      Update_Nei7_Rd_flow_State <=Update_Nei7_IDLE;
                  end 
            Update_Nei7_BEGIN:
                 begin
                     if (Nei7_Read_cnt == Nei7_cal_times)
                       Update_Nei7_Rd_flow_State <=Update_Nei7_END;
                     else
                       Update_Nei7_Rd_flow_State <=Update_Nei7_BEGIN;
                 end 
 
            Update_Nei7_END:
                 begin        
                      Update_Nei7_Rd_flow_State <=Update_Nei7_IDLE;
                 end     
                 
       default:       Update_Nei7_Rd_flow_State <=Update_Nei7_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei7_reading                <=   1'b0 ;             
      else if (Nei6_Update_ALL_Force_Ram_done )
             Nei7_reading              <=   1'b1 ;    
      else if(  Update_Nei7_Rd_flow_State ==Update_Nei7_END  )   
            Nei7_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei7_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei7_Rd_flow_State ==Update_Nei7_END)
              Nei7_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei7_Rd_flow_State ==Update_Nei7_IDLE  )   
             Nei7_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei7_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei7_Rd_flow_State ==Update_Nei7_BEGIN)
              Nei7_Read_cnt       <= Nei7_Read_cnt +   8'd1  ;
      else if(  Update_Nei7_Rd_flow_State ==Update_Nei7_IDLE  )   
              Nei7_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei7_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei7_Rd_flow_State ==Update_Nei7_BEGIN)
              S_AXIS_Update_Nei7_Rd_addr     <= Nei7_Read_cnt  ;
      else if(  Update_Nei7_Rd_flow_State ==Update_Nei7_IDLE  )   
             S_AXIS_Update_Nei7_Rd_addr  <=  12'd0;                         
      end 
//-----------------------------------------------------------------------------------------------//
//   nei 8
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei8_RST   = 4'b0001	,
           Update_Nei8_IDLE  = 4'b0010	,
           Update_Nei8_BEGIN = 4'b0100	,
           Update_Nei8_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei8_Rd_flow_State <= Update_Nei8_RST;
     end 
      else begin 
           case( Update_Nei8_Rd_flow_State)  
            Update_Nei8_RST :
                begin
                      Update_Nei8_Rd_flow_State  <=Update_Nei8_IDLE;
                end 
            Update_Nei8_IDLE:
                begin
                  if (Nei7_Update_ALL_Force_Ram_done)
                      Update_Nei8_Rd_flow_State <=Update_Nei8_BEGIN;
                  else
                      Update_Nei8_Rd_flow_State <=Update_Nei8_IDLE;
                  end 
            Update_Nei8_BEGIN:
                 begin
                     if (Nei8_Read_cnt == Nei8_cal_times)
                       Update_Nei8_Rd_flow_State <=Update_Nei8_END;
                     else
                       Update_Nei8_Rd_flow_State <=Update_Nei8_BEGIN;
                 end 
 
            Update_Nei8_END:
                 begin        
                      Update_Nei8_Rd_flow_State <=Update_Nei8_IDLE;
                 end     
                 
       default:       Update_Nei8_Rd_flow_State <=Update_Nei8_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
           Nei8_reading                <=   1'b0 ;             
      else if (Nei7_Update_ALL_Force_Ram_done )
             Nei8_reading              <=   1'b1 ;    
      else if(  Update_Nei8_Rd_flow_State ==Update_Nei8_END  )   
            Nei8_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei8_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei8_Rd_flow_State ==Update_Nei8_END)
              Nei8_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei8_Rd_flow_State ==Update_Nei8_IDLE  )   
             Nei8_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei8_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei8_Rd_flow_State ==Update_Nei8_BEGIN)
              Nei8_Read_cnt       <= Nei8_Read_cnt +   8'd1  ;
      else if(  Update_Nei8_Rd_flow_State ==Update_Nei8_IDLE  )   
              Nei8_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei8_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei8_Rd_flow_State ==Update_Nei8_BEGIN)
              S_AXIS_Update_Nei8_Rd_addr     <= Nei8_Read_cnt  ;
      else if(  Update_Nei8_Rd_flow_State ==Update_Nei8_IDLE  )   
             S_AXIS_Update_Nei8_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 9
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei9_RST   = 4'b0001	,
           Update_Nei9_IDLE  = 4'b0010	,
           Update_Nei9_BEGIN = 4'b0100	,
           Update_Nei9_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei9_Rd_flow_State <= Update_Nei9_RST;
     end 
      else begin 
           case( Update_Nei9_Rd_flow_State)  
            Update_Nei9_RST :
                begin
                      Update_Nei9_Rd_flow_State  <=Update_Nei9_IDLE;
                end 
            Update_Nei9_IDLE:
                begin
                  if (Nei8_Update_ALL_Force_Ram_done)
                      Update_Nei9_Rd_flow_State <=Update_Nei9_BEGIN;
                  else
                      Update_Nei9_Rd_flow_State <=Update_Nei9_IDLE;
                  end 
            Update_Nei9_BEGIN:
                 begin
                     if (Nei9_Read_cnt == Nei9_cal_times)
                       Update_Nei9_Rd_flow_State <=Update_Nei9_END;
                     else
                       Update_Nei9_Rd_flow_State <=Update_Nei9_BEGIN;
                 end 
 
            Update_Nei9_END:
                 begin        
                      Update_Nei9_Rd_flow_State <=Update_Nei9_IDLE;
                 end     
                 
       default:       Update_Nei9_Rd_flow_State <=Update_Nei9_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei9_reading                <=   1'b0 ;             
      else if (Nei8_Update_ALL_Force_Ram_done )
             Nei9_reading              <=   1'b1 ;    
      else if(  Update_Nei9_Rd_flow_State ==Update_Nei9_END  )   
            Nei9_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei9_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei9_Rd_flow_State ==Update_Nei9_END)
              Nei9_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei9_Rd_flow_State ==Update_Nei9_IDLE  )   
             Nei9_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei9_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei9_Rd_flow_State ==Update_Nei9_BEGIN)
              Nei9_Read_cnt       <= Nei9_Read_cnt +   8'd1  ;
      else if(  Update_Nei9_Rd_flow_State ==Update_Nei9_IDLE  )   
              Nei9_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei9_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei9_Rd_flow_State ==Update_Nei9_BEGIN)
              S_AXIS_Update_Nei9_Rd_addr     <= Nei9_Read_cnt  ;
      else if(  Update_Nei9_Rd_flow_State ==Update_Nei9_IDLE  )   
             S_AXIS_Update_Nei9_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 10
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei10_RST   = 4'b0001	,
           Update_Nei10_IDLE  = 4'b0010	,
           Update_Nei10_BEGIN = 4'b0100	,
           Update_Nei10_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei10_Rd_flow_State <= Update_Nei10_RST;
     end 
      else begin 
           case( Update_Nei10_Rd_flow_State)  
            Update_Nei10_RST :
                begin
                      Update_Nei10_Rd_flow_State  <=Update_Nei10_IDLE;
                end 
            Update_Nei10_IDLE:
                begin
                  if (Nei9_Update_ALL_Force_Ram_done)
                      Update_Nei10_Rd_flow_State <=Update_Nei10_BEGIN;
                  else
                      Update_Nei10_Rd_flow_State <=Update_Nei10_IDLE;
                  end 
            Update_Nei10_BEGIN:
                 begin
                     if (Nei10_Read_cnt == Nei10_cal_times)
                       Update_Nei10_Rd_flow_State <=Update_Nei10_END;
                     else
                       Update_Nei10_Rd_flow_State <=Update_Nei10_BEGIN;
                 end 
 
            Update_Nei10_END:
                 begin        
                      Update_Nei10_Rd_flow_State <=Update_Nei10_IDLE;
                 end     
                 
       default:       Update_Nei10_Rd_flow_State <=Update_Nei10_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
           Nei10_reading                <=   1'b0 ;             
      else if (Nei9_Update_ALL_Force_Ram_done )
             Nei10_reading              <=   1'b1 ;    
      else if(  Update_Nei10_Rd_flow_State ==Update_Nei10_END  )   
            Nei10_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei10_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei10_Rd_flow_State ==Update_Nei10_END)
              Nei10_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei10_Rd_flow_State ==Update_Nei10_IDLE  )   
             Nei10_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei10_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei10_Rd_flow_State ==Update_Nei10_BEGIN)
              Nei10_Read_cnt       <= Nei10_Read_cnt +   8'd1  ;
      else if(  Update_Nei10_Rd_flow_State ==Update_Nei10_IDLE  )   
              Nei10_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei10_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei10_Rd_flow_State ==Update_Nei10_BEGIN)
              S_AXIS_Update_Nei10_Rd_addr     <= Nei10_Read_cnt  ;
      else if(  Update_Nei10_Rd_flow_State ==Update_Nei10_IDLE  )   
             S_AXIS_Update_Nei10_Rd_addr  <=  12'd0;                         
      end 

//-----------------------------------------------------------------------------------------------//
//   nei 11
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei11_RST   = 4'b0001	,
           Update_Nei11_IDLE  = 4'b0010	,
           Update_Nei11_BEGIN = 4'b0100	,
           Update_Nei11_END   = 4'b1000	;
           
  always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei11_Rd_flow_State <= Update_Nei11_RST;
     end 
      else begin 
           case( Update_Nei11_Rd_flow_State)  
            Update_Nei11_RST :
                begin
                      Update_Nei11_Rd_flow_State  <=Update_Nei11_IDLE;
                end 
            Update_Nei11_IDLE:
                begin
                  if (Nei10_Update_ALL_Force_Ram_done)
                      Update_Nei11_Rd_flow_State <=Update_Nei11_BEGIN;
                  else
                      Update_Nei11_Rd_flow_State <=Update_Nei11_IDLE;
                  end 
            Update_Nei11_BEGIN:
                 begin
                     if (Nei11_Read_cnt == Nei11_cal_times)
                       Update_Nei11_Rd_flow_State <=Update_Nei11_END;
                     else
                       Update_Nei11_Rd_flow_State <=Update_Nei11_BEGIN;
                 end 
 
            Update_Nei11_END:
                 begin        
                      Update_Nei11_Rd_flow_State <=Update_Nei11_IDLE;
                 end     
                 
       default:       Update_Nei11_Rd_flow_State <=Update_Nei11_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei11_reading                <=   1'b0 ;             
      else if (Nei10_Update_ALL_Force_Ram_done )
             Nei11_reading              <=   1'b1 ;    
      else if(  Update_Nei11_Rd_flow_State ==Update_Nei11_END  )   
            Nei11_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            Nei11_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei11_Rd_flow_State ==Update_Nei11_END)
              Nei11_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei11_Rd_flow_State ==Update_Nei11_IDLE  )   
             Nei11_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
              Nei11_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei11_Rd_flow_State ==Update_Nei11_BEGIN)
              Nei11_Read_cnt       <= Nei11_Read_cnt +   8'd1  ;
      else if(  Update_Nei11_Rd_flow_State ==Update_Nei11_IDLE  )   
              Nei11_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei11_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei11_Rd_flow_State ==Update_Nei11_BEGIN)
              S_AXIS_Update_Nei11_Rd_addr     <= Nei11_Read_cnt  ;
      else if(  Update_Nei11_Rd_flow_State ==Update_Nei11_IDLE  )   
             S_AXIS_Update_Nei11_Rd_addr  <=  12'd0;                         
      end 
//-----------------------------------------------------------------------------------------------//
//   nei 12
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei12_RST   = 4'b0001	,
           Update_Nei12_IDLE  = 4'b0010	,
           Update_Nei12_BEGIN = 4'b0100	,
           Update_Nei12_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei12_Rd_flow_State <= Update_Nei12_RST;
     end 
      else begin 
           case( Update_Nei12_Rd_flow_State)  
            Update_Nei12_RST :
                begin
                      Update_Nei12_Rd_flow_State  <=Update_Nei12_IDLE;
                end 
            Update_Nei12_IDLE:
                begin
                  if (Nei11_Update_ALL_Force_Ram_done)
                      Update_Nei12_Rd_flow_State <=Update_Nei12_BEGIN;
                  else
                      Update_Nei12_Rd_flow_State <=Update_Nei12_IDLE;
                  end 
            Update_Nei12_BEGIN:
                 begin
                     if (Nei12_Read_cnt == Nei12_cal_times)
                       Update_Nei12_Rd_flow_State <=Update_Nei12_END;
                     else
                       Update_Nei12_Rd_flow_State <=Update_Nei12_BEGIN;
                 end 
 
            Update_Nei12_END:
                 begin        
                      Update_Nei12_Rd_flow_State <=Update_Nei12_IDLE;
                 end     
                 
       default:       Update_Nei12_Rd_flow_State <=Update_Nei12_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
           Nei12_reading                <=   1'b0 ;             
      else if (Nei11_Update_ALL_Force_Ram_done )
             Nei12_reading              <=   1'b1 ;    
      else if(  Update_Nei12_Rd_flow_State ==Update_Nei12_END  )   
            Nei12_reading               <=   1'b0 ;                        
      end 
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei12_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei12_Rd_flow_State ==Update_Nei12_END)
              Nei12_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei12_Rd_flow_State ==Update_Nei12_IDLE  )   
             Nei12_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
              Nei12_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei12_Rd_flow_State ==Update_Nei12_BEGIN)
              Nei12_Read_cnt       <= Nei12_Read_cnt +   12'd1  ;
      else if(  Update_Nei12_Rd_flow_State ==Update_Nei12_IDLE  )   
              Nei12_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei12_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei12_Rd_flow_State ==Update_Nei12_BEGIN)
              S_AXIS_Update_Nei12_Rd_addr     <= Nei12_Read_cnt  ;
      else if(  Update_Nei12_Rd_flow_State ==Update_Nei12_IDLE  )   
             S_AXIS_Update_Nei12_Rd_addr  <=  12'd0;                         
      end 
//-----------------------------------------------------------------------------------------------//
//   nei 13
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Update_Nei13_RST   = 4'b0001	,
           Update_Nei13_IDLE  = 4'b0010	,
           Update_Nei13_BEGIN = 4'b0100	,
           Update_Nei13_END   = 4'b1000	;
           
  always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n) begin   
       Update_Nei13_Rd_flow_State <= Update_Nei13_RST;
     end 
      else begin 
           case( Update_Nei13_Rd_flow_State)  
            Update_Nei13_RST :
                begin
                      Update_Nei13_Rd_flow_State  <=Update_Nei13_IDLE;
                end 
            Update_Nei13_IDLE:
                begin
                  if (Nei12_Update_ALL_Force_Ram_done)
                      Update_Nei13_Rd_flow_State <=Update_Nei13_BEGIN;
                  else
                      Update_Nei13_Rd_flow_State <=Update_Nei13_IDLE;
                  end 
            Update_Nei13_BEGIN:
                 begin
                     if (Nei13_Read_cnt == Nei13_cal_times)
                       Update_Nei13_Rd_flow_State <=Update_Nei13_END;
                     else
                       Update_Nei13_Rd_flow_State <=Update_Nei13_BEGIN;
                 end 
 
            Update_Nei13_END:
                 begin        
                      Update_Nei13_Rd_flow_State <=Update_Nei13_IDLE;
                 end     
                 
       default:       Update_Nei13_Rd_flow_State <=Update_Nei13_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Nei13_reading                <=   1'b0 ;             
      else if ( Nei12_Update_ALL_Force_Ram_done )
             Nei13_reading              <=   1'b1 ;    
      else  if ( Update_Nei13_Rd_flow_State ==Update_Nei13_END )
            Nei13_reading               <=   1'b0 ;                        
      end 
                
           always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
           Update_ALL_Force_Ram_done                <=   1'b0 ;             
      else if ( Update_Nei13_Rd_flow_State ==Update_Nei13_END )
             Update_ALL_Force_Ram_done              <=   1'b1 ;    
      else if(  Update_Nei13_Rd_flow_State ==Update_Nei13_IDLE  )   
            Update_ALL_Force_Ram_done               <=   1'b0 ;                        
      end           
                 
                
                
                
    always@(posedge Sys_Clk )  begin
     if (!Sys_Rst_n)    
            Nei13_Update_ALL_Force_Ram_done    <=   1'b0 ;  
      else if (Update_Nei13_Rd_flow_State ==Update_Nei13_END)
              Nei13_Update_ALL_Force_Ram_done  <=   1'b1 ;  
      else if(  Update_Nei13_Rd_flow_State ==Update_Nei13_IDLE  )   
             Nei13_Update_ALL_Force_Ram_done   <=   1'b0 ;                         
      end 
      always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
              Nei13_Read_cnt       <=  12'd0 ;  
      else if (Update_Nei13_Rd_flow_State ==Update_Nei13_BEGIN)
              Nei13_Read_cnt       <= Nei13_Read_cnt +   12'd1  ;
      else if(  Update_Nei13_Rd_flow_State ==Update_Nei13_IDLE  )   
              Nei13_Read_cnt       <=  12'd0;                         
      end      
         
     always@(posedge Sys_Clk  )  begin
     if (!Sys_Rst_n)    
            S_AXIS_Update_Nei13_Rd_addr    <=  12'd0 ;  
      else if (Update_Nei13_Rd_flow_State ==Update_Nei13_BEGIN)
              S_AXIS_Update_Nei13_Rd_addr     <= Nei13_Read_cnt  ;
      else if(  Update_Nei13_Rd_flow_State ==Update_Nei13_IDLE  )   
             S_AXIS_Update_Nei13_Rd_addr  <=  12'd0;                         
      end 


endmodule       
