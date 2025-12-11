`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 12:18:05 PM
// Design Name: 
// Module Name: Bond_AXI_WR
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


module Bond_AXI_WR(
    input							           sys_clk					,
    input							           sys_rst					,

	input							           Bond_axi_awready				,
 	output	reg 				               Bond_axi_awvalid				,
 	output reg	[35:0]		                   Bond_axi_awaddr				, 
 	input							           Bond_axi_wready				,
 	output reg	[255:0]		                   Bond_axi_wdata				,
 	output	reg					               Bond_axi_wvalid			    ,
 	output	reg					               Bond_axi_wlast		        ,
 	input							           Bond_axi_arready				,	
    output	reg			         	           Bond_axi_arvalid				,  
 	output	reg   [35:0]		               Bond_axi_araddr				,
    output						               Bond_axi_rready			    ,
 	input	     [255:0]		               Bond_axi_rdata				,	
 	input					                   Bond_axi_rvalid			    ,	 
    input					                   Bond_axi_rlast				, 
    output	reg                                Bond_axi_bready    =1         , 
    input                                      Bond_axi_bresp                , 
    input                                      Bond_axi_bvalid               ,
    
    input							           Angle_axi_awready			,                                  
 	output	reg 				               Angle_axi_awvalid		    ,                          
 	output reg	[35:0]		                   Angle_axi_awaddr				,                   
 	input							           Angle_axi_wready				,                                  
 	output reg	[255:0]		                   Angle_axi_wdata				,                   
 	output	reg					               Angle_axi_wvalid			    ,                        
 	output	reg					               Angle_axi_wlast		        ,                      
 	input							           Angle_axi_arready			,	                                
    output	reg			         	           Angle_axi_arvalid			,                    
 	output	reg   [35:0]		               Angle_axi_araddr				,                     
    output						               Angle_axi_rready			    ,                         
 	input	     [255:0]		               Angle_axi_rdata				,	                      
 	input					                   Angle_axi_rvalid			    ,	                        
    input					                   Angle_axi_rlast				,                           
    output	reg                                Angle_axi_bready    =1        ,  
    input                                      Angle_axi_bresp               , 
    input                                      Angle_axi_bvalid              , 
    
    input							           DIR_axi_awready			,                                
 	output	reg 				               DIR_axi_awvalid		    ,                        
 	output reg	[35:0]		                   DIR_axi_awaddr				,                   
 	input							           DIR_axi_wready				,                                  
 	output reg	[255:0]		                   DIR_axi_wdata				,                   
 	output	reg					               DIR_axi_wvalid			    ,                        
 	output	reg					               DIR_axi_wlast		        ,                      
 	input							           DIR_axi_arready			,	                                 
    output	reg			         	           DIR_axi_arvalid			,                     
 	output	reg   [35:0]		               DIR_axi_araddr				,                     
    output						               DIR_axi_rready			    ,                         
 	input	     [255:0]		               DIR_axi_rdata				,	                      
 	input					                   DIR_axi_rvalid			    ,	                        
    input					                   DIR_axi_rlast				,                           
    output	reg                                DIR_axi_bready    =1        ,   
    input                                      DIR_axi_bresp               ,  
    input                                      DIR_axi_bvalid              ,  
    
    input							           Index_axi_awready			,                                
 	output	reg 				               Index_axi_awvalid		    ,                        
 	output reg	[35:0]		                   Index_axi_awaddr				,                   
 	input							           Index_axi_wready				,                                  
 	output reg	[255:0]		                   Index_axi_wdata				,                   
 	output	reg					               Index_axi_wvalid			    ,                        
 	output	reg					               Index_axi_wlast		        ,                      
 	input							           Index_axi_arready			,	                                 
    output	reg			         	           Index_axi_arvalid			,                     
 	output	reg   [35:0]		               Index_axi_araddr				,                     
    output						               Index_axi_rready			    ,                         
 	input	     [255:0]		               Index_axi_rdata				,	                      
 	input					                   Index_axi_rvalid			    ,	                        
    input					                   Index_axi_rlast				,                           
    output	reg                                Index_axi_bready    =1        ,   
    input                                      Index_axi_bresp               ,  
    input                                      Index_axi_bvalid             
    );            
    
    
 reg              Index_araddr_en; 
 reg              Index_addr_en;
 reg   [15:0]	  Index_addr_get;
  reg   [15:0]	  Index_addr;
 reg   [15:0]	  Index_valid_cnt;
 
 reg   [15:0]	  BURST_LEN;
 reg              Index_read_Begin;
 reg              Index_begin_en;
 
  reg             Index_LEN_DONE;
  
  reg   [255:0]	   read_rom[63:0];
  reg   [15:0]	   read_datain_cnt;
  reg   [15:0]	   read_ram_aradder;
  reg   [255:0]	   read_ram_dout;
  
  reg              Bond_LEN_DONE;
  reg   [15:0]	   Bond_axi_CNT;
  reg   [15:0]	   Bond_valid_cnt;
  reg              Bond_araddr_en;
  reg   [15:0]	   Bond_axi_get;
  reg              Bond_axi_Begin;
  reg              Bond_axi_begin_en;
  reg              Bond_axi_addr_en;
  reg   [15:0]	   Bond_axi_addr_get;
  wire   [15:0]    Bond_axi_addr;
  
  reg              Angle_LEN_DONE;
  reg   [15:0]	   Angle_axi_CNT;
  reg   [15:0]	   Angle_valid_cnt;
  reg              Angle_araddr_en;
  reg   [15:0]	   Angle_axi_get;
  reg              Angle_axi_Begin;
  reg              Angle_axi_begin_en;
  reg              Angle_axi_addr_en;
  reg   [15:0]	   Angle_axi_addr_get;
  wire   [15:0]    Angle_axi_addr;
  
  reg              DIR_LEN_DONE;
  reg   [15:0]	   DIR_axi_CNT;
  reg   [15:0]	   DIR_valid_cnt;
  reg              DIR_araddr_en;
  reg   [15:0]	   DIR_axi_get;
  reg              DIR_axi_Begin;
  reg              DIR_axi_begin_en;
  reg              DIR_axi_addr_en;
  reg   [15:0]	   DIR_axi_addr_get;
  wire   [15:0]    DIR_axi_addr;
  
 reg   [4:0]	   cnt_last;
 reg               Index_awaddr_en;
 reg   [15:0]	   Index_ram_WR_addr;
 reg               Update_ALL_Force_Ram_done;
 
 reg   [15:0]	   ram_WR_addr;
 reg   [255:0]     Index_ram_WR_data;
 reg   [15:0]      Home_force_num;
  ////////////////////////////////////////////////////////////////////////////////
  
	assign	 Index_axi_rready  =   Index_axi_rvalid			;
	assign	 Bond_axi_rready   =   Bond_axi_rvalid			;
	assign	 Angle_axi_rready  =   Angle_axi_rvalid			;
	assign	 DIR_axi_rready    =    DIR_axi_rvalid			;
 
	
	
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////״̬��/////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam	[8:0]
					Index_Rd_state_RESET	      = 8'b00000001	,
					Index_Rd_state_IDLE	    	   = 8'b00000010	,													
					Index_Rd_state_READ		       = 8'b00000100	,
					Index_Rd_state_READ_Wait      = 8'b00001000	,
					Index_Rd_state_ADDR           = 8'b00010000	,
					Index_Rd_state_RSTART         = 8'b00100000	,
					Index_Rd_state_CAL_START      = 8'b01000000	,
					Index_Rd_state_END            = 8'b10000000	;
                        
reg		[8:0]	Index_read_state			;          


 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if(	sys_rst )
			Index_read_state <= Index_Rd_state_RESET	;
		else
		begin

			case ( Index_read_state )
			 Index_Rd_state_RESET	:
				begin
						Index_read_state = Index_Rd_state_IDLE	;
				end
				
			 Index_Rd_state_IDLE	:
				begin
					 if (  Index_read_Begin )
						Index_read_state = Index_Rd_state_READ	;
					else
						Index_read_state = Index_Rd_state_IDLE	;
				end
				
			 Index_Rd_state_READ	:
                begin
 					 if (  	Index_LEN_DONE) // 000 200 400 600
						 Index_read_state = Index_Rd_state_CAL_START	;
					 else if( Index_araddr_en )
				         Index_read_state = Index_Rd_state_READ_Wait	;
					 else
						 Index_read_state = Index_Rd_state_READ	;
				end	
			  Index_Rd_state_READ_Wait	:
                begin
					 if ( Index_axi_rvalid) // 000 200 400 600
						Index_read_state = Index_Rd_state_ADDR	;						
					else
						Index_read_state = Index_Rd_state_READ_Wait	;
				end	
		 
			  Index_Rd_state_ADDR	:   
                begin
					 if ( Index_axi_rlast 	)    //
						Index_read_state = Index_Rd_state_RSTART	;
					 		 
					else
						Index_read_state = Index_Rd_state_ADDR	;
				end
			  Index_Rd_state_RSTART	:
                begin
					 if ( Index_axi_arready 	)
						Index_read_state = Index_Rd_state_READ	;
			
					else
						Index_read_state = Index_Rd_state_RSTART	;
				end	
				
			  Index_Rd_state_CAL_START:		
                begin					 
						Index_read_state = Index_Rd_state_END	;			 
				end
				
			  Index_Rd_state_END:		
                begin	
                	if (Index_addr_en)	 
						Index_read_state = Index_Rd_state_READ	;
		
					else 
						Index_read_state = Index_Rd_state_END;			 
				end					
				default			:                      		
						Index_read_state = Index_Rd_state_IDLE		;  		
			endcase

		end
	end	

 
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
			     Index_valid_cnt	<= 16'd0;
		else if  (Index_valid_cnt	== (BURST_LEN ))  
			     Index_valid_cnt	<= 16'd0;
		else if   ((Index_read_state == Index_Rd_state_READ) && (Index_valid_cnt	<=  BURST_LEN ) ) 
			     Index_valid_cnt	<= Index_valid_cnt + 16'd1  ;
	end  
  	
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Index_begin_en<= 1'b0 ;     
        else if (Index_read_state == Index_Rd_state_CAL_START	 )    
                 Index_begin_en<= 1'b1 ;
        else             
                 Index_begin_en<= 1'b0 ;     
        end      
 
  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		     	 Index_LEN_DONE	<= 1'd0;
		else if  (Index_valid_cnt[6:0]	== 7'b1111111)  
		    	 Index_LEN_DONE	<= 1'd1;
		else 
		    	 Index_LEN_DONE	<= 1'd0;
	end  
  
 		
		  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Index_addr_get	<= 14'd0;
		else if(  Index_addr_en )  
			     Index_addr_get  <=  Index_addr   ; 
		else if (Index_LEN_DONE)
	             Index_addr_get	<= 14'd0;
	  else if ( 	Index_read_state == Index_Rd_state_IDLE		)
	             Index_addr_get	<= 14'd0;
	end 
 
always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Index_araddr_en	<= 1'b0;
		else if ( (   Index_valid_cnt[4:0] ==  5'b11111 )   )
			     Index_araddr_en  <= 1'b1;	  
		else 
	             Index_araddr_en	<= 1'b0;
	end    
         
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Index_axi_arvalid<= 1'b0 ;     
        else if ( 	Index_araddr_en )    
                 Index_axi_arvalid<= 1'b1 ;
        else             
                 Index_axi_arvalid<= 1'b0 ;     
        end 
        
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	    Index_axi_araddr	<= 36'd0;
	  	else if( Index_araddr_en   )  
		        Index_axi_araddr  =    {17'b0,  Index_valid_cnt[13:5] ,5'h0,4'h0}	+  
		                               {17'b0,  Index_addr_get[13:5]  ,5'h0,4'h0}   ;		                          		    		      
	    else
	            Index_axi_araddr	<= 36'd0;
	end    
  ///////////////////////////////////////////////////////////////////////////////  
/////////////////////////////read write data fifo//////////////////////////////  
///////////////////////////////////////////////////////////////////////////////  
 always@(posedge sys_clk or negedge sys_rst) 
	begin
	  if( Bond_axi_rvalid )
	        read_rom[read_datain_cnt[13:0]] <= Bond_axi_rdata;
	end
	
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
			read_datain_cnt	    <= 14'd0;
	    else if(Bond_axi_rvalid && ( read_datain_cnt[3:0]<= 15'd15 ))
	        read_datain_cnt     <= read_datain_cnt +1'b1;	    
	    else if  (read_datain_cnt	>= 15'd63)  
	      	read_datain_cnt  	<= 14'd0;
	end

 always@(posedge sys_clk or negedge sys_rst) 
	begin  
	        read_ram_dout <= read_rom[ read_ram_aradder];
	end  
////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////״̬��/////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam	[8:0]
					Bond_Rd_state_RESET	    	= 8'b00000001	,
					Bond_Rd_state_IDLE	    	= 8'b00000010	,													
					Bond_Rd_state_READ		    = 8'b00000100	,
					Bond_Rd_state_READ_Wait      = 8'b00001000	,
					Bond_Rd_state_ADDR           = 8'b00010000	,
					Bond_Rd_state_RSTART         = 8'b00100000	,
					Bond_Rd_state_CAL_START      = 8'b01000000	,
					Bond_Rd_state_END            = 8'b10000000	;
                        
reg		[8:0]	Bond_read_state			;          


 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if(	sys_rst )
			Bond_read_state <= Bond_Rd_state_RESET	;
		else
		begin

			case ( Bond_read_state )
			 Bond_Rd_state_RESET	:
				begin
						Bond_read_state = Bond_Rd_state_IDLE	;
				end
				
			 Bond_Rd_state_IDLE	:
				begin
					 if ( Bond_axi_Begin )
						Bond_read_state = Bond_Rd_state_READ	;
					else
						Bond_read_state = Bond_Rd_state_IDLE	;
				end
				
			 Bond_Rd_state_READ	:
                begin
 					 if ( Bond_LEN_DONE) // 000 200 400 600
						 Bond_read_state = Bond_Rd_state_CAL_START	;
					 else if( Bond_araddr_en )
				         Bond_read_state = Bond_Rd_state_READ_Wait	;
					 else
						 Bond_read_state = Bond_Rd_state_READ	;
				end	
			  Bond_Rd_state_READ_Wait	:
                begin
					 if ( Bond_axi_rvalid) // 000 200 400 600
						Bond_read_state = Bond_Rd_state_ADDR	;						
					else
						Bond_read_state = Bond_Rd_state_READ_Wait	;
				end	
		 
			  Bond_Rd_state_ADDR	:   
                begin
					 if ( Bond_axi_rlast 	)    //
						Bond_read_state = Bond_Rd_state_RSTART	;
					 		 
					else
						Bond_read_state = Bond_Rd_state_ADDR	;
				end
			  Bond_Rd_state_RSTART	:
                begin
					 if ( Bond_axi_arready 	)
						Bond_read_state = Bond_Rd_state_READ	;
			
					else
						Bond_read_state = Bond_Rd_state_RSTART	;
				end	
				
			  Bond_Rd_state_CAL_START:		
                begin					 
						Bond_read_state = Bond_Rd_state_END	;			 
				end
				
			  Bond_Rd_state_END:		
                begin	
                	if (Bond_axi_CNT == 200)	 
						Bond_read_state = Bond_Rd_state_READ	;
    			
					else 
						Bond_read_state = Bond_Rd_state_END;			 
				end					
				default			:                      		
						Bond_read_state = Bond_Rd_state_IDLE		;  		
			endcase

		end
	end	

 
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
			     Bond_valid_cnt	<= 16'd0;
		else if  (Bond_valid_cnt	== (BURST_LEN ))  
			     Bond_valid_cnt	<= 16'd0;
		else if   ((Bond_read_state == Bond_Rd_state_READ) && (Bond_valid_cnt	<=  BURST_LEN ) ) 
			     Bond_valid_cnt	<= Bond_valid_cnt + 16'd1  ;
	end  
  	
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Bond_axi_begin_en<= 1'b0 ;     
        else if (Bond_read_state == Bond_Rd_state_CAL_START	 )    
                 Bond_axi_begin_en<= 1'b1 ;
        else             
                 Bond_axi_begin_en<= 1'b0 ;     
        end 
        
 
  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		     	 Bond_LEN_DONE	<= 1'd0;
		else if  (Bond_valid_cnt[6:0]	== 7'b1111111)  
		    	 Bond_LEN_DONE	<= 1'd1;
		else 
		    	 Bond_LEN_DONE	<= 1'd0;
	end  
		
		  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Bond_axi_addr_get	<= 14'd0;
		else if( Bond_axi_addr_en )  
			     Bond_axi_addr_get  <=  Bond_axi_addr  ; 
		else if (Bond_LEN_DONE)
	             Bond_axi_addr_get	<= 14'd0;
	  else if (Bond_read_state == Bond_Rd_state_IDLE)
	             Bond_axi_addr_get	<= 14'd0;
	end 	  
	
			  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Bond_axi_Begin	<= 1'd0;
		else if( Bond_axi_addr_en )  
			     Bond_axi_Begin  <=  1'd1;    
		else if (Bond_LEN_DONE)
	         	 Bond_axi_Begin	<= 1'd0;
	    else if (Bond_read_state == Bond_Rd_state_IDLE)
	             Bond_axi_Begin	<= 1'd0;
	end 	 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Bond_axi_CNT	<= 14'd0;
		else if(( Bond_axi_Begin > 0) &&( Bond_axi_CNT <= 14'd200  ))  
			     Bond_axi_CNT  <=  Bond_axi_CNT +1'd1; 
		else
	             Bond_axi_CNT	<= 14'd0;
	end 	  
 
always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Bond_araddr_en	<= 1'b0;
		else if ( (   Bond_valid_cnt[4:0] ==  5'b11111 )   )
			     Bond_araddr_en  <= 1'b1;	  
		else 
	             Bond_araddr_en	<= 1'b0;
	end    
         
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Bond_axi_arvalid<= 1'b0 ;     
        else if ( 	Bond_araddr_en )    
                 Bond_axi_arvalid<= 1'b1 ;
        else             
                 Bond_axi_arvalid<= 1'b0 ;     
        end 
        
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	  Bond_axi_araddr	<= 36'd0;
	  	else if( Bond_araddr_en   )  
		      Bond_axi_araddr  =    {17'b0,  Bond_valid_cnt[13:5] ,5'h0,4'h0}	+  
		                            {17'b0,  Bond_axi_get[13:5]   ,5'h0,4'h0}   ;		                	                      		    		      
	    else
	          Bond_axi_araddr	<= 36'd0;
	end    
 ////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////״̬��/////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam	[8:0]
					Angle_Rd_state_RESET	    	= 8'b00000001	,
					Angle_Rd_state_IDLE	    	= 8'b00000010	,													
					Angle_Rd_state_READ		    = 8'b00000100	,
					Angle_Rd_state_READ_Wait      = 8'b00001000	,
					Angle_Rd_state_ADDR           = 8'b00010000	,
					Angle_Rd_state_RSTART         = 8'b00100000	,
					Angle_Rd_state_CAL_START      = 8'b01000000	,
					Angle_Rd_state_END            = 8'b10000000	;
                        
reg		[8:0]	Angle_read_state			;          


 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if(	sys_rst )
			Angle_read_state <= Angle_Rd_state_RESET	;
		else
		begin

			case ( Angle_read_state )
			 Angle_Rd_state_RESET	:
				begin
						Angle_read_state = Angle_Rd_state_IDLE	;
				end
				
			 Angle_Rd_state_IDLE	:
				begin
					 if ( Angle_axi_Begin )
						Angle_read_state = Angle_Rd_state_READ	;
					else
						Angle_read_state = Angle_Rd_state_IDLE	;
				end
				
			 Angle_Rd_state_READ	:
                begin
 					 if ( Angle_LEN_DONE) // 000 200 400 600
						 Angle_read_state = Angle_Rd_state_CAL_START	;
					 else if( Angle_araddr_en )
				         Angle_read_state = Angle_Rd_state_READ_Wait	;
					 else
						 Angle_read_state = Angle_Rd_state_READ	;
				end	
			  Angle_Rd_state_READ_Wait	:
                begin
					 if ( Angle_axi_rvalid) // 000 200 400 600
						Angle_read_state = Angle_Rd_state_ADDR	;						
					else
						Angle_read_state = Angle_Rd_state_READ_Wait	;
				end	
		 
			  Angle_Rd_state_ADDR	:   
                begin
					 if ( Angle_axi_rlast 	)    //
						Angle_read_state = Angle_Rd_state_RSTART	;
					 		 
					else
						Angle_read_state = Angle_Rd_state_ADDR	;
				end
			  Angle_Rd_state_RSTART	:
                begin
					 if ( Angle_axi_arready 	)
						Angle_read_state = Angle_Rd_state_READ	;
			
					else
						Angle_read_state = Angle_Rd_state_RSTART	;
				end	
				
			  Angle_Rd_state_CAL_START:		
                begin					 
						Angle_read_state = Angle_Rd_state_END	;			 
				end
				
			  Angle_Rd_state_END:		
                begin	
                	if (Angle_axi_CNT == 200)	 
						Angle_read_state = Angle_Rd_state_READ	;
    			
					else 
						Angle_read_state = Angle_Rd_state_END;			 
				end					
				default			:                      		
						Angle_read_state = Angle_Rd_state_IDLE		;  		
			endcase

		end
	end	

 
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
			     Angle_valid_cnt	<= 16'd0;
		else if  (Angle_valid_cnt	== (BURST_LEN ))  
			     Angle_valid_cnt	<= 16'd0;
		else if   ((Angle_read_state == Angle_Rd_state_READ) && (Angle_valid_cnt	<=  BURST_LEN ) ) 
			     Angle_valid_cnt	<= Angle_valid_cnt + 16'd1  ;
	end  
  	
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Angle_axi_begin_en<= 1'b0 ;     
        else if (Angle_read_state == Angle_Rd_state_CAL_START	 )    
                 Angle_axi_begin_en<= 1'b1 ;
        else             
                 Angle_axi_begin_en<= 1'b0 ;     
        end 
        
 
  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		     	 Angle_LEN_DONE	<= 1'd0;
		else if  (Angle_valid_cnt[6:0]	== 7'b1111111)  
		    	 Angle_LEN_DONE	<= 1'd1;
		else 
		    	 Angle_LEN_DONE	<= 1'd0;
	end  
		
		  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Angle_axi_addr_get	<= 14'd0;
		else if( Angle_axi_addr_en )  
			     Angle_axi_addr_get  <=  Angle_axi_addr  ; 
		else if (Angle_LEN_DONE)
	             Angle_axi_addr_get	<= 14'd0;
	  else if (Angle_read_state == Angle_Rd_state_IDLE)
	             Angle_axi_addr_get	<= 14'd0;
	end 	  
	
			  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Angle_axi_Begin	<= 1'd0;
		else if( Angle_axi_addr_en )  
			     Angle_axi_Begin  <=  1'd1;    
		else if (Angle_LEN_DONE)
	         	 Angle_axi_Begin	<= 1'd0;
	    else if (Angle_read_state == Angle_Rd_state_IDLE)
	             Angle_axi_Begin	<= 1'd0;
	end 	 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Angle_axi_CNT	<= 14'd0;
		else if(( Angle_axi_Begin > 0) &&( Angle_axi_CNT <= 14'd200  ))  
			     Angle_axi_CNT  <=  Angle_axi_CNT +1'd1; 
		else
	             Angle_axi_CNT	<= 14'd0;
	end 	  
 
always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     Angle_araddr_en	<= 1'b0;
		else if ( (   Angle_valid_cnt[4:0] ==  5'b11111 )   )
			     Angle_araddr_en  <= 1'b1;	  
		else 
	             Angle_araddr_en	<= 1'b0;
	end    
         
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 Angle_axi_arvalid<= 1'b0 ;     
        else if ( 	Angle_araddr_en )    
                 Angle_axi_arvalid<= 1'b1 ;
        else             
                 Angle_axi_arvalid<= 1'b0 ;     
        end 
        
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	  Angle_axi_araddr	<= 36'd0;
	  	else if( Angle_araddr_en   )  
		      Angle_axi_araddr  =    {17'b0,  Angle_valid_cnt[13:5] ,5'h0,4'h0}	+  
		                            {17'b0,  Angle_axi_get[13:5]   ,5'h0,4'h0}   ;		                	                      		    		      
	    else
	          Angle_axi_araddr	<= 36'd0;
	end    
   ////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////״̬��/////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
localparam	[8:0]
					DIR_Rd_state_RESET	    	= 8'b00000001	,
					DIR_Rd_state_IDLE	    	= 8'b00000010	,													
					DIR_Rd_state_READ		    = 8'b00000100	,
					DIR_Rd_state_READ_Wait      = 8'b00001000	,
					DIR_Rd_state_ADDR           = 8'b00010000	,
					DIR_Rd_state_RSTART         = 8'b00100000	,
					DIR_Rd_state_CAL_START      = 8'b01000000	,
					DIR_Rd_state_END            = 8'b10000000	;
                        
reg		[8:0]	DIR_read_state			;          


 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if(	sys_rst )
			DIR_read_state <= DIR_Rd_state_RESET	;
		else
		begin

			case ( DIR_read_state )
			 DIR_Rd_state_RESET	:
				begin
						DIR_read_state = DIR_Rd_state_IDLE	;
				end
				
			 DIR_Rd_state_IDLE	:
				begin
					 if ( DIR_axi_Begin )
						DIR_read_state = DIR_Rd_state_READ	;
					else
						DIR_read_state = DIR_Rd_state_IDLE	;
				end
				
			 DIR_Rd_state_READ	:
                begin
 					 if ( DIR_LEN_DONE) // 000 200 400 600
						 DIR_read_state = DIR_Rd_state_CAL_START	;
					 else if( DIR_araddr_en )
				         DIR_read_state = DIR_Rd_state_READ_Wait	;
					 else
						 DIR_read_state = DIR_Rd_state_READ	;
				end	
			  DIR_Rd_state_READ_Wait	:
                begin
					 if ( DIR_axi_rvalid) // 000 200 400 600
						DIR_read_state = DIR_Rd_state_ADDR	;						
					else
						DIR_read_state = DIR_Rd_state_READ_Wait	;
				end	
		 
			  DIR_Rd_state_ADDR	:   
                begin
					 if ( DIR_axi_rlast 	)    //
						DIR_read_state = DIR_Rd_state_RSTART	;
					 		 
					else
						DIR_read_state = DIR_Rd_state_ADDR	;
				end
			  DIR_Rd_state_RSTART	:
                begin
					 if ( DIR_axi_arready 	)
						DIR_read_state = DIR_Rd_state_READ	;
			
					else
						DIR_read_state = DIR_Rd_state_RSTART	;
				end	
				
			  DIR_Rd_state_CAL_START:		
                begin					 
						DIR_read_state = DIR_Rd_state_END	;			 
				end
				
			  DIR_Rd_state_END:		
                begin	
                	if (DIR_axi_CNT == 200)	 
						DIR_read_state = DIR_Rd_state_READ	;
    			
					else 
						DIR_read_state = DIR_Rd_state_END;			 
				end					
				default			:                      		
						DIR_read_state = DIR_Rd_state_IDLE		;  		
			endcase

		end
	end	

 
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
			     DIR_valid_cnt	<= 16'd0;
		else if  (DIR_valid_cnt	== (BURST_LEN ))  
			     DIR_valid_cnt	<= 16'd0;
		else if   ((DIR_read_state == DIR_Rd_state_READ) && (DIR_valid_cnt	<=  BURST_LEN ) ) 
			     DIR_valid_cnt	<= DIR_valid_cnt + 16'd1  ;
	end  
  	
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 DIR_axi_begin_en<= 1'b0 ;     
        else if (DIR_read_state == DIR_Rd_state_CAL_START	 )    
                 DIR_axi_begin_en<= 1'b1 ;
        else             
                 DIR_axi_begin_en<= 1'b0 ;     
        end 
        
 
  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		     	 DIR_LEN_DONE	<= 1'd0;
		else if  (DIR_valid_cnt[6:0]	== 7'b1111111)  
		    	 DIR_LEN_DONE	<= 1'd1;
		else 
		    	 DIR_LEN_DONE	<= 1'd0;
	end  
		
		  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     DIR_axi_addr_get	<= 14'd0;
		else if( DIR_axi_addr_en )  
			     DIR_axi_addr_get  <=  DIR_axi_addr  ; 
		else if (DIR_LEN_DONE)
	             DIR_axi_addr_get	<= 14'd0;
	  else if (DIR_read_state == DIR_Rd_state_IDLE)
	             DIR_axi_addr_get	<= 14'd0;
	end 	  
	
			  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     DIR_axi_Begin	<= 1'd0;
		else if( DIR_axi_addr_en )  
			     DIR_axi_Begin  <=  1'd1;    
		else if (DIR_LEN_DONE)
	         	 DIR_axi_Begin	<= 1'd0;
	    else if (DIR_read_state == DIR_Rd_state_IDLE)
	             DIR_axi_Begin	<= 1'd0;
	end 	 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     DIR_axi_CNT	<= 14'd0;
		else if(( DIR_axi_Begin > 0) &&( DIR_axi_CNT <= 14'd200  ))  
			     DIR_axi_CNT  <=  DIR_axi_CNT +1'd1; 
		else
	             DIR_axi_CNT	<= 14'd0;
	end 	  
 
always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	     DIR_araddr_en	<= 1'b0;
		else if ( (   DIR_valid_cnt[4:0] ==  5'b11111 )   )
			     DIR_araddr_en  <= 1'b1;	  
		else 
	             DIR_araddr_en	<= 1'b0;
	end    
         
 always@(posedge sys_clk or negedge sys_rst)
   begin
        if (sys_rst)  
                 DIR_axi_arvalid<= 1'b0 ;     
        else if ( 	DIR_araddr_en )    
                 DIR_axi_arvalid<= 1'b1 ;
        else             
                 DIR_axi_arvalid<= 1'b0 ;     
        end 
        
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	  DIR_axi_araddr	<= 36'd0;
	  	else if( DIR_araddr_en   )  
		      DIR_axi_araddr  =    {17'b0,  DIR_valid_cnt[13:5] ,5'h0,4'h0}	+  
		                            {17'b0,  DIR_axi_get[13:5]   ,5'h0,4'h0}   ;		                	                      		    		      
	    else
	          DIR_axi_araddr	<= 36'd0;
	end    
           
  
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

	 localparam	[8:0]
							Index_Wr_state_RESET	    	= 9'b00000001	,
							Index_Wr_state_IDLE	    	= 9'b00000010	,	
							Index_Wr_state_begin			= 9'b00000100	,										
							Index_Wr_state_Trans          = 9'b00001000	,											
							Index_Wr_state_ADDR		    = 9'b00010000	,
							Index_Wr_state_Vil            = 9'b00100000	,
							Index_Wr_state_WR             = 9'b01000000	,
							Index_Wr_state_END            = 9'b10000000	; 
							                          
reg		[8:0]	Index_Write_state			;          
	 
	 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if(	sys_rst )
			Index_Write_state <=  Index_Wr_state_RESET	;
		else
		begin
			case ( Index_Write_state )
			 Index_Wr_state_RESET	:
				    begin
						 Index_Write_state = Index_Wr_state_IDLE	;
				    end
	         Index_Wr_state_IDLE:
	              begin
					 if ( Update_ALL_Force_Ram_done 	)
						Index_Write_state = Index_Wr_state_begin	;
					else
						Index_Write_state = Index_Wr_state_IDLE	;									
				   end
			  Index_Wr_state_begin:
	              begin				 
						Index_Write_state = Index_Wr_state_Trans	; 							
				   end
 
			 Index_Wr_state_Trans:
	              begin				 
						Index_Write_state = Index_Wr_state_ADDR	; 							
				   end
 
				   	  	   
	         Index_Wr_state_ADDR:
	              begin
					 if( (   Index_ram_WR_addr[12:4]> 7'd0 )&& ( Index_ram_WR_addr[3:0]== 4'd0000	) )
						Index_Write_state = Index_Wr_state_Vil	;
					else
						Index_Write_state = Index_Wr_state_ADDR	;									
				   end	
				   
			 Index_Wr_state_Vil:
	              begin		
                  if (Index_axi_bvalid)		 
						Index_Write_state = Index_Wr_state_WR	; 
 					else 
 						Index_Write_state = Index_Wr_state_Vil	;						
				   end	 			   
		   	   
			  Index_Wr_state_WR:
				   begin
					 if (Index_ram_WR_addr >= ram_WR_addr  )
						Index_Write_state = Index_Wr_state_END	;
					else
						Index_Write_state = Index_Wr_state_begin	;
				   end
				
	 			 Index_Wr_state_END:		
 	                  	Index_Write_state = Index_Wr_state_IDLE	;
														
				default			:                      		
						Index_Write_state = Index_Wr_state_IDLE		;  		
			endcase

		end
	end	
 
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_ram_WR_addr	<= 36'd0;
		else if( 	Index_Write_state == Index_Wr_state_ADDR )  
		 	 Index_ram_WR_addr  =   Index_ram_WR_addr + 1'b1	;
		else if (  Index_Write_state == Index_Wr_state_IDLE	 ) 
	         Index_ram_WR_addr	<= 36'd0;
	end  

 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 cnt_last	<= 5'd0;
		else if( 	Index_Write_state == Index_Wr_state_ADDR )  
		 	 cnt_last  =   cnt_last + 1'b1	;
		else 
	         cnt_last	<= 5'd0;
	end  
	
 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 ram_WR_addr	<= 36'd0;
		else if( 	 Update_ALL_Force_Ram_done)  
		 	 ram_WR_addr  <=   Home_force_num  	;
		else if ( Index_Write_state == Index_Wr_state_END ) 
	         ram_WR_addr	<= 36'd0;
	end  

  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_awaddr_en	<= 1'd0;
		else if( Index_Write_state == Index_Wr_state_begin )  
			 Index_awaddr_en  <= 1'd1;	 
		else 
	         Index_awaddr_en	<= 1'd0;
	end  
	 
  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_axi_awaddr	<= 36'd0;
		else if( Index_awaddr_en )  
			 Index_axi_awaddr  =  {17'b0, Index_ram_WR_addr[13:5],5'h0,4'h0}  ;
  			 
		else 
	         Index_axi_awaddr	<= 36'd0;
	end  
	 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_axi_awvalid     <=   1'b0;
		else if( Index_awaddr_en )  
			 Index_axi_awvalid     <=   1'b1;
		else 
	         Index_axi_awvalid	 <=   1'b0;
	end  

	
	 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_axi_wdata	<= 36'd0;
		else if(  Index_Write_state == Index_Wr_state_ADDR )  
			 Index_axi_wdata  = Index_ram_WR_data;
		else 
	         Index_axi_wdata	<= 36'd0;
	end  

	 always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_axi_wvalid	<=   1'b0;
		else if(  Index_Write_state == Index_Wr_state_ADDR )   
		     Index_axi_wvalid    <=  1'b1;
		else 
	         Index_axi_wvalid	<=  1'b0;
	end  
			 
	  always@(posedge sys_clk or negedge sys_rst) 
	begin
		if( sys_rst )
		 	 Index_axi_wlast  <=   1'b0;
		  else if(  cnt_last == 5'b10000	 )  
			 Index_axi_wlast  <=   1'b1;
		 else 
	         Index_axi_wlast <=   1'b0;
	end  
  
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	
	Par_Bond_Top U_Par_Bond_Top(
	
   . Sys_Clk                            (sys_clk                     )  ,  // system clock with 300mHz
   . Sys_Rst_n                          (~sys_rst                    )  ,  // system rest
 
   . Update_ALL_Force_Ram_done          (Update_ALL_Force_Ram_done   )  ,   // reading all new force to ram       
   . Home_force_num                     (Home_force_num              )  ,
   . Index_ram_WR_addr                 (Index_ram_WR_addr          )  ,
   . Index_ram_WR_data                 (Index_ram_WR_data          )  ,  
          
                                                                             //read from pinpang module to subram
   . read_ram_aradder                   (read_ram_aradder            )  ,
   . read_ram_dout                      (read_ram_dout               )  ,  
   . Neicell_NUM                        (Neicell_NUM                 )  ,
   . Neicell_NUM_en                     (Neicell_NUM_en              )  ,
   .  Index_axi_rdata                     (Index_axi_rdata),
   
    . Bond_axi_addr                      (Bond_axi_addr)                ,
   .  Bond_axi_addr_en                   ( Bond_axi_addr_en)         ,
   .  S_Bond_ram_Rd_addr                 (  S_Bond_ram_Rd_addr             )  ,
   .  S_Bond_ram_Rd_data                 (  S_Bond_ram_Rd_data                )  ,
 
    . Angle_axi_addr                      (Angle_axi_addr)                ,
   .  Angle_axi_addr_en                   (Angle_axi_addr_en)       ,
   .  S_Angle_ram_Rd_addr                   (  S_Angle_ram_Rd_addr             )  ,
   .  S_Angle_ram_Rd_data                   (  S_Angle_ram_Rd_data                )  ,
 
   .  DIR_axi_addr                        (DIR_axi_addr)                ,
   .  DIR_axi_addr_en                     (DIR_axi_addr_en)     ,
   .  S_DIR_ram_Rd_addr                   (  S_DIR_ram_Rd_addr             )  , 
   .  S_DIR_ram_Rd_data                   (  S_DIR_ram_Rd_data                )  
     
    );  	
	
	  
endmodule
