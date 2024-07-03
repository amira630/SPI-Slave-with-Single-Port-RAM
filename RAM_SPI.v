module RAM_SPI (din,rx_valid,tx_valid,dout,clk,rst_n);
input [9:0] din;
input clk,rst_n,rx_valid;
reg [7:0] addr_wr,addr_rd;
output reg [7:0] dout ;
output  reg tx_valid;
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
	dout<=0;	
	end
	else begin
	case (din[9:8])
		2'b00: begin
			tx_valid<=0; 
			if (rx_valid) 
				addr_wr<=din[7:0];
		end
		2'b01: begin
			tx_valid<=0; 
			if (rx_valid) 
				mem[addr_wr]<=din[7:0];
		end 
		2'b10: begin
			tx_valid<=0;
			if (rx_valid) addr_rd<=din[7:0];
		end
		2'b11: begin 
			tx_valid<=1; 
			dout<=mem[addr_rd];
		end	
	endcase
	end
end
endmodule

