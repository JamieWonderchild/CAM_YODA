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
    address,    //address input
    data, //data is bi-directional
    cs, //chip select
    we, //write-enabled/read-enabled -> 1 means write, 0 means read
    oe //output enabled
    );
    
    //parameters
    parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 10;
    parameter RAM_DEPTH = 1<<ADDR_WIDTH;
    
    //define inputs
    input clock,cs,we,oe;
    input [ADDR_WIDTH-1:0] address;
    
    //data is bi-directional
    inout[DATA_WIDTH-1:0] data;
    //preivate registers
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1]; // Set up the memory array
    reg [DATA_WIDTH-1:0] r_data;              // copy of data value to return
    reg r_oe; // delayed oe, r_oeupdates only when rdataupdated
    always@ (posedge clock)begin
        if (cs)begin
            if (we) 
                mem[address] <= data;
                r_data<= mem[address];
                end
            r_oe<= oe;
            end
        assign data = (oe&& cs && !we)? r_data: 8'bz;
endmodule
