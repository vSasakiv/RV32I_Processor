module mux4to1 (
  input [1:0] select,
  input [31:0] I0, I1, I2, I3,
  output [31:0] data_o
);

  reg [31:0] data_o_r;

  always @(*) begin
    case (select)
      2'd0: data_o_r = I0;
      2'd1: data_o_r = I1;
      2'd2: data_o_r = I2;
      2'd3: data_o_r = I3;
    endcase
  end
  assign data_o = data_o_r;

endmodule