/* Módulo que descreve a regfile do processador. Contém 32 registradores de 32 bits
uma entrada para gravar nos registradores, e duas saídas, além de reset síncrono */
module regfile (
    input clk, // sinal de clock
    input rs_i, // sinal de reset síncrono
    input [4:0] rd, // seletor do registrador destino (a ser gravado)
    input [4:0] rs1, // seletor da saída 1
    input [4:0] rs2, // seletor da saída 2
    input [31:0] rd_in, // valor de entrada ao registrador destino
    output [31:0] rs1_out, // valor de saída 1
    output [31:0] rs2_out // valor de saída 2
);

// Declaração de todos os 32 registradores (note a falta de r0, isto é porque de acordo
// com a documentação do riscv, este "registrador" sempre é 0, e não é possível modifcar o seu valor.)
reg [31:0] r1;
reg [31:0] r2;
reg [31:0] r3;
reg [31:0] r4;
reg [31:0] r5;
reg [31:0] r6;
reg [31:0] r7;
reg [31:0] r8;
reg [31:0] r9;
reg [31:0] r10;
reg [31:0] r11;
reg [31:0] r12;
reg [31:0] r13;
reg [31:0] r14;
reg [31:0] r15;
reg [31:0] r16;
reg [31:0] r17;
reg [31:0] r18;
reg [31:0] r19;
reg [31:0] r20;
reg [31:0] r21;
reg [31:0] r22;
reg [31:0] r23;
reg [31:0] r24;
reg [31:0] r25;
reg [31:0] r26;
reg [31:0] r27;
reg [31:0] r28;
reg [31:0] r29;
reg [31:0] r30;
reg [31:0] r31;

// e das duas saídas
reg [31:0] rs1_out_value;
reg [31:0] rs2_out_value;


