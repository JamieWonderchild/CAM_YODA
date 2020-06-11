`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module search(
input clk, user_input, reset, next, start, we, oe, cs, //user input  = sw, next and start are buttons
    output data_out // output returns an address in binary up to 560 or 1111111111 to signify no match found
    );
    reg [15:0] mem_add;
    reg found;
    reg data;
    reg out = 0;
    
    RAM_interface ram(
    .clock(clk), 
    .address(mem_add),    //address input
    .data(data), //data is bi-directional
    .cs(cs), //chip select
    .we(we), //write-enabled/read-enabled -> 1 means write, 0 means read
    .oe(oe) //output enabled
    );
    
always@(posedge clk)begin
    if(reset)begin//reset conditions
    //is this necesary if not main module?
    end
    if(start)begin//wait for button push to start
    for (mem_add= 0; mem_add<=560;mem_add=mem_add+1)begin
        if(data == user_input)begin
            out <= mem_add;
            found <= 1;
        end
        while(found)begin//stays in loop until button is pressed
            //print to seven segment and wait for button push(next)
            if(next)begin
                found <= 0;
            end
        end
     end
     out <= 'b1111111111;
    end 

end
assign data_out = out;
    //attn: Jmaie and Kev 
    //if i say assign outside of the always block,
    //does that link the output of the module to the register out?
    // so if i change out in the for loop does data_out update
    //otherwise need to break the loop, assign, 
    //and then keep track of where we were to resume search
endmodule