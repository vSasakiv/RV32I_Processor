module immx (
    input [31:0] insn,
    output [31:0] imm
);

reg [31:0] imm_r;

always @(insn) begin
    case (insn[6:0])
        7'b0110111, 7'b0010111: imm_r = {insn[31:12], 12'b0};
        7'b1101111: imm_r = {{12{insn[31]}}, insn[19:12], insn[20], insn[30:21], 1'b0};
        7'b1100111, 7'b0010011, 7'b0000011: imm_r = {{20{insn[31]}}, insn[31:20]};
        7'b1100011: imm_r = {{20{insn[31]}}, insn[7], insn[30:25], insn[11:8], 1'b0};
        7'b0100011: imm_r = {{20{insn[31]}}, insn[31:25], insn[11:7]};
        default: imm_r = 32'hxxxxxxxx;
    endcase
end
assign imm = imm_r;


endmodule