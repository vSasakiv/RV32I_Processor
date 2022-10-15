module Comparator (
  input wire A_S, B_S, COUT,
  input wire [31:0] S,
  output wire EQ, LU, LS
);
  
  ComparatorEQ E0 (.S(S), .EQ(EQ));
  ComparatorLTUnsigned CU0 (.COUT(COUT), .EQ(EQ), .R(LU));
  ComparatorLTSigned CS0 (.A_S(A_S), .B_S(B_S), .S_S(S[31]), .EQ(EQ), .R(LS));

endmodule