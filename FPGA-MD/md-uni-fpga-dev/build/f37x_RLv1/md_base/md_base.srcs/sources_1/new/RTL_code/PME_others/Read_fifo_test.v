`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2022 08:05:15 AM
// Design Name: 
// Module Name: Read_fifo_test
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


module Read_fifo_test(
        input                          Sys_Clk,
        input                          Sys_Rst_n , 
        input                          Test_en,  //just for test ,write data to ram
        
       // input                        S_AXIS_ram_rd_en   ,                     //read from pinpang module to subram
        input              [11  : 0]   S_AXIS_ram_Rd_addr ,
        output     wire    [255 : 0]   S_AXIS_ram_rd_data ,         
        output     reg                 M_AXIS_New_tDone                         // write to pingpangram
    );

//==========================================================================================================     
reg               PingP_wea               ;  
reg  [11  : 0]    PingP_addra             ;
reg  [255 : 0]    PingP_dina              ; 
reg  [11  : 0]    Wr_Pos_cnt              ;
reg  [3   : 0]    Wr_flow_cnt             ;
//==========================================================================================================  
parameter example0 =   256'H0001AAAA_AA00001A_AAAAAAAA_AAAAAAAA_AAAAAAAA_406CCCCC_41400000_41400000 ;  
parameter example1 =   256'H0002AAAA_AA00001AAA_AAAAAAAAAA_AAAAAAAAAA_AA406CCCCC_4140000041_400000 ;
parameter example2 =   256'H0003AAAA_AA00002AAA_AAAAAAAAAA_AAAAAAAAAA_AA416CCCCC_4130000041_300000 ;
parameter example3 =   256'H0004AAAA_AA00003AAA_AAAAAAAAAA_AAAAAAAAAA_AA426CCCCC_4140000041_400000 ;
parameter example4 =   256'H0005AAAA_AA00004AAA_AAAAAAAAAA_AAAAAAAAAA_AA436CCCCC_4130000041_300000 ;
parameter example5 =   256'H0006AAAA_AA00005AAA_AAAAAAAAAA_AAAAAAAAAA_AA446CCCCC_4150000041_500000 ;
parameter example6 =   256'H0007AAAA_AA00006AAA_AAAAAAAAAA_AAAAAAAAAA_AA456CCCCC_4130000041_300000 ;
parameter example7 =   256'H0008AAAA_AA00007AAA_AAAAAAAAAA_AAAAAAAAAA_AA466CCCCC_4160000041_600000 ;
parameter example8 =   256'H0009AAAA_AA00008AAA_AAAAAAAAAA_AAAAAAAAAA_AA416CCCCC_4170000041_700000 ;
parameter example9 =   256'H000AAAAA_AA00009AAA_AAAAAAAAAA_AAAAAAAAAA_AA426CCCCC_4180000041_800000 ;
parameter example10 =  256'H000BAAAA_AA0000AAAA_AAAAAAAAAA_AAAAAAAAAA_AA436CCCCC_4190000041_900000 ;
parameter example11 =  256'H000CAAAA_AA0000BAAA_AAAAAAAAAA_AAAAAAAAAA_AA446CCCCC_41B0000041_B00000 ;
parameter example12 =  256'H000DAAAA_AA0000CAAA_AAAAAAAAAA_AAAAAAAAAA_AA456CCCCC_41C0000041_C00000 ;
parameter example13 =  256'H000EAAAA_AA0000DAAA_AAAAAAAAAA_AAAAAAAAAA_AA466CCCCC_41D0000041_D00000 ;//from -> x y z
//-----------------------------------------------------------------------------------------------//
//                        WR pinpang ram   (Test)                                                //
//-----------------------------------------------------------------------------------------------//

always@(posedge Sys_Clk or negedge Sys_Rst_n) begin
       if (!Sys_Rst_n) begin
          Wr_flow_cnt        <=   3'd0 ; 
          PingP_wea          <=   1'b0 ;
          PingP_addra        <=  12'd0 ;
          PingP_dina         <= 255'd0 ;
          M_AXIS_New_tDone   <=   1'b0 ;
          Wr_Pos_cnt         <=  12'd0 ; 

       end 
 else begin
       case(Wr_flow_cnt)    
           3'd0: begin 
                            PingP_wea              <=   1'b0 ;                     
                            PingP_addra            <=  12'd0 ;    
                            PingP_dina             <= 255'd0 ;    
                            M_AXIS_New_tDone       <=   1'b0 ;    
                            Wr_Pos_cnt             <=  12'd0 ; 
                        if( Test_en ) begin              
                            PingP_wea              <=   1'b1 ;                         
                            Wr_flow_cnt            <=   Wr_flow_cnt+  1'b1;                        
                        end 
                 else
                            Wr_flow_cnt            <=    Wr_flow_cnt;
                 end 
               
            3'd1: begin    
                        if (Wr_Pos_cnt == 12'd80) begin                                                     
                              Wr_flow_cnt         <= 3'd3; 
                            end 
                       else if (Wr_Pos_cnt >= 12'd75 ) 
                              begin   
                              PingP_dina             <= example0;                                                                                                                 
                              Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;         
                             end                                                   
                        else if (Wr_Pos_cnt >= 12'd70 ) 
                              begin   
                              PingP_dina             <= example1;                                                                                                                 
                              Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;         
                             end
                        else if (Wr_Pos_cnt >= 12'd65 ) 
                           begin
                               PingP_dina             <= example2;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end  
                        else  if (Wr_Pos_cnt >= 12'd60 ) 
                           begin
                               PingP_dina             <= example3;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end   
                        else if (Wr_Pos_cnt >= 12'd55 ) 
                           begin
                               PingP_dina             <= example4;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end      
                        else if (Wr_Pos_cnt >= 12'd50 ) 
                           begin
                               PingP_dina             <= example5;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end                                   
                        else if (Wr_Pos_cnt >= 12'd45 ) 
                            begin
                               PingP_dina             <= example6;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                        else if (Wr_Pos_cnt >= 12'd40 ) 
                            begin
                               PingP_dina             <= example7;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                        else if (Wr_Pos_cnt >= 12'd35 ) 
                            begin
                               PingP_dina             <= example8;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                        else if (Wr_Pos_cnt >= 12'd25 ) 
                            begin
                               PingP_dina             <= example9;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                        else if (Wr_Pos_cnt >= 12'd20 ) 
                            begin
                               PingP_dina             <= example10;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                         else if (Wr_Pos_cnt >= 12'd15 ) 
                            begin
                               PingP_dina             <= example11;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                         else if (Wr_Pos_cnt >= 12'd5 ) 
                            begin
                               PingP_dina             <= example12;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                         else if(Wr_Pos_cnt < 12'd5 )
                            begin
                               PingP_dina             <= example13;    
                               Wr_flow_cnt           <= Wr_flow_cnt+  1'b1;           
                           end
                  end  
            3'd2: begin     
                             PingP_addra          <=  PingP_addra + 1'b1;   
                             Wr_Pos_cnt           <=  Wr_Pos_cnt  + 1'b1;
                             Wr_flow_cnt          <=  3'd1  ;         
                   end 
            3'd3:  begin   
                       
                            M_AXIS_New_tDone      <=   1'b1 ;           ////write finish 
                            Wr_flow_cnt           <=   3'd0;
                    end

            default:        Wr_flow_cnt           <=   3'd0;   
     endcase
   end 
end     


 
 Test_ram U_PinPang_Ram_IN (
  .clka (        Sys_Clk                 ),              // input wire clka
  .ena  (        Sys_Rst_n               ),              // input wire ena
  .wea  (        PingP_wea               ),              // input wire [0 : 0] wea
  .addra(        PingP_addra             ),              // input wire [11 : 0] addra
  .dina (        PingP_dina              ),              // input wire [223 : 0] dina
  .clkb (        Sys_Clk                 ),               // input wire clkb
  .enb  (        Sys_Rst_n               ),               // input wire enb
  .addrb(        S_AXIS_ram_Rd_addr      ),       // input wire [11 : 0] addrb
  .doutb(        S_AXIS_ram_rd_data      )        // output wire [223 : 0] doutb
);    
    
endmodule