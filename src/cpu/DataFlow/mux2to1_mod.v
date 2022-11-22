module mux2to1 (
  input select,
  input [31:0] I0, I1,
  output [31:0] data_o
);

  reg [31:0] data_o_r;

  always @(*) begin
    case (select)
      1'd0: data_o_r = I0;
      1'd1: data_o_r = I1;
    endcase
  end
  
  assign data_o = data_o_r;

endmodule