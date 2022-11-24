/* Módulo que descreve um registrador de 32 bits */
module reg32bit (
    input clk, // clock de entrada
    input rs_i, // entrada de reset síncrono
    input [31:0] data_i, // valor de entrada
    output reg [31:0] data_o // valor de saída
);
    /* A cada borda de clock devemos verificar se o reset está ativo, caso esteja
    resetamos o valor do registrador, caso não esteja, apenas passamos o valor da entrada
    para dentro do registrador */
    always @(posedge clk) begin
      if (rs_i) begin
        data_o <= 32'h00000000;
      end
      else begin
        data_o <= data_i;
      end
    end

endmodule
