/* Módulo que representa um multiplexador geral de 4 entradas de 32-bits e uma saída de 32-bits */
module mux4to1 (
  input [1:0] select, // seletor do multiplexador
  input [31:0] I0, I1, I2, I3, // entradas
  output [31:0] data_o // saída
);

  reg [31:0] data_o_r; // reg para ser utilizado no bloco always

  always @(*) begin
    case (select)
      2'd0: data_o_r = I0; // caso o seletor for 00, I0 deve passar para a saída
      2'd1: data_o_r = I1; // caso o seletor for 01, I1 deve passar para a saída
      2'd2: data_o_r = I2; // caso o seletor for 10, I2 deve passar para a saída
      2'd3: data_o_r = I3; // caso o seletor for 11, I3 deve passar para a saída
    endcase
  end
  assign data_o = data_o_r;

endmodule