always @(posedge clk) begin
    // a cada borda de block devemos verificar se o reset esta ativado,
    // caso esteja, basta zerar todos os registradores
    if (rs_i) begin
      r1 <= 32'h00000000;
      r2 <= 32'h00000000;
      r3 <= 32'h00000000;
      r4 <= 32'h00000000;
      r5 <= 32'h00000000;
      r6 <= 32'h00000000;
      r7 <= 32'h00000000;
      r8 <= 32'h00000000;
      r9 <= 32'h00000000;
      r10 <= 32'h00000000;
      r11 <= 32'h00000000;
      r12 <= 32'h00000000;
      r13 <= 32'h00000000;
      r14 <= 32'h00000000;
      r15 <= 32'h00000000;
      r16 <= 32'h00000000;
      r17 <= 32'h00000000;
      r18 <= 32'h00000000;
      r19 <= 32'h00000000;
      r20 <= 32'h00000000;
      r21 <= 32'h00000000;
      r22 <= 32'h00000000;
      r23 <= 32'h00000000;
      r24 <= 32'h00000000;
      r25 <= 32'h00000000;
      r26 <= 32'h00000000;
      r27 <= 32'h00000000;
      r28 <= 32'h00000000;
      r29 <= 32'h00000000;
      r30 <= 32'h00000000;
      r31 <= 32'h00000000;
    end
    // caso não esteja, devemos selecionar o registrador destino e atribuir
    // o valor de entrada à ele.
    else begin
      if (rd == 5'd1) r1 <= rd_in;
      if (rd == 5'd2) r2 <= rd_in;
      if (rd == 5'd3) r3 <= rd_in;
      if (rd == 5'd4) r4 <= rd_in;
      if (rd == 5'd5) r5 <= rd_in;
      if (rd == 5'd6) r6 <= rd_in;
      if (rd == 5'd7) r7 <= rd_in;
      if (rd == 5'd8) r8 <= rd_in;
      if (rd == 5'd9) r9 <= rd_in;
      if (rd == 5'd10) r10 <= rd_in;
      if (rd == 5'd11) r11 <= rd_in;
      if (rd == 5'd12) r12 <= rd_in;
      if (rd == 5'd13) r13 <= rd_in;
      if (rd == 5'd14) r14 <= rd_in;
      if (rd == 5'd15) r15 <= rd_in;
      if (rd == 5'd16) r16 <= rd_in;
      if (rd == 5'd17) r17 <= rd_in;
      if (rd == 5'd18) r18 <= rd_in;
      if (rd == 5'd19) r19 <= rd_in;
      if (rd == 5'd20) r20 <= rd_in;
      if (rd == 5'd21) r21 <= rd_in;
      if (rd == 5'd22) r22 <= rd_in;
      if (rd == 5'd23) r23 <= rd_in;
      if (rd == 5'd24) r24 <= rd_in;
      if (rd == 5'd25) r25 <= rd_in;
      if (rd == 5'd26) r26 <= rd_in;
      if (rd == 5'd27) r27 <= rd_in;
      if (rd == 5'd28) r28 <= rd_in;
      if (rd == 5'd29) r29 <= rd_in;
      if (rd == 5'd30) r30 <= rd_in;
      if (rd == 5'd31) r31 <= rd_in;
    end
end

always @(*) begin
    // por fim, caso algum valor mude, devemos sempre reatribuir às saídas o valor
    // do registrador selecionado atualmente.
    begin
        case (rs1)
            5'd0: rs1_out_value = 32'h00000000;
            5'd1: rs1_out_value = r1;
            5'd2: rs1_out_value = r2;
            5'd3: rs1_out_value = r3;
            5'd4: rs1_out_value = r4;
            5'd5: rs1_out_value = r5;
            5'd6: rs1_out_value = r6;
            5'd7: rs1_out_value = r7;
            5'd8: rs1_out_value = r8;
            5'd9: rs1_out_value = r9;
            5'd10: rs1_out_value = r10;
            5'd11: rs1_out_value = r11;
            5'd12: rs1_out_value = r12;
            5'd13: rs1_out_value = r13;
            5'd14: rs1_out_value = r14;
            5'd15: rs1_out_value = r15;
            5'd16: rs1_out_value = r16;
            5'd17: rs1_out_value = r17;
            5'd18: rs1_out_value = r18;
            5'd19: rs1_out_value = r19;
            5'd20: rs1_out_value = r20;
            5'd21: rs1_out_value = r21;
            5'd22: rs1_out_value = r22;
            5'd23: rs1_out_value = r23;
            5'd24: rs1_out_value = r24;
            5'd25: rs1_out_value = r25;
            5'd26: rs1_out_value = r26;
            5'd27: rs1_out_value = r27;
            5'd28: rs1_out_value = r28;
            5'd29: rs1_out_value = r29;
            5'd30: rs1_out_value = r30;
            5'd31: rs1_out_value = r31;
            default: rs1_out_value = 32'hxxxxxxxx;
        endcase
    end
    begin
        case (rs2)
            5'd0: rs2_out_value = 32'h00000000;
            5'd1: rs2_out_value = r1;
            5'd2: rs2_out_value = r2;
            5'd3: rs2_out_value = r3;
            5'd4: rs2_out_value = r4;
            5'd5: rs2_out_value = r5;
            5'd6: rs2_out_value = r6;
            5'd7: rs2_out_value = r7;
            5'd8: rs2_out_value = r8;
            5'd9: rs2_out_value = r9;
            5'd10: rs2_out_value = r10;
            5'd11: rs2_out_value = r11;
            5'd12: rs2_out_value = r12;
            5'd13: rs2_out_value = r13;
            5'd14: rs2_out_value = r14;
            5'd15: rs2_out_value = r15;
            5'd16: rs2_out_value = r16;
            5'd17: rs2_out_value = r17;
            5'd18: rs2_out_value = r18;
            5'd19: rs2_out_value = r19;
            5'd20: rs2_out_value = r20;
            5'd21: rs2_out_value = r21;
            5'd22: rs2_out_value = r22;
            5'd23: rs2_out_value = r23;
            5'd24: rs2_out_value = r24;
            5'd25: rs2_out_value = r25;
            5'd26: rs2_out_value = r26;
            5'd27: rs2_out_value = r27;
            5'd28: rs2_out_value = r28;
            5'd29: rs2_out_value = r29;
            5'd30: rs2_out_value = r30;
            5'd31: rs2_out_value = r31;
            default: rs1_out_value = 32'hxxxxxxxx;
        endcase
    end
end
assign rs1_out = rs1_out_value;
assign rs2_out = rs2_out_value;

endmodule