# SPI-Slave-with-Single-Port-RAM
One of the most popular interfaces nowadays. 
Stands for Serial-Peripheral Interface.
It has four wires and high data rates.
2-Single Port RAM:
It has parameters and ports.
3- SPI Wrapper:
Includes the SPI Slave as well as the RAM.
• Tcl file was created to create the vivado project and run the full design flow on Vivado using the Tcl
file
• A XDC file was created where the rst_n , SS_n & MOSI are connected to 3 switches, and the MISO to
a led.
• The SPI slave implementation is done using FSM, I tried out three different encoding (gray,
one_hot or seq) using the following vivado attribute in my Verilog code.
• We wish to operate at the highest frequency possible and so I chose the encoding
based on the best timing report that gives the high setup slack after implementation.
• After choosing the best encoding, I added a debug core such that all internals (MISO, MOSI, SS_n,
rst_n & clk) can be analyzed and then generated a bitstream file.
