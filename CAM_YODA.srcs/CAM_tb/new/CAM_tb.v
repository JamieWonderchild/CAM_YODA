module CAM_tb();  
reg  clk, btn_action, we, re;

// Instantiate the module to be tested
reg [7:0]SEG;
reg [7:0]AN;
reg [15:0]sw;
main(
    .clock(clk), 
	.btn_action(btn_action), //next record button 
	.btn_re(re),
	.btn_we(we),
	.SW(sw),
	.SEG(SEG),
	.AN(AN)
    );

initial begin  
// set up initial conditions
clk = 0;  
we  = 0;
re  = 0;
sw  = 0;
#5
sw =16'b0100000101000010; //AB
we = 1;
btn_action = 1;
clk = 1;
#5
clk = 0;
btn_action = 0;
#5
sw = 16'b0100001101000100; //CD
btn_action = 1;
#5
clk =1;
#5
clk = 0;
btn_action = 0;
we = 0;
#5
re = 1;
sw = 16'b0100000101000010;
#5
clk = 1;
#5
clk = 0;
btn_action = 1;
#5
clk = 1;
#5
clk = 0;

end
endmodule