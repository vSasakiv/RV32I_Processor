/* Módulo que representa um multiplexador geral de 2 entradas de 32-bits e uma saída de 32-bits */
module mux2to1 (
  input select, // entrada que seleciona qual das duas entradas deve passar para a saída
  input [31:0] I0, I1, // valores de entrada
  output [31:0] data_o // valores de saída
);

  
  reg [31:0] data_o_r; // reg para ser utilizado no bloco always

  always @(*) begin
    case (select)
      1'd0: data_o_r = I0; // caso o seletor for 0, I0 deve passar para a saída
      1'd1: data_o_r = I1; // caso o seletor for 1, I1 deve passar para a saída
    endcase
  end
  
  assign data_o = data_o_r;

endmodule