`timescale 1ns / 100ps

module mux_pc_TB ();
    reg [31:0] I0, I1;
    reg A0, correct_Q;
    wire Q;
    integer errors, i, j;

task Check;
    input xpectQ;
    if (Q != xpectQ) begin 
        $display ("Error I0: %32b, I1: %32b, expected %32b, got Q: %32b", I0, I1, xpectQ, Q);
        errors = errors + 1;
    end
endtask

mux_pc UUT (.I0(I0), .I1(I1), .A0(A0), .Q(Q));

initial begin
    errors = 0;
    A0 = 0; //parametro para o test, com 0 quando I0 eh selecionado e 1 quando A1 eh selecionado

    for (i = 0; i < 1; i = i + 1)
        for (j = 0; j < 1; j = j + 1) begin
            I0 = i;
            I1 = j;
            correct_Q = (I0 & ~A0) | (I0 & A0);
            #10
            check(correct_Q);
            end
    $display ("Finished, got %2d errors", errors);
end

endmodule
     
