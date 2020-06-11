module ramcu_tb();
wire [15:0] data;       // this is the connection to ramcudata port
reg  [15:0] data_value; // need a register to store value to send on a write
reg clk, cs, we, oe;
reg [9:0] addr;
// Instantiate the module to be testes
RAM_interface ramcu_uut(clk,addr,data,cs,we,oe);

initial begin
    clk= 0; cs    = 0; we    = 0; oe= 0; addr= 0;
    $display("clkcs we oeaddrdata");
    $monitor("%b   %b  %b   %b %03d  %03d",clk,cs,we,oe,addr,data);
    
    // try doing a clock change just when nothing should happen (cs=0)
    #5 clk= ~clk; #5 clk= ~clk;
    
    // let is do a memory write...
    // note that you need to deselect the chip before setting up data
    $display("write 99 to mem[1]");
    oe= 0; we   = 1; cs   = 1; addr= 10'd1; data_value= 16'd99;
    #5 clk= ~clk; #5 clk= ~clk; // do a clock pulse
    
    // now disconnect data_valuefrom data line
    $display("write junk into top level data_value buffer");
    cs  = 0; we  = 0; oe= 0; data_value= 8'd2;
    #5 clk= ~clk; #5 clk= ~clk; // do a clock pulse
    
    // let's read the value back
    $display("check reading back data");
    addr= 10'd1; cs   = 1;  we   = 0; oe= 1; // ask module to write out data
    #5 clk= ~clk; #5 clk= ~clk;    // do a clock pulse (reads the data)
    // you should now have back the value that was written to memory
    
    // disable chip select and write some more junk to local buffer
    $display("write more junk into topleveldata_value");
    cs = 0; data_value= 8'd123;
    
    #5 clk= ~clk; #5 clk= ~clk; // do a clock pulse to see what happens
    end
endmodule