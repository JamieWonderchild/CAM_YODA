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
	input  btn_next, //next record button 
	input btn_rst,
	input [15:0]SW,
	
	output reg [7:0]SEG,
	output reg [7:0]AN
    );
    
    wire inc_button;
    wire rst_btn;
    reg rst;
	Debounce debounce_inc(.clk(clock), .button(btn_next), .out(inc_button)); 
	Debounce debounce_rst(.clk(clock), .button(btn_rst), .out(rst)); 
	
	wire mem_addr;
	//search search_record(.clk(clock), .user_input(), .reset(rst_btn), next, start, we, oe, cs,)
    
    always @(posedge clock)begin
    //split input twitches into [7:0] and [15:8}
    //convert to ascii
    //call RAM, check if the value is equal to the input
    //if it is, display address on seven segment
    //if not check the next address
    end
endmodule
