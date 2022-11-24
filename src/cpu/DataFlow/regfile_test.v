/* Testebench da regfile. Novamente são sorteados valores aleatórios, e utilizamos o $monitor
para export os valores. Também é gerado um .vcd, que pode ser visualizado em programas como
gtk wave, que nos permitem visualizar o diagrama de tempo do registrador. */
`timescale 1 ns / 100 ps

module regfile_TB ();
    reg clk; // entrada de sinal de clock
    wire [31:0] rs1_out; // saída 1 do registrador
    wire [31:0] rs2_out; // saída 2 do registrador
    reg [31:0] rd_in; // entrada do registrador destino
    reg [4:0] rs1; // seletor de registrador 1
    reg [4:0] rs2; // seletor de registrador 2
    reg [4:0] rd; // seletor do registrador destino
    integer i;

    // módulo em teste: regfile
    regfile UUT (.clk(clk), .rd(rd), .rd_in(rd_in), .rs1(rs1), .rs2(rs2), .rs1_out(rs1_out), .rs2_out(rs2_out));

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0,clk, rd, rd_in, rs1, rs2, rs1_out, rs2_out);
        clk = 0;
        for (i = 0; i < 50; i = i + 1) begin
            rd_in = $urandom;
            rd = $urandom%32;
            rs1 = rd;
            rs2 = rd;
            #10;
            clk = ~clk;
            #10;
            $monitor("rd: %d rs1: %d rs2: %d rd_in: %d rs1_out: %d rs2_out %d", rd, rs1, rs2, rd_in, rs1_out, rs2_out);
            clk = ~clk;
        end
        $display("Finished");
        $stop;
    end
    

endmodule