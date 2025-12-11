`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2023 02:50:46 PM
// Design Name: 
// Module Name: Filter
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


module Filter(
 input                 Sys_Clk  ,
 input                 Sys_Rst_n,
 input                 Home0_cell_cal_finish ,
 //to next caculation unit  
 input                 S_AXIS_COMP_Begin     ,       //previous input, enable XYZ buf  
 input                 S_AXIS_COMP_2_Begin   ,       //previous input, enable XYZ buf  
 output reg            Sum_rr_done     ,
 output reg[256:0]     M_AXIS_RR_data   ,
                   
 input    [31:0]       X_Pos_buf_nei,
 input    [31:0]       Y_Pos_buf_nei,
 input    [31:0]       Z_Pos_buf_nei,  
    
  // from  Fifo module home
 input    [31:0]       X_Pos_buf,
 input    [31:0]       Y_Pos_buf,
 input    [31:0]       Z_Pos_buf,  
          
 input      [159:0]    S_AXIS_home_Index_buf, 
 input      [159:0]    S_AXIS_Index_buf ,            
 output reg [159:0]    Index_Pos_home,
 output reg [159:0]    Index_Pos_nei,
 
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
     //X to caculation sub unit 
 output reg [31:0]     X_Sub_A_out ,
 output reg            X_Sub_A_Vil ,
 output reg            X_Sub_B_Vil ,
 output reg [31:0]     X_Sub_B_out ,
 input      [31:0]     X_Sub_get_r,
 input                 X_Sub_get_vil,   
      //Y to caculation mul unit 
 output reg [31:0]     Y_Mul_A_out ,
 output reg            Y_Mul_A_Vil ,
 output reg            Y_Mul_B_Vil ,
 output reg [31:0]     Y_Mul_B_out ,
 input      [31:0]     Y_Mul_get_r,
 input                 Y_Mul_get_vil,
     //Y to caculation sub unit 
 output reg [31:0]     Y_Sub_A_out ,
 output reg            Y_Sub_A_Vil ,
 output reg            Y_Sub_B_Vil ,
 output reg [31:0]     Y_Sub_B_out ,
 input      [31:0]     Y_Sub_get_r,
 input                 Y_Sub_get_vil,   

   //Z to caculation mul unit 
 output reg [31:0]     Z_Mul_A_out ,
 output reg            Z_Mul_A_Vil ,
 output reg            Z_Mul_B_Vil ,
 output reg [31:0]     Z_Mul_B_out ,
 input      [31:0]     Z_Mul_get_r,
 input                 Z_Mul_get_vil,
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
reg [7:0]         Home_flow_cnt_State    ;
reg [7:0]         Nei_flow_cnt_State     ;
reg [7:0]         X_Mul_flow_cnt_State;
reg [7:0]         X_Sub_flow_cnt_State;
reg [7:0]         Y_Mul_flow_cnt_State;
reg [7:0]         Y_Sub_flow_cnt_State;
reg [7:0]         Z_Mul_flow_cnt_State;
reg [7:0]         Z_Sub_flow_cnt_State;
reg [7:0]         Sqr_RR_flow_cnt_State;

reg [31:0]        X_Pos_home;              
reg [31:0]        Y_Pos_home;              
reg [31:0]        Z_Pos_home;    
reg [31:0]        X_Pos_nei;  
reg [31:0]        Y_Pos_nei;  
reg [31:0]        Z_Pos_nei;  
reg [31:0]        DertaX; 
reg [31:0]        DertaY; 
reg [31:0]        DertaZ;  
reg [31:0]        Sqr_DertaX;
reg [31:0]        Sqr_DertaY;
reg [31:0]        Sqr_DertaZ;           
   
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

reg               Force_Sub_Done      ;  

 reg [31:0]       Z_Pos_home_buf      ;
 reg [31:0]       Z_Pos_nei_buf       ;


//---------------------------------------------------------------   
 //    get  po.j and po.i position  
 //---------------------------------------------------------------   

 localparam [3:0]
           Home_flow_cnt_RST   = 4'b0001	,
           Home_flow_cnt_IDLE  = 4'b0010	,
           Home_flow_cnt_BEGIN = 4'b0100	,
           Home_flow_cnt_END   = 4'b1000	;
           
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Home_flow_cnt_State <= Home_flow_cnt_RST;
     end 
      else begin 
           case( Home_flow_cnt_State)  
            Home_flow_cnt_RST :
                begin
                      Home_flow_cnt_State  <=Home_flow_cnt_IDLE;
                end 
            Home_flow_cnt_IDLE:
                begin
                  if (S_AXIS_COMP_Begin)
                      Home_flow_cnt_State <=Home_flow_cnt_BEGIN;
                  else
                      Home_flow_cnt_State <=Home_flow_cnt_IDLE;
                  end 
            Home_flow_cnt_BEGIN:
                 begin
                     if ( Z_Pos_home_buf  !=  Z_Pos_buf)
                       Home_flow_cnt_State <=Home_flow_cnt_END;
                     else
                       Home_flow_cnt_State <=Home_flow_cnt_BEGIN;
                 end 
 
            Home_flow_cnt_END:
                 begin        
                     if ( Home0_cell_cal_finish  )
                        Home_flow_cnt_State <=Home_flow_cnt_IDLE;
                     else                     
                        Home_flow_cnt_State <=Home_flow_cnt_END;
                 end     
                 
       default:       Home_flow_cnt_State <=Home_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Z_Pos_home_buf        <=  32'd0;  
      else if (S_AXIS_COMP_Begin )
              Z_Pos_home_buf          <=  Z_Pos_buf   ;   
      else if(  Home0_cell_cal_finish   )      
              Z_Pos_home_buf        <=  32'd0;              
      end 

    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_home        <=  32'd0;  
      else if (  S_AXIS_COMP_Begin)
              X_Pos_home         <=  X_Pos_buf    ;   
      else if(  Home0_cell_cal_finish  )      
              X_Pos_home        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_home        <=  32'd0;  
      else if ( S_AXIS_COMP_Begin )
              Y_Pos_home         <=  Y_Pos_buf    ;   
      else if(  Home0_cell_cal_finish  )      
              Y_Pos_home        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_home         <=  32'd0;  
      else if (  S_AXIS_COMP_Begin )
              Z_Pos_home         <=  Z_Pos_buf    ;   
      else if( Home0_cell_cal_finish    )      
              Z_Pos_home         <=  32'd0;              
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Index_Pos_home        <=  160'd0;  
      else if (  S_AXIS_COMP_Begin )
              Index_Pos_home        <=   S_AXIS_home_Index_buf ;   
      else if(  Home0_cell_cal_finish )      
              Index_Pos_home        <=  160'd0;              
      end 
  //---------------------------------------------------------------      
   localparam [3:0]
           Nei_flow_cnt_RST   = 4'b0001	,
           Nei_flow_cnt_IDLE  = 4'b0010	,
           Nei_flow_cnt_BEGIN = 4'b0100	,
           Nei_flow_cnt_END   = 4'b1000	;
           
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n) begin   
       Nei_flow_cnt_State <= Nei_flow_cnt_RST;
     end 
      else begin 
           case( Nei_flow_cnt_State)  
            Nei_flow_cnt_RST :
                begin
                      Nei_flow_cnt_State  <=Nei_flow_cnt_IDLE;
                end 
            Nei_flow_cnt_IDLE:
                begin
                  if (S_AXIS_COMP_2_Begin)
                      Nei_flow_cnt_State <=Nei_flow_cnt_BEGIN;
                  else
                      Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
                  end 
            Nei_flow_cnt_BEGIN:
                 begin
                     if ( Z_Pos_nei_buf  !=  Z_Pos_buf_nei)
                       Nei_flow_cnt_State <=Nei_flow_cnt_END;
                     else
                       Nei_flow_cnt_State <=Nei_flow_cnt_BEGIN;
                 end 
 
            Nei_flow_cnt_END:
                 begin        
                     if ( Force_Sub_Done)
                      Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
                      
                     else
                       Nei_flow_cnt_State <=Nei_flow_cnt_END;
                 end     
                 
       default:       Nei_flow_cnt_State <=Nei_flow_cnt_IDLE;
     endcase
   end 
 end   
 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
               Z_Pos_nei_buf        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin )
               Z_Pos_nei_buf  <=  Z_Pos_buf_nei ;  
      else if(Force_Sub_Done  )      
               Z_Pos_nei_buf        <=  32'd0;              
      end 
 
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Pos_nei        <=  32'd0;  
      else if (  S_AXIS_COMP_2_Begin )
             X_Pos_nei       <=  X_Pos_buf_nei     ;   
      else if( Force_Sub_Done   )      
              X_Pos_nei        <=  32'd0;              
      end  
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Pos_nei        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin  )
               Y_Pos_nei       <=  Y_Pos_buf_nei ;   
      else if( Force_Sub_Done  )      
              Y_Pos_nei        <=  32'd0;              
      end 
      
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Pos_nei        <=  32'd0;  
      else if (S_AXIS_COMP_2_Begin  )
              Z_Pos_nei         <= Z_Pos_buf_nei   ;   
      else if( Force_Sub_Done  )      
              Z_Pos_nei        <=  32'd0;              
      end 
      
            always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Index_Pos_nei        <=  160'd0;  
      else if (S_AXIS_COMP_2_Begin )
              Index_Pos_nei   <=  S_AXIS_Index_buf  ;   
      else if( Force_Sub_Done  )      
              Index_Pos_nei        <=  160'd0;              
      end 
      
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
            Get_XYZ_delta_en  <= 1'b0;
      else if ( S_AXIS_COMP_2_Begin )
            Get_XYZ_delta_en  <= 1'b1; 
      else     
            Get_XYZ_delta_en  <= 1'b0;              
      end 
   //-------------------------------------------------------
  //  LJ
 //-------------------------------------------------------    
 always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              X_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              X_Sub_en      <= 1'b1;  
      else 
              X_Sub_en      <= 1'b0;               
      end 
     always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Y_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              Y_Sub_en      <= 1'b1;  
      else 
              Y_Sub_en      <= 1'b0;               
      end 
      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
      if (!Sys_Rst_n)    
              Z_Sub_en      <= 1'b0;  
      else if (Get_XYZ_delta_en )
              Z_Sub_en      <= 1'b1;  
      else 
              Z_Sub_en      <= 1'b0;               
      end 
      
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
                    if  ( Force_Sub_Done )        
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
                    if  ( Force_Sub_Done )        
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
            X_Mul_A_out  <= DertaX    ;
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_IDLE)      
            X_Mul_A_out  <= 32'd0;             
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_Mul_B_out  <=  32'd0;         
      else if ( X_Mul_flow_cnt_State  ==X_Mul_flow_cnt_BEGIN)
            X_Mul_B_out  <= DertaX    ;
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
                    if  ( Force_Sub_Done )        
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
                    if  ( Force_Sub_Done )        
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
                    if  ( Force_Sub_Done )        
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
                    if  ( Force_Sub_Done )        
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
                    if  ( Force_Sub_Done )        
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
            M_AXIS_RR_data            <=  95'd0;          
      else if ( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
            M_AXIS_RR_data     <=  {Index_Pos_home,Index_Pos_nei,RR_Add_get_r,DertaX,DertaY,DertaZ}; 
      else   if (  Sqr_RR_flow_cnt_State  ==Sqr_RR_flow_cnt_IDLE)          
            M_AXIS_RR_data             <= 95'd0;       
      end 
         
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
           Sum_rr_done        <=  1'b0;     
      else if( RR_Add_get_vil&&  RR_Add_CNT ==  5'd13  )
           Sum_rr_done        <=  1'b1;  
      else           
           Sum_rr_done        <=  1'b0; 
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
     
     
endmodule
