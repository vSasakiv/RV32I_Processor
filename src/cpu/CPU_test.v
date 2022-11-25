`timescale 1 ns / 100 ps

module CPU_TB ();
  wire [31:0] data_o; // saida da memoria
	wire mem_clk;
	wire [1:0] mem_size;
	wire [31:0] addr, data_i;
  reg reset;

  CPU CPU0 (
    .reset(reset)
    ,.data_o(data_o)
    ,.mem_clk(mem_clk)
    ,.mem_size(mem_size)
    ,.addr(addr)
    ,.data_i(data_i)
  );
  
/* Dentro do módulo "RAM_mod.c", escolha o teste a ser executado seguindo as instruções dadas */ 
  RAM MEM0 (
    .mem_clk(mem_clk)
    ,.mem_size(mem_size)
    ,.addr(addr)
    ,.data_i(data_i)
    ,.data_o(data_o)
  );

  initial begin
    $dumpfile("CPU.vcd");
    $dumpvars(20, CPU_TB);
  end
  initial begin
    reset = 1;
    #500000;
    reset = 0;
    #15000000;
    $stop;
  end

endmodule