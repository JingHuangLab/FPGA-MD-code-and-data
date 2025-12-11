`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 03:04:52 PM
// Design Name: 
// Module Name: ABCD_SUB
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


module ABCD_SUB(

 input                       Sys_Clk  ,
 input                       Sys_Rst_n ,
 
input                    Index_DIR_A_en,
input                    Index_DIR_B_en,
input                    Index_DIR_C_en,
 input                   Index_DIR_D_en,
 
input    [95:0]          Index_DIR_A_in,
input    [95:0]          Index_DIR_B_in,
input    [95:0]          Index_DIR_C_in ,
input    [95:0]          Index_DIR_D_in ,

output     reg     [95:0]    Index_DIR_AB_Out,
output     reg     [95:0]    Index_DIR_AC_Out,
output     reg     [95:0]    Index_DIR_BC_Out,
output     reg     [95:0]    Index_DIR_BD_Out,

 
     //X to caculation sub unit 
 output reg [31:0]     X_Sub_A_out ,
 output reg            X_Sub_A_Vil ,
 output reg            X_Sub_B_Vil ,
 output reg [31:0]     X_Sub_B_out ,
 input      [31:0]     X_Sub_get_r,
 input                 X_Sub_get_vil,   

     //Y to caculation sub unit 
 output reg [31:0]     Y_Sub_A_out ,
 output reg            Y_Sub_A_Vil ,
 output reg            Y_Sub_B_Vil ,
 output reg [31:0]     Y_Sub_B_out ,
 input      [31:0]     Y_Sub_get_r,
 input                 Y_Sub_get_vil,   

     //Z to caculation sub unit 
 output reg [31:0]     Z_Sub_A_out ,
 output reg            Z_Sub_A_Vil ,
 output reg            Z_Sub_B_Vil ,
 output reg [31:0]     Z_Sub_B_out ,
 input      [31:0]     Z_Sub_get_r,
 input                 Z_Sub_get_vil       
     );
     // ---------------------------------------- -----------------------       
//  --state

reg [7:0]         X_Sub_flow_cnt_State;
reg [7:0]         Y_Sub_flow_cnt_State;
reg [7:0]         Z_Sub_flow_cnt_State;


reg [31:0]        X_Pos_home          ;              
reg [31:0]        Y_Pos_home          ;              
reg [31:0]        Z_Pos_home          ;    
reg [31:0]        X_Pos_nei           ;  
reg [31:0]        Y_Pos_nei           ;  
reg [31:0]        Z_Pos_nei           ;  
      
reg               sub_done            ;
reg               X_Sub_en            ;  
reg               Y_Sub_en            ; 
reg               Z_Sub_en            ; 
reg               Get_XYZ_delta_en    ;

reg [4:0]         X_Sub_CNT           ;  
reg [4:0]         Y_Sub_CNT           ;  
reg [4:0]         Z_Sub_CNT           ;  

 reg [31:0]         DertaX;
 reg [31:0]         DertaY;
 reg [31:0]         DertaZ;
 
 reg               R_Root_en;
 reg               R_Root_Done;
 
 reg               Get_AB_en;
 reg               Get_AC_en;
 reg               Get_BC_en;
 reg               Get_BD_en;
 

//---------------------------------------------------------------   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_home        <=  32'd0;  
      else if (  Get_AB_en ||Get_AC_en )
              X_Pos_home         <=  Index_DIR_A_in    ;  
      else if (  Get_BC_en||Get_BD_en )                           
              X_Pos_home         <=  Index_DIR_B_in    ;                         
      else if(  R_Root_Done  )      
              X_Pos_home        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_home        <=  32'd0;  
      else if ( Get_AB_en ||Get_AC_en )
              Y_Pos_home         <=  Index_DIR_A_in    ;   
      else if (  Get_BC_en||Get_BD_en )
              Y_Pos_home         <=  Index_DIR_B_in    ;            
      else if(  R_Root_Done  )      
              Y_Pos_home        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_home         <=  32'd0;  
      else if (   Get_AB_en ||Get_AC_en )
              Z_Pos_home         <=  Index_DIR_A_in    ;   
     else if (   Get_BC_en||Get_BD_en )
              Z_Pos_home         <=  Index_DIR_B_in     ;     
      else if( R_Root_Done    )      
              Z_Pos_home         <=  32'd0;              
      end 

//---------------------------------------------------------------   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_nei        <=  32'd0;  
      else if (  Get_AB_en )
              X_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_AC_en )
              X_Pos_nei       <=  Index_DIR_C_in     ; 
      else if (  Get_BC_en )
              X_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_BD_en )
              X_Pos_nei       <=  Index_DIR_D_in     ;                    
      else if( R_Root_Done   )      
              X_Pos_nei        <=  32'd0;              
      end  
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_nei        <=  32'd0;  
      else if (  Get_AB_en )
              Y_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_AC_en )
              Y_Pos_nei       <=  Index_DIR_C_in     ; 
      else if (  Get_BC_en )
              Y_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_BD_en )
              Y_Pos_nei       <=  Index_DIR_D_in     ;                    
      else if( R_Root_Done   )      
              Y_Pos_nei        <=  32'd0;              
      end  
       
      
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_nei        <=  32'd0;  
      else if (  Get_AB_en )
              Z_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_AC_en )
              Z_Pos_nei       <=  Index_DIR_C_in     ; 
      else if (  Get_BC_en )
              Z_Pos_nei       <=  Index_DIR_B_in     ;   
      else if (  Get_BD_en )
              Z_Pos_nei       <=  Index_DIR_D_in     ;                    
      else if( R_Root_Done   )      
              Z_Pos_nei        <=  32'd0;              
      end  
 
//-----------------------------------------------------------------------
//                X  - *  -> Delat X^2
//-----------------------------------------------------------------------
localparam [4:0]
           X_Sub_flow_cnt_RST   = 5'b00001	,
           X_Sub_flow_cnt_IDLE  = 5'b00010	,
           X_Sub_flow_cnt_BEGIN = 5'b00100	,
           X_Sub_flow_cnt_CHK   = 5'b01000	,
           X_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       X_Sub_flow_cnt_State <= X_Sub_flow_cnt_RST;
     end 
      else begin 
           case( X_Sub_flow_cnt_State)  
            X_Sub_flow_cnt_RST :
                begin
                      X_Sub_flow_cnt_State  <=X_Sub_flow_cnt_IDLE;
                end 
            X_Sub_flow_cnt_IDLE:
                begin
                  if (X_Sub_en)
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_BEGIN;
                  else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
                  end 
            X_Sub_flow_cnt_BEGIN:
                 begin
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_CHK;
                 end 
            X_Sub_flow_cnt_CHK:
                  begin
                     if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_END;
                     else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_CHK;
                   end 
            X_Sub_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
                      else
                      X_Sub_flow_cnt_State <=X_Sub_flow_cnt_END;
                 end     
                 
       default:       X_Sub_flow_cnt_State <=X_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_A_out  <=  32'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)      
            X_Sub_A_out  <= X_Pos_home    ;
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)      
            X_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_B_out  <=  32'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_B_out  <= X_Pos_nei    ;
      else   if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)           
            X_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_A_Vil  <= 1'b0;          
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_A_Vil <= 1'b1;  
      else  if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)            
            X_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_B_Vil <= 1'b0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_BEGIN)
            X_Sub_B_Vil <= 1'b1;  
      else              
            X_Sub_B_Vil  <= 1'b0;             
      end 
   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaX             <=  32'd0;          
      else if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
            DertaX             <=  X_Sub_get_r;
      else   if (  X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_IDLE)          
            DertaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            sub_done           <= 1'b0;            
      else if ( X_Sub_get_vil &&( X_Sub_CNT == 5'd12))
            sub_done           <= 1'b1;       
      else     
            sub_done           <= 1'b0;              
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Sub_CNT  <=  5'd0;         
      else if ( X_Sub_flow_cnt_State  ==X_Sub_flow_cnt_CHK)      
            X_Sub_CNT  <= X_Sub_CNT + 5'd1  ;
      else 
            X_Sub_CNT   <=  5'd0;              
      end 
 
      
//-----------------------------------------------------------------------
//                Y  - *  -> Delat Y^2
//-----------------------------------------------------------------------
 
localparam [4:0]
           Y_Sub_flow_cnt_RST   = 5'b00001	,
           Y_Sub_flow_cnt_IDLE  = 5'b00010	,
           Y_Sub_flow_cnt_BEGIN = 5'b00100	,
           Y_Sub_flow_cnt_CHK   = 5'b01000	,
           Y_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y_Sub_flow_cnt_State <= Y_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Y_Sub_flow_cnt_State)  
            Y_Sub_flow_cnt_RST :
                begin
                      Y_Sub_flow_cnt_State  <=Y_Sub_flow_cnt_IDLE;
                end 
            Y_Sub_flow_cnt_IDLE:
                begin
                  if (Y_Sub_en)
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_BEGIN;
                  else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
                  end 
            Y_Sub_flow_cnt_BEGIN:
                 begin
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_CHK;
                 end 
            Y_Sub_flow_cnt_CHK:
                  begin
                     if ( Y_Sub_get_vil &&Y_Sub_CNT== 5'd12)
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_END;
                     else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_CHK;
                   end 
            Y_Sub_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
                      else
                      Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_END;
                 end     
                 
       default:       Y_Sub_flow_cnt_State <=Y_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_A_out  <=  32'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)      
            Y_Sub_A_out  <= Y_Pos_home    ;
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)      
            Y_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_B_out  <=  32'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_B_out  <= Y_Pos_nei    ;
      else   if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)           
            Y_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_A_Vil  <= 1'b0;          
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_A_Vil <= 1'b1;  
      else  if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)            
            Y_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_B_Vil <= 1'b0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_BEGIN)
            Y_Sub_B_Vil <= 1'b1;  
      else  if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)            
            Y_Sub_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaY            <=  32'd0;          
      else if ( Y_Sub_get_vil &&Y_Sub_CNT== 5'd12)
            DertaY             <=  Y_Sub_get_r;
      else   if (  Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_IDLE)          
            DertaY             <= 32'd0;       
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Sub_CNT  <=  5'd0;         
      else if ( Y_Sub_flow_cnt_State  ==Y_Sub_flow_cnt_CHK)      
            Y_Sub_CNT  <= Y_Sub_CNT + 5'd1  ;
      else      
            Y_Sub_CNT   <=  5'd0;              
      end 
 
//-----------------------------------------------------------------------
//                Z  - *  -> Delat Z^2
//-----------------------------------------------------------------------

 
localparam [4:0]
           Z_Sub_flow_cnt_RST   = 5'b00001	,
           Z_Sub_flow_cnt_IDLE  = 5'b00010	,
           Z_Sub_flow_cnt_BEGIN = 5'b00100	,
           Z_Sub_flow_cnt_CHK   = 5'b01000	,
           Z_Sub_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Z_Sub_flow_cnt_State <= Z_Sub_flow_cnt_RST;
     end 
      else begin 
           case( Z_Sub_flow_cnt_State)  
            Z_Sub_flow_cnt_RST :
                begin
                      Z_Sub_flow_cnt_State  <=Z_Sub_flow_cnt_IDLE;
                end 
            Z_Sub_flow_cnt_IDLE:
                begin
                  if (Z_Sub_en)
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_BEGIN;
                  else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
                  end 
            Z_Sub_flow_cnt_BEGIN:
                 begin
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_CHK;
                 end 
            Z_Sub_flow_cnt_CHK:
                  begin
                     if ( Z_Sub_get_vil && Z_Sub_CNT == 5'd12)
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_END;
                     else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_CHK;
                   end 
            Z_Sub_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
                      else
                      Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_END;
                 end     
                 
       default:       Z_Sub_flow_cnt_State <=Z_Sub_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_A_out  <=  32'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)      
            Z_Sub_A_out  <= Z_Pos_home    ;
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)      
            Z_Sub_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_B_out  <=  32'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_B_out  <= Z_Pos_nei    ;
      else   if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)           
            Z_Sub_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_A_Vil  <= 1'b0;          
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_A_Vil <= 1'b1;  
      else  if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)            
            Z_Sub_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_B_Vil <= 1'b0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_BEGIN)
            Z_Sub_B_Vil <= 1'b1;  
      else  if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)            
            Z_Sub_B_Vil  <= 1'b0;             
      end 


  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            DertaZ            <=  32'd0;          
      else if  ( Z_Sub_get_vil && Z_Sub_CNT == 5'd12)
            DertaZ             <=  Z_Sub_get_r;
      else   if (  Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_IDLE)          
            DertaZ             <= 32'd0;       
      end 

 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Sub_CNT   <=  5'd0;         
      else if ( Z_Sub_flow_cnt_State  ==Z_Sub_flow_cnt_CHK)      
            Z_Sub_CNT   <= Z_Sub_CNT + 5'd1  ;
      else  
            Z_Sub_CNT   <=  5'd0;              
      end 
 
endmodule  
    

