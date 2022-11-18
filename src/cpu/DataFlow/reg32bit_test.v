`timescale 1 ns / 100 ps

module reg32bitTB ();
    reg clk;
    wire [31:0] dout;
    reg [31:0] din;
    integer i;

    reg32bit UUT (.clk(clk), .din(din), .dout(dout));

    initial begin
        clk = 0;
        for (i = 0; i < 50; i = i + 1) begin
            din = $urandom;
            #10;
            clk = ~clk;
            #10;
            if (dout !== din) begin
                $display("Error: dout = %d din = %d", dout, din);
            end
            clk = ~clk;
        end
        $display("Finished");
        $stop;
    end
    

endmodule