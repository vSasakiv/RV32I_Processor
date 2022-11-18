module reg32bit (
    input clk,
    input rs_i,
    input [31:0] din,
    output reg [31:0] dout
);
    
    always @(posedge clk) begin
      if (rs_i) begin
        dout <= 32'h00000000;
      end
      else begin
        dout <= din;
      end
    end

endmodule
