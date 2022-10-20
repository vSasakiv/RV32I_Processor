/*MUX para U13, U14, U17, e U21*/

module mux_geral (
    input wire [31:0] I0, I1, //duas entradas de 32bits
    input wire A0, //slecionador da saida
    output reg [31:0] Q//saida
);

    always @ (*)
    case (A0)
        0 : Q <= I0;
        1 : Q <= I1;
    endcase
endmodule
