vlib work
vlog RAM_SPI.v SPI.v SPI_WRAPPER.v SPI_tb.V
vsim -voptargs=+acc work.SPI_tb
add wave -position insertpoint  \
sim:/SPI_tb/clk \
sim:/SPI_tb/rst_n \
sim:/SPI_tb/SS_n \
sim:/SPI_tb/MOSI \
sim:/SPI_tb/MISO \
sim:/SPI_tb/dut/RAM/din \
sim:/SPI_tb/dut/RAM/addr_wr \
sim:/SPI_tb/dut/RAM/addr_rd \
sim:/SPI_tb/dut/RAM/dout \
sim:/SPI_tb/dut/SLAVE/tx_valid \
sim:/SPI_tb/dut/SLAVE/tx_data \
sim:/SPI_tb/dut/SLAVE/rx_valid \
sim:/SPI_tb/dut/SLAVE/rx_data \
sim:/SPI_tb/dut/SLAVE/addr_data_sel \
sim:/SPI_tb/dut/SLAVE/rx_data_serial \
sim:/SPI_tb/dut/SLAVE/cs \
sim:/SPI_tb/dut/SLAVE/ns \
sim:/SPI_tb/dut/SLAVE/i \
sim:/SPI_tb/dut/RAM/mem
run -all