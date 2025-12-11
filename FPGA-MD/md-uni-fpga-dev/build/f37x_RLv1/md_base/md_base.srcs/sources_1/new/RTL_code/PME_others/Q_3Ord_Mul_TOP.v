`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 04:31:28 PM
// Design Name: 
// Module Name: Q_3Ord_Mul_TOP
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


module Q_3Ord_Mul_TOP # (       
                 parameter  Ngrid_fix                =  32'd64 
  )
(
   input                        Sys_Clk                ,
   input                        Sys_Rst_n              , 
     
   input           [95:0]       atomCoorn_Index         ,   
   input                        Pme_Index_Fraction_Done ,               
   input                        Q_Calculater_en        ,
   input           [31:0]       Q_KKK_get                  ,   
   input                        thetaX_GetBspline_vil  ,
   input                        thetaY_GetBspline_vil  ,
   input                        thetaZ_GetBspline_vil  ,
   input           [127:0]      X_GetBspline           , //bspline  
   input           [127:0]      Y_GetBspline           ,   
   input           [127:0]      Z_GetBspline           ,
   input           [31:0]       Q_get_ADDR                  , 
   output    reg   [31:0]        Q_get_Data                
   
           
    );
localparam  NUMBER_Charge =  64*64*64;
    
reg [31:0]  RAM_Q   [NUMBER_Charge-1:0];
//////////////////////////////////////////////////////////////////////////////////  
 
reg            Refresh_Done;   
reg  [31:0]    Q_KKK;    
reg  [11:0]    write_ram_Cnt;   
//wire  [95:0]    atomCoorn_Index ;

reg [31:0] X_GetBspline_0   ; 
reg [31:0] X_GetBspline_1  ;     
reg [31:0] X_GetBspline_2  ;     
reg [31:0] X_GetBspline_3  ;    
   
reg [31:0] Y_GetBspline_0   ; 
reg [31:0] Y_GetBspline_1  ;     
reg [31:0] Y_GetBspline_2  ;     
reg [31:0] Y_GetBspline_3  ;     
   
reg [31:0] Z_GetBspline_0   ;   
reg [31:0] Z_GetBspline_1  ;    
reg [31:0] Z_GetBspline_2  ;    
reg [31:0] Z_GetBspline_3  ; 

   
reg [31:0]   charge_on_ix0_iy0_iz0_get;
reg [31:0]   charge_on_ix0_iy0_iz1_get;
reg [31:0]   charge_on_ix0_iy0_iz2_get;
reg [31:0]   charge_on_ix0_iy0_iz3_get;   
reg [31:0]   charge_on_ix0_iy1_iz0_get;
reg [31:0]   charge_on_ix0_iy1_iz1_get;
reg [31:0]   charge_on_ix0_iy1_iz2_get;
reg [31:0]   charge_on_ix0_iy1_iz3_get;
reg [31:0]   charge_on_ix0_iy2_iz0_get;   
reg [31:0]   charge_on_ix0_iy2_iz1_get;   
reg [31:0]   charge_on_ix0_iy2_iz2_get;   
reg [31:0]   charge_on_ix0_iy2_iz3_get;    
reg [31:0]   charge_on_ix0_iy3_iz0_get;  
reg [31:0]   charge_on_ix0_iy3_iz1_get;  
reg [31:0]   charge_on_ix0_iy3_iz2_get;  
reg [31:0]   charge_on_ix0_iy3_iz3_get;  
    
reg [31:0]   charge_on_ix1_iy0_iz0_get; 
reg [31:0]   charge_on_ix1_iy0_iz1_get; 
reg [31:0]   charge_on_ix1_iy0_iz2_get; 
reg [31:0]   charge_on_ix1_iy0_iz3_get; 
reg [31:0]   charge_on_ix1_iy1_iz0_get; 
reg [31:0]   charge_on_ix1_iy1_iz1_get; 
reg [31:0]   charge_on_ix1_iy1_iz2_get; 
reg [31:0]   charge_on_ix1_iy1_iz3_get; 
reg [31:0]   charge_on_ix1_iy2_iz0_get; 
reg [31:0]   charge_on_ix1_iy2_iz1_get; 
reg [31:0]   charge_on_ix1_iy2_iz2_get; 
reg [31:0]   charge_on_ix1_iy2_iz3_get; 
reg [31:0]   charge_on_ix1_iy3_iz0_get; 
reg [31:0]   charge_on_ix1_iy3_iz1_get; 
reg [31:0]   charge_on_ix1_iy3_iz2_get; 
reg [31:0]   charge_on_ix1_iy3_iz3_get; 

reg [31:0]   charge_on_ix2_iy0_iz0_get;
reg [31:0]   charge_on_ix2_iy0_iz1_get;
reg [31:0]   charge_on_ix2_iy0_iz2_get;
reg [31:0]   charge_on_ix2_iy0_iz3_get;
reg [31:0]   charge_on_ix2_iy1_iz0_get;
reg [31:0]   charge_on_ix2_iy1_iz1_get;
reg [31:0]   charge_on_ix2_iy1_iz2_get;
reg [31:0]   charge_on_ix2_iy1_iz3_get;
reg [31:0]   charge_on_ix2_iy2_iz0_get;
reg [31:0]   charge_on_ix2_iy2_iz1_get;
reg [31:0]   charge_on_ix2_iy2_iz2_get;
reg [31:0]   charge_on_ix2_iy2_iz3_get;
reg [31:0]   charge_on_ix2_iy3_iz0_get;
reg [31:0]   charge_on_ix2_iy3_iz1_get;
reg [31:0]   charge_on_ix2_iy3_iz2_get;
reg [31:0]   charge_on_ix2_iy3_iz3_get;

reg [31:0]   charge_on_ix3_iy0_iz0_get;
reg [31:0]   charge_on_ix3_iy0_iz1_get;
reg [31:0]   charge_on_ix3_iy0_iz2_get;
reg [31:0]   charge_on_ix3_iy0_iz3_get;
reg [31:0]   charge_on_ix3_iy1_iz0_get;
reg [31:0]   charge_on_ix3_iy1_iz1_get;
reg [31:0]   charge_on_ix3_iy1_iz2_get;
reg [31:0]   charge_on_ix3_iy1_iz3_get;
reg [31:0]   charge_on_ix3_iy2_iz0_get;
reg [31:0]   charge_on_ix3_iy2_iz1_get;
reg [31:0]   charge_on_ix3_iy2_iz2_get;
reg [31:0]   charge_on_ix3_iy2_iz3_get;
reg [31:0]   charge_on_ix3_iy3_iz0_get;
reg [31:0]   charge_on_ix3_iy3_iz1_get;
reg [31:0]   charge_on_ix3_iy3_iz2_get;
reg [31:0]   charge_on_ix3_iy3_iz3_get;    
     
wire [31:0]   charge_on_ix0_iy0_iz0;
wire [31:0]   charge_on_ix0_iy0_iz1;
wire [31:0]   charge_on_ix0_iy0_iz2;
wire [31:0]   charge_on_ix0_iy0_iz3;   
wire [31:0]   charge_on_ix0_iy1_iz0;
wire [31:0]   charge_on_ix0_iy1_iz1;
wire [31:0]   charge_on_ix0_iy1_iz2;
wire [31:0]   charge_on_ix0_iy1_iz3;
wire [31:0]   charge_on_ix0_iy2_iz0;   
wire [31:0]   charge_on_ix0_iy2_iz1;   
wire [31:0]   charge_on_ix0_iy2_iz2;   
wire [31:0]   charge_on_ix0_iy2_iz3;    
wire [31:0]   charge_on_ix0_iy3_iz0;  
wire [31:0]   charge_on_ix0_iy3_iz1;  
wire [31:0]   charge_on_ix0_iy3_iz2;  
wire [31:0]   charge_on_ix0_iy3_iz3;  
     
wire [31:0]   charge_on_ix1_iy0_iz0; 
wire [31:0]   charge_on_ix1_iy0_iz1; 
wire [31:0]   charge_on_ix1_iy0_iz2; 
wire [31:0]   charge_on_ix1_iy0_iz3; 
wire [31:0]   charge_on_ix1_iy1_iz0; 
wire [31:0]   charge_on_ix1_iy1_iz1; 
wire [31:0]   charge_on_ix1_iy1_iz2; 
wire [31:0]   charge_on_ix1_iy1_iz3; 
wire [31:0]   charge_on_ix1_iy2_iz0; 
wire [31:0]   charge_on_ix1_iy2_iz1; 
wire [31:0]   charge_on_ix1_iy2_iz2; 
wire [31:0]   charge_on_ix1_iy2_iz3; 
wire [31:0]   charge_on_ix1_iy3_iz0; 
wire [31:0]   charge_on_ix1_iy3_iz1; 
wire [31:0]   charge_on_ix1_iy3_iz2; 
wire [31:0]   charge_on_ix1_iy3_iz3; 
    
wire [31:0]   charge_on_ix2_iy0_iz0; 
wire [31:0]   charge_on_ix2_iy0_iz1; 
wire [31:0]   charge_on_ix2_iy0_iz2; 
wire [31:0]   charge_on_ix2_iy0_iz3; 
wire [31:0]   charge_on_ix2_iy1_iz0; 
wire [31:0]   charge_on_ix2_iy1_iz1; 
wire [31:0]   charge_on_ix2_iy1_iz2; 
wire [31:0]   charge_on_ix2_iy1_iz3; 
wire [31:0]   charge_on_ix2_iy2_iz0; 
wire [31:0]   charge_on_ix2_iy2_iz1; 
wire [31:0]   charge_on_ix2_iy2_iz2; 
wire [31:0]   charge_on_ix2_iy2_iz3; 
wire [31:0]   charge_on_ix2_iy3_iz0; 
wire [31:0]   charge_on_ix2_iy3_iz1; 
wire [31:0]   charge_on_ix2_iy3_iz2; 
wire [31:0]   charge_on_ix2_iy3_iz3; 
    
wire [31:0]   charge_on_ix3_iy0_iz0; 
wire [31:0]   charge_on_ix3_iy0_iz1; 
wire [31:0]   charge_on_ix3_iy0_iz2; 
wire [31:0]   charge_on_ix3_iy0_iz3; 
wire [31:0]   charge_on_ix3_iy1_iz0; 
wire [31:0]   charge_on_ix3_iy1_iz1; 
wire [31:0]   charge_on_ix3_iy1_iz2; 
wire [31:0]   charge_on_ix3_iy1_iz3; 
wire [31:0]   charge_on_ix3_iy2_iz0; 
wire [31:0]   charge_on_ix3_iy2_iz1; 
wire [31:0]   charge_on_ix3_iy2_iz2; 
wire [31:0]   charge_on_ix3_iy2_iz3; 
wire [31:0]   charge_on_ix3_iy3_iz0; 
wire [31:0]   charge_on_ix3_iy3_iz1; 
wire [31:0]   charge_on_ix3_iy3_iz2; 
wire [31:0]   charge_on_ix3_iy3_iz3;    
    
wire [31:0]   index_ix0_iy0_iz0;
wire [31:0]   index_ix0_iy0_iz1;
wire [31:0]   index_ix0_iy0_iz2;
wire [31:0]   index_ix0_iy0_iz3;   
wire [31:0]   index_ix0_iy1_iz0;
wire [31:0]   index_ix0_iy1_iz1;
wire [31:0]   index_ix0_iy1_iz2;
wire [31:0]   index_ix0_iy1_iz3;
wire [31:0]   index_ix0_iy2_iz0;   
wire [31:0]   index_ix0_iy2_iz1;   
wire [31:0]   index_ix0_iy2_iz2;   
wire [31:0]   index_ix0_iy2_iz3;    
wire [31:0]   index_ix0_iy3_iz0;  
wire [31:0]   index_ix0_iy3_iz1;  
wire [31:0]   index_ix0_iy3_iz2;  
wire [31:0]   index_ix0_iy3_iz3;  
     
wire [31:0]   index_ix1_iy0_iz0; 
wire [31:0]   index_ix1_iy0_iz1; 
wire [31:0]   index_ix1_iy0_iz2; 
wire [31:0]   index_ix1_iy0_iz3; 
wire [31:0]   index_ix1_iy1_iz0; 
wire [31:0]   index_ix1_iy1_iz1; 
wire [31:0]   index_ix1_iy1_iz2; 
wire [31:0]   index_ix1_iy1_iz3; 
wire [31:0]   index_ix1_iy2_iz0; 
wire [31:0]   index_ix1_iy2_iz1; 
wire [31:0]   index_ix1_iy2_iz2; 
wire [31:0]   index_ix1_iy2_iz3; 
wire [31:0]   index_ix1_iy3_iz0; 
wire [31:0]   index_ix1_iy3_iz1; 
wire [31:0]   index_ix1_iy3_iz2; 
wire [31:0]   index_ix1_iy3_iz3; 
    
wire  [31:0]  index_ix2_iy0_iz0; 
wire  [31:0]  index_ix2_iy0_iz1; 
wire  [31:0]  index_ix2_iy0_iz2; 
wire  [31:0]  index_ix2_iy0_iz3; 
wire  [31:0]  index_ix2_iy1_iz0; 
wire  [31:0]  index_ix2_iy1_iz1; 
wire  [31:0]  index_ix2_iy1_iz2; 
wire  [31:0]  index_ix2_iy1_iz3; 
wire  [31:0]  index_ix2_iy2_iz0; 
wire  [31:0]  index_ix2_iy2_iz1; 
wire  [31:0]  index_ix2_iy2_iz2; 
wire  [31:0]  index_ix2_iy2_iz3; 
wire  [31:0]  index_ix2_iy3_iz0; 
wire  [31:0]  index_ix2_iy3_iz1; 
wire  [31:0]  index_ix2_iy3_iz2; 
wire  [31:0]  index_ix2_iy3_iz3; 
    
wire  [31:0]  index_ix3_iy0_iz0; 
wire  [31:0]  index_ix3_iy0_iz1; 
wire  [31:0]  index_ix3_iy0_iz2; 
wire  [31:0]  index_ix3_iy0_iz3; 
wire  [31:0]  index_ix3_iy1_iz0; 
wire  [31:0]  index_ix3_iy1_iz1; 
wire  [31:0]  index_ix3_iy1_iz2; 
wire  [31:0]  index_ix3_iy1_iz3; 
wire  [31:0]  index_ix3_iy2_iz0; 
wire  [31:0]  index_ix3_iy2_iz1; 
wire  [31:0]  index_ix3_iy2_iz2; 
wire  [31:0]  index_ix3_iy2_iz3; 
wire  [31:0]  index_ix3_iy3_iz0; 
wire  [31:0]  index_ix3_iy3_iz1; 
wire  [31:0]  index_ix3_iy3_iz2; 
wire  [31:0]  index_ix3_iy3_iz3; 

wire   Q_Calculater_Done1;
wire   Q_Calculater_Done2;
wire   Q_Calculater_Done3;
wire   Q_Calculater_Done4;
wire   Q_Calculater_Done5;
wire   Q_Calculater_Done6;
wire   Q_Calculater_Done7;
wire   Q_Calculater_Done8;
wire   Q_Calculater_Done9;
wire   Q_Calculater_Done10;
wire   Q_Calculater_Done11;
wire   Q_Calculater_Done12;
wire   Q_Calculater_Done13;
wire   Q_Calculater_Done14;
wire   Q_Calculater_Done15;
wire   Q_Calculater_Done16;

wire   Q_Calculater_Done17;
wire   Q_Calculater_Done18;
wire   Q_Calculater_Done19;
wire   Q_Calculater_Done20;
wire   Q_Calculater_Done21;
wire   Q_Calculater_Done22;
wire   Q_Calculater_Done23;
wire   Q_Calculater_Done24;
wire   Q_Calculater_Done25;
wire   Q_Calculater_Done26;
wire   Q_Calculater_Done27;
wire   Q_Calculater_Done28;
wire   Q_Calculater_Done29;
wire   Q_Calculater_Done30;
wire   Q_Calculater_Done31;
wire   Q_Calculater_Done32;

wire   Q_Calculater_Done33;
wire   Q_Calculater_Done34;
wire   Q_Calculater_Done35;
wire   Q_Calculater_Done36;
wire   Q_Calculater_Done37;
wire   Q_Calculater_Done38;
wire   Q_Calculater_Done39;
wire   Q_Calculater_Done40 ;
wire   Q_Calculater_Done41 ;
wire   Q_Calculater_Done42;
wire   Q_Calculater_Done43;
wire   Q_Calculater_Done44;
wire   Q_Calculater_Done45;
wire   Q_Calculater_Done46;
wire   Q_Calculater_Done47;
wire   Q_Calculater_Done48;

wire   Q_Calculater_Done49;
wire   Q_Calculater_Done50;
wire   Q_Calculater_Done51;
wire   Q_Calculater_Done52;
wire   Q_Calculater_Done53;
wire   Q_Calculater_Done54;
wire   Q_Calculater_Done55;
wire   Q_Calculater_Done56;
wire   Q_Calculater_Done57;
wire   Q_Calculater_Done58;
wire   Q_Calculater_Done59;
wire   Q_Calculater_Done60;
wire   Q_Calculater_Done61;
wire   Q_Calculater_Done62;
wire   Q_Calculater_Done63;
wire   Q_Calculater_Done64;   
   
   
  ////////////////////////////////////////////////////////////////////////////////// 
  //              set all number in RAM Q zero                                    // 
  ////////////////////////////////////////////////////////////////////////////////// 
    integer i;

      always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin    
          for (i=0; i <= NUMBER_Charge; i=i+1)  begin
             RAM_Q[i] <= 64'b0;
          end 
      end    

  ////////////////////////////////////////////////////////////////////////////////// 
    
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Q_KKK                   <=  32'd0;               
      else if ( Q_Calculater_en  )
            Q_KKK                   <= Q_KKK_get;      
      else  if (Q_Calculater_Done1)           
            Q_KKK                   <=  32'd0;                
      end 
   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)  
            Refresh_Done   <= 1'b0;   
     else  if (write_ram_Cnt ==  10'd400)   
            Refresh_Done<= 1'b1;
     else 
            Refresh_Done<= 1'b0; 
   end        
    
  ////////////////////////////////////////////////////////////////////////////////// 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_GetBspline_0            <=  32'd0;               
      else if ( thetaX_GetBspline_vil  )
            X_GetBspline_0            <= X_GetBspline[127:96] ;      
      else  if( Refresh_Done    )
            X_GetBspline_0            <=  32'd0;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_GetBspline_1            <=  32'd0;               
      else if ( thetaX_GetBspline_vil  )
            X_GetBspline_1            <= X_GetBspline[95:64] ;      
      else   if( Refresh_Done    )     
            X_GetBspline_1            <=  32'd0;                
      end   
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_GetBspline_2            <=  32'd0;               
      else if ( thetaX_GetBspline_vil  )
            X_GetBspline_2            <=X_GetBspline[63:32] ;      
      else   if( Refresh_Done    )     
            X_GetBspline_2             <=  32'd0;                
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            X_GetBspline_3            <=  32'd0;               
      else if ( thetaX_GetBspline_vil  )
            X_GetBspline_3            <=X_GetBspline[31:0]  ;      
      else    if( Refresh_Done    )    
            X_GetBspline_3             <=  32'd0;                
      end 
  //////////////////////////////////////////////////////////////////////////////////   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_GetBspline_0             <=  32'd0;               
      else if ( thetaY_GetBspline_vil  )
            Y_GetBspline_0             <= Y_GetBspline[127:96] ;      
      else    if( Refresh_Done    )    
            Y_GetBspline_0             <=  32'd0;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_GetBspline_1            <=  32'd0;               
      else if ( thetaY_GetBspline_vil  )
            Y_GetBspline_1            <= Y_GetBspline[95:64] ;      
      else   if( Refresh_Done    )     
            Y_GetBspline_1            <=  32'd0;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_GetBspline_2            <=  32'd0;               
      else if ( thetaY_GetBspline_vil  )
            Y_GetBspline_2            <=Y_GetBspline[63:32] ;      
      else    if( Refresh_Done    )    
            Y_GetBspline_2             <=  32'd0;                
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Y_GetBspline_3            <=  32'd0;               
      else if ( thetaY_GetBspline_vil  )
            Y_GetBspline_3            <=Y_GetBspline[31:0]  ;      
      else   if( Refresh_Done    )     
            Y_GetBspline_3            <=  32'd0;                
      end 
    //////////////////////////////////////////////////////////////////////////////////   
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_GetBspline_0            <=  32'd0;               
      else if ( thetaZ_GetBspline_vil  )
            Z_GetBspline_0            <= Z_GetBspline[127:96] ;      
      else   if( Refresh_Done    )     
            Z_GetBspline_0             <=  32'd0;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_GetBspline_1            <=  32'd0;               
      else if ( thetaZ_GetBspline_vil  )
            Z_GetBspline_1            <= Z_GetBspline[95:64] ;      
      else   if( Refresh_Done    )     
            Z_GetBspline_1             <=  32'd0;                
      end 
      
  always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_GetBspline_2            <=  32'd0;               
      else if ( thetaZ_GetBspline_vil  )
            Z_GetBspline_2            <=Z_GetBspline[63:32] ;      
      else   if( Refresh_Done    )     
            Z_GetBspline_2            <=  32'd0;                
      end 

   always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
     if (!Sys_Rst_n)    
            Z_GetBspline_3            <=  32'd0;               
      else if ( thetaZ_GetBspline_vil  )
            Z_GetBspline_3            <=Z_GetBspline[31:0]  ;      
      else    if( Refresh_Done    )    
            Z_GetBspline_3            <=  32'd0;                
      end     

  
  
   //////////////////////////////////////////////////////////////////////////////////   
    always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       write_ram_Cnt <=10'd0;
   else if (Q_Calculater_Done1)      
       write_ram_Cnt<= write_ram_Cnt + 10'd1;
   else if (write_ram_Cnt==10'd400)      
       write_ram_Cnt <=10'd0;
   end 

     //////////////////////////////////////////////////////////////////////////////////     

    //--------------------------------------------------------------- 
    //     0    0    0   0
    //--------------------------------------------------------------- 
 

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy0_iz0_get <=32'd0;
   else if (write_ram_Cnt ==  10'd1)      
       charge_on_ix0_iy0_iz0_get<= RAM_Q[index_ix0_iy0_iz0  ];
   else 
       charge_on_ix0_iy0_iz0_get <=32'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
       if (write_ram_Cnt ==  10'd3)   
      RAM_Q[index_ix0_iy0_iz0 ]<= charge_on_ix0_iy0_iz0 + charge_on_ix0_iy0_iz0_get;
   end 
    
    //--------------------------------------------------------------- 
    //    0   0   0   1
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy0_iz1_get <=32'd0;
   else if (write_ram_Cnt ==  10'd5)      
       charge_on_ix0_iy0_iz1_get<= RAM_Q[index_ix0_iy0_iz1  ];
   else 
       charge_on_ix0_iy0_iz1_get <=32'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd7)   
      RAM_Q[index_ix0_iy0_iz1 ]<= charge_on_ix0_iy0_iz1 + charge_on_ix0_iy0_iz1_get;
   end  
    //--------------------------------------------------------------- 
    //     0   0    0    2
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy0_iz2_get <=32'd0;
   else if (write_ram_Cnt ==  10'd9)      
       charge_on_ix0_iy0_iz2_get<= RAM_Q[index_ix0_iy0_iz2 ];
   else 
       charge_on_ix0_iy0_iz2_get <=32'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd11)   
      RAM_Q[index_ix0_iy0_iz2 ]<= charge_on_ix0_iy0_iz2 + charge_on_ix0_iy0_iz2_get;
   end  
   
    //--------------------------------------------------------------- 
    //     0   0    0    3
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy0_iz3_get <=64'd0;
   else if (write_ram_Cnt ==  10'd13)      
       charge_on_ix0_iy0_iz3_get<= RAM_Q[index_ix0_iy0_iz3 ];
   else 
       charge_on_ix0_iy0_iz3_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd15)   
      RAM_Q[index_ix0_iy0_iz3 ]<= charge_on_ix0_iy0_iz3 + charge_on_ix0_iy0_iz3_get;
   end   
   
   
   
    //--------------------------------------------------------------- 
    //     0    0    1   0
    //--------------------------------------------------------------- 
 

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy1_iz0_get <=64'd0;
   else if (write_ram_Cnt ==  10'd1)      
       charge_on_ix0_iy1_iz0_get<= RAM_Q[index_ix0_iy1_iz0  ];
   else 
       charge_on_ix0_iy1_iz0_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
       if (write_ram_Cnt ==  10'd3)   
      RAM_Q[index_ix0_iy1_iz0 ]<= charge_on_ix0_iy1_iz0 + charge_on_ix0_iy1_iz0_get;
   end 
    
    //--------------------------------------------------------------- 
    //    0   0   1   1
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy1_iz1_get <=64'd0;
   else if (write_ram_Cnt ==  10'd5)      
       charge_on_ix0_iy1_iz1_get<= RAM_Q[index_ix0_iy1_iz1  ];
   else 
       charge_on_ix0_iy1_iz1_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd7)   
      RAM_Q[index_ix0_iy1_iz1 ]<= charge_on_ix0_iy1_iz1 + charge_on_ix0_iy1_iz1_get;
   end  
    //--------------------------------------------------------------- 
    //     0   0    1   2
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy1_iz2_get <=64'd0;
   else if (write_ram_Cnt ==  10'd9)      
       charge_on_ix0_iy1_iz2_get<= RAM_Q[index_ix0_iy1_iz2 ];
   else 
       charge_on_ix0_iy1_iz2_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd11)   
      RAM_Q[index_ix0_iy1_iz2 ]<= charge_on_ix0_iy1_iz2 + charge_on_ix0_iy1_iz2_get;
   end  
   
    //--------------------------------------------------------------- 
    //     0   0    1   3
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy1_iz3_get <=64'd0;
   else if (write_ram_Cnt ==  10'd13)      
       charge_on_ix0_iy1_iz3_get<= RAM_Q[index_ix0_iy1_iz3 ];
   else 
       charge_on_ix0_iy1_iz3_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd15)   
      RAM_Q[index_ix0_iy1_iz3 ]<= charge_on_ix0_iy1_iz3 + charge_on_ix0_iy1_iz3_get;
   end   
   
   
   
    //--------------------------------------------------------------- 
    //     0    0    3   0
    //--------------------------------------------------------------- 
 

always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy2_iz0_get <=64'd0;
   else if (write_ram_Cnt ==  10'd1)      
       charge_on_ix0_iy2_iz0_get<= RAM_Q[index_ix0_iy2_iz0  ];
   else 
       charge_on_ix0_iy2_iz0_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
       if (write_ram_Cnt ==  10'd3)   
      RAM_Q[index_ix0_iy2_iz0 ]<= charge_on_ix0_iy2_iz0 + charge_on_ix0_iy2_iz0_get;
   end 
    
    //--------------------------------------------------------------- 
    //    0   0   3  1
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy2_iz1_get <=64'd0;
   else if (write_ram_Cnt ==  10'd5)      
       charge_on_ix0_iy2_iz1_get<= RAM_Q[index_ix0_iy2_iz1  ];
   else 
       charge_on_ix0_iy2_iz1_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd7)   
      RAM_Q[index_ix0_iy2_iz1 ]<= charge_on_ix0_iy2_iz1 + charge_on_ix0_iy2_iz1_get;
   end  
    //--------------------------------------------------------------- 
    //     0   0   3   2
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy2_iz2_get <=64'd0;
   else if (write_ram_Cnt ==  10'd9)      
       charge_on_ix0_iy2_iz2_get<= RAM_Q[index_ix0_iy2_iz2 ];
   else 
       charge_on_ix0_iy2_iz2_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd11)   
      RAM_Q[index_ix0_iy2_iz2 ]<= charge_on_ix0_iy2_iz2 + charge_on_ix0_iy2_iz2_get;
   end  
   
    //--------------------------------------------------------------- 
    //     0   0   3   3
    //--------------------------------------------------------------- 
 
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n) 
       charge_on_ix0_iy2_iz3_get <=64'd0;
   else if (write_ram_Cnt ==  10'd13)      
       charge_on_ix0_iy2_iz3_get<= RAM_Q[index_ix0_iy2_iz3 ];
   else 
       charge_on_ix0_iy2_iz3_get <=64'd0; 
   end 
    
always@(posedge Sys_Clk or negedge Sys_Rst_n)  begin
   if (!Sys_Rst_n)   
     if (write_ram_Cnt ==  10'd15)   
      RAM_Q[index_ix0_iy2_iz3 ]<= charge_on_ix0_iy2_iz3 + charge_on_ix0_iy2_iz3_get;
   end   
   


    //---------------------------------------------------------------//
    //                                                               //
    //---------------------------------------------------------------//     
    //---------------------------------------------------------------//
    //     y   1                                                     //
    //---------------------------------------------------------------// 
 
Q_ONE_Cal_top    U_Q_ix0_iy0_iz0_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n            ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy0_iz0       ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done1      ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0       ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_0        ),
                        
. charge_on_grid         ( charge_on_ix0_iy0_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix0_iy0_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy0_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done2),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_0    ),
.thetaZ_GetBspline       (Z_GetBspline[63:32]        ),
                        
. charge_on_grid         ( charge_on_ix0_iy0_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix0_iy0_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy0_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done3      ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       ( X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_0     ),
.thetaZ_GetBspline       (Z_GetBspline[95:64]        ),
                        
. charge_on_grid         ( charge_on_ix0_iy0_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix0_iy0_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy0_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done4),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_0    ),
.thetaZ_GetBspline       (Z_GetBspline[127:96]        ),
                        
. charge_on_grid         ( charge_on_ix0_iy0_iz3        )
 )    ;     
  
     //--------------------------------------------------------------- 
    //     y 2  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix0_iy1_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy1_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done5),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_1      ),
.thetaZ_GetBspline       (Z_GetBspline_0        ),
                        
. charge_on_grid         ( charge_on_ix0_iy1_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix0_iy1_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy1_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done6),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0 ),
.thetaY_GetBspline       (Y_GetBspline_1      ),
.thetaZ_GetBspline       (Z_GetBspline_1          ),
                        
. charge_on_grid         ( charge_on_ix0_iy1_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix0_iy1_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy1_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done7),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0     ),
.thetaY_GetBspline       (Y_GetBspline_1       ),
.thetaZ_GetBspline       (Z_GetBspline_2         ),
                        
. charge_on_grid         ( charge_on_ix0_iy1_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix0_iy1_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy1_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done8),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_1       ),
.thetaZ_GetBspline       (Z_GetBspline_3            ),
                        
. charge_on_grid         ( charge_on_ix0_iy1_iz3        )          
  );
  
  
                                                      
    //--------------------------------------------------------------- 
    //     y 3  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix0_iy2_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy2_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done9),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_0       ),
                        
. charge_on_grid         ( charge_on_ix0_iy2_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix0_iy2_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy2_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done10),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0           ),
.thetaY_GetBspline       (Y_GetBspline_2          ),
.thetaZ_GetBspline       (Z_GetBspline_1             ),
                        
. charge_on_grid         ( charge_on_ix0_iy2_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix0_iy2_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy2_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done11),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0       ),
.thetaY_GetBspline       (Y_GetBspline_2       ),
.thetaZ_GetBspline       (Z_GetBspline_2          ),
                        
. charge_on_grid         ( charge_on_ix0_iy2_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix0_iy2_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy2_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done12),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0       ),
.thetaY_GetBspline       (Y_GetBspline_2        ),
.thetaZ_GetBspline       (Z_GetBspline_3           ),
                        
. charge_on_grid         ( charge_on_ix0_iy2_iz3        )          
  );
  
   //--------------------------------------------------------------- 
    //     y 4 
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix0_iy3_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy3_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done13),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_3          ),
.thetaZ_GetBspline       (Z_GetBspline_0            ),
                        
. charge_on_grid         ( charge_on_ix0_iy3_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix0_iy3_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy3_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done14),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0         ),
.thetaY_GetBspline       (Y_GetBspline_3         ),
.thetaZ_GetBspline       (Z_GetBspline_1         ),
                        
. charge_on_grid         ( charge_on_ix0_iy3_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix0_iy3_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy3_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done15),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       ( X_GetBspline_0          ),
.thetaY_GetBspline       ( Y_GetBspline_3          ),
.thetaZ_GetBspline       ( Z_GetBspline_2             ),
                        
. charge_on_grid         ( charge_on_ix0_iy3_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix0_iy3_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   (atomCoorn_Index[31:0]   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd3 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix0_iy3_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done       (Q_Calculater_Done16     ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_0      ),
.thetaY_GetBspline       (Y_GetBspline_3       ),
.thetaZ_GetBspline       (Z_GetBspline_3          ),
                        
. charge_on_grid         ( charge_on_ix0_iy3_iz3        )          
  );
  
    //--------------------------------------------------------------- 
    //    x 2   y 1  
    //--------------------------------------------------------------- 
 
Q_ONE_Cal_top    U_Q_ix1_iy0_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy0_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done17),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1          ),
.thetaY_GetBspline       (Y_GetBspline_0         ),
.thetaZ_GetBspline       (Z_GetBspline_0           ),
                        
. charge_on_grid         ( charge_on_ix1_iy0_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix1_iy0_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy0_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done18),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_1         ),
                        
. charge_on_grid         ( charge_on_ix1_iy0_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix1_iy0_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy0_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done19),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_0      ),
.thetaZ_GetBspline       (Z_GetBspline_2        ),
                        
. charge_on_grid         ( charge_on_ix1_iy0_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix1_iy0_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy0_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done20),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_0      ),
.thetaZ_GetBspline       (Z_GetBspline_3        ),
                        
. charge_on_grid         ( charge_on_ix1_iy0_iz3        )
 )    ;     
  
     //--------------------------------------------------------------- 
    //    x 2   y 2  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix1_iy1_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy1_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done21),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1    ),
.thetaY_GetBspline       (Y_GetBspline_1  ),
.thetaZ_GetBspline       (Z_GetBspline_0     ),
                        
. charge_on_grid         ( charge_on_ix1_iy1_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix1_iy1_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy1_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done22),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_1      ),
.thetaZ_GetBspline       (Z_GetBspline_1         ),
                        
. charge_on_grid         ( charge_on_ix1_iy1_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix1_iy1_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy1_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done23),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1      ),
.thetaY_GetBspline       (Y_GetBspline_1     ),
.thetaZ_GetBspline       (Z_GetBspline_2        ),
                        
. charge_on_grid         ( charge_on_ix1_iy1_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix1_iy1_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy1_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_Calculater_Done   (Q_Calculater_Done24),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1        ),
.thetaY_GetBspline       (Y_GetBspline_1     ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix1_iy1_iz3        )          
  );
  
  
                                                      
    //--------------------------------------------------------------- 
    //    x 2   y 3  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix1_iy2_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy2_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_0        ),
                        
. charge_on_grid         ( charge_on_ix1_iy2_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix1_iy2_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy2_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_1         ),
                        
. charge_on_grid         ( charge_on_ix1_iy2_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix1_iy2_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy2_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_2         ),
                        
. charge_on_grid         ( charge_on_ix1_iy2_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix1_iy2_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy2_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix1_iy2_iz3        )          
  );
  
   //--------------------------------------------------------------- 
    //    x 2   y 4 
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix1_iy3_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy3_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1      ),
.thetaY_GetBspline       (Y_GetBspline_3    ),
.thetaZ_GetBspline       (Z_GetBspline_0       ),
                        
. charge_on_grid         ( charge_on_ix1_iy3_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix1_iy3_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy3_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1        ),
.thetaY_GetBspline       (Y_GetBspline_3       ),
.thetaZ_GetBspline       (Z_GetBspline_1          ),
                        
. charge_on_grid         ( charge_on_ix1_iy3_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix1_iy3_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy3_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1      ),
.thetaY_GetBspline       (Y_GetBspline_3    ),
.thetaZ_GetBspline       (Z_GetBspline_2        ),
                        
. charge_on_grid         ( charge_on_ix1_iy3_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix1_iy3_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd1     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd3 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix1_iy3_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_1       ),
.thetaY_GetBspline       (Y_GetBspline_3      ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix1_iy3_iz3        )          
  );                                                     
        
    //--------------------------------------------------------------- 
    //    x 3  y 1  
    //--------------------------------------------------------------- 
 
Q_ONE_Cal_top    U_Q_ix2_iy0_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy0_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_0         ),
                        
. charge_on_grid         ( charge_on_ix2_iy0_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix2_iy0_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy0_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2      ),
.thetaY_GetBspline       (Y_GetBspline_0     ),
.thetaZ_GetBspline       (Z_GetBspline_1        ),
                        
. charge_on_grid         ( charge_on_ix2_iy0_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix2_iy0_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]    +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy0_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_2         ),
                        
. charge_on_grid         ( charge_on_ix2_iy0_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix2_iy0_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy0_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_3          ),
                        
. charge_on_grid         ( charge_on_ix2_iy0_iz3        )
 )    ;     
  
     //--------------------------------------------------------------- 
    //    x 3   y 2  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix2_iy1_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy1_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2         ),
.thetaY_GetBspline       (Y_GetBspline_1        ),
.thetaZ_GetBspline       (Z_GetBspline_0          ),
                        
. charge_on_grid         ( charge_on_ix2_iy1_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix2_iy1_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy1_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2         ),
.thetaY_GetBspline       (Y_GetBspline_1        ),
.thetaZ_GetBspline       (Z_GetBspline_1           ),
                        
. charge_on_grid         ( charge_on_ix2_iy1_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix2_iy1_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy1_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_1       ),
.thetaZ_GetBspline       (Z_GetBspline_2          ),
                        
. charge_on_grid         ( charge_on_ix2_iy1_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix2_iy1_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy1_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_1       ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix2_iy1_iz3        )          
  );
  
  
                                                      
    //--------------------------------------------------------------- 
    //    x 3  y 3  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix2_iy2_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy2_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2         ),
.thetaY_GetBspline       (Y_GetBspline_2       ),
.thetaZ_GetBspline       (Z_GetBspline_0          ),
                        
. charge_on_grid         ( charge_on_ix2_iy2_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix2_iy2_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy2_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_1         ),
                        
. charge_on_grid         ( charge_on_ix2_iy2_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix2_iy2_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy2_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2         ),
.thetaY_GetBspline       (Y_GetBspline_2        ),
.thetaZ_GetBspline       (Z_GetBspline_2           ),
                        
. charge_on_grid         ( charge_on_ix2_iy2_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix2_iy2_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy2_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2       ),
.thetaY_GetBspline       (Y_GetBspline_2      ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix2_iy2_iz3        )          
  );
  
   //--------------------------------------------------------------- 
    //    x 3  y 4 
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix2_iy3_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy3_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_3       ),
.thetaZ_GetBspline       (Z_GetBspline_0         ),
                        
. charge_on_grid         ( charge_on_ix2_iy3_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix2_iy3_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy3_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_3       ),
.thetaZ_GetBspline       (Z_GetBspline_1          ),
                        
. charge_on_grid         ( charge_on_ix2_iy3_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix2_iy3_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy3_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2       ),
.thetaY_GetBspline       (Y_GetBspline_3      ),
.thetaZ_GetBspline       (Z_GetBspline_2        ),
                        
. charge_on_grid         ( charge_on_ix2_iy3_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix2_iy3_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd2     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd3 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix2_iy3_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_2        ),
.thetaY_GetBspline       (Y_GetBspline_3       ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix2_iy3_iz3        )          
  );                
       
   //--------------------------------------------------------------- 
    //    x 4  y 1  
    //--------------------------------------------------------------- 
 
Q_ONE_Cal_top    U_Q_ix3_iy0_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy0_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_0         ),
                        
. charge_on_grid         ( charge_on_ix3_iy0_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix3_iy0_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3  ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy0_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3        ),
.thetaY_GetBspline       (Y_GetBspline_0       ),
.thetaZ_GetBspline       (Z_GetBspline_1          ),
                        
. charge_on_grid         ( charge_on_ix3_iy0_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix3_iy0_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3   ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy0_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3      ),
.thetaY_GetBspline       (Y_GetBspline_0     ),
.thetaZ_GetBspline       (Z_GetBspline_2       ),
                        
. charge_on_grid         ( charge_on_ix3_iy0_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix3_iy0_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy0_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3       ),
.thetaY_GetBspline       (Y_GetBspline_0      ),
.thetaZ_GetBspline       (Z_GetBspline_3        ),
                        
. charge_on_grid         ( charge_on_ix3_iy0_iz3        )
 )    ;     
  
     //--------------------------------------------------------------- 
    //   x 4   y 2  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix3_iy1_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy1_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3         ),
.thetaY_GetBspline       (Y_GetBspline_1       ),
.thetaZ_GetBspline       (Z_GetBspline_0          ),
                        
. charge_on_grid         ( charge_on_ix3_iy1_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix3_iy1_iz1_top(                    
.Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd1  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy1_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3     ),
.thetaY_GetBspline       (Y_GetBspline_1    ),
.thetaZ_GetBspline       (Z_GetBspline_1       ),
                        
. charge_on_grid         ( charge_on_ix3_iy1_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix3_iy1_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]   + 32'd1     ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]   + 32'd2     ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy1_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3      ),
.thetaY_GetBspline       (Y_GetBspline_1  ),
.thetaZ_GetBspline       (Z_GetBspline_2     ),
                        
. charge_on_grid         ( charge_on_ix3_iy1_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix3_iy1_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]  + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd1     ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd3     ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy1_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3   ),
.thetaY_GetBspline       (Y_GetBspline_1  ),
.thetaZ_GetBspline       (Z_GetBspline_3      ),
                        
. charge_on_grid         ( charge_on_ix3_iy1_iz3        )          
  );
  
  
                                                      
    //--------------------------------------------------------------- 
    //   x 4  y 3  
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix3_iy2_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]   + 32'd2     ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy2_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3      ),
.thetaY_GetBspline       (Y_GetBspline_2    ),
.thetaZ_GetBspline       (Z_GetBspline_0     ),
                        
. charge_on_grid         ( charge_on_ix3_iy2_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix3_iy2_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd2  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy2_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3       ),
.thetaY_GetBspline       (Y_GetBspline_2     ),
.thetaZ_GetBspline       (Z_GetBspline_1       ),
                        
. charge_on_grid         ( charge_on_ix3_iy2_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix3_iy2_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] +32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy2_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3        ),
.thetaY_GetBspline       (Y_GetBspline_2       ),
.thetaZ_GetBspline       (Z_GetBspline_2        ),
                        
. charge_on_grid         ( charge_on_ix3_iy2_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix3_iy2_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd2 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  +32'd3),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy2_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3        ),
.thetaY_GetBspline       (Y_GetBspline_2     ),
.thetaZ_GetBspline       (Z_GetBspline_3         ),
                        
. charge_on_grid         ( charge_on_ix3_iy2_iz3        )          
  );
  
   //--------------------------------------------------------------- 
    //   x 4  y 4 
    //--------------------------------------------------------------- 
  
   
Q_ONE_Cal_top    U_Q_ix3_iy3_iz0_top(                    
 .  Sys_Clk               (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy3_iz0                   ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3       ),
.thetaY_GetBspline       (Y_GetBspline_3      ),
.thetaZ_GetBspline       (Z_GetBspline_0      ),
                        
. charge_on_grid         ( charge_on_ix3_iy3_iz0         )          
                                                       
       );                                             
 
Q_ONE_Cal_top    U_Q_ix3_iy3_iz1_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32] + 32'd3  ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64] + 32'd1  ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy3_iz1                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3    ),
.thetaY_GetBspline       (Y_GetBspline_3   ),
.thetaZ_GetBspline       (Z_GetBspline_1      ),
                        
. charge_on_grid         ( charge_on_ix3_iy3_iz1        )          
                                                       
       );     
 
Q_ONE_Cal_top    U_Q_ix3_iy3_iz2_top(                    
.Sys_Clk                  (  Sys_Clk               ),
.Sys_Rst_n                (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd2 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy3_iz2                  ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3       ),
.thetaY_GetBspline       (Y_GetBspline_3     ),
.thetaZ_GetBspline       (Z_GetBspline_2     ),
                        
. charge_on_grid         ( charge_on_ix3_iy3_iz2        )          
                                                       
       );    
     
Q_ONE_Cal_top    U_Q_ix3_iy3_iz3_top(                    
.Sys_Clk                 (  Sys_Clk               ),
.Sys_Rst_n               (  Sys_Rst_n               ),
                     
.atomCoorn_Index_X_fix   ( atomCoorn_Index[31:0]   + 32'd3     ),
.atomCoorn_Index_Y_fix   (atomCoorn_Index[63:32]  + 32'd3 ),
.atomCoorn_Index_Z_fix   (atomCoorn_Index[95:64]  + 32'd3 ),
.Ngrid_fix               (Ngrid_fix               ),
                         
.index                   (index_ix3_iy3_iz3                 ),
                         
.Q_Calculater_en         (Q_Calculater_en         ),
.Q_KKK                   (Q_KKK                   ),
.thetaX_GetBspline_vil   (thetaX_GetBspline_vil   ),
.thetaY_GetBspline_vil   (thetaY_GetBspline_vil   ),
.thetaZ_GetBspline_vil   (thetaZ_GetBspline_vil   ),
.thetaX_GetBspline       (X_GetBspline_3      ),
.thetaY_GetBspline       (Y_GetBspline_3     ),
.thetaZ_GetBspline       (Z_GetBspline_3        ),
                        
. charge_on_grid         ( charge_on_ix3_iy3_iz3        )          
  );                      

endmodule
