module reg32bit (
    input clk,
    input rs_i,
    input [31:0] data_i,
    output reg [31:0] data_o
);
    
    always @(posedge clk) begin
      if (rs_i) begin
        data_o <= 32'h00000000;
      end
      else begin
        data_o <= data_i;
      end
    end

endmodule
