module memsx (
    input [2:0] mem_size,
    input [31:0] mem_value,
    output [31:0] mem_extend
);
reg [31:0] mem_extend_r;

always @(*) begin
    case (mem_size)
        3'b000: mem_extend_r = {{24{mem_value[7]}},mem_value[7:0]};
        3'b001: mem_extend_r = {{16{mem_value[15]}}, mem_value[15:0]};
        3'b010: mem_extend_r = mem_value;
        3'b100: mem_extend_r = {{24{1'b0}}, mem_value[7:0]};
        3'b101: mem_extend_r = {{16{1'b0}}, mem_value[15:0]};
        default: mem_extend_r = 32'hxxxxxxxx;
    endcase    
end
assign mem_extend = mem_extend_r;

endmodule
