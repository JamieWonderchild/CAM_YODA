`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2020 15:30:45
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module main(
    input	clock, 
	input  btn_action, //next record button 
	input btn_re,
	input btn_we,
	input [15:0]SW,
	
	output reg [7:0]SEG,
	output reg [7:0]AN
    );
    
    wire action_button;
    
    wire re_btn;
    reg re;
    wire we_btn;
    reg we;
    reg Rst;
    
	Debounce debounce_inc(.clk(clock), .button(btn_action), .out(action_button)); 
	Debounce debounce_re(.clk(clock), .button(btn_re), .out(re_btn)); 
	Debounce debounce_we(.clk(clock), .button(btn_we), .out(we_btn)); 

	integer mem_addr;
	
	//registers for storing memory address in decimal
	reg[3:0] units = 4'd0;
	reg[3:0] tens = 4'd0;
	reg[3:0] hundreds = 4'd0;
	
	search search_instance(.clk(clock), .user_input(SW), .re(re), .we(we), .next(action_button),.data_out(mem_addr));
	
	wire[3:0]AN_wire;
	wire[7:0]SEG_wire;
	
	SS_driver SS_Driver1(
		.Clk(clock), .Reset(Rst), //clock and reset signals
		.BCD2(hundreds), .BCD1(tens), .BCD0(units), 
		.SegmentDrivers(AN_wire), .SevenSegment(SEG_wire)
	);
    
    always @(posedge clock)begin
    
    AN <= {AN_wire, 4'b1111};
    SEG <= 8'b11111111;//turns whole segment on
    
    if(re_btn)begin
        re <= ~re;
        end
        
    if(we_btn)begin
        we <= ~we;
        end
        
    if(we == 1)begin //write condition
        if(action_button)begin
            
            end
        end

    if (re == 1)begin//search condition
        if(action_button)begin
            units <= mem_addr%10;
            tens <= ((mem_addr%100)-units)/10;
            hundreds <= (mem_addr-tens*10-units)/100;
            SEG <= SEG_wire;//setting the semented display array 
            end   
         end   
    end
endmodule
