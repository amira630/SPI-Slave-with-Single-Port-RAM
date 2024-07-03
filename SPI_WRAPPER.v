module SPI_WRAPPER (MOSI,MISO,SS_n,clk,rst_n);
input MOSI,SS_n,clk,rst_n;
output MISO;
wire tx_valid;
wire rx_valid;
wire [9:0] rx_data;
wire [7:0] tx_data;
RAM_SPI RAM(rx_data,rx_valid,tx_valid,tx_data,clk,rst_n);
SPI SLAVE(rx_data,SS_n,rst_n,MOSI,clk,rx_valid,tx_valid,MISO,tx_data);
endmodule