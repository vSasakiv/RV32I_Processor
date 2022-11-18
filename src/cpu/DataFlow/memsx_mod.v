module memsx (
    input [2:0] mem_s,
    input [31:0] mem_v,
    output [31:0] mem_x
);
reg [31:0] mem_x_r;

always @(*) begin
    case (mem_s)
        3'b000: mem_x_r = {{24{mem_v[7]}},mem_v[7:0]};
        3'b001: mem_x_r = {{16{mem_v[15]}}, mem_v[15:0]};
        3'b010: mem_x_r = mem_v;
        3'b100: mem_x_r = {{24{1'b0}}, mem_v[7:0]};
        3'b101: mem_x_r = {{16{1'b0}}, mem_v[15:0]};
        default: mem_x_r = 32'hxxxxxxxx;
    endcase    
end
assign mem_x = mem_x_r;

endmodule
