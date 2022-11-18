`timescale 1 ns / 100 ps

module mux4to1TB ();
    wire [31:0] dout;
    reg [1:0] select;
    reg [31:0] I0, I1, I2, I3;
    integer i, j;

    mux4to1 UUT (.select(select), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .dout(dout));

    initial begin
        $monitor("I0: %h I1: %h I2: %h I3: %h dout: %h select: %h", I0, I1, I2, I3, dout, select);
        for (i = 0; i < 50; i = i + 1) begin
          I0 = $urandom;
          I1 = $urandom;
          I2 = $urandom;
          I3 = $urandom;
          for (j = 0; j < 4; j = j + 1) begin
            select = j;
            #10;
          end

        end
        $display("Finished");
        $stop;
    end
    

endmodule