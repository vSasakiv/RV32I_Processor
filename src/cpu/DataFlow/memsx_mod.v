/* Módulo utilizado para realizar a extensão de um valor proveniente da memória RAM, para ser corretamente
armazenado em um registrador. 
*/
module memsx (
    input [2:0] mem_extend, // entrada para definir qual deve ser a extensão a ser realizada
    input [31:0] mem_value, // entrada do valor de memória
    output [31:0] mem_extended // saída do valor de memória estendido e corrigido
);
reg [31:0] mem_extended_r;

always @(*) begin
    case (mem_extend)
        3'b000: mem_extended_r = {{24{mem_value[7]}},mem_value[7:0]}; // caso mem_extend for 0, realiza uma extensão signed para um palavra de 8-bits, ou seja, mantém os últimos 8 bits, e todos os outros 24 serão iguais ao bit de sinal deste valor de 8bits
        3'b001: mem_extended_r = {{16{mem_value[15]}}, mem_value[15:0]}; // análogo ao anterior, mas com uma palavra signed de 16 bits
        3'b010: mem_extended_r = mem_value; // utilizada para armazenar uma palavra de 32-bits, logo não é feita nenhuma extensão
        3'b100: mem_extended_r = {{24{1'b0}}, mem_value[7:0]}; // extensão para um palavra de 8-bits unsigned, desta vez os 24 bits mais significativos são preenchidos com 0
        3'b101: mem_extended_r = {{16{1'b0}}, mem_value[15:0]}; // análogo ao anterior, mas com uma palavra de 16-bits
        default: mem_extended_r = 32'hxxxxxxxx;
    endcase    
end
assign mem_extended = mem_extended_r;

endmodule
