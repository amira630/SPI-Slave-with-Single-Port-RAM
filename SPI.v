module SPI(rx_data,SS_n,rst_n,MOSI,clk,rx_valid,tx_valid,MISO,tx_data);
	input tx_valid;
	input SS_n,rst_n,MOSI,clk;
	input [7:0] tx_data;
	output reg rx_valid;
	output reg [9:0] rx_data;
	output reg MISO;
	parameter IDLE=3'b000;
	parameter CHK_CMD=3'b001;
	parameter WRITE=3'b010;
	parameter READ_ADD=3'b011;
	parameter READ_DATA=3'b100;
	reg  addr_data_sel=0;
	reg [9:0] rx_data_serial;
	(* fsm_encoding = "gray" *)  //high setup slack after implementation.
	reg [2:0] cs,ns;
	integer i=0;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) 
			cs <= IDLE;
		else 
			cs <= ns;
	end


	always @(cs or rx_data or SS_n or MOSI or rx_valid or tx_valid) begin
		case(cs) 
			IDLE:
				if(SS_n)
					ns = IDLE;
				else 
					ns = CHK_CMD;
			CHK_CMD:
				if (SS_n) 
					ns = IDLE;
				else if(!MOSI)
					ns = WRITE;
				else if (!addr_data_sel) 
						ns = READ_ADD;
					else 
						ns = READ_DATA;					
			WRITE:
				if (SS_n) 
					ns = IDLE;
				else if (!rx_valid) 
					ns = WRITE;
			READ_DATA:begin
				if (SS_n) 
					ns = IDLE;
				else if (tx_valid) begin 
					ns = READ_DATA;
					addr_data_sel=0;	
				end 	
			end		
			READ_ADD:
				if (SS_n) 
					ns = IDLE;
				else if (!rx_valid) begin
					ns = READ_ADD;	
					addr_data_sel=1;	
				end 	
		endcase
	end

	always @(posedge clk) begin
		if(!rst_n) MISO<=0; 
		case (cs) 
			READ_ADD:begin
				if (i <10) begin
					rx_data_serial[9-i] <= MOSI;
					rx_valid <= 0;
					i <=i+1;
				end
				else begin
					rx_valid <=1;
					rx_data <= rx_data_serial;
				end
			end
			WRITE:begin
				if (i <10) begin
					rx_data_serial[9-i] <= MOSI;
					rx_valid <= 0;
					i <=i+1;
				end
				else begin
					rx_valid <=1;
					rx_data <= rx_data_serial;
				end
			end
			READ_DATA:begin
				if (i <10) begin
					rx_data[9-i] <= MOSI;
					i <=i+1;
				end
				else if (i==10) begin
				    i <=i+1;
					rx_data <= rx_data_serial;
				end
				else if (i<19) begin
					MISO <= tx_data[18-i];
					i <=i+1;
				end
				else  MISO <= 0;		
			end
			default: i <=0;
		endcase
	end
endmodule