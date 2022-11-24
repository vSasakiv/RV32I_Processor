`timescale 1 ns / 100 ps

module immxTB ();
    wire [31:0] imm;
    reg [31:0] insn;
    reg [6:0] opcodes [0:8];


    integer i;

    immx UUT (.insn(insn), .imm(imm));

    initial begin
        opcodes[0] = 7'b0110111;
        opcodes[1] = 7'b0010111;
        opcodes[2] = 7'b1101111;
        opcodes[3] = 7'b1100111;
        opcodes[4] = 7'b0010011;
        opcodes[5] = 7'b0000011;
        opcodes[6] = 7'b1100011;
        opcodes[7] = 7'b0100011;
        opcodes[8] = 7'b1110011; 
        $monitor("insn : %b opcode: %b imm : %b", insn, insn[6:0], imm);
        for (i = 0; i < 50; i = i+1) begin
            insn = $urandom;
            insn[6:0] = opcodes[$urandom%9];
            #10;
        end
        $display("Finished");
        $stop;
    end
    

endmodule