`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 12:08:18 PM
// Design Name: 
// Module Name: XYZ_AFTER
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


module XYZ_AFTER #  (parameter  Loop_times        =  14'd4096,
                     parameter  X_K_value         =  9'd64,
                     parameter  Y_K_value         =  9'd64,
                     parameter  Z_K_value         =  9'd64 )

(
 input                        Sys_Clk   , 
 input                        Sys_Rst_n , 
 
 input                       XFFT_Running ,  
 input                       YFFT_Running ,  
 input                       ZFFT_Running ,  
  
 output reg   [14:0]         After_1_FFT_R_addr    ,
 input        [511:0]        After_1_FFT_R_data    ,                
 output reg   [14:0]         After_2_FFT_R_addr    ,
 input        [511:0]        After_2_FFT_R_data    ,                  
 output reg   [14:0]         After_3_FFT_R_addr    ,
 input        [511:0]        After_3_FFT_R_data    ,                  
 output reg   [14:0]         After_4_FFT_R_addr   ,
 input        [511:0]        After_4_FFT_R_data   ,               
 output reg   [14:0]         After_5_FFT_R_addr   ,
 input        [511:0]        After_5_FFT_R_data   ,                 
 output reg   [14:0]         After_6_FFT_R_addr   ,
 input        [511:0]        After_6_FFT_R_data   ,                 
 output reg   [14:0]         After_7_FFT_R_addr   ,
 input        [511:0]        After_7_FFT_R_data   ,              
 output reg   [14:0]         After_8_FFT_R_addr   ,
 input        [511:0]        After_8_FFT_R_data    ,
 
 output reg   [31:0]         RAM_Q_ADDR ,
 output reg   [63:0]         Get_ONE_Value 

    );
   //------------------------------------------------------   
 reg     [8:0]    XFFT_After_Q_State;
 reg              Read_ram_1_en;
 reg              Read_ram_2_en;
 reg              Read_ram_3_en;
 reg              Read_ram_4_en;
 reg              Read_ram_5_en;
 reg              Read_ram_6_en;
 reg              Read_ram_7_en;
 reg              Read_ram_8_en;
 reg     [3:0]    READ_RAM_NUM;
 reg     [511:0]  Get_FFT_R_data;
 
 reg     [8:0]    RAM_Read_Cnt;
 reg     [31:0]   X;
 reg     [31:0]   Y;
 reg     [31:0]   Z;
 reg              READ_8_data_done;
 reg     [8:0]    READ_8_data_Cnt;
   
 reg              REFRSH_RAM_Q_DONE;
  //------------------------------------------------------  
  
localparam [8:0]
           XFFT_After_Q_RST         = 8'b0000001	,
           XFFT_After_Q_IDLE        = 8'b0000010	,        
           XFFT_After_Q_CHK         = 8'b0000100	,
           XFFT_After_Q_CHK_buf     = 8'b0001000	,
           XFFT_After_Q_BEGIN       = 8'b0010000	,
           XFFT_After_Q_BEGIN_Buf   = 8'b0100000	,             
           XFFT_After_Q_End         = 8'b1000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
      XFFT_After_Q_State <=XFFT_After_Q_RST;
     end 
      else begin 
           case( XFFT_After_Q_State)  
            XFFT_After_Q_RST :
                begin
                      XFFT_After_Q_State <=XFFT_After_Q_IDLE;
                end 
            XFFT_After_Q_IDLE:
                begin
                    if   ( XFFT_Running  ) 
                       XFFT_After_Q_State <=XFFT_After_Q_CHK;
                    else
                       XFFT_After_Q_State <=XFFT_After_Q_IDLE;
                  end 
            XFFT_After_Q_CHK:
                  begin
                      if ( READ_RAM_NUM == 4'd9  ) 
                      XFFT_After_Q_State <=XFFT_After_Q_End;  
                       else
                      XFFT_After_Q_State <=XFFT_After_Q_CHK_buf;                     
                  end  
            XFFT_After_Q_CHK_buf:  
                  begin   
                     XFFT_After_Q_State <=XFFT_After_Q_BEGIN;  
                  end 
            XFFT_After_Q_BEGIN:
                  begin
                      if ( RAM_Read_Cnt == Loop_times ) 
                      XFFT_After_Q_State <=XFFT_After_Q_CHK;  
                       else
                      XFFT_After_Q_State <=XFFT_After_Q_BEGIN_Buf;                     
                  end  
            XFFT_After_Q_BEGIN_Buf:      
                   begin
                      if (  READ_8_data_done ) 
                      XFFT_After_Q_State <=XFFT_After_Q_BEGIN;  
                       else
                      XFFT_After_Q_State <=XFFT_After_Q_BEGIN_Buf;                     
                  end  
                           
             XFFT_After_Q_End:
                  begin
                       if (REFRSH_RAM_Q_DONE) 
                      XFFT_After_Q_State <=XFFT_After_Q_IDLE;  
                       else
                      XFFT_After_Q_State <=XFFT_After_Q_End;                     
                  end           
         default:     XFFT_After_Q_State <=XFFT_After_Q_IDLE;
     endcase
   end 
 end   
 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_1_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd1  )  )     
           Read_ram_1_en           <=  1'd1  ;       
      else   
           Read_ram_1_en           <=  1'd0  ;                
      end 
   
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_2_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd2  )  )     
           Read_ram_2_en           <=  1'd1  ;       
      else   
           Read_ram_2_en           <=  1'd0  ;                
      end      
   
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_3_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd3  )  )     
           Read_ram_3_en           <=  1'd1  ;       
      else   
           Read_ram_3_en           <=  1'd0  ;                
      end 
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_4_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd4  )  )     
           Read_ram_4_en           <=  1'd1  ;       
      else   
           Read_ram_4_en           <=  1'd0  ;                
      end 
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_5_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd5  )  )     
           Read_ram_5_en           <=  1'd1  ;       
      else   
           Read_ram_5_en           <=  1'd0  ;                
      end     
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_6_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd6  )  )     
           Read_ram_6_en           <=  1'd1  ;       
      else   
           Read_ram_6_en           <=  1'd0  ;                
      end 
      
   
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_7_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd7  )  )     
           Read_ram_7_en           <=  1'd1  ;       
      else   
           Read_ram_7_en           <=  1'd0  ;                
      end 
      
        always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Read_ram_8_en           <=  1'd0  ;          
      else if ((XFFT_After_Q_State ==XFFT_After_Q_CHK_buf) && (READ_RAM_NUM == 4'd8  )  )     
           Read_ram_8_en           <=  1'd1  ;       
      else   
           Read_ram_8_en           <=  1'd0  ;                
      end 
      
         always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           READ_RAM_NUM           <=  4'd0  ;          
      else if (XFFT_After_Q_State ==XFFT_After_Q_CHK)      
           READ_RAM_NUM           <= READ_RAM_NUM + 1'd1  ;       
      else   
           READ_RAM_NUM           <=  4'd0  ;                
      end 
      

          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           RAM_Read_Cnt          <=  15'd0  ;          
      else if (XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf )       
           RAM_Read_Cnt           <= RAM_Read_Cnt + 15'd1  ;       
      else if  ( RAM_Read_Cnt == Loop_times )  
           RAM_Read_Cnt          <=  15'd0  ;  
      else if  ( XFFT_After_Q_State == XFFT_After_Q_CHK )  
           RAM_Read_Cnt          <=  15'd0  ;                       
      end          
    
   //------------------------------------------------------    
   //  After_1_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_1_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_1_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_1_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_1_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_1_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_1_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end      
     //------------------------------------------------------    
   //  After_2_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_2_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_2_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_2_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_2_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_2_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_2_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end        
      
       //------------------------------------------------------    
   //  After_3_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_3_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_3_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_3_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_3_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_3_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_3_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end      
      
       //------------------------------------------------------    
   //  After_4_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_4_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_4_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_4_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_4_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_4_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_4_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end      
      
      //------------------------------------------------------    
   //  After_5_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_5_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_5_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_5_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_5_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_5_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_5_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end    
      
       //------------------------------------------------------    
   //  After_6_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_6_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_6_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_6_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_6_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_6_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_6_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end   
      
      //------------------------------------------------------    
   //  After_7_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_7_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_7_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_7_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_7_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_7_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_7_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end    
      
       //------------------------------------------------------    
   //  After_8_FFT
   //------------------------------------------------------   
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           After_8_FFT_R_addr          <=  15'd0  ;          
      else if (Read_ram_8_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           After_8_FFT_R_addr           <= RAM_Read_Cnt    ;       
      else if (READ_8_data_done) 
           After_8_FFT_R_addr          <=  15'd0  ;             
      end     
       
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_FFT_R_data           <=  512'd0  ;          
      else if (Read_ram_8_en && XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Get_FFT_R_data           <=  After_8_FFT_R_data    ;       
      else if (READ_8_data_done)   
           Get_FFT_R_data           <=  512'd0  ;             
      end   

      
       //------------------------------------------------------   
       //------------------------------------------------------   
      
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           READ_8_data_Cnt           <=  4'd0  ;          
      else if (  XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           READ_8_data_Cnt           <=  READ_8_data_Cnt  +4'd1  ;       
      else if (READ_8_data_done)     
           READ_8_data_Cnt           <=  4'd0  ;             
      end      
    
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           READ_8_data_done           <=  1'd0  ;     
      else if (READ_8_data_Cnt ==  4'd8)       
           READ_8_data_done         <=  1'd1  ;         
      else if (READ_8_data_done)     
           READ_8_data_done             <=  1'd0  ;                
      end    
       //------------------------------------------------------   
       //------------------------------------------------------   
             always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd1 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else  if (READ_8_data_done)   
           Get_ONE_Value           <=  63'd0  ;             
      end   
      
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd2 )       
           Get_ONE_Value           <=  Get_FFT_R_data[127 : 64]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end   
                   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd3 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end   
      
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd4 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end   
                   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd5 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end   
      
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd6 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end   
      
           
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd7 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done)  
           Get_ONE_Value           <=  63'd0  ;             
      end 
      
                 
          always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Get_ONE_Value           <=  63'd0  ;          
      else if (READ_8_data_Cnt ==  4'd8 )       
           Get_ONE_Value           <=  Get_FFT_R_data[63:0 ]    ;       
      else   if (READ_8_data_done) 
           Get_ONE_Value           <=  63'd0  ;             
      end  
      
      
         
      //------------------------------------------------------      
      //   WRITE DATA TO RAM Q  
      //------------------------------------------------------  
      
       always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Y <=                  32'd0  ;          
      else if (  XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           Y <=                  READ_8_data_Cnt + 4'd8 *READ_RAM_NUM-4'd8 ;     
      else   
           Y <=                  32'd0  ;          
      end   
    
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           X <=                  32'd0  ;          
      else if (  XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
           X <=          RAM_Read_Cnt%X_K_value;     
      else   
           X <=                  32'd0  ;          
      end   

              always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z <=                  32'd0  ;          
      else if (  XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
            Z <=            RAM_Read_Cnt/64  ;     
      else   
            Z <=                  32'd0  ;          
      end   
    
           always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            RAM_Q_ADDR <=                  32'd0  ;          
      else if (  XFFT_After_Q_State ==XFFT_After_Q_BEGIN_Buf)       
            RAM_Q_ADDR <=      Z*  X_K_value *X_K_value + Y *  X_K_value + X  ;     
      else   
            RAM_Q_ADDR<=                  32'd0  ;          
      end   
     
     
     
     
     
     
endmodule
