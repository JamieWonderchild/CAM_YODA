`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module search(
input clk, user_input, re, we, next, //
    output data_out // output returns an address in binary up to 560 or 1111111111 to signify no match found
    );
    reg [15:0] mem_add = 0;
    reg [15:0] stor_add = 0;
    reg [15:0] w_data=0;
    reg cs = 0;
    reg found = 1;
    reg data;
    reg out = 0;
    reg [15:0] char1;
    reg [15:0] char2;
    reg [15:0] input1;
    reg [15:0] input2;
   
    RAM_interface ram(
    .clock(clk),  //clock input
    .we(we), //write enable
    .w_addr(stor_add), //write address
    .w_data(w_data),//write data
    .re(re),//read enable
    .r_addr(mem_add),//read address
    .cs(cs),//chip select
    .r_data(data)//output for read operation
    );
    
always@(posedge clk)begin
    cs = 0;
    if(found&next)begin
        found <=0;
    end
    
    if(re&(~found))begin//read enable mode
        cs = 1;
        char1 <= data & 16'b1111111100000000;
        char1 <= char1 >> 8;
        char2 <= data & 16'b0000000011111111;
        input1 <= user_input & 16'b1111111100000000;
        input1 <= input1 >> 8;
        input2 <= user_input & 16'b0000000011111111;
        if(input1)begin
            if(input2==0)begin//input 1 but no input 2
                if(input1 == char1)begin
                   out <= mem_add;
                   found <= 1;
                end else if(input1 == char2)begin
                   out <= mem_add;
                   found <= 1;
            end else begin//input 1 and 2
                if(input1 == char1)begin
                    if(input2 == char2)begin
                        out <= mem_add;
                        found <= 1;
                    end
                end
            end
             
        end else if (input2)begin//input 2 but no input 1
            if(input2 == char1)begin
                out <= mem_add;
                found <= 1;
            end else if(input2 == char2)begin
                out <= mem_add;
                found <= 1;
            end
        end
    end else if (we&(~re)&next)begin//write enable mode
            if(w_data != user_input)begin
                w_data <= user_input;
                if(stor_add)begin
                    stor_add <= stor_add + 1;
                end
                cs <= 1;
            end
        end
      
        if(mem_add == 560)begin
            out <= 'b1111111111;
            mem_add <= 0;
        end
    end 
if(~found)begin
    mem_add = mem_add+1;
end
end
assign data_out = out;
   
endmodule