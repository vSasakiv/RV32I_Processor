module ALU (
  input wire [31:0] A, B,
  input wire [2:0] FUNC,
  input wire sub_sra,
  output reg [31:0] S,
  output wire EQ, LU, LS
);
  
  wire [31:0] ADD, bXOR, bAND, bOR, SR, SL;
  wire COUT;
  
  Adder32b A0 (.A(A), .B(B), .S(ADD), .SUB(sub_sra), .COUT(COUT));
  And32b bAND0 (.A(A), .B(B), .And(bAND));
  Or32b bOR0 (.A(A), .B(B), .O(bOR));
  Xor32b bXOR0 (.A(A), .B(B), .X(bXOR));
  LeftLShifter LeftS0 (.A(A), .B(B), .S(SL));
  RightShifter RightS0 (.A(A), .B(B), .SRA(sub_sra), .Shifted(SR));
  Comparator C0 (.A_S(A[31]), .B_S(B[31]), .S(ADD), .COUT(COUT), .EQ(EQ), .LS(LS), .LU(LU));

  always @(FUNC) begin
    case (FUNC)
      3'b0: S = ADD;
      3'b001: S = SL;
      3'b100: S = bXOR;
      3'b101: S = SR;
      3'b110: S = bOR;
      3'b111: S = bAND;
      default: S = ADD;
    endcase
  end

endmodule
