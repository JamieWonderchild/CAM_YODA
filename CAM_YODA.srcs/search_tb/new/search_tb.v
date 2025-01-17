// EEE4120F Memory Control Unit Example
// Testbench for the dual port dp_ramRAM control memory unit
module search_tb();  
reg  clk, we, next, re;
reg  [15:0] user_input;  
wire [9:0] data_out;  // link to data returned on a read
// Instantiate the module to be tested
search search_uut(clk, user_input, re, we, next, data_out);
initial begin  
// set up initial conditions
clk= 0; next = 0; we    = 0;
re    = 0; user_input = 0; 
w_data= 100;
$display("clk we re user_input data_out");
$monitor("%b   %b  %b  %b  %03d   %03d   %03d   %03d",clk,we,re,user_input,data_out);
// set up to search for binsry value of AB which would be 0100000101000010
re <= 1; #5 $display("read contents matching AB");  
// (the #5 is here to force the display output)
#5 clk= ~clk; #5 clk= ~clk; // do a clock pulse
re <= 1; w_addr<= 2; w_data<= 101;
#5 $display("write 101 to [2] and read from 1")
;#5 clk= ~clk; #5 clk= ~clk; // do a clock pulseend endmodule
end
endmodule