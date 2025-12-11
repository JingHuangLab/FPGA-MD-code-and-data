`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2022 09:31:06 PM
// Design Name: 
// Module Name: INIT_DATA_2_RAM
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


module INIT_DATA_2_RAM 
(   
      input                        Sys_Clk,
      input                        Sys_Rst_n,
    
      output reg                   Subcell_pass_done ,          
      input                        New_Homecell_begin_en,  
     
      output reg      [15:0]       S_AXIS_ram_Rd_addr,   // read data from same block
      input           [255:0]      S_AXIS_ram_rd_data,   // read data from same block
    
      // wr subcell ram   
      output reg                 M_AXIS_home_wr_en        ,     
      output reg     [255:0]     M_AXIS_home_wr_data      ,
      output reg       [7:0]     M_AXIS_home_ram_addr     , 
      output reg      [11:0]     Home0_Ptcal_Num,            
                                          
      output reg                 M_AXIS_home1_wr_en      ,
      output reg      [255:0]    M_AXIS_home1_wr_data    ,
      output reg       [7:0]     M_AXIS_home1_ram_addr   ,
      output reg      [11:0]     Home1_Ptcal_Num         , 
         
      output reg      [11:0]     Nei1_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei1_wr_en       ,  
      output reg      [255:0]    M_AXIS_Nei1_wr_data     , 
      output reg       [7:0]     M_AXIS_Nei1_ram_addr    ,
      
      output reg      [11:0]     Nei2_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei2_wr_en       ,  
      output reg      [255:0]    M_AXIS_Nei2_wr_data     , 
      output reg       [7:0]     M_AXIS_Nei2_ram_addr    ,
      
      output reg      [11:0]     Nei3_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei3_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei3_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei3_ram_addr    ,
      
      output reg      [11:0]     Nei4_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei4_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei4_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei4_ram_addr    ,
      
      output reg      [11:0]     Nei5_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei5_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei5_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei5_ram_addr    ,
      
      output reg      [11:0]     Nei6_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei6_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei6_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei6_ram_addr    ,
      
      output reg      [11:0]     Nei7_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei7_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei7_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei7_ram_addr    ,
      
      output reg      [11:0]     Nei8_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei8_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei8_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei8_ram_addr    ,
      
      output reg      [11:0]     Nei9_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei9_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei9_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei9_ram_addr    ,
      
      output reg      [11:0]     Nei10_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei10_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei10_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei10_ram_addr    ,
           
      output reg      [11:0]     Nei11_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei11_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei11_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei11_ram_addr    ,
      
      output reg      [11:0]     Nei12_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei12_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei12_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei12_ram_addr    ,
           
      output reg      [11:0]     Nei13_Ptcal_Num          ,     
      output reg                 M_AXIS_Nei13_wr_en      ,  
      output reg      [255:0]    M_AXIS_Nei13_wr_data    , 
      output reg       [7:0]     M_AXIS_Nei13_ram_addr               
    );
    
 
reg          Homeram_wr_one_Done ;
reg          Home1ram_wr_one_Done;

reg [8:0]    Read_Ptcal_State         ;
reg [8:0]    Homecell_Rd_State        ;
reg [8:0]    Neicell_Rd_State         ;

reg [8:0]    Home0_Ptcal_Flow_State    ;
reg [8:0]    Home1_Ptcal_Flow_State    ;
reg [8:0]    Nei1_Ptcal_Flow_State     ;
reg [8:0]    Nei2_Ptcal_Flow_State     ; 
reg [8:0]    Nei3_Ptcal_Flow_State     ; 
reg [8:0]    Nei4_Ptcal_Flow_State     ; 
reg [8:0]    Nei5_Ptcal_Flow_State     ; 
reg [8:0]    Nei6_Ptcal_Flow_State     ; 
reg [8:0]    Nei7_Ptcal_Flow_State     ; 
reg [8:0]    Nei8_Ptcal_Flow_State     ; 
reg [8:0]    Nei9_Ptcal_Flow_State     ; 
reg [8:0]    Nei10_Ptcal_Flow_State     ; 
reg [8:0]    Nei11_Ptcal_Flow_State     ; 
reg [8:0]    Nei12_Ptcal_Flow_State     ; 
reg [8:0]    Nei13_Ptcal_Flow_State     ; 

reg          Nei1ram_wr_one_Done ;
reg          Nei2ram_wr_one_Done ; 
reg          Nei3ram_wr_one_Done ; 
reg          Nei4ram_wr_one_Done ; 
reg          Nei5ram_wr_one_Done ; 
reg          Nei6ram_wr_one_Done ; 
reg          Nei7ram_wr_one_Done ; 
reg          Nei8ram_wr_one_Done ; 
reg          Nei9ram_wr_one_Done ; 
reg          Nei10ram_wr_one_Done ; 
reg          Nei11ram_wr_one_Done ; 
reg          Nei12ram_wr_one_Done ; 
reg          Nei13ram_wr_one_Done ; 

reg [8:0]    Home_subram_wr_flow_State  ;
reg [8:0]    Home1_subram_wr_flow_State ;
reg [8:0]    Nei1_subram_wr_flow_State  ;
reg [8:0]    Nei2_subram_wr_flow_State  ; 
reg [8:0]    Nei3_subram_wr_flow_State  ; 
reg [8:0]    Nei4_subram_wr_flow_State  ; 
reg [8:0]    Nei5_subram_wr_flow_State  ; 
reg [8:0]    Nei6_subram_wr_flow_State  ; 
reg [8:0]    Nei7_subram_wr_flow_State  ; 
reg [8:0]    Nei8_subram_wr_flow_State  ; 
reg [8:0]    Nei9_subram_wr_flow_State  ; 
reg [8:0]    Nei10_subram_wr_flow_State ; 
reg [8:0]    Nei11_subram_wr_flow_State ; 
reg [8:0]    Nei12_subram_wr_flow_State ;
reg [8:0]    Nei13_subram_wr_flow_State ;  

 reg [255:0]   Home_Data_buf;
 reg [255:0]   Nei_Data_buf ;
 reg [7:0]     Neicell_NUM_CNT;
 reg           connect_valid;
 reg           Subcell_pass_stop   ;
 reg           Home_Subcell_pass_stop;
 reg           Nei_Subcell_pass_stop;
 reg           Homecell_Read_from_cache;
 reg           Neicell_Read_from_cache;
 //------------------------------------------------------------
 //------------------------------------------------------------
localparam [7:0]
           Read_Ptcal_State_RST        = 8'b0000001	,
           Read_Ptcal_State_IDLE       = 8'b0000010	,
           Read_Ptcal_State_Homecell   = 8'b0000100	,
           Read_Ptcal_State_Homedone   = 8'b0001000	,
           Read_Ptcal_State_Neicell    = 8'b0010000	,
           Read_Ptcal_State_NeiDone    = 8'b0100000	,
           Read_Ptcal_State_End        = 8'b1000000	;
           
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
  Read_Ptcal_State <=Read_Ptcal_State_RST;
     end 
      else begin 
           case( Read_Ptcal_State)  
            Read_Ptcal_State_RST :
                begin
                      Read_Ptcal_State    <=Read_Ptcal_State_IDLE;
                end 
           Read_Ptcal_State_IDLE:
                begin
                     if (New_Homecell_begin_en ) 
                         Read_Ptcal_State <= Read_Ptcal_State_Homecell;
                     else
                         Read_Ptcal_State <= Read_Ptcal_State_IDLE;
                 end 
            Read_Ptcal_State_Homecell:
                 begin        
                         Read_Ptcal_State <= Read_Ptcal_State_Homedone;
                 end 
           Read_Ptcal_State_Homedone:
                 begin 
                   if( Home_Subcell_pass_stop) //read done 
                         Read_Ptcal_State <=Read_Ptcal_State_Neicell;
                   else
                         Read_Ptcal_State <=Read_Ptcal_State_Homedone;
                 end    
           Read_Ptcal_State_Neicell :
                 begin        
                       Read_Ptcal_State <= Read_Ptcal_State_NeiDone;
                 end 
           Read_Ptcal_State_NeiDone :
                begin    
                    if( Nei_Subcell_pass_stop&&(Neicell_NUM_CNT == 8'd13) ) //read done 
                      Read_Ptcal_State <=Read_Ptcal_State_End;
                   else
                      Read_Ptcal_State <=Read_Ptcal_State_Neicell;
                 end        
           Read_Ptcal_State_End: 
                 begin  

                      Read_Ptcal_State <=Read_Ptcal_State_IDLE;
                 end        
       default:       Read_Ptcal_State <=Read_Ptcal_State_IDLE;
     endcase
   end 
 end  
 
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Homecell_Read_from_cache      <=   1'b0 ; 
      else if (    Read_Ptcal_State ==Read_Ptcal_State_Homecell )
           Homecell_Read_from_cache      <=   1'b1 ; 
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Homecell_Read_from_cache      <=   1'b0 ;                     
      end   

          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Neicell_Read_from_cache      <=   1'b0 ; 
      else if (    Read_Ptcal_State ==Read_Ptcal_State_Neicell )
           Neicell_Read_from_cache      <=   1'b1 ; 
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Neicell_Read_from_cache      <=   1'b0 ;                     
      end   
                  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Neicell_NUM_CNT      <=   8'd0 ; 
      else if (    Read_Ptcal_State ==Read_Ptcal_State_Neicell )
           Neicell_NUM_CNT      <= Neicell_NUM_CNT+  1'b1 ; 
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Neicell_NUM_CNT      <=   8'd0  ;                     
      end        
             
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            connect_valid      <=     1'b0 ; 
      else if (    Read_Ptcal_State ==Read_Ptcal_State_Neicell )
            connect_valid      <=     1'b1 ; 
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
            connect_valid      <=     1'b0 ;                   
      end         
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Subcell_pass_done      <=   1'b0 ; 
      else if (    Read_Ptcal_State ==Read_Ptcal_State_End )
           Subcell_pass_done      <=   1'b1 ; 
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Subcell_pass_done      <=   1'b0 ;                     
      end   
 
      
  //------------------------------------------------------------
 //------------------------------------------------------------
  localparam [4:0]
           Homecell_Rd_RST   = 5'b00001	,
           Homecell_Rd_IDLE  = 5'b00010	,
           Homecell_Rd_BEGIN = 5'b00100	,
           Homecell_Rd_CHK   = 5'b01000	,
           Homecell_Rd_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Homecell_Rd_State <= Homecell_Rd_RST;
     end 
      else begin 
           case( Homecell_Rd_State)  
            Homecell_Rd_RST :
                begin
                      Homecell_Rd_State  <=Homecell_Rd_IDLE;
                end 
            Homecell_Rd_IDLE:
                begin
                  if (Homecell_Read_from_cache)
                      Homecell_Rd_State <=Homecell_Rd_BEGIN;
                  else
                      Homecell_Rd_State <=Homecell_Rd_IDLE;
                  end 
            Homecell_Rd_BEGIN:
                 begin
                      Homecell_Rd_State <=Homecell_Rd_CHK;
                 end 
            Homecell_Rd_CHK:
                  begin
                     Homecell_Rd_State <=Homecell_Rd_END;
                   end 
            Homecell_Rd_END:
                 begin        
                      Homecell_Rd_State <=Homecell_Rd_IDLE;
                 end     
                 
       default:       Homecell_Rd_State <=Homecell_Rd_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            S_AXIS_ram_Rd_addr  <= 8'd0 ;         
      else if (Homecell_Rd_State==Homecell_Rd_BEGIN )
            S_AXIS_ram_Rd_addr  <= S_AXIS_ram_Rd_addr + 8'd1    ;
      else if (Subcell_pass_done)      
            S_AXIS_ram_Rd_addr  <= 8'd0    ;                    
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home_Data_buf           <= 256'd0 ;          
      else if (  Homecell_Rd_State ==Homecell_Rd_CHK )
            Home_Data_buf       <=    S_AXIS_ram_rd_data ;
     else if (Subcell_pass_done)          
            Home_Data_buf             <= 256'd0 ;       
      end 
  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Home_Subcell_pass_stop  <=   1'b0 ;      
      else if (Homecell_Rd_State==Homecell_Rd_END )
            Home_Subcell_pass_stop  <=   1'b1 ; 
      else if (Subcell_pass_done)      
            Home_Subcell_pass_stop   <=   1'b0 ;                      
      end     
//-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//
 localparam [4:0]
           Neicell_Rd_RST   = 5'b00001	,
           Neicell_Rd_IDLE  = 5'b00010	,
           Neicell_Rd_BEGIN = 5'b00100	,
           Neicell_Rd_CHK   = 5'b01000	,
           Neicell_Rd_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Neicell_Rd_State <= Neicell_Rd_RST;
     end 
      else begin 
           case( Neicell_Rd_State)  
            Neicell_Rd_RST :
                begin
                      Neicell_Rd_State  <=Neicell_Rd_IDLE;
                end 
            Neicell_Rd_IDLE:
                begin
                  if (Neicell_Read_from_cache)
                      Neicell_Rd_State <=Neicell_Rd_BEGIN;
                  else
                      Neicell_Rd_State <=Neicell_Rd_IDLE;
                  end 
            Neicell_Rd_BEGIN:
                 begin
                      Neicell_Rd_State <=Neicell_Rd_CHK;
                 end 
            Neicell_Rd_CHK:
                  begin
                     Neicell_Rd_State <=Neicell_Rd_END;
                   end 
            Neicell_Rd_END:
                 begin        
                      Neicell_Rd_State <=Neicell_Rd_IDLE;
                 end     
                 
       default:       Neicell_Rd_State <=Neicell_Rd_IDLE;
     endcase
   end 
 end   
 
       
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei_Data_buf           <= 256'd0 ;          
      else if (  Homecell_Rd_State ==Homecell_Rd_CHK )
            Nei_Data_buf       <=    S_AXIS_ram_rd_data ;
     else if (Subcell_pass_done)          
            Nei_Data_buf             <= 256'd0 ;       
      end 
  
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Nei_Subcell_pass_stop  <=   1'b0 ;      
      else if (Homecell_Rd_State==Homecell_Rd_END )
            Nei_Subcell_pass_stop  <=   1'b1 ; 
      else if (Subcell_pass_done)      
            Nei_Subcell_pass_stop   <=   1'b0 ;                      
      end     

//-----------------------------------------------------------------------------------------------//
// home 
//-----------------------------------------------------------------------------------------------//

   
 localparam [3:0]
           Home_subram_wr_flow_RST   = 4'b0001	,
           Home_subram_wr_flow_IDLE  = 4'b0010	,
           Home_subram_wr_flow_BEGIN = 4'b0100	,
           Home_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home_subram_wr_flow_State <= Home_subram_wr_flow_RST;
     end 
      else begin 
           case( Home_subram_wr_flow_State)  
            Home_subram_wr_flow_RST :
                begin
                      Home_subram_wr_flow_State     <=Home_subram_wr_flow_IDLE;
                end 
            Home_subram_wr_flow_IDLE:
                begin
                  if (connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd1  ) 
                      Home_subram_wr_flow_State <=Home_subram_wr_flow_BEGIN;
                  else
                      Home_subram_wr_flow_State <=Home_subram_wr_flow_IDLE;
                 end 
            Home_subram_wr_flow_BEGIN:
                 begin
                      Home_subram_wr_flow_State <=Home_subram_wr_flow_END;
                 end 
            Home_subram_wr_flow_END:
                 begin        
                      Home_subram_wr_flow_State <=Home_subram_wr_flow_IDLE;
                 end     
                 
       default:     Home_subram_wr_flow_State <=Home_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_home_wr_en   <=  1'b0 ;                 
      else if ( Home_subram_wr_flow_State==Home_subram_wr_flow_BEGIN )
           M_AXIS_home_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_home_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_home_wr_data  <=  256'd0 ;         
      else if (Home_subram_wr_flow_State==Home_subram_wr_flow_BEGIN )
            M_AXIS_home_wr_data  <=  Home_Data_buf   ;
      else       
            M_AXIS_home_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_home_ram_addr  <=    12'd0 ;            
      else if (Home_subram_wr_flow_State==Home_subram_wr_flow_BEGIN )
            M_AXIS_home_ram_addr  <=  Home0_Ptcal_Num  ;
      else       
            M_AXIS_home_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Homeram_wr_one_Done   <=  1'b0 ;                 
      else if ( Home_subram_wr_flow_State == Home_subram_wr_flow_END )
           Homeram_wr_one_Done   <=  1'b1 ;      
      else       
           Homeram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//

localparam [2:0]
           Home0_Ptcal_Flow_RST   = 3'b001	,
           Home0_Ptcal_Flow_IDLE  = 3'b010	,
           Home0_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_RST;
     end 
      else begin 
           case( Home0_Ptcal_Flow_State)  
            Home0_Ptcal_Flow_RST :
                begin
                  Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_IDLE;
                end 
            Home0_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_BEGIN;
                  else
                      Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_IDLE;
                 end 
            Home0_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_IDLE;
                  else  
                      Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_BEGIN;
              end          
         default:     Home0_Ptcal_Flow_State <=Home0_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home0_Ptcal_Num           <= 12'd0 ;
      else if ( Home0_Ptcal_Flow_State ==Home0_Ptcal_Flow_IDLE)      
           Home0_Ptcal_Num           <= 12'd0 ;                      
      else if (Homeram_wr_one_Done && ( Home0_Ptcal_Flow_State==Home0_Ptcal_Flow_BEGIN))
           Home0_Ptcal_Num          <= Home0_Ptcal_Num + 12'd1;        
      
      end 

 
//-----------------------------------------------------------------------------------------------//
// home 1
//-----------------------------------------------------------------------------------------------//

   
 localparam [3:0]
           Home1_subram_wr_flow_RST   = 4'b0001	,
           Home1_subram_wr_flow_IDLE  = 4'b0010	,
           Home1_subram_wr_flow_BEGIN = 4'b0100	,
           Home1_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home1_subram_wr_flow_State <= Home1_subram_wr_flow_RST;
     end 
      else begin 
           case( Home1_subram_wr_flow_State)  
            Home1_subram_wr_flow_RST :
                begin
                      Home1_subram_wr_flow_State     <=Home1_subram_wr_flow_IDLE;
                end 
            Home1_subram_wr_flow_IDLE:
                begin
                  if (connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd1 ) 
                      Home1_subram_wr_flow_State <=Home1_subram_wr_flow_BEGIN;
                  else
                      Home1_subram_wr_flow_State <=Home1_subram_wr_flow_IDLE;
                 end 
            Home1_subram_wr_flow_BEGIN:
                 begin
                      Home1_subram_wr_flow_State <=Home1_subram_wr_flow_END;
                 end 
            Home1_subram_wr_flow_END:
                 begin        
                      Home1_subram_wr_flow_State <=Home1_subram_wr_flow_IDLE;
                 end     
                 
       default:     Home1_subram_wr_flow_State <=Home1_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_home1_wr_en   <=  1'b0 ;                 
      else if ( Home1_subram_wr_flow_State==Home1_subram_wr_flow_BEGIN )
           M_AXIS_home1_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_home1_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_home1_wr_data  <=  256'd0 ;         
      else if (Home1_subram_wr_flow_State==Home1_subram_wr_flow_BEGIN )
            M_AXIS_home1_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_home1_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_home1_ram_addr  <=    12'd0 ;            
      else if (Home1_subram_wr_flow_State==Home1_subram_wr_flow_BEGIN )
            M_AXIS_home1_ram_addr  <=  Home1_Ptcal_Num  ;
      else       
            M_AXIS_home1_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home1ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Home1_subram_wr_flow_State==Home1_subram_wr_flow_END )
           Home1ram_wr_one_Done   <=  1'b1 ;      
      else       
           Home1ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Home1_Ptcal_Flow_RST   = 3'b001	,
           Home1_Ptcal_Flow_IDLE  = 3'b010	,
           Home1_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_RST;
     end 
      else begin 
           case( Home1_Ptcal_Flow_State)  
            Home1_Ptcal_Flow_RST :
                begin
                  Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_IDLE;
                end 
            Home1_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_BEGIN;
                  else
                      Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_IDLE;
                 end 
            Home1_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_IDLE;
                  else  
                      Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_BEGIN;
              end          
         default:     Home1_Ptcal_Flow_State <=Home1_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Home1_Ptcal_Num           <= 12'd0 ;                
      else if (Home1ram_wr_one_Done && ( Home1_Ptcal_Flow_State==Home1_Ptcal_Flow_BEGIN))
           Home1_Ptcal_Num          <= Home1_Ptcal_Num + 12'd1;        
      else if ( Home1_Ptcal_Flow_State ==Home1_Ptcal_Flow_IDLE)      
           Home1_Ptcal_Num           <= 12'd0 ;            
      end 


//-----------------------------------------------------------------------------------------------//
//   Nei1                                                                                        //
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei1_subram_wr_flow_RST   = 4'b0001	,
           Nei1_subram_wr_flow_IDLE  = 4'b0010	,
           Nei1_subram_wr_flow_BEGIN = 4'b0100	,
           Nei1_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei1_subram_wr_flow_State <= Nei1_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei1_subram_wr_flow_State)  
            Nei1_subram_wr_flow_RST :
                begin
                      Nei1_subram_wr_flow_State     <=Nei1_subram_wr_flow_IDLE;
                end 
            Nei1_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd2  ) 
                      Nei1_subram_wr_flow_State <=Nei1_subram_wr_flow_BEGIN;
                  else
                      Nei1_subram_wr_flow_State <=Nei1_subram_wr_flow_IDLE;
                 end 
            Nei1_subram_wr_flow_BEGIN:
                 begin
                      Nei1_subram_wr_flow_State <=Nei1_subram_wr_flow_END;
                 end 
            Nei1_subram_wr_flow_END:
                 begin        
                      Nei1_subram_wr_flow_State <=Nei1_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei1_subram_wr_flow_State <=Nei1_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei1_wr_en   <=  1'b0 ;                 
      else if ( Nei1_subram_wr_flow_State==Nei1_subram_wr_flow_BEGIN )
           M_AXIS_Nei1_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei1_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei1_wr_data  <=  256'd0 ;         
      else if (Nei1_subram_wr_flow_State==Nei1_subram_wr_flow_BEGIN )
            M_AXIS_Nei1_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei1_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei1_ram_addr  <=    12'd0 ;            
      else if (Nei1_subram_wr_flow_State==Nei1_subram_wr_flow_BEGIN )
            M_AXIS_Nei1_ram_addr  <=  Nei1_Ptcal_Num  ;
      else       
            M_AXIS_Nei1_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei1ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei1_subram_wr_flow_State==Nei1_subram_wr_flow_END )
           Nei1ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei1ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei1_Ptcal_Flow_RST   = 3'b001	,
           Nei1_Ptcal_Flow_IDLE  = 3'b010	,
           Nei1_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei1_Ptcal_Flow_State)  
            Nei1_Ptcal_Flow_RST :
                begin
                  Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_IDLE;
                end 
            Nei1_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_BEGIN;
                  else
                      Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_IDLE;
                 end 
            Nei1_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_IDLE;
                  else  
                      Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_BEGIN;
              end          
         default:     Nei1_Ptcal_Flow_State <=Nei1_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei1_Ptcal_Num           <= 12'd0 ;                
      else if (Nei1ram_wr_one_Done && ( Nei1_Ptcal_Flow_State==Nei1_Ptcal_Flow_BEGIN))
           Nei1_Ptcal_Num          <= Nei1_Ptcal_Num + 12'd1;        
      else if ( Nei1_Ptcal_Flow_State ==Nei1_Ptcal_Flow_IDLE)      
           Nei1_Ptcal_Num           <= 12'd0 ;            
      end 

  

//-----------------------------------------------------------------------------------------------//
 //   Nei2
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei2_subram_wr_flow_RST   = 4'b0001	,
           Nei2_subram_wr_flow_IDLE  = 4'b0010	,
           Nei2_subram_wr_flow_BEGIN = 4'b0100	,
           Nei2_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei2_subram_wr_flow_State <= Nei2_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei2_subram_wr_flow_State)  
            Nei2_subram_wr_flow_RST :
                begin
                      Nei2_subram_wr_flow_State     <=Nei2_subram_wr_flow_IDLE;
                end 
            Nei2_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd3  ) 
                      Nei2_subram_wr_flow_State <=Nei2_subram_wr_flow_BEGIN;
                  else
                      Nei2_subram_wr_flow_State <=Nei2_subram_wr_flow_IDLE;
                 end 
            Nei2_subram_wr_flow_BEGIN:
                 begin
                      Nei2_subram_wr_flow_State <=Nei2_subram_wr_flow_END;
                 end 
            Nei2_subram_wr_flow_END:
                 begin        
                      Nei2_subram_wr_flow_State <=Nei2_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei2_subram_wr_flow_State <=Nei2_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei2_wr_en   <=  1'b0 ;                 
      else if ( Nei2_subram_wr_flow_State==Nei2_subram_wr_flow_BEGIN )
           M_AXIS_Nei2_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei2_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei2_wr_data  <=  256'd0 ;         
      else if (Nei2_subram_wr_flow_State==Nei2_subram_wr_flow_BEGIN )
            M_AXIS_Nei2_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei2_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei2_ram_addr  <=    12'd0 ;            
      else if (Nei2_subram_wr_flow_State==Nei2_subram_wr_flow_BEGIN )
            M_AXIS_Nei2_ram_addr  <=  Nei2_Ptcal_Num  ;
      else       
            M_AXIS_Nei2_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei2ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei2_subram_wr_flow_State==Nei2_subram_wr_flow_END )
           Nei2ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei2ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei2_Ptcal_Flow_RST   = 3'b001	,
           Nei2_Ptcal_Flow_IDLE  = 3'b010	,
           Nei2_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei2_Ptcal_Flow_State)  
            Nei2_Ptcal_Flow_RST :
                begin
                  Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_IDLE;
                end 
            Nei2_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_BEGIN;
                  else
                      Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_IDLE;
                 end 
            Nei2_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_IDLE;
                  else  
                      Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_BEGIN;
              end          
         default:     Nei2_Ptcal_Flow_State <=Nei2_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei2_Ptcal_Num           <= 12'd0 ;                
      else if (Nei2ram_wr_one_Done && ( Nei2_Ptcal_Flow_State==Nei2_Ptcal_Flow_BEGIN))
           Nei2_Ptcal_Num          <= Nei2_Ptcal_Num + 12'd1;        
      else if ( Nei2_Ptcal_Flow_State ==Nei2_Ptcal_Flow_IDLE)      
           Nei2_Ptcal_Num           <= 12'd0 ;            
      end 

  
//-----------------------------------------------------------------------------------------------//
 //   Nei3
//-----------------------------------------------------------------------------------------------//


 localparam [3:0]
           Nei3_subram_wr_flow_RST   = 4'b0001	,
           Nei3_subram_wr_flow_IDLE  = 4'b0010	,
           Nei3_subram_wr_flow_BEGIN = 4'b0100	,
           Nei3_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei3_subram_wr_flow_State <= Nei3_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei3_subram_wr_flow_State)  
            Nei3_subram_wr_flow_RST :
                begin
                      Nei3_subram_wr_flow_State     <=Nei3_subram_wr_flow_IDLE;
                end 
            Nei3_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd4  ) 
                      Nei3_subram_wr_flow_State <=Nei3_subram_wr_flow_BEGIN;
                  else
                      Nei3_subram_wr_flow_State <=Nei3_subram_wr_flow_IDLE;
                 end 
            Nei3_subram_wr_flow_BEGIN:
                 begin
                      Nei3_subram_wr_flow_State <=Nei3_subram_wr_flow_END;
                 end 
            Nei3_subram_wr_flow_END:
                 begin        
                      Nei3_subram_wr_flow_State <=Nei3_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei3_subram_wr_flow_State <=Nei3_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei3_wr_en   <=  1'b0 ;                 
      else if ( Nei3_subram_wr_flow_State==Nei3_subram_wr_flow_BEGIN )
           M_AXIS_Nei3_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei3_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei3_wr_data  <=  256'd0 ;         
      else if (Nei3_subram_wr_flow_State==Nei3_subram_wr_flow_BEGIN )
            M_AXIS_Nei3_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei3_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei3_ram_addr  <=    12'd0 ;            
      else if (Nei3_subram_wr_flow_State==Nei3_subram_wr_flow_BEGIN )
            M_AXIS_Nei3_ram_addr  <=  Nei3_Ptcal_Num  ;
      else       
            M_AXIS_Nei3_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei3ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei3_subram_wr_flow_State==Nei3_subram_wr_flow_END )
           Nei3ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei3ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei3_Ptcal_Flow_RST   = 3'b001	,
           Nei3_Ptcal_Flow_IDLE  = 3'b010	,
           Nei3_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei3_Ptcal_Flow_State)  
            Nei3_Ptcal_Flow_RST :
                begin
                  Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_IDLE;
                end 
            Nei3_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_BEGIN;
                  else
                      Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_IDLE;
                 end 
            Nei3_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_IDLE;
                  else  
                      Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_BEGIN;
              end          
         default:     Nei3_Ptcal_Flow_State <=Nei3_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei3_Ptcal_Num           <= 12'd0 ;                
      else if (Nei3ram_wr_one_Done && ( Nei3_Ptcal_Flow_State==Nei3_Ptcal_Flow_BEGIN))
           Nei3_Ptcal_Num          <= Nei3_Ptcal_Num + 12'd1;        
      else if ( Nei3_Ptcal_Flow_State ==Nei3_Ptcal_Flow_IDLE)      
           Nei3_Ptcal_Num           <= 12'd0 ;            
      end 

 //-----------------------------------------------------------------------------------------------//
 //   Nei4
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei4_subram_wr_flow_RST   = 4'b0001	,
           Nei4_subram_wr_flow_IDLE  = 4'b0010	,
           Nei4_subram_wr_flow_BEGIN = 4'b0100	,
           Nei4_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei4_subram_wr_flow_State <= Nei4_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei4_subram_wr_flow_State)  
            Nei4_subram_wr_flow_RST :
                begin
                      Nei4_subram_wr_flow_State     <=Nei4_subram_wr_flow_IDLE;
                end 
            Nei4_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd5   ) 
                      Nei4_subram_wr_flow_State <=Nei4_subram_wr_flow_BEGIN;
                  else
                      Nei4_subram_wr_flow_State <=Nei4_subram_wr_flow_IDLE;
                 end 
            Nei4_subram_wr_flow_BEGIN:
                 begin
                      Nei4_subram_wr_flow_State <=Nei4_subram_wr_flow_END;
                 end 
            Nei4_subram_wr_flow_END:
                 begin        
                      Nei4_subram_wr_flow_State <=Nei4_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei4_subram_wr_flow_State <=Nei4_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei4_wr_en   <=  1'b0 ;                 
      else if ( Nei4_subram_wr_flow_State==Nei4_subram_wr_flow_BEGIN )
           M_AXIS_Nei4_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei4_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei4_wr_data  <=  256'd0 ;         
      else if (Nei4_subram_wr_flow_State==Nei4_subram_wr_flow_BEGIN )
            M_AXIS_Nei4_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei4_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei4_ram_addr  <=    12'd0 ;            
      else if (Nei4_subram_wr_flow_State==Nei4_subram_wr_flow_BEGIN )
            M_AXIS_Nei4_ram_addr  <=  Nei4_Ptcal_Num  ;
      else       
            M_AXIS_Nei4_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei4ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei4_subram_wr_flow_State==Nei4_subram_wr_flow_END )
           Nei4ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei4ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei4_Ptcal_Flow_RST   = 3'b001	,
           Nei4_Ptcal_Flow_IDLE  = 3'b010	,
           Nei4_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei4_Ptcal_Flow_State)  
            Nei4_Ptcal_Flow_RST :
                begin
                  Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_IDLE;
                end 
            Nei4_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_BEGIN;
                  else
                      Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_IDLE;
                 end 
            Nei4_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_IDLE;
                  else  
                      Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_BEGIN;
              end          
         default:     Nei4_Ptcal_Flow_State <=Nei4_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei4_Ptcal_Num           <= 12'd0 ;                
      else if (Nei4ram_wr_one_Done && ( Nei4_Ptcal_Flow_State==Nei4_Ptcal_Flow_BEGIN))
           Nei4_Ptcal_Num          <= Nei4_Ptcal_Num + 12'd1;        
      else if (  Nei4_Ptcal_Flow_State ==Nei4_Ptcal_Flow_IDLE)      
           Nei4_Ptcal_Num           <= 12'd0 ;            
      end 
 
 
//-----------------------------------------------------------------------------------------------//
//   Nei5
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei5_subram_wr_flow_RST   = 4'b0001	,
           Nei5_subram_wr_flow_IDLE  = 4'b0010	,
           Nei5_subram_wr_flow_BEGIN = 4'b0100	,
           Nei5_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei5_subram_wr_flow_State <= Nei5_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei5_subram_wr_flow_State)  
            Nei5_subram_wr_flow_RST :
                begin
                      Nei5_subram_wr_flow_State     <=Nei5_subram_wr_flow_IDLE;
                end 
            Nei5_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd6  ) 
                      Nei5_subram_wr_flow_State <=Nei5_subram_wr_flow_BEGIN;
                  else
                      Nei5_subram_wr_flow_State <=Nei5_subram_wr_flow_IDLE;
                 end 
            Nei5_subram_wr_flow_BEGIN:
                 begin
                      Nei5_subram_wr_flow_State <=Nei5_subram_wr_flow_END;
                 end 
            Nei5_subram_wr_flow_END:
                 begin        
                      Nei5_subram_wr_flow_State <=Nei5_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei5_subram_wr_flow_State <=Nei5_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei5_wr_en   <=  1'b0 ;                 
      else if ( Nei5_subram_wr_flow_State==Nei5_subram_wr_flow_BEGIN )
           M_AXIS_Nei5_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei5_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei5_wr_data  <=  256'd0 ;         
      else if (Nei5_subram_wr_flow_State==Nei5_subram_wr_flow_BEGIN )
            M_AXIS_Nei5_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei5_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei5_ram_addr  <=    12'd0 ;            
      else if (Nei5_subram_wr_flow_State==Nei5_subram_wr_flow_BEGIN )
            M_AXIS_Nei5_ram_addr  <=  Nei5_Ptcal_Num  ;
      else       
            M_AXIS_Nei5_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei5ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei5_subram_wr_flow_State==Nei5_subram_wr_flow_END )
           Nei5ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei5ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei5_Ptcal_Flow_RST   = 3'b001	,
           Nei5_Ptcal_Flow_IDLE  = 3'b010	,
           Nei5_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei5_Ptcal_Flow_State)  
            Nei5_Ptcal_Flow_RST :
                begin
                  Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_IDLE;
                end 
            Nei5_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_BEGIN;
                  else
                      Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_IDLE;
                 end 
            Nei5_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_IDLE;
                  else  
                      Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_BEGIN;
              end          
         default:     Nei5_Ptcal_Flow_State <=Nei5_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei5_Ptcal_Num           <= 12'd0 ;                
      else if (Nei5ram_wr_one_Done && ( Nei5_Ptcal_Flow_State==Nei5_Ptcal_Flow_BEGIN))
           Nei5_Ptcal_Num          <= Nei5_Ptcal_Num + 12'd1;        
      else if (   Nei5_Ptcal_Flow_State ==Nei5_Ptcal_Flow_IDLE)      
           Nei5_Ptcal_Num           <= 12'd0 ;            
      end 
//-----------------------------------------------------------------------------------------------//
//   Nei6
//-----------------------------------------------------------------------------------------------//
 localparam [3:0]
           Nei6_subram_wr_flow_RST   = 4'b0001	,
           Nei6_subram_wr_flow_IDLE  = 4'b0010	,
           Nei6_subram_wr_flow_BEGIN = 4'b0100	,
           Nei6_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei6_subram_wr_flow_State <= Nei6_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei6_subram_wr_flow_State)  
            Nei6_subram_wr_flow_RST :
                begin
                      Nei6_subram_wr_flow_State     <=Nei6_subram_wr_flow_IDLE;
                end 
            Nei6_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd7  ) 
                      Nei6_subram_wr_flow_State <=Nei6_subram_wr_flow_BEGIN;
                  else
                      Nei6_subram_wr_flow_State <=Nei6_subram_wr_flow_IDLE;
                 end 
            Nei6_subram_wr_flow_BEGIN:
                 begin
                      Nei6_subram_wr_flow_State <=Nei6_subram_wr_flow_END;
                 end 
            Nei6_subram_wr_flow_END:
                 begin        
                      Nei6_subram_wr_flow_State <=Nei6_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei6_subram_wr_flow_State <=Nei6_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei6_wr_en   <=  1'b0 ;                 
      else if ( Nei6_subram_wr_flow_State==Nei6_subram_wr_flow_BEGIN )
           M_AXIS_Nei6_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei6_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei6_wr_data  <=  256'd0 ;         
      else if (Nei6_subram_wr_flow_State==Nei6_subram_wr_flow_BEGIN )
            M_AXIS_Nei6_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei6_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei6_ram_addr  <=    12'd0 ;            
      else if (Nei6_subram_wr_flow_State==Nei6_subram_wr_flow_BEGIN )
            M_AXIS_Nei6_ram_addr  <=  Nei6_Ptcal_Num  ;
      else       
            M_AXIS_Nei6_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei6ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei6_subram_wr_flow_State==Nei6_subram_wr_flow_END )
           Nei6ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei6ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei6_Ptcal_Flow_RST   = 3'b001	,
           Nei6_Ptcal_Flow_IDLE  = 3'b010	,
           Nei6_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei6_Ptcal_Flow_State)  
            Nei6_Ptcal_Flow_RST :
                begin
                  Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_IDLE;
                end 
            Nei6_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_BEGIN;
                  else
                      Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_IDLE;
                 end 
            Nei6_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_IDLE;
                  else  
                      Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_BEGIN;
              end          
         default:     Nei6_Ptcal_Flow_State <=Nei6_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei6_Ptcal_Num           <= 12'd0 ;                
      else if (Nei6ram_wr_one_Done && ( Nei6_Ptcal_Flow_State==Nei6_Ptcal_Flow_BEGIN))
           Nei6_Ptcal_Num          <= Nei6_Ptcal_Num + 12'd1;        
      else if (   Nei6_Ptcal_Flow_State ==Nei6_Ptcal_Flow_IDLE)      
           Nei6_Ptcal_Num           <= 12'd0 ;            
      end 
 //-----------------------------------------------------------------------------------------------//
//   Nei7
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei7_subram_wr_flow_RST   = 4'b0001	,
           Nei7_subram_wr_flow_IDLE  = 4'b0010	,
           Nei7_subram_wr_flow_BEGIN = 4'b0100	,
           Nei7_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei7_subram_wr_flow_State <= Nei7_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei7_subram_wr_flow_State)  
            Nei7_subram_wr_flow_RST :
                begin
                      Nei7_subram_wr_flow_State     <=Nei7_subram_wr_flow_IDLE;
                end 
            Nei7_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd8 ) 
                      Nei7_subram_wr_flow_State <=Nei7_subram_wr_flow_BEGIN;
                  else
                      Nei7_subram_wr_flow_State <=Nei7_subram_wr_flow_IDLE;
                 end 
            Nei7_subram_wr_flow_BEGIN:
                 begin
                      Nei7_subram_wr_flow_State <=Nei7_subram_wr_flow_END;
                 end 
            Nei7_subram_wr_flow_END:
                 begin        
                      Nei7_subram_wr_flow_State <=Nei7_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei7_subram_wr_flow_State <=Nei7_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei7_wr_en   <=  1'b0 ;                 
      else if ( Nei7_subram_wr_flow_State==Nei7_subram_wr_flow_BEGIN )
           M_AXIS_Nei7_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei7_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei7_wr_data  <=  256'd0 ;         
      else if (Nei7_subram_wr_flow_State==Nei7_subram_wr_flow_BEGIN )
            M_AXIS_Nei7_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei7_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei7_ram_addr  <=    12'd0 ;            
      else if (Nei7_subram_wr_flow_State==Nei7_subram_wr_flow_BEGIN )
            M_AXIS_Nei7_ram_addr  <=  Nei7_Ptcal_Num  ;
      else       
            M_AXIS_Nei7_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei7ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei7_subram_wr_flow_State==Nei7_subram_wr_flow_END )
           Nei7ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei7ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei7_Ptcal_Flow_RST   = 3'b001	,
           Nei7_Ptcal_Flow_IDLE  = 3'b010	,
           Nei7_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei7_Ptcal_Flow_State)  
            Nei7_Ptcal_Flow_RST :
                begin
                  Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_IDLE;
                end 
            Nei7_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_BEGIN;
                  else
                      Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_IDLE;
                 end 
            Nei7_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_IDLE;
                  else  
                      Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_BEGIN;
              end          
         default:     Nei7_Ptcal_Flow_State <=Nei7_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei7_Ptcal_Num           <= 12'd0 ;                
      else if (Nei7ram_wr_one_Done && ( Nei7_Ptcal_Flow_State==Nei7_Ptcal_Flow_BEGIN))
           Nei7_Ptcal_Num          <= Nei7_Ptcal_Num + 12'd1;        
      else if (  Nei7_Ptcal_Flow_State ==Nei7_Ptcal_Flow_IDLE)      
           Nei7_Ptcal_Num           <= 12'd0 ;            
      end         
  //-----------------------------------------------------------------------------------------------//
//   Nei8
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei8_subram_wr_flow_RST   = 4'b0001	,
           Nei8_subram_wr_flow_IDLE  = 4'b0010	,
           Nei8_subram_wr_flow_BEGIN = 4'b0100	,
           Nei8_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei8_subram_wr_flow_State <= Nei8_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei8_subram_wr_flow_State)  
            Nei8_subram_wr_flow_RST :
                begin
                      Nei8_subram_wr_flow_State     <=Nei8_subram_wr_flow_IDLE;
                end 
            Nei8_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd9  ) 
                      Nei8_subram_wr_flow_State <=Nei8_subram_wr_flow_BEGIN;
                  else
                      Nei8_subram_wr_flow_State <=Nei8_subram_wr_flow_IDLE;
                 end 
            Nei8_subram_wr_flow_BEGIN:
                 begin
                      Nei8_subram_wr_flow_State <=Nei8_subram_wr_flow_END;
                 end 
            Nei8_subram_wr_flow_END:
                 begin        
                      Nei8_subram_wr_flow_State <=Nei8_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei8_subram_wr_flow_State <=Nei8_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei8_wr_en   <=  1'b0 ;                 
      else if ( Nei8_subram_wr_flow_State==Nei8_subram_wr_flow_BEGIN )
           M_AXIS_Nei8_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei8_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei8_wr_data  <=  256'd0 ;         
      else if (Nei8_subram_wr_flow_State==Nei8_subram_wr_flow_BEGIN )
            M_AXIS_Nei8_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei8_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei8_ram_addr  <=    12'd0 ;            
      else if (Nei8_subram_wr_flow_State==Nei8_subram_wr_flow_BEGIN )
            M_AXIS_Nei8_ram_addr  <=  Nei8_Ptcal_Num  ;
      else       
            M_AXIS_Nei8_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei8ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei8_subram_wr_flow_State==Nei8_subram_wr_flow_END )
           Nei8ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei8ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei8_Ptcal_Flow_RST   = 3'b001	,
           Nei8_Ptcal_Flow_IDLE  = 3'b010	,
           Nei8_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei8_Ptcal_Flow_State)  
            Nei8_Ptcal_Flow_RST :
                begin
                  Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_IDLE;
                end 
            Nei8_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_BEGIN;
                  else
                      Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_IDLE;
                 end 
            Nei8_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_IDLE;
                  else  
                      Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_BEGIN;
              end          
         default:     Nei8_Ptcal_Flow_State <=Nei8_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei8_Ptcal_Num           <= 12'd0 ;                
      else if (Nei8ram_wr_one_Done && ( Nei8_Ptcal_Flow_State==Nei8_Ptcal_Flow_BEGIN))
           Nei8_Ptcal_Num          <= Nei8_Ptcal_Num + 12'd1;        
      else if (   Nei8_Ptcal_Flow_State ==Nei8_Ptcal_Flow_IDLE)      
           Nei8_Ptcal_Num           <= 12'd0 ;            
      end 
//-----------------------------------------------------------------------------------------------//
//   Nei9
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei9_subram_wr_flow_RST   = 4'b0001	,
           Nei9_subram_wr_flow_IDLE  = 4'b0010	,
           Nei9_subram_wr_flow_BEGIN = 4'b0100	,
           Nei9_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei9_subram_wr_flow_State <= Nei9_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei9_subram_wr_flow_State)  
            Nei9_subram_wr_flow_RST :
                begin
                      Nei9_subram_wr_flow_State     <=Nei9_subram_wr_flow_IDLE;
                end 
            Nei9_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd10 ) 
                      Nei9_subram_wr_flow_State <=Nei9_subram_wr_flow_BEGIN;
                  else
                      Nei9_subram_wr_flow_State <=Nei9_subram_wr_flow_IDLE;
                 end 
            Nei9_subram_wr_flow_BEGIN:
                 begin
                      Nei9_subram_wr_flow_State <=Nei9_subram_wr_flow_END;
                 end 
            Nei9_subram_wr_flow_END:
                 begin        
                      Nei9_subram_wr_flow_State <=Nei9_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei9_subram_wr_flow_State <=Nei9_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei9_wr_en   <=  1'b0 ;                 
      else if ( Nei9_subram_wr_flow_State==Nei9_subram_wr_flow_BEGIN )
           M_AXIS_Nei9_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei9_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei9_wr_data  <=  256'd0 ;         
      else if (Nei9_subram_wr_flow_State==Nei9_subram_wr_flow_BEGIN )
            M_AXIS_Nei9_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei9_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei9_ram_addr  <=    12'd0 ;            
      else if (Nei9_subram_wr_flow_State==Nei9_subram_wr_flow_BEGIN )
            M_AXIS_Nei9_ram_addr  <=  Nei9_Ptcal_Num  ;
      else       
            M_AXIS_Nei9_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei9ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei9_subram_wr_flow_State==Nei9_subram_wr_flow_END )
           Nei9ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei9ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei9_Ptcal_Flow_RST   = 3'b001	,
           Nei9_Ptcal_Flow_IDLE  = 3'b010	,
           Nei9_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei9_Ptcal_Flow_State)  
            Nei9_Ptcal_Flow_RST :
                begin
                  Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_IDLE;
                end 
            Nei9_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_BEGIN;
                  else
                      Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_IDLE;
                 end 
            Nei9_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_IDLE;
                  else  
                      Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_BEGIN;
              end          
         default:     Nei9_Ptcal_Flow_State <=Nei9_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei9_Ptcal_Num           <= 12'd0 ;                
      else if (Nei9ram_wr_one_Done && ( Nei9_Ptcal_Flow_State==Nei9_Ptcal_Flow_BEGIN))
           Nei9_Ptcal_Num          <= Nei9_Ptcal_Num + 12'd1;        
      else if (  Nei9_Ptcal_Flow_State ==Nei9_Ptcal_Flow_IDLE)      
           Nei9_Ptcal_Num           <= 12'd0 ;            
      end 
//-----------------------------------------------------------------------------------------------//
//   Nei10
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei10_subram_wr_flow_RST   = 4'b0001	,
           Nei10_subram_wr_flow_IDLE  = 4'b0010	,
           Nei10_subram_wr_flow_BEGIN = 4'b0100	,
           Nei10_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei10_subram_wr_flow_State <= Nei10_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei10_subram_wr_flow_State)  
            Nei10_subram_wr_flow_RST :
                begin
                      Nei10_subram_wr_flow_State     <=Nei10_subram_wr_flow_IDLE;
                end 
            Nei10_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd11 ) 
                      Nei10_subram_wr_flow_State <=Nei10_subram_wr_flow_BEGIN;
                  else
                      Nei10_subram_wr_flow_State <=Nei10_subram_wr_flow_IDLE;
                 end 
            Nei10_subram_wr_flow_BEGIN:
                 begin
                      Nei10_subram_wr_flow_State <=Nei10_subram_wr_flow_END;
                 end 
            Nei10_subram_wr_flow_END:
                 begin        
                      Nei10_subram_wr_flow_State <=Nei10_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei10_subram_wr_flow_State <=Nei10_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei10_wr_en   <=  1'b0 ;                 
      else if ( Nei10_subram_wr_flow_State==Nei10_subram_wr_flow_BEGIN )
           M_AXIS_Nei10_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei10_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei10_wr_data  <=  256'd0 ;         
      else if (Nei10_subram_wr_flow_State==Nei10_subram_wr_flow_BEGIN )
            M_AXIS_Nei10_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei10_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei10_ram_addr  <=    12'd0 ;            
      else if (Nei10_subram_wr_flow_State==Nei10_subram_wr_flow_BEGIN )
            M_AXIS_Nei10_ram_addr  <=  Nei10_Ptcal_Num  ;
      else       
            M_AXIS_Nei10_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei10ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei10_subram_wr_flow_State==Nei10_subram_wr_flow_END )
           Nei10ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei10ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei10_Ptcal_Flow_RST   = 3'b001	,
           Nei10_Ptcal_Flow_IDLE  = 3'b010	,
           Nei10_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei10_Ptcal_Flow_State)  
            Nei10_Ptcal_Flow_RST :
                begin
                  Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_IDLE;
                end 
            Nei10_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_BEGIN;
                  else
                      Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_IDLE;
                 end 
            Nei10_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_IDLE;
                  else  
                      Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_BEGIN;
              end          
         default:     Nei10_Ptcal_Flow_State <=Nei10_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei10_Ptcal_Num           <= 12'd0 ;                
      else if (Nei10ram_wr_one_Done && ( Nei10_Ptcal_Flow_State==Nei10_Ptcal_Flow_BEGIN))
           Nei10_Ptcal_Num          <= Nei10_Ptcal_Num + 12'd1;        
      else if (   Nei10_Ptcal_Flow_State ==Nei10_Ptcal_Flow_IDLE)      
           Nei10_Ptcal_Num           <= 12'd0 ;            
      end 
//-----------------------------------------------------------------------------------------------//
//   Nei11
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei11_subram_wr_flow_RST   = 4'b0001	,
           Nei11_subram_wr_flow_IDLE  = 4'b0010	,
           Nei11_subram_wr_flow_BEGIN = 4'b0100	,
           Nei11_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei11_subram_wr_flow_State <= Nei11_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei11_subram_wr_flow_State)  
            Nei11_subram_wr_flow_RST :
                begin
                      Nei11_subram_wr_flow_State     <=Nei11_subram_wr_flow_IDLE;
                end 
            Nei11_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd12  ) 
                      Nei11_subram_wr_flow_State <=Nei11_subram_wr_flow_BEGIN;
                  else
                      Nei11_subram_wr_flow_State <=Nei11_subram_wr_flow_IDLE;
                 end 
            Nei11_subram_wr_flow_BEGIN:
                 begin
                      Nei11_subram_wr_flow_State <=Nei11_subram_wr_flow_END;
                 end 
            Nei11_subram_wr_flow_END:
                 begin        
                      Nei11_subram_wr_flow_State <=Nei11_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei11_subram_wr_flow_State <=Nei11_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei11_wr_en   <=  1'b0 ;                 
      else if ( Nei11_subram_wr_flow_State==Nei11_subram_wr_flow_BEGIN )
           M_AXIS_Nei11_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei11_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei11_wr_data  <=  256'd0 ;         
      else if (Nei11_subram_wr_flow_State==Nei11_subram_wr_flow_BEGIN )
            M_AXIS_Nei11_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei11_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei11_ram_addr  <=    12'd0 ;            
      else if (Nei11_subram_wr_flow_State==Nei11_subram_wr_flow_BEGIN )
            M_AXIS_Nei11_ram_addr  <=  Nei11_Ptcal_Num  ;
      else       
            M_AXIS_Nei11_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei11ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei11_subram_wr_flow_State==Nei11_subram_wr_flow_END )
           Nei11ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei11ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei11_Ptcal_Flow_RST   = 3'b001	,
           Nei11_Ptcal_Flow_IDLE  = 3'b010	,
           Nei11_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei11_Ptcal_Flow_State)  
            Nei11_Ptcal_Flow_RST :
                begin
                  Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_IDLE;
                end 
            Nei11_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_BEGIN;
                  else
                      Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_IDLE;
                 end 
            Nei11_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_IDLE;
                  else  
                      Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_BEGIN;
              end          
         default:     Nei11_Ptcal_Flow_State <=Nei11_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei11_Ptcal_Num           <= 12'd0 ;                
      else if (Nei11ram_wr_one_Done && ( Nei11_Ptcal_Flow_State==Nei11_Ptcal_Flow_BEGIN))
           Nei11_Ptcal_Num          <= Nei11_Ptcal_Num + 12'd1;        
      else if (  Nei11_Ptcal_Flow_State ==Nei11_Ptcal_Flow_IDLE)      
           Nei11_Ptcal_Num           <= 12'd0 ;            
      end 
//-----------------------------------------------------------------------------------------------//
//   Nei12
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei12_subram_wr_flow_RST   = 4'b0001	,
           Nei12_subram_wr_flow_IDLE  = 4'b0010	,
           Nei12_subram_wr_flow_BEGIN = 4'b0100	,
           Nei12_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei12_subram_wr_flow_State <= Nei12_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei12_subram_wr_flow_State)  
            Nei12_subram_wr_flow_RST :
                begin
                      Nei12_subram_wr_flow_State     <=Nei12_subram_wr_flow_IDLE;
                end 
            Nei12_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd13  ) 
                      Nei12_subram_wr_flow_State <=Nei12_subram_wr_flow_BEGIN;
                  else
                      Nei12_subram_wr_flow_State <=Nei12_subram_wr_flow_IDLE;
                 end 
            Nei12_subram_wr_flow_BEGIN:
                 begin
                      Nei12_subram_wr_flow_State <=Nei12_subram_wr_flow_END;
                 end 
            Nei12_subram_wr_flow_END:
                 begin        
                      Nei12_subram_wr_flow_State <=Nei12_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei12_subram_wr_flow_State <=Nei12_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei12_wr_en   <=  1'b0 ;                 
      else if ( Nei12_subram_wr_flow_State==Nei12_subram_wr_flow_BEGIN )
           M_AXIS_Nei12_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei12_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei12_wr_data  <=  256'd0 ;         
      else if (Nei12_subram_wr_flow_State==Nei12_subram_wr_flow_BEGIN )
            M_AXIS_Nei12_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei12_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei12_ram_addr  <=    12'd0 ;            
      else if (Nei12_subram_wr_flow_State==Nei12_subram_wr_flow_BEGIN )
            M_AXIS_Nei12_ram_addr  <=  Nei12_Ptcal_Num  ;
      else       
            M_AXIS_Nei12_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei12ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei12_subram_wr_flow_State==Nei12_subram_wr_flow_END )
           Nei12ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei12ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei12_Ptcal_Flow_RST   = 3'b001	,
           Nei12_Ptcal_Flow_IDLE  = 3'b010	,
           Nei12_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei12_Ptcal_Flow_State)  
            Nei12_Ptcal_Flow_RST :
                begin
                  Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_IDLE;
                end 
            Nei12_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_BEGIN;
                  else
                      Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_IDLE;
                 end 
            Nei12_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_IDLE;
                  else  
                      Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_BEGIN;
              end          
         default:     Nei12_Ptcal_Flow_State <=Nei12_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei12_Ptcal_Num           <= 12'd0 ;                
      else if (Nei12ram_wr_one_Done && ( Nei12_Ptcal_Flow_State==Nei12_Ptcal_Flow_BEGIN))
           Nei12_Ptcal_Num          <= Nei12_Ptcal_Num + 12'd1;        
      else if ( Nei12_Ptcal_Flow_State ==Nei12_Ptcal_Flow_IDLE)      
           Nei12_Ptcal_Num           <= 12'd0 ;            
      end 
 //-----------------------------------------------------------------------------------------------//
//   Nei13
//-----------------------------------------------------------------------------------------------//

 localparam [3:0]
           Nei13_subram_wr_flow_RST   = 4'b0001	,
           Nei13_subram_wr_flow_IDLE  = 4'b0010	,
           Nei13_subram_wr_flow_BEGIN = 4'b0100	,
           Nei13_subram_wr_flow_END   = 4'b1000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei13_subram_wr_flow_State <= Nei13_subram_wr_flow_RST;
     end 
      else begin 
           case( Nei13_subram_wr_flow_State)  
            Nei13_subram_wr_flow_RST :
                begin
                      Nei13_subram_wr_flow_State     <=Nei13_subram_wr_flow_IDLE;
                end 
            Nei13_subram_wr_flow_IDLE:
                begin
                  if ( connect_valid == 1'b1 &&  Neicell_NUM_CNT  ==7'd14  ) 
                      Nei13_subram_wr_flow_State <=Nei13_subram_wr_flow_BEGIN;
                  else
                      Nei13_subram_wr_flow_State <=Nei13_subram_wr_flow_IDLE;
                 end 
            Nei13_subram_wr_flow_BEGIN:
                 begin
                      Nei13_subram_wr_flow_State <=Nei13_subram_wr_flow_END;
                 end 
            Nei13_subram_wr_flow_END:
                 begin        
                      Nei13_subram_wr_flow_State <=Nei13_subram_wr_flow_IDLE;
                 end     
                 
       default:     Nei13_subram_wr_flow_State <=Nei13_subram_wr_flow_IDLE;
     endcase
   end 
 end   
 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           M_AXIS_Nei13_wr_en   <=  1'b0 ;                 
      else if ( Nei13_subram_wr_flow_State==Nei13_subram_wr_flow_BEGIN )
           M_AXIS_Nei13_wr_en   <=  1'b1 ;      
      else       
           M_AXIS_Nei13_wr_en   <=  1'b0 ;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei13_wr_data  <=  256'd0 ;         
      else if (Nei13_subram_wr_flow_State==Nei13_subram_wr_flow_BEGIN )
            M_AXIS_Nei13_wr_data  <=  S_AXIS_ram_rd_data   ;
      else       
            M_AXIS_Nei13_wr_data  <=   256'd0 ;                     
      end 
      
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Nei13_ram_addr  <=    12'd0 ;            
      else if (Nei13_subram_wr_flow_State==Nei13_subram_wr_flow_BEGIN )
            M_AXIS_Nei13_ram_addr  <=  Nei13_Ptcal_Num  ;
      else       
            M_AXIS_Nei13_ram_addr  <=     12'd0 ;                   
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei13ram_wr_one_Done   <=  1'b0 ;                 
      else if ( Nei13_subram_wr_flow_State==Nei13_subram_wr_flow_END )
           Nei13ram_wr_one_Done   <=  1'b1 ;      
      else       
           Nei13ram_wr_one_Done   <=  1'b0 ;               
      end 
      
//-----------------------------------------------------------------------------------------------//


localparam [2:0]
           Nei13_Ptcal_Flow_RST   = 3'b001	,
           Nei13_Ptcal_Flow_IDLE  = 3'b010	,
           Nei13_Ptcal_Flow_BEGIN = 3'b100	;
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_RST;
     end 
      else begin 
           case( Nei13_Ptcal_Flow_State)  
            Nei13_Ptcal_Flow_RST :
                begin
                  Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_IDLE;
                end 
            Nei13_Ptcal_Flow_IDLE:
                begin
                  if (New_Homecell_begin_en ) 
                      Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_BEGIN;
                  else
                      Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_IDLE;
                 end 
            Nei13_Ptcal_Flow_BEGIN:
              begin
                  if (Subcell_pass_done ) 
                      Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_IDLE;
                  else  
                      Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_BEGIN;
              end          
         default:     Nei13_Ptcal_Flow_State <=Nei13_Ptcal_Flow_IDLE;
     endcase
   end 
 end   
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Nei13_Ptcal_Num           <= 12'd0 ;                
      else if (Nei13ram_wr_one_Done && ( Nei13_Ptcal_Flow_State==Nei13_Ptcal_Flow_BEGIN))
           Nei13_Ptcal_Num          <= Nei13_Ptcal_Num + 12'd1;        
      else if ( Nei13_Ptcal_Flow_State ==Nei13_Ptcal_Flow_IDLE)      
           Nei13_Ptcal_Num           <= 12'd0 ;            
      end 
 
endmodule
