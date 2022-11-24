/* Módulo de uma Gate (um "mux" com seletor sendo um código de 10 bits), utilizado para selecionar os sinais
que deveram passar dos decodificados para o resto do circuito,
onde os sinais "code" vem dos OPDecoders, e Dec_Data vem do sinal concatenado dos decodificados */
module Gate (
  input wire [9:0] code, Dec_Data,
  output wire S
);

  // Como cada code possui 0 em 9 bits e 1 em apenas um (Ex: 10'b0010000000),
  // basta fazer um bitwise and com cada bit do code e do dec_data, e em seguida fazer um or com cada bit para obter o resultado.
  assign S = |(code & Dec_Data);

endmodule