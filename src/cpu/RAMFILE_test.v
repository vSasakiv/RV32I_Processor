`timescale 1 ns / 100 ps

module RAMFILETB ();
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
        addr = 0;
        for (i = 0; i < 63; i = i + 1) begin
          addr = addr + 4;
          #10;
        end

        $display("Finished");
        $stop;
    end
    

endmodule