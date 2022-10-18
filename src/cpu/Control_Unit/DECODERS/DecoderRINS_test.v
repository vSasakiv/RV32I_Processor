`timescale 1ns / 100ps
/* 
Testbench para teste do Decodificador de instruções do tipo R, que confere
todas as saídas do módulo com as saídas corretas, e ao final retorna o número
de erros, se houver. */
module DecoderRINS_TB ();

reg [31:0] INSN; // reg que contém a instrução

// regs que contém os valores corretos de todas as saídas do módulo
reg [4:0] rsa_c, rsb_c, rd_c;
reg [2:0] func3_c, sx_size_c;
reg [1:0] rd_sel_c;
reg alu_sel_a_c, alu_sel_b_c, sub_sra_c, addr_sel_c, pc_next_sel_c, pc_alu_sel_c;
reg rd_clk_c, mem_clk_c;

// net que contém o sinal de Clock proveniente do gerador
wire CLK;

// nets contendo as saídas do módulo em teste
wire [4:0] rsa, rsb, rd;
wire [2:0] func3, sx_size;
wire [1:0] rd_sel;
wire alu_sel_a, alu_sel_b, sub_sra, addr_sel, pc_next_sel, pc_alu_sel;
wire rd_clk, mem_clk;

integer errors; // contador

/* 
Task verifica se o valor esperado é igual ao valor devolvido pelo módulo
*/
task Check;
  input [4:0] rsa_x, rsb_x, rd_x;
  input [2:0] func3_x, sx_size_x;
  input [1:0] rd_sel_x;
  input alu_sel_a_x, alu_sel_b_x, sub_sra_x, addr_sel_x, pc_next_sel_x, pc_alu_sel_x;
  input rd_clk_x, mem_clk_x;

  begin
  if (rsa_x != rsa) begin
    $display("Error on RSA: %b, Expected: %b", rsa, rsa_x);
    errors = errors+1;
  end
  if (rsb_x != rsb) begin
    $display("Error on RSB: %b, Expected: %b", rsb, rsb_x);
    errors = errors+1;
  end
  if (rd_x != rd) begin
    $display("Error on RD: %b, Expected: %b", rd, rd_x);
    errors = errors+1;
  end
  if (func3_x != func3) begin
    $display("Error on FUNC3: %b, Expected: %b", func3, func3_x);
    errors = errors+1;
  end
  if (rd_sel_x != rd_sel) begin
    $display("Error on rd_sel: %b, Expected: %b", rd_sel, rd_sel_x);
    errors = errors+1;
  end
  if (alu_sel_a_x != alu_sel_a) begin
    $display("Error on alu_sel_a: %b, Expected: %b", alu_sel_a, alu_sel_a_x);
    errors = errors+1;
  end
  if (alu_sel_b_x != alu_sel_b) begin
    $display("Error on alu_sel_b: %b, Expected: %b", alu_sel_b, alu_sel_b_x);
    errors = errors+1;
  end
  if (sub_sra_x != sub_sra) begin
    $display("Error on sub_sra: %b, Expected: %b", sub_sra, sub_sra_x);
    errors = errors+1;
  end
  if (addr_sel_x != addr_sel) begin
    $display("Error on addr_sel: %b, Expected: %b", addr_sel, addr_sel_x);
    errors = errors+1;
  end
  if (pc_next_sel_x != pc_next_sel) begin
    $display("Error on pc_next_sel: %b, Expected: %b", pc_alu_sel, pc_alu_sel_x);
    errors = errors+1;
  end
  if (sx_size_x != sx_size) begin 
    $display("Error on pc_next_sel: %b, Expected: %b", sx_size, sx_size_x);
    errors = errors+1;
  end
  if (rd_clk_x != rd_clk) begin
    $display("Error on rd_clk: %b, Expected: %b", rd_clk, rd_clk_x);
    errors = errors+1;
  end
  if (mem_clk_x != mem_clk) begin
    $display("Error on mem_clk: %b, Expected: %b", mem_clk, mem_clk_x);
    errors = errors+1;
  end
  end
endtask

// Unidade em teste, Decoder R
DecoderRINSN UUT (
  .INSN(INSN),
  .CLK(CLK), 
  .rsa(rsa), 
  .rsb(rsb), 
  .rd(rd), 
  .func3(func3), 
  .sx_size(sx_size), 
  .rd_sel(rd_sel), 
  .alu_sel_a(alu_sel_a), 
  .alu_sel_b(alu_sel_b), 
  .sub_sra(sub_sra), 
  .addr_sel(addr_sel), 
  .pc_next_sel(pc_next_sel), 
  .pc_alu_sel(pc_alu_sel),
  .rd_clk(rd_clk), 
  .mem_clk(mem_clk)
);

// gerador de Clock
ClockGen C0 (.CLK(CLK));

initial begin
  errors = 0;
  // Instrução arbitrária: soma do registrador x2 com o registrador x15
  // com registrador de destino x1
  INSN = 32'h00F100B3;

  rsa_c = 5'b00010;
  rsb_c = 5'b01111;
  rd_c = 5'b00001;
  func3_c = 3'b000;
  sx_size_c = 3'bxxx;
  rd_sel_c = 2'b10;
  alu_sel_a_c = 0;
  alu_sel_b_c = 0;
  sub_sra_c = 0;
  addr_sel_c = 0;
  pc_next_sel_c = 0;
  pc_alu_sel_c = 0;
  rd_clk_c = CLK;
  mem_clk_c = 0;
  
  Check( 
    rsa_c, 
    rsb_c, 
    rd_c, 
    func3_c,
    sx_size_c, 
    rd_sel_c, 
    alu_sel_a_c, 
    alu_sel_b_c, 
    sub_sra_c, 
    addr_sel_c, 
    pc_next_sel_c, 
    pc_alu_sel_c, 
    rd_clk_c, 
    mem_clk_c
  );

  // Instrução arbitrária: subtração do registrador x20 com o registrador x2
  // com registrador de destino x1
  INSN = 32'h402A00B3;

  rsa_c = 5'b10100;
  rsb_c = 5'b00010;
  rd_c = 5'b00001;
  func3_c = 3'b000;
  sx_size_c = 3'bxxx;
  rd_sel_c = 2'b10;
  alu_sel_a_c = 0;
  alu_sel_b_c = 0;
  sub_sra_c = 1;
  addr_sel_c = 0;
  pc_next_sel_c = 0;
  pc_alu_sel_c = 0;
  rd_clk_c = CLK;
  mem_clk_c = 0;
  
  Check( 
    rsa_c, 
    rsb_c, 
    rd_c, 
    func3_c, 
    sx_size_c,
    rd_sel_c, 
    alu_sel_a_c, 
    alu_sel_b_c, 
    sub_sra_c, 
    addr_sel_c, 
    pc_next_sel_c, 
    pc_alu_sel_c, 
    rd_clk_c, 
    mem_clk_c
  );

  $display("Finished, got %d errors", errors);
  $stop;
end
endmodule