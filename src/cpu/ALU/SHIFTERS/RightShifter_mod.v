/* Módulo responsável por dar Right Logical Shift ou Right Arithmetic Shift
Recebe dois números de 32 bits, A e B, e shifta A para direita na quantidade especificada pelos 5 LSB de B.
Resultado é atribuido na saída Shifted.
Caso SRA for 1, executa um arithmetic shift, caso contrário (igual a 0) executa um logical shift */
module RightShifter (
    input signed [31:0] A, B,
    input SRA,
    output reg [31:0] Shifted
);
    always @ (A, B, SRA)
        if (SRA == 0) 
            Shifted = A >> B[4:0];
        else 
            Shifted = A >>> B[4:0];

endmodule