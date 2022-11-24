/* Módulo responsável por fornecer o valor do imediato codificado na instrução.
Para cada tipo de instrução (cada opcode), codificado no sinal "code", o módulo monta o valor do imediato a partir da instrução insn de acordo com a ISA do RV-32I. */
module immx (
    input [31:0] insn, // Instrução 
    input [9:0] code, // Código gerado pelo OPDecoder, codifica o opcode
    output [31:0] imm // Valor do imediato
);

reg [31:0] imm_r;

/* Para cada code, monta o imediato concatenando bits específicos da instrução de acordo com a ISA. */
always @(insn) begin
    case (code)
        10'b0000000001: imm_r = {{12{insn[31]}}, insn[19:12], insn[20], insn[30:21], 1'b0}; // Instrução tipo J 
        10'b0000000010, 10'b0010000000, 10'b0100000000: imm_r = {{20{insn[31]}}, insn[31:20]}; // Instrução tipo I (Jarl)  // Instrução tipo I (ALU)  // Instrução tipo I (LOAD)
        10'b0000000100, 10'b0000001000: imm_r = {insn[31:12], 12'b0}; // Instrução tipo U (LUI)  // Instrução tipo U (AUIPC)
        10'b0000010000: imm_r = {{20{insn[31]}}, insn[7], insn[30:25], insn[11:8], 1'b0};  // Instrução tipo B
        10'b0001000000, 10'b1000000000: imm_r = {{20{insn[31]}}, insn[31:25], insn[11:7]}; // Instrução tipo S e CSR
        default: imm_r = 32'hxxxxxxxx; // Instrução do tipo R
    endcase
end

assign imm = imm_r;

endmodule