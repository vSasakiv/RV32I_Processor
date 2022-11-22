`timescale 1 ns / 100 ps

module reg32bit_TB ();
    reg clk;
    wire [31:0] data_o;
    reg [31:0] data_i;
    integer i;

    reg32bit UUT (.clk(clk), .data_i(data_i), .data_o(data_o));

    initial begin
        clk = 0;
        for (i = 0; i < 50; i = i + 1) begin
            data_i = $urandom;
            #10;
            clk = ~clk;
            #10;
            if (data_o !== data_i) begin
                $display("Error: data_o = %d data_i = %d", data_o, data_i);
            end
            clk = ~clk;
        end
        $display("Finished");
        $stop;
    end
    

endmodule