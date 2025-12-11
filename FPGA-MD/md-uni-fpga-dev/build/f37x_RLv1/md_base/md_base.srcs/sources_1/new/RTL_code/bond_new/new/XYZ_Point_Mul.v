`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2023 02:50:46 PM
// Design Name: 
// Module Name: XYZ_Point_Mul
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


module XYZ_Point_Mul(
 input                 Sys_Clk  ,
 input                 Sys_Rst_n,
 output reg            Sum_rr_done, 
                   
input    [95:0]         Index_bond_A_in,
input                   Index_bond_A_en,
input    [95:0]         Index_bond_B_in,
input                   Index_bond_B_en,

 input                  Home0_cell_cal_finish,
 output reg [31:0]      Root_R,
  
  output reg [31:0]    Root_R_A_out ,
  output reg           Root_R_A_Vil ,   
  input      [31:0]    Root_R_get_r,
  input                Root_R_get_vil, // 1/r
  
  //sum to caculation Add unit 
 output reg [31:0]     X_Add_A_out , 
 output reg [31:0]     Y_Add_B_out ,     
 output reg            X_Add_A_Vil ,
 output reg            Y_Add_B_Vil ,           
 input      [31:0]     RR_Add_get_r   ,    
 input                 RR_Add_get_vil ,
 
 output reg [31:0]     XY_Add_C_out , 
 output reg            XY_Add_C_Vil ,      
 output reg [31:0]     Z_Add_C_out   , 
 output reg            Z_Add_C_Vil   ,
 input                 XY_Add_get_vil ,
 input      [31:0]     RR_Add_get_XY_R,    
 //X to caculation mul unit 
 output reg [31:0]     X_Mul_A_out ,
 output reg            X_Mul_A_Vil ,
 output reg            X_Mul_B_Vil ,
 output reg [31:0]     X_Mul_B_out ,
 input      [31:0]     X_Mul_get_r ,
 input                 X_Mul_get_vil,

      //Y to caculation mul unit 
 output reg [31:0]     Y_Mul_A_out ,
 output reg            Y_Mul_A_Vil ,
 output reg            Y_Mul_B_Vil ,
 output reg [31:0]     Y_Mul_B_out ,
 input      [31:0]     Y_Mul_get_r,
 input                 Y_Mul_get_vil,

   //Z to caculation mul unit 
 output reg [31:0]     Z_Mul_A_out ,
 output reg            Z_Mul_A_Vil ,
 output reg            Z_Mul_B_Vil ,
 output reg [31:0]     Z_Mul_B_out ,
 input      [31:0]     Z_Mul_get_r,
 input                 Z_Mul_get_vil 

     );
     // ---------------------------------------- -----------------------       
//  --state
reg [7:0]         Home_flow_cnt_State    ;
reg [7:0]         Nei_flow_cnt_State     ;
reg [7:0]         X_Mul_flow_cnt_State   ;
reg [7:0]         X_Sub_flow_cnt_State   ;
reg [7:0]         Y_Mul_flow_cnt_State   ;
reg [7:0]         Y_Sub_flow_cnt_State   ;
reg [7:0]         Z_Mul_flow_cnt_State   ;
reg [7:0]         Z_Sub_flow_cnt_State   ;
reg [7:0]         Sqr_RR_flow_cnt_State  ;
reg [7:0]         Root_R_flow_cnt_State  ;

reg [31:0]        X_Pos_home              ;              
reg [31:0]        Y_Pos_home              ;              
reg [31:0]        Z_Pos_home              ;    
reg [31:0]        X_Pos_nei               ;  
reg [31:0]        Y_Pos_nei               ;  
reg [31:0]        Z_Pos_nei               ;  
reg [31:0]        DertaX                  ; 
reg [31:0]        DertaY                  ; 
reg [31:0]        DertaZ                  ;  
reg [31:0]        Sqr_DertaX              ;
reg [31:0]        Sqr_DertaY              ;
reg [31:0]        Sqr_DertaZ              ;           
   
reg               X_Sub_en            ;  
reg               X_Mul_en            ;  
reg               Sum_rr              ;  
reg               Y_Sub_en            ; 
reg               Y_Mul_en            ; 
reg               Z_Sub_en            ; 
reg               Z_Mul_en            ; 
reg               Get_XYZ_delta_en    ;
reg               sub_done            ;
reg               Mul_done            ;

reg [4:0]         X_Sub_CNT           ;  
reg [4:0]         Y_Sub_CNT           ;  
reg [4:0]         Z_Sub_CNT           ;  
reg [4:0]         X_Mul_CNT           ;  
reg [4:0]         Y_Mul_CNT           ;  
reg [4:0]         Z_Mul_CNT           ;  
reg [4:0]         XY_Add_CNT          ;
reg [4:0]         RR_Add_CNT          ;   

 reg [31:0]       Z_Pos_home_buf      ;
 reg [31:0]       Z_Pos_nei_buf       ;
reg [7:0]         Root_R_CNT          ;
reg               Root_R_Done         ;
 reg [31:0]       M_AXIS_RR_data      ;
 reg               Sum_rr_Done        ;
 
 reg               R_Root_en           ;
 reg               R_Root_Done         ;
//---------------------------------------------------------------   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_home        <=  32'd0;  
      else if (  Index_bond_A_en)
              X_Pos_home         <=  Index_bond_A_in    ;   
      else if(  Home0_cell_cal_finish  )      
              X_Pos_home        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_home        <=  32'd0;  
      else if ( Index_bond_A_en )
              Y_Pos_home         <=  Index_bond_A_in    ;   
      else if(  Home0_cell_cal_finish  )      
              Y_Pos_home        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_home         <=  32'd0;  
      else if (  Index_bond_A_en )
              Z_Pos_home         <=  Index_bond_A_in    ;   
      else if( Home0_cell_cal_finish    )      
              Z_Pos_home         <=  32'd0;              
      end 
//---------------------------------------------------------------   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_nei        <=  32'd0;  
      else if (  Index_bond_B_en )
              X_Pos_nei        <=  Index_bond_B_in     ;   
      else if( R_Root_Done   )      
              X_Pos_nei        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_nei        <=  32'd0;  
      else if (Index_bond_B_en  )
               Y_Pos_nei       <=  Index_bond_B_in ;   
      else if( R_Root_Done  )      
              Y_Pos_nei        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_nei        <=  32'd0;  
      else if (Index_bond_B_en  )
              Z_Pos_nei         <= Index_bond_B_in   ;   
      else if( R_Root_Done  )      
              Z_Pos_nei        <=  32'd0;              
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
            Get_XYZ_delta_en  <= 1'b0;
      else if ( Index_bond_B_en )
            Get_XYZ_delta_en  <= 1'b1; 
      else     
            Get_XYZ_delta_en  <= 1'b0;              
      end 
   //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------    

     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Mul_en      <= 1'b0;  
      else if (sub_done )
              X_Mul_en      <= 1'b1;  
      else 
              X_Mul_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Mul_en      <= 1'b0;  
      else if (sub_done )
              Y_Mul_en      <= 1'b1;  
      else 
              Y_Mul_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Mul_en      <= 1'b0;  
      else if (sub_done )
              Z_Mul_en      <= 1'b1;  
      else 
              Z_Mul_en      <= 1'b0;               
      end 
 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Sum_rr            <= 1'b0;  
      else if (Mul_done )
               Sum_rr            <= 1'b1;     
      else 
               Sum_rr            <= 1'b0;               
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               R_Root_en            <= 1'b0;  
      else if (Sum_rr_Done )
               R_Root_en            <= 1'b1;     
      else 
               R_Root_en            <= 1'b0;               
      end  

    //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------   
  localparam [4:0]
           X_Mul_flow_cnt_RST   = 5'b00001	,
           X_Mul_flow_cnt_IDLE  = 5'b00010	,
           X_Mul_flow_cnt_BEGIN = 5'b00100	,
           X_Mul_flow_cnt_CHK   = 5'b01000	,
           X_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       X_Mul_flow_cnt_State <= X_Mul_flow_cnt_RST;
     end 
      else begin 
           case( X_Mul_flow_cnt_State)  
            X_Mul_flow_cnt_RST :
                begin
                      X_Mul_flow_cnt_State  <=X_Mul_flow_cnt_IDLE;
                end 
            X_Mul_flow_cnt_IDLE:
                begin
                  if (X_Mul_en)
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_BEGIN;
                  else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
                  end 
            X_Mul_flow_cnt_BEGIN:
                 begin
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_CHK;
                 end 
            X_Mul_flow_cnt_CHK:
                  begin
                     if ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_END;
                     else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_CHK;
                   end 
            X_Mul_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
                      else
                      X_Mul_flow_cnt_State <=X_Mul_flow_cnt_END;
                 end     
                 
       default:       X_Mul_flow_cnt_State <=X_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_A_out  <=  32'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)      
            X_Mul_A_out  <= X_Pos_home    ;
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)      
            X_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_B_out  <=  32'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_B_out  <= X_Pos_nei    ;
      else   if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)           
            X_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_A_Vil  <= 1'b0;          
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_A_Vil <= 1'b1;  
      else  if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)            
            X_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_B_Vil <= 1'b0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_B_Vil <= 1'b1;  
      else  if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)            
            X_Mul_B_Vil  <= 1'b0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaX            <=  32'd0;          
      else if  ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
            Sqr_DertaX             <=  X_Mul_get_r;
      else   if (  X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)          
            Sqr_DertaX             <= 32'd0;       
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Mul_done           <= 1'b0;            
      else if  ( X_Mul_get_vil && X_Mul_CNT ==   5'd10    )
            Mul_done           <= 1'b1;       
      else        
            Mul_done           <= 1'b0;              
      end 
  
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_CNT  <=  5'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_CHK)      
            X_Mul_CNT  <= X_Mul_CNT + 5'd1  ;
      else  
            X_Mul_CNT   <=  5'd0;              
      end     
      
 
    //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------       
 
 
  localparam [4:0]
           Y_Mul_flow_cnt_RST   = 5'b00001	,
           Y_Mul_flow_cnt_IDLE  = 5'b00010	,
           Y_Mul_flow_cnt_BEGIN = 5'b00100	,
           Y_Mul_flow_cnt_CHK   = 5'b01000	,
           Y_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Y_Mul_flow_cnt_State <= Y_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Y_Mul_flow_cnt_State)  
            Y_Mul_flow_cnt_RST :
                begin
                      Y_Mul_flow_cnt_State  <=Y_Mul_flow_cnt_IDLE;
                end 
            Y_Mul_flow_cnt_IDLE:
                begin
                  if (Y_Mul_en)
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_BEGIN;
                  else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
                  end 
            Y_Mul_flow_cnt_BEGIN:
                 begin
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_CHK;
                 end 
            Y_Mul_flow_cnt_CHK:
                  begin
                     if ( Y_Mul_get_vil && Y_Mul_CNT == 5'd10 )
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_END;
                     else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_CHK;
                   end 
            Y_Mul_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
                      else
                      Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_END;
                 end     
                 
       default:       Y_Mul_flow_cnt_State <=Y_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_A_out  <=  32'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)      
            Y_Mul_A_out  <= DertaY    ;
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)      
            Y_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_B_out  <=  32'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_B_out  <= DertaY    ;
      else   if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)           
            Y_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_A_Vil  <= 1'b0;          
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_A_Vil <= 1'b1;  
      else  if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)            
            Y_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_B_Vil <= 1'b0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_BEGIN)
            Y_Mul_B_Vil <= 1'b1;  
      else  if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)            
            Y_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaY            <=  32'd0;          
      else if  ( Y_Mul_get_vil && Y_Mul_CNT == 5'd10 )
            Sqr_DertaY            <=  Y_Mul_get_r;
      else   if (  Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_IDLE)          
            Sqr_DertaY             <= 32'd0;       
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Mul_CNT  <=  5'd0;         
      else if ( Y_Mul_flow_cnt_State  ==Y_Mul_flow_cnt_CHK)      
            Y_Mul_CNT  <= Y_Mul_CNT + 5'd1  ;
      else   
            Y_Mul_CNT   <=  5'd0;              
      end    
//-----------------------------------------------------------------------
//                Z  - *  -> Delat Z^2
//-----------------------------------------------------------------------

  localparam [4:0]
           Z_Mul_flow_cnt_RST   = 5'b00001	,
           Z_Mul_flow_cnt_IDLE  = 5'b00010	,
           Z_Mul_flow_cnt_BEGIN = 5'b00100	,
           Z_Mul_flow_cnt_CHK   = 5'b01000	,
           Z_Mul_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Z_Mul_flow_cnt_State <= Z_Mul_flow_cnt_RST;
     end 
      else begin 
           case( Z_Mul_flow_cnt_State)  
            Z_Mul_flow_cnt_RST :
                begin
                      Z_Mul_flow_cnt_State  <=Z_Mul_flow_cnt_IDLE;
                end 
            Z_Mul_flow_cnt_IDLE:
                begin
                  if (Z_Mul_en)
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_BEGIN;
                  else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
                  end 
            Z_Mul_flow_cnt_BEGIN:
                 begin
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_CHK;
                 end 
            Z_Mul_flow_cnt_CHK:
                  begin
                     if ( Z_Mul_get_vil && Z_Mul_CNT   ==  5'd10)
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_END;
                     else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_CHK;
                   end 
            Z_Mul_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
                      else
                      Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_END;
                 end     
                 
       default:       Z_Mul_flow_cnt_State <=Z_Mul_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_A_out  <=  32'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)      
            Z_Mul_A_out  <= DertaZ    ;
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)      
            Z_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_B_out  <=  32'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_B_out  <= DertaZ    ;
      else   if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)           
            Z_Mul_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_A_Vil  <= 1'b0;          
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_A_Vil <= 1'b1;  
      else  if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)            
            Z_Mul_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_B_Vil <= 1'b0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_BEGIN)
            Z_Mul_B_Vil <= 1'b1;  
      else  if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)            
            Z_Mul_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Sqr_DertaZ            <=  32'd0;          
      else if ( Z_Mul_get_vil && Z_Mul_CNT   ==  5'd10)
            Sqr_DertaZ            <=  Z_Mul_get_r;
      else    if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_IDLE)                
            Sqr_DertaZ             <= 32'd0;       
      end 
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Mul_CNT  <=  5'd0;         
      else if ( Z_Mul_flow_cnt_State  ==Z_Mul_flow_cnt_CHK)      
            Z_Mul_CNT  <= Z_Mul_CNT + 5'd1  ;
      else     
            Z_Mul_CNT   <=  5'd0;              
      end 
      
//-----------------------------------------------------------------------
//                  Z^2 + y^2 +x^2
//-----------------------------------------------------------------------
 

 localparam [6:0]
           Sqr_RR_flow_cnt_RST      = 7'b0000001	,
           Sqr_RR_flow_cnt_IDLE     = 7'b0000010	,
           Sqr_RR_flow_cnt_BEGIN    = 7'b0000100	,
           Sqr_RR_flow_cnt_CHK      = 7'b0001000	,
           Sqr_RR_flow_cnt_XYZ      = 7'b0010000	,
           Sqr_RR_flow_cnt_CHKXYZ   = 7'b0100000	,
           Sqr_RR_flow_cnt_END      = 7'b1000000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Sqr_RR_flow_cnt_State <= Sqr_RR_flow_cnt_RST;
     end 
      else begin 
           case( Sqr_RR_flow_cnt_State)  
            Sqr_RR_flow_cnt_RST :
                begin
                      Sqr_RR_flow_cnt_State  <=Sqr_RR_flow_cnt_IDLE;
                end 
            Sqr_RR_flow_cnt_IDLE:
                begin
                  if (Sum_rr)
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_BEGIN;
                  else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
                  end 
            Sqr_RR_flow_cnt_BEGIN:
                 begin
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHK;
                 end 
            Sqr_RR_flow_cnt_CHK:
                  begin
                     if ( XY_Add_get_vil && XY_Add_CNT ==  5'd13 )
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_XYZ;
                     else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHK;
                   end 
            Sqr_RR_flow_cnt_XYZ:
                  begin                               
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHKXYZ;
                   end          
            Sqr_RR_flow_cnt_CHKXYZ:
                  begin
                     if ( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_END;
                     else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_CHKXYZ;
                   end        
                   
                   
            Sqr_RR_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
                      else
                      Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_END;
                 end     
                 
       default:       Sqr_RR_flow_cnt_State <=Sqr_RR_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Add_A_out  <=  32'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)      
            X_Add_A_out  <= Sqr_DertaX    ;
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)      
            X_Add_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Add_B_out  <=  32'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            Y_Add_B_out  <= Sqr_DertaY   ;
      else   if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)           
            Y_Add_B_out  <= 32'd0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Add_A_Vil  <= 1'b0;          
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            X_Add_A_Vil  <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            X_Add_A_Vil  <= 1'b0;               
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_Add_B_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_BEGIN)
            Y_Add_B_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            Y_Add_B_Vil  <= 1'b0;             
      end 

  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_C_out            <=  32'd0;          
      else if ( XY_Add_get_vil && XY_Add_CNT ==  5'd13 )
            XY_Add_C_out       <= RR_Add_get_XY_R; 
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            XY_Add_C_out             <= 32'd0;       
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Add_C_out            <=  32'd0;          
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ )
            Z_Add_C_out        <= Sqr_DertaZ;  
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            Z_Add_C_out             <= 32'd0;       
      end 
 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_C_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ)
            XY_Add_C_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            XY_Add_C_Vil  <= 1'b0;             
      end 
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_Add_C_Vil <= 1'b0;         
      else if ( Sqr_RR_flow_cnt_State ==Sqr_RR_flow_cnt_XYZ)
            Z_Add_C_Vil <= 1'b1;  
      else  if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)            
            Z_Add_C_Vil  <= 1'b0;             
      end 
      
         
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           R_Root_Done        <=  1'b0;     
      else if( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
           R_Root_Done        <=  1'b1;  
      else           
           R_Root_Done        <=  1'b0; 
      end   
      
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            XY_Add_CNT  <=  5'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_CHK)      
            XY_Add_CNT  <= XY_Add_CNT + 5'd1  ;
      else     
            XY_Add_CNT   <=  5'd0;              
      end       
       
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            RR_Add_CNT  <=  5'd0;         
      else if ( Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_CHKXYZ)      
            RR_Add_CNT  <= RR_Add_CNT + 5'd1  ;
      else     
            RR_Add_CNT   <=  5'd0;              
      end 
            
 //---------------------------------------------------------------    
 //---------------------------------------------------------------    
localparam [4:0]
           Root_R_flow_cnt_RST   = 5'b00001	,
           Root_R_flow_cnt_IDLE  = 5'b00010	,
           Root_R_flow_cnt_BEGIN = 5'b00100	,
           Root_R_flow_cnt_CHK   = 5'b01000	,
           Root_R_flow_cnt_END   = 5'b10000	;

 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Root_R_flow_cnt_State <= Root_R_flow_cnt_RST;
     end 
      else begin 
           case( Root_R_flow_cnt_State)  
            Root_R_flow_cnt_RST :
                begin
                      Root_R_flow_cnt_State  <=Root_R_flow_cnt_IDLE;
                end 
            Root_R_flow_cnt_IDLE:
                begin
                  if (R_Root_en)
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_BEGIN;
                  else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
                  end 
            Root_R_flow_cnt_BEGIN:
                 begin
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_CHK;
                 end 
            Root_R_flow_cnt_CHK:
                  begin
                     if ( Root_R_get_vil && Root_R_CNT == 5'd30)
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_END;
                     else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_CHK;
                   end 
            Root_R_flow_cnt_END:
                 begin        
                    if  ( R_Root_Done )        
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
                      else
                      Root_R_flow_cnt_State <=Root_R_flow_cnt_END;
                 end     
                 
       default:       Root_R_flow_cnt_State <=Root_R_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_A_out  <=  32'd0;         
      else if ( Root_R_flow_cnt_State ==Root_R_flow_cnt_BEGIN)      
            Root_R_A_out  <=  M_AXIS_RR_data ;
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)
            Root_R_A_out  <= 32'd0;             
      end 
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_A_Vil  <=  1'b0;         
      else if ( Root_R_flow_cnt_State ==Root_R_flow_cnt_BEGIN)      
            Root_R_A_Vil  <=  1'b1;  
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)     
            Root_R_A_Vil  <=  1'b0;            
      end 
           
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
             Root_R  <=  32'd0;         
      else if ( Root_R_get_vil && Root_R_CNT == 5'd30)
             Root_R  <=  Root_R_get_r; 
      else  if (  Root_R_flow_cnt_State ==Root_R_flow_cnt_IDLE)
             Root_R  <=  32'd0;           
      end  

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_Done    <=  1'b0;     
      else if ( Root_R_get_vil && Root_R_CNT == 5'd30)
            Root_R_Done    <=  1'b1;  
      else      
            Root_R_Done    <=  1'b0;       
      end 
       
   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Root_R_CNT    <=  5'b0;     
      else if (Root_R_get_vil&& Root_R_flow_cnt_State ==Root_R_flow_cnt_CHK)      
            Root_R_CNT    <= Root_R_CNT + 1'b1;  
      else      
            Root_R_CNT    <=  5'b0;       
      end  

     
endmodule