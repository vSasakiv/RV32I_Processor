`timescale 1ns / 100ps
/* Testbench para o módulo da Control Unit (CU). 
Para cada tipo de instrução, diferenciada pelos OPCODES, verifica se os sinais recebidos da CU são iguais aos esperados.
Caso algum sinal não seja igual, exibe a instrução, o valor esperado e o valor recebido, aumentando a contagem de erros. */
module CU_TB ();
reg [31:0] insn; 
reg LU, LS, EQ;
wire addr_sel, pc_next_sel, sub_sra, pc_alu_sel;
wire rd_clk, mem_clk;
wire alu_sel_a, alu_sel_b;
wire pc_clk, insn_clk;
wire [1:0] mem_size;
wire [2:0] mem_extend;
wire [2:0] func;
wire [1:0] rd_sel;
wire [4:0] rs1, rs2, rd;

integer errors;
parameter delay = 50000; // Parâmetro: tempo entre duas edges do sinal CLOCK.

/* Declaração dos sinais "_c", que registram o valor correto que o sinal deve assumir */
wire pc_clk_c, insn_clk_c;
wire [1:0] mem_size_c;
wire [2:0] mem_extend_c;
wire [4:0] rs1_c, rs2_c, rd_c;

wire clk;
ClockGen C0 (.clk(clk)); // Módulo que gera o sinal clock

/* Task responsável por verificar se o valor de um sinal recebido é igual ao valor esperado */
task Check;
    input addr_sel_xpect, pc_next_sel_xpect, sub_sra_xpect, pc_alu_sel_xpect, rd_clk_xpect, mem_clk_xpect, alu_sel_a_xpect, alu_sel_b_xpect;
    input [2:0] func_xpect;
    input [1:0] rd_sel_xpect;
    input pc_clk_xpect, insn_clk_xpect;
    input [1:0] mem_size_xpect;
    input [2:0] mem_extend_xpect;
    input [4:0] rs1_xpect, rs2_xpect, rd_xpect;

    begin
        if (addr_sel !== addr_sel_xpect) begin 
            $display ("Error insn: %32b, expected %b, got addr_sel: %b", insn, addr_sel_xpect, addr_sel);
            errors = errors + 1;
        end
        if (pc_next_sel !== pc_next_sel_xpect) begin 
            $display ("Error insn: %32b, expected %b, got pc_next_sel: %b", insn, pc_next_sel_xpect, pc_next_sel);
            errors = errors + 1;
        end
        if (sub_sra !== sub_sra_xpect) begin 
            $display ("Error insn: %32b, expected %b, got sub_sra: %b", insn, sub_sra_xpect, sub_sra);
            errors = errors + 1;
        end
        if (pc_alu_sel !== pc_alu_sel_xpect) begin 
            $display ("Error insn: %32b, expected %b, got pc_alu_sel: %b", insn, pc_alu_sel_xpect, pc_alu_sel);
            errors = errors + 1;
        end
        if (rd_clk !== rd_clk_xpect) begin 
            $display ("Error insn: %32b, expected %b, got rd_clk: %b", insn, rd_clk_xpect, rd_clk);
            errors = errors + 1;
        end
        if (mem_clk !== mem_clk_xpect) begin 
            $display ("Error insn: %32b, expected %b, got mem_clk: %b", insn, mem_clk_xpect, mem_clk);
            errors = errors + 1;
        end
        if (alu_sel_a !== alu_sel_a_xpect) begin 
            $display ("Error insn: %32b, expected %b, got alu_sel_a: %b", insn, alu_sel_a_xpect, alu_sel_a);
            errors = errors + 1;
        end
        if (alu_sel_b !== alu_sel_b_xpect) begin 
            $display ("Error insn: %32b, expected %b, got alu_sel_b: %b", insn, alu_sel_b_xpect, alu_sel_b);
            errors = errors + 1;
        end
        if (func !== func_xpect) begin 
            $display ("Error insn: %32b, expected %3b, got func: %3b", insn, func_xpect, func);
            errors = errors + 1;
        end
        if (rd_sel !== rd_sel_xpect) begin 
            $display ("Error insn: %32b, expected %2b, got rd_sel: %2b", insn, rd_sel_xpect, rd_sel);
            errors = errors + 1;
        end
        if (pc_clk !== pc_clk_xpect) begin 
            $display ("Error insn: %32b, expected %b, got pc_clk: %b", insn, pc_clk_xpect, pc_clk);
            errors = errors + 1;
        end
        if (insn_clk !== insn_clk_xpect) begin 
            $display ("Error insn: %32b, expected %b, got insn_clk: %b", insn, insn_clk_xpect, insn_clk);
            errors = errors + 1;
        end
        if (mem_size !== mem_size_xpect) begin 
            $display ("Error insn: %32b, expected %2b, got mem_size: %2b", insn, mem_size_xpect, mem_size);
            errors = errors + 1;
        end
        if (mem_extend !== mem_extend_xpect) begin 
            $display ("Error insn: %32b, expected %3b, got mem_extend: %3b", insn, mem_extend_xpect, mem_extend);
            errors = errors + 1;
        end
        if (rs1 !== rs1_xpect) begin 
            $display ("Error insn: %32b, expected %5b, got rs1: %5b", insn, rs1_xpect, rs1);
            errors = errors + 1;
        end
        if (rs2 !== rs2_xpect) begin 
            $display ("Error insn: %32b, expected %5b, got rs2: %5b", insn, rs2_xpect, rs2);
            errors = errors + 1;
        end
        if (rd !== rd_xpect) begin 
            $display ("Error insn: %32b, expected %5b, got rd: %5b", insn, rd_xpect, rd);
            errors = errors + 1;
        end
    end
endtask

/* Unidade sendo testada : CU */
CU UTT (.insn(insn), .LU(LU), .LS(LS), .EQ(EQ), .addr_sel(addr_sel), .pc_next_sel(pc_next_sel), 
.sub_sra(sub_sra), .pc_alu_sel(pc_alu_sel), .rd_clk(rd_clk), .mem_clk(mem_clk), .alu_sel_a(alu_sel_a),
.alu_sel_b(alu_sel_b), .pc_clk(pc_clk), .insn_clk(insn_clk), .mem_size(mem_size), .mem_extend(mem_extend), 
.func(func), .rd_sel(rd_sel), .rs1(rs1), .rs2(rs2), .rd(rd));

/* Atribuindo os valores esperadas aos sinais "_c" */
assign rs1_c = insn[19:15];
assign rs2_c = insn[24:20];
assign rd_c = insn[11:7];
assign mem_extend_c = insn[14:12];
assign mem_size_c = insn[13:12];
assign insn_clk_c = ~clk;
assign pc_clk_c = clk;

/* Para cada tipo de instrução, verifica através da task "check" se os sinais recebidos são iguais aos esperados.
Sinais esperados são passados diretamente na chamada da task e por meio dos sinais "_c", os quais guardam os valores corretos. 
As instruções testadas são específicas. Para testar outras, basta substituir o valor em hex de uma por outra do mesmo tipo, com atenção aos sinais "func" e "sub_sra". 
OBS: Observer na task Check a ordem de declaração dos inputs para saber a ordem dos parâmetros passados quando chamada. */
initial begin
    errors = 0; 
    insn = 32'h008001EF; /* Tipo J, instrução: jal x03, 0x08 */
    #1
    Check (1'b0, 1'b1, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b1, 1'b1, 3'b000, 2'b11, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b0, 1'b1 , 1'b1, 1'b0, 1'b1, 1'b1, 3'b000, 2'b11, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo J - errors: %2d ", errors);

    errors = 0;
    insn = 32'h00C08613; /* Tipo I ALU, instrução: addi x0C, x01, 12 */
    #delay
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b1, 1'b0, 1'b0, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo I ALU - errors: %2d ", errors);

    errors = 0; 
    insn = 32'h00208463; /* Tipo B, instrução: beq x01, x02, 0x08 */
    #delay
    Check (1'b0, 1'b0, 1'b1, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b0, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    EQ = 1; /* Para essa instrução, foi considerado x01 e x02 iguais, ou seja, EQ = 1 */
    #delay
    Check (1'b0, 1'b0, 1'b1, 1'b1 , 1'b0, 1'b0, 1'b0, 1'b0, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo B - errors: %2d ", errors);

    errors = 0;
    insn = 32'h000082B7; /* Tipo U LUI, instrução: lui x05, 0x08 */
    #delay
    Check (1'b0, 1'b0, 1'bx, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b1, 3'b000, 2'b01, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'bx, 1'b0 , 1'b1, 1'b0, 1'b0, 1'b1, 3'b000, 2'b01, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo U LUI - errors: %2d ", errors);
  
    errors = 0;
    insn = 32'h00410267; /* Tipo I - JARL, instrução: jarl x04, 4(0x02) */
    #delay
    Check (1'b0, 1'b1, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b1, 3'b000, 2'b11, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b1, 1'b0, 1'b0 , 1'b1, 1'b0, 1'b0, 1'b1, 3'b000, 2'b11, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo I JARL - errors: %2d ", errors);
     
    errors = 0;
    insn = 32'h00521623; /* Tipo S, instrução: sh x05, 12(x04) */
    #delay
    Check (1'b1, 1'b0, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b0, 1'b1, 1'b0, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo S - errors: %2d ", errors);
     
    errors = 0;
    insn = 32'h00123CB3; /* Tipo R, instrução: sltu x19, x04, x01 */
    #delay
    Check (1'b0, 1'b0, 1'b1, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b0, 3'b011, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b1, 1'b0 , 1'b1, 1'b0, 1'b0, 1'b0, 3'b011, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo R - errors: %2d ", errors);

    errors = 0;
    insn = 32'h00001F97; /* Tipo U AUIPC, instrução: auipc x1F, 0x01 */
    #delay
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b1, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b1, 1'b0, 1'b1, 1'b1, 3'b000, 2'b10, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo R - errors: %2d ", errors);

    errors = 0;
    insn = 32'h00420383; /* Tipo I - LOAD, instrução: lb x07, 4(x04) */
    #delay
    Check (1'b1, 1'b0, 1'b0, 1'b0 , 1'b0, 1'b0, 1'b0, 1'b1, 3'b000, 2'b00, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    #delay;
    Check (1'b0, 1'b0, 1'b0, 1'b0 , 1'b1, 1'b0, 1'b0, 1'b1, 3'b000, 2'b00, pc_clk_c, insn_clk_c, mem_size_c, mem_extend_c, rs1_c, rs2_c, rd_c);
    $display("Tipo I LOAD - errors: %2d ", errors);

    $stop;
end
endmodule 