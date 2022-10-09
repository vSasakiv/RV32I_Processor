module adder_cla8b 
(
  input wire [7:0] A, // Primeiro integrante da soma
  input wire [7:0] B, // Segundo integrante da soma
  input wire CIN, // Carry-in da soma
  output reg [7:0] S, // Resultado da soma
  output reg COUT // Carry-out da soma
);

  always @(A, B, CIN) begin
    assign S = A + B + CIN;
  end

endmodule