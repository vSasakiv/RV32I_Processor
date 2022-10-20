/* Módulo de uma Gate, utilizado para selecionar os sinais
que deveram passar dos decodificados para o resto do circuito,
onde os sinais Code vem dos OPDecoders, e Dec_Data vem do sinal
concatenado dos decodificados
*/
module Gate (
  input wire [9:0] Code, Dec_Data,
  output wire S
);

  // Como cada code é do formato 00000001, basta fazer um bitwise
  // and com cada bit do code e do dec_data, e em seguida fazer um or com cada bit para obter o resultado.
  assign S = |(Code & Dec_Data);

endmodule