`timescale 1 ns / 100 ps

module regfile_TB ();
    reg clk;
    wire [31:0] rs1_out;
    wire [31:0] rs2_out;
    reg [31:0] rd_in;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    integer i;

    regfile UUT (.clk(clk), .rd(rd), .rd_in(rd_in), .rs1(rs1), .rs2(rs2), .rs1_out(rs1_out), .rs2_out(rs2_out));

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0,clk, rd, rd_in, rs1, rs2, rs1_out, rs2_out);
        clk = 0;
        for (i = 0; i < 50; i = i + 1) begin
            rd_in = $urandom;
            rd = $urandom%32;
            rs1 = rd;
            rs2 = rd;
            #10;
            clk = ~clk;
            #10;
            $monitor("rd: %d rs1: %d rs2: %d rd_in: %d rs1_out: %d rs2_out %d", rd, rs1, rs2, rd_in, rs1_out, rs2_out);
            clk = ~clk;
        end
        $display("Finished");
        $stop;
    end
    

endmodule