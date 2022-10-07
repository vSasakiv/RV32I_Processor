module cpu #(

) (
  input A,
  input B,
  output C,
);


reg C = {B, A};

endmodule