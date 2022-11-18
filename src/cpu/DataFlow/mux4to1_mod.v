module mux4to1 (
  input [1:0] select,
  input [31:0] I0, I1, I2, I3,
  output [31:0] dout
);

  reg [31:0] dout_r;

  always @(*) begin
    case (select)
      2'd0: dout_r = I0;
      2'd1: dout_r = I1;
      2'd2: dout_r = I2;
      2'd3: dout_r = I3;
    endcase
  end
  assign dout = dout_r;

endmodule