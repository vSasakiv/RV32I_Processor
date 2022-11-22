`timescale 1 ns / 100 ps

module mux2to1_TB ();
    wire [31:0] data_o;
    reg select;
    reg [31:0] I0, I1;
    integer i, j;

    mux2to1 UUT (.select(select), .I0(I0), .I1(I1), .data_o(data_o));

    initial begin
        $monitor("I0: %h I1: %h data_o: %h select: %h", I0, I1, data_o, select);
        for (i = 0; i < 50; i = i + 1) begin
          I0 = $urandom;
          I1 = $urandom;
          for (j = 0; j < 2; j = j + 1) begin
            select = j;
            #10;
          end

        end
        $display("Finished");
        $stop;
    end
    

endmodule