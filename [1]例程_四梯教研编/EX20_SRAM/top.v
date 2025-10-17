
module top (
	input	wire			sys_clk     ,	
	input 	wire			rst		    ,	

	input 	wire	[3:0]	key_in		,		
	output	wire			we			,		
	output 	wire			oe			,		
	output 	wire			ce			,		
	output	wire	[16:0]	addr		,		
	inout	wire	[7:0]	data		,		
	output 	wire 	[7:0] 	seg			,	
	output 	wire 	[7:0]	sel		
);


wire				[7:0]	rd_data		;
reg							wr_req		;
reg					[7:0]	wr_data		;
assign addr = 17'b0_0000_0000_0000_0000 ;

//
always@(posedge sys_clk or posedge rst)
	if(rst) begin
		wr_req <= 1'b1;
		wr_data <= 8'b1100_0011;
	end else
		wr_req <= 1'b0;

//seg module
segdisplay inst_seg(
	.clk 				(sys_clk)											,
	.rst 				(~rst)												,	
	.seg_number_in 		({4'd13,4'd10,4'd10,4'd10,4'd10,4'd10,rd_data})		,
	.seg_number 		(seg)												,
	.seg_choice 		(sel)


);

//sram module
sram_controller u_sram_controller
(
	.clk				(sys_clk)					,
	.rst	    		(~rst)						,

	.we					(we)						,		
	.oe					(oe)						,		
	.ce 				(ce)						,		

	.data				(data)						,
	.addr				(addr)						,
	.wr_request			(wr_req)					,
	.rd_request			(~key_in[0])				,
	.wr_data			(wr_data)					,
	.rd_data			(rd_data)
);


endmodule 
 