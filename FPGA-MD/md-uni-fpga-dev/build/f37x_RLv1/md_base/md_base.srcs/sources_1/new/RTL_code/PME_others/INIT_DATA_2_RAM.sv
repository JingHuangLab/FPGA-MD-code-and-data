`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 03:56:11 PM
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


module INIT_DATA_2_RAM(
       input                        Sys_Clk                    ,
       input                        Sys_Rst_n                  ,
       output reg                   ALL_Par_pass_done          ,          
       input                        M_AXIS_New_tDone           ,   // begin system
       input                        One_partical_BfFFT_Cal_Done,   // calculate one partical done
       input           [11:0]       Par_num                    ,   // total particals number

       output reg      [11:0]       S_AXIS_ram_Rd_addr         ,   // read partical addr  
       input           [255:0]      S_AXIS_ram_rd_data         ,   // read partical data  
       
       output reg                   One_Part_Get_Done          ,   // get one partical information finish 
       
       output reg      [95:0]       atomCoorn           ,
 
       output reg      [159:0]      M_AXIS_Index_buf   
    
    );
    
    reg [11:0]         Par_num_get          ; 
    reg [6:0]          Read_Ptcal_State     ;
    reg [15:0]         Index_Check_subcell  ;
    reg                Subcell_pass_stop    ;
    reg [11:0]         Rd_Pos_cnt           ;
    reg [6:0]          One_Part_Get_State   ;
    reg                One_Part_Get_en      ;
    reg                M_AXIS_Cal_Begin_buff;
    reg  [255:0]       M_AXIS_buf_Data      ;
 //------------------------------------------------------------
 // 
 //------------------------------------------------------------
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Par_num_get <= 12'b0 ;           
      else if (M_AXIS_New_tDone  )
           Par_num_get   <= Par_num;
      else if (ALL_Par_pass_done) 
           Par_num_get  <= 12'b0 ;     
      end     
//-----------------------------------------------------------------------------------------------//
//                        RD pinpang ram                                                         //
//-----------------------------------------------------------------------------------------------//
localparam [5:0]
           Read_Ptcal_State_RST      = 6'b000001	,
           Read_Ptcal_State_IDLE     = 6'b000010	,
           Read_Ptcal_State_BEGIN    = 6'b000100	,
           Read_Ptcal_State_COTR     = 6'b001000	,
           Read_Ptcal_State_CHCK     = 6'b010000	,       
           Read_Ptcal_State_END      = 6'b100000	;
           
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
                  if (M_AXIS_New_tDone  ) 
                      Read_Ptcal_State <= Read_Ptcal_State_BEGIN;
                  else
                      Read_Ptcal_State <= Read_Ptcal_State_IDLE;
                 end 
            Read_Ptcal_State_BEGIN:
                 begin
                    if (Rd_Pos_cnt == Par_num_get) 
                          Read_Ptcal_State  <= Read_Ptcal_State_IDLE;
                    else if( ( Rd_Pos_cnt > 12'b0) && (Subcell_pass_stop))
                          Read_Ptcal_State <= Read_Ptcal_State_IDLE;
                    else
                          Read_Ptcal_State <= Read_Ptcal_State_COTR;
                 end 
            Read_Ptcal_State_COTR:
                 begin 
                   if ( (Index_Check_subcell  >  16'd0000 ) && ( Index_Check_subcell  <  16'HFFFF) ) 
                      Read_Ptcal_State <=Read_Ptcal_State_CHCK;
                   else
                      Read_Ptcal_State <=Read_Ptcal_State_BEGIN;
                 end    
          
            Read_Ptcal_State_CHCK :
                begin    
                      Read_Ptcal_State <=Read_Ptcal_State_END;      
                end
            Read_Ptcal_State_END: 
                 begin        
                     if (One_partical_BfFFT_Cal_Done ) 
                      Read_Ptcal_State <=Read_Ptcal_State_BEGIN;
                    else
                      Read_Ptcal_State <=Read_Ptcal_State_END;     
                 end    
             
       default:     Read_Ptcal_State <=Read_Ptcal_State_IDLE;
     endcase
   end 
 end   
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Rd_Pos_cnt      <=   12'd0;      
      else if ( Rd_Pos_cnt <= Par_num_get &&    Read_Ptcal_State ==Read_Ptcal_State_BEGIN    )
           Rd_Pos_cnt      <=  Rd_Pos_cnt + 12'd1;
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Rd_Pos_cnt      <=   12'd0;                    
      end 
 
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           S_AXIS_ram_Rd_addr      <=   12'd0;      
      else if (( Rd_Pos_cnt <= Par_num_get ) &&    (Read_Ptcal_State ==Read_Ptcal_State_BEGIN    ))
           S_AXIS_ram_Rd_addr      <= Rd_Pos_cnt ;
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           S_AXIS_ram_Rd_addr      <=   12'd0;                    
      end 
 
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Index_Check_subcell      <=   16'd0;      
      else if( ( Rd_Pos_cnt <= Par_num_get )&&   ( Read_Ptcal_State ==Read_Ptcal_State_BEGIN    ))
           Index_Check_subcell      <=  S_AXIS_ram_rd_data[255:240];
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           Index_Check_subcell      <=   16'd0;                    
      end   
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           One_Part_Get_en      <= 1'b0;         
      else if ( Rd_Pos_cnt <= Par_num_get   &&( Read_Ptcal_State ==Read_Ptcal_State_CHCK   ))
           One_Part_Get_en      <= 1'b1;     
      else if   (Read_Ptcal_State ==Read_Ptcal_State_IDLE)    
           One_Part_Get_en      <= 1'b0;                        
      end 

      
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Subcell_pass_stop        <=   1'b0 ;      
      else if ((( Index_Check_subcell  ==  16'd0000  )&& ( Read_Ptcal_State ==Read_Ptcal_State_COTR))|| (( Index_Check_subcell  ==  16'HFFFF  )&& ( Read_Ptcal_State ==Read_Ptcal_State_COTR)))
             Subcell_pass_stop        <=   1'b1 ;   
      else if (Read_Ptcal_State == Read_Ptcal_State_IDLE)    
             Subcell_pass_stop        <=   1'b0 ; 
       else 
             Subcell_pass_stop        <=   1'b0 ;            
      end         
 
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           ALL_Par_pass_done      <=   1'b0 ;      
      else if  (Read_Ptcal_State ==Read_Ptcal_State_IDLE)   
           ALL_Par_pass_done      <=   1'b0 ;   
      else if ((Rd_Pos_cnt > 11'd200) &&    (Read_Ptcal_State ==Read_Ptcal_State_IDLE ) )
           ALL_Par_pass_done      <=   1'b1 ;   
      else      
           ALL_Par_pass_done      <=   1'b0 ;        
      end    
 
 //------------------------------------------------------------
 // 
 //------------------------------------------------------------
    localparam [4:0]
           One_Part_Get_RST   = 5'b00001	,
           One_Part_Get_IDLE  = 5'b00010	,
           One_Part_Get_BEGIN = 5'b00100	,
           One_Part_Get_CHK   = 5'b01000	,
           One_Part_Get_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       One_Part_Get_State <= One_Part_Get_RST;
     end 
      else begin 
           case( One_Part_Get_State)  
            One_Part_Get_RST :
                begin
                      One_Part_Get_State  <=One_Part_Get_IDLE;
                end 
            One_Part_Get_IDLE:
                begin
                  if (One_Part_Get_en)
                      One_Part_Get_State <=One_Part_Get_BEGIN;
                  else
                      One_Part_Get_State <=One_Part_Get_IDLE;
                  end 
            One_Part_Get_BEGIN:
                 begin
                      One_Part_Get_State <=One_Part_Get_CHK;
                 end 
            One_Part_Get_CHK:
                  begin
                     One_Part_Get_State <=One_Part_Get_END;
                   end 
            One_Part_Get_END:
                 begin     
                  if (One_partical_BfFFT_Cal_Done )    
                      One_Part_Get_State <=One_Part_Get_IDLE;
                   else
                        One_Part_Get_State <=One_Part_Get_END;
                 end     
                 
       default:       One_Part_Get_State <=One_Part_Get_IDLE;
     endcase
   end 
 end   
 
  //------------------------------------------------------------
    
 
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Cal_Begin_buff           <= 1'b0;           
      else if (  One_Part_Get_State ==One_Part_Get_CHK )
            M_AXIS_Cal_Begin_buff           <= 1'b1;     
      else if (  One_Part_Get_State  ==One_Part_Get_IDLE)         
            M_AXIS_Cal_Begin_buff           <= 1'b0; 
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_buf_Data             <= 256'd0 ;          
      else if (  One_Part_Get_State ==One_Part_Get_CHK )
            M_AXIS_buf_Data         <=    S_AXIS_ram_rd_data   ;
      else   if (  One_Part_Get_State  ==One_Part_Get_IDLE)          
            M_AXIS_buf_Data               <= 256'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            M_AXIS_Index_buf             <= 160'd0 ;          
      else if (  One_Part_Get_State == One_Part_Get_END )
            M_AXIS_Index_buf             <=   M_AXIS_buf_Data [255:96] ; 
      else   if (  One_Part_Get_State  ==One_Part_Get_IDLE)          
            M_AXIS_Index_buf             <= 160'd0 ;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            atomCoorn             <= 32'd0 ;          
      else if (  One_Part_Get_State == One_Part_Get_END )
           atomCoorn             <=  M_AXIS_buf_Data[95:0] ;  
      else   if (  One_Part_Get_State  ==One_Part_Get_IDLE)          
            atomCoorn              <= 32'd0 ;       
      end 
     
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            One_Part_Get_Done                 <= 1'b0;         
      else if (  One_Part_Get_State == One_Part_Get_END )
            One_Part_Get_Done                 <= 1'b1;  
      else   if (  One_Part_Get_State  ==One_Part_Get_IDLE)          
            One_Part_Get_Done                 <= 1'b0;        
      end 
//------------------------------------------------------------


 
endmodule
