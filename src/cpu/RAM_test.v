`timescale 1 ns / 100 ps

module RAMTB ();
    reg clk;
    wire [31:0] data_o;
    reg [31:0] data_i;
    reg [31:0] addr;
    reg [1:0] mem_sz;
    integer i;

    RAM UUT (.clk(clk), .data_i(data_i), .data_o(data_o), .mem_sz(mem_sz), .addr(addr));

    initial begin
        clk = 0;
        $monitor("data_in: %h data_out: %h mem_sz: %d addr: %h", data_i, data_o, mem_sz, addr);
        for (i = 0; i < 50; i = i + 1) begin
            data_i = $urandom;
            addr = $urandom;
            mem_sz = 2;
            #10;
            clk = ~clk;
            #10;
            clk = ~clk;
        end
        for (i = 0; i < 50; i = i + 1) begin
            data_i = $urandom;
            addr = $urandom;
            mem_sz = 1;
            #10;
            clk = ~clk;
            #10;
            clk = ~clk;
            addr = addr - 2;
            data_i = 32'h00000000;
            #10
            clk = ~clk;
            #10
            clk = ~clk;
        end


        $display("Finished");
        $stop;
    end
    

endmodule