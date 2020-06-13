// EEE4120F Memory Control Unit Example
// Testbench for the dual port dp_ramRAM control memory unit
module hdp_ram_tb();  
reg  clk, cs, we, re;
reg  [15:0] w_data;  // this is the connection to dp_ramwrite data port
reg  [9:0] w_addr;  // address to write to
reg  [9:0] r_addr;  // address to read from
wire [15:0] r_data;  // link to data returned on a read
// Instantiate the module to be tested
RAM_interface hdp_ram_uut(clk,we,w_addr,w_data,re,r_addr,cs,r_data);
initial begin  
// set up initial conditions
clk= 0; cs    = 0; we    = 1;
re    = 0; r_addr= 1; w_addr= 1;
w_data= 100;
$display("clkcs we re raddr waddr rdata wdata");
$monitor("%b   %b  %b  %b  %03d   %03d   %03d   %03d",clk,cs,we,re,r_addr,w_addr,r_data,w_data);
// set up to write to 100 to [1] and disable read:
cs <= 1; #5 $display("write 100 to [1]");  
// (the #5 is here to force the display output)
#5 clk= ~clk; #5 clk= ~clk; // do a clock pulse
re <= 1; w_addr<= 2; w_data<= 101;
#5 $display("write 101 to [2] and read from 1")
;#5 clk= ~clk; #5 clk= ~clk; // do a clock pulseend endmodule
end
endmodule