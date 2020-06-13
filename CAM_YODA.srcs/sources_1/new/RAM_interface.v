`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2020 20:58:36
// Design Name: 
// Module Name: RAM_interface
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


module RAM_interface(
    clock,  //clock input
    we, //write enable
    w_addr, //write address
    w_data,//write data
    re,//read enable
    r_addr,//read address
    cs,//chip select (ignores inputs if cs = 0)
    r_data,//output for read operation
    w_done //output for successul write
    );
    
    //parameters
    parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 10;
    parameter RAM_DEPTH = 1<<ADDR_WIDTH;
    
    //define inputs
    input clock,we,re,cs;
    input [ADDR_WIDTH-1:0] r_addr, w_addr;
    input[DATA_WIDTH-1:0] w_data;
    output reg[DATA_WIDTH-1:0] r_data;
    //preivate registers
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1]; // Set up the memory array
    always@ (posedge clock)begin
        if(cs)begin
            if (we) mem[w_addr] <= w_data;
            if (re) r_data<= mem[r_addr];
        end
    end
endmodule
