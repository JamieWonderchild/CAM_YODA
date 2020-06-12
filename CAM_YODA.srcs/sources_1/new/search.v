`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//TO DO:
//Take out for loop (tick)
// increment in always loop (tick)
//allow for searching of individual characters
//////////////////////////////////////////////////////////////////////////////////
module search(
input clk, user_input, reset, next, start, cs, we, w_addr, re, w_data, //user input  = sw, next and start are buttons
    output data_out // output returns an address in binary up to 560 or 1111111111 to signify no match found
    );
    reg [15:0] mem_add = 0;
    reg found;
    reg data;
    reg out = 0;
    reg started;
    reg [15:0] char1;
    reg [15:0] char2;
    reg [15:0] input1;
    reg [15:0] input2;
   
    RAM_interface ram(
    .clock(clk),  //clock input
    .we(we), //write enable
    .w_addr(w_addr), //write address
    .w_data(w_data),//write data
    .re(re),//read enable
    .r_addr(mem_add),//read address
    .cs(cs),//chip select
    .r_data(data)//output for read operation
    );
    
always@(posedge clk)begin
    if(reset)begin//reset conditions
    //is this necesary if not main module?
    end
    if(start || started)begin//wait for button push to start
        started = 1;
        char1 = data & 16'b1111111100000000;
        char1 = char1 >> 8;
        char2 = data & 16'b0000000011111111;
        input1 = user_input & 16'b1111111100000000;
        input1 = input1 >> 8;
        input2 = user_input & 16'b0000000011111111;
        if(input1)begin
            if(input1 == char1)begin
                out <= mem_add;
                found <= 1;
            end else if(input1 == char2)begin
                out <= mem_add;
                found <= 1;
            end else if(input2 == char1)begin
                out <= mem_add;
                found <= 1;
            end else if(input2 == char2)begin
                out <= mem_add;
                found <= 1;
            end
        end
      
        while(found)begin//stays in loop until button is pressed
            //print to seven segment and wait for button push(next)
            if(next)begin
                found <= 0;
            end
        end
        if(mem_add == 560)begin
            out <= 'b1111111111;
            started = 0;
            mem_add = 0;
        end
    end 
mem_add = mem_add+1;
end
assign data_out = out;
   
endmodule