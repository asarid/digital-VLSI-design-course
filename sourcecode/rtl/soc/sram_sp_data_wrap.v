module sram_sp_data_wrap (
		input 		clk,
		input 		data_req_i,
		input [31:0] 	data_addr_i,
		input 		data_we_i,
		input [3:0] 	data_be_i,
		input [31:0]	data_wdata_i,
		input [1:0]	ds_addr_sel_0,
		output reg [31:0] data_rdata_o
   );

   wire [31:0] data_rdata_i;

// Fill in your instantiations here
// You must use the name "dccm_ram_0" for the memory instantiation!!!

	sram_sp_32768x32_m32_be_wrap 
		dccm_ram_0 (
					.CLK(clk),     
					.CEN(!data_req_i), 
					//.GWEN(!data_we_i),                   
					.GWEN(!(data_we_i & data_req_i)),                   
					.BEN(~data_be_i), 
					.A(data_addr_i[16:2]),      
					.D(data_wdata_i),   
					.Q(data_rdata_i)                                 
					);

	assign data_rdata_o = data_rdata_i;

endmodule
