module SPI_tb();
reg MOSI,SS_n,clk,rst_n;
wire MISO;
SPI_WRAPPER dut(MOSI,MISO,SS_n,clk,rst_n);
initial begin
	clk = 0;
	forever begin
		#1 clk = ~clk;
	end
end
initial begin
	rst_n = 0;
	MOSI = 1;
	SS_n=0;
	#50
	repeat(20)begin
		MOSI=$random;
		@(negedge clk);
	end
	rst_n=1;
	SS_n=1;
	MOSI=$random;
	#20;
	// Beginning of WRITE ADDRESS
	SS_n=0;
	#2;
	MOSI=0;
	#2;
	MOSI=0;
	#4;
	MOSI=1;      //FF
	#16;
	SS_n=1;
	#10;
	//BEGINNING OF WRITE DATA
	SS_n=0;
	#2;
	MOSI=0;
	#2;
	MOSI=0;
	#2;
	MOSI=1;
	#2;
	MOSI=0;
	#8;
	MOSI=1;    //0F
	#8;
	SS_n=1;
	#20;
	//BEGINNING OF READ ADDRESS
	SS_n=0;
	#2;
	MOSI=1;
	#4;
	MOSI=0;
	#2;
	MOSI=1;   //FF
	#16;
	SS_n=1;
	#20;
	//BEGINNING OF READ DATA
	SS_n=0;
	#2;
	MOSI=1;
	#6;
	MOSI=0;   //DON'T CARE 
	#40;
	SS_n=1;
	#20;
	$stop;
end
endmodule