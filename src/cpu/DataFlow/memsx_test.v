`timescale 1 ns / 100 ps

module memsx_TB ();
    wire [31:0] mem_extend;
    reg [31:0] mem_value;
    reg [2:0] mem_size;

    integer i;

    memsx UUT (.mem_size(mem_size), .mem_value(mem_value), .mem_extend(mem_extend));

    initial begin
        $monitor("mem value: %h mem extended: %h sx size: %h",mem_value, mem_extend, mem_size);
        for (i = 0; i < 50; i = i + 1) begin
            mem_value = $urandom;
            mem_size = $urandom%5;
            if (mem_size == 3'd3) begin
                mem_size = 3'd5;
            end
            #10;
        end
        $display("Finished");
        $stop;
    end
    

endmodule