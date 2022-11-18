`timescale 1 ns / 100 ps

module memsxTB ();
    wire [31:0] mem_x;
    reg [31:0] mem_v;
    reg [2:0] mem_s;

    integer i;

    memsx UUT (.mem_s(mem_s), .mem_v(mem_v), .mem_x(mem_x));

    initial begin
        $monitor("mem value: %h mem extended: %h sx size: %h",mem_v, mem_x, mem_s);
        for (i = 0; i < 50; i = i + 1) begin
            mem_v = $urandom;
            mem_s = $urandom%5;
            if (mem_s == 3'd3) begin
                mem_s = 3'd5;
            end
            #10;
        end
        $display("Finished");
        $stop;
    end
    

endmodule