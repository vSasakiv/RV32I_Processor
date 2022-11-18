module mux2to1 (
  input select,
  input [31:0] I0, I1,
  output [31:0] dout
);

  reg [31:0] dout_r;

  always @(*) begin
    case (select)
      1'd0: dout_r = I0;
      1'd1: dout_r = I1;
    endcase
  end
  
  assign dout = dout_r;

endmodule