`timescale 1 ns / 100 ps

module regfileTB ();
    reg clk;
    wire [31:0] ra_out;
    wire [31:0] rb_out;
    reg [31:0] rd_in;
    reg [4:0] ra;
    reg [4:0] rb;
    reg [4:0] rd;
    integer i;

    regfile UUT (.clk(clk), .rd(rd), .rd_in(rd_in), .ra(ra), .rb(rb), .ra_out(ra_out), .rb_out(rb_out));

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0,clk, rd, rd_in, ra, rb, ra_out, rb_out);
        clk = 0;
        for (i = 0; i < 50; i = i + 1) begin
            rd_in = $urandom;
            rd = $urandom%32;
            ra = rd;
            rb = rd;
            #10;
            clk = ~clk;
            #10;
            $monitor("rd: %d ra: %d rb: %d rd_in: %d ra_out: %d rb_out %d", rd, ra, rb, rd_in, ra_out, rb_out);
            clk = ~clk;
        end
        $display("Finished");
        $stop;
    end
    

endmodule