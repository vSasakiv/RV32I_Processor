/* Testbench para o módulo memory extender. São sorteados aleatóriamente os valores da memória 
e o tamanho da extensão, são expostos, juntamente com a saída do módulo ao terminal por meio
do $monitor */
`timescale 1 ns / 100 ps

module memsx_TB ();
    wire [31:0] mem_extend; // resultado de saída do módulo
    reg [31:0] mem_value; // valor da memória
    reg [2:0] mem_size; // tamanho da extensão

    integer i;
    // módulo em teste: memory extender
    memsx UUT (.mem_size(mem_size), .mem_value(mem_value), .mem_extend(mem_extend));

    initial begin
        $monitor("mem value: %h mem extended: %h sx size: %h",mem_value, mem_extend, mem_size);
        for (i = 0; i < 50; i = i + 1) begin
            mem_value = $urandom;
            mem_size = $urandom%5;
            if (mem_size == 3'd3) begin
                mem_size = 3'd5;
            end
            #10;
        end
        $display("Finished");
        $stop;
    end
    

endmodule