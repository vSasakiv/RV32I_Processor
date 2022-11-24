/* Módulo responsável pela operação Left Logical Shift 
Recebe um número de 32 bits A e shifta ele para esquerda na quantidade especificada pelos 5 LSB de B */
module LeftLShifter ( 
    input wire [31:0] A, B,
    output [31:0] S
    );
    
    assign S = A << B[4:0];

endmodule