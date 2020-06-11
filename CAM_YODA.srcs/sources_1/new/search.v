`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2020 16:33:11
// Design Name: 
// Module Name: search
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


module search(
input clk, user_input, reset, init, last, next, start
    output data
    );
    reg [15:0] mem [3:0] = {"AB", "CD", "EF", "AF"};//simulating memory
    reg found;
always@(posedge clk)begin
    if(reset)begin//reset conditions
    
    end
    if(start)begin//wait for button push to start
    for (i= init; i<=last;i=i+1)begin
        if(mem(i) == user_input)begin
            data = mem(i);
            found = 1;
        end
        while(found)begin
            //print to seven segment and wait for button push(next)
            if(next)begin
                found = 0;
            end
        end
     end
     //print "none found" to seven segment
    end 

end

    
endmodule