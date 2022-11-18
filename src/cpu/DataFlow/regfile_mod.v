module regfile (
    input clk,
    input rs_i,
    input [4:0] rd,
    input [4:0] ra,
    input [4:0] rb,
    input [31:0] rd_in,
    output [31:0] ra_out,
    output [31:0] rb_out
);

reg [31:0] r1;
reg [31:0] r2;
reg [31:0] r3;
reg [31:0] r4;
reg [31:0] r5;
reg [31:0] r6;
reg [31:0] r7;
reg [31:0] r8;
reg [31:0] r9;
reg [31:0] r10;
reg [31:0] r11;
reg [31:0] r12;
reg [31:0] r13;
reg [31:0] r14;
reg [31:0] r15;
reg [31:0] r16;
reg [31:0] r17;
reg [31:0] r18;
reg [31:0] r19;
reg [31:0] r20;
reg [31:0] r21;
reg [31:0] r22;
reg [31:0] r23;
reg [31:0] r24;
reg [31:0] r25;
reg [31:0] r26;
reg [31:0] r27;
reg [31:0] r28;
reg [31:0] r29;
reg [31:0] r30;
reg [31:0] r31;

reg [31:0] ra_out_value;
reg [31:0] rb_out_value;


always @(posedge clk) begin
    if (rs_i) begin
      r1 <= 32'h00000000;
      r2 <= 32'h00000000;
      r3 <= 32'h00000000;
      r4 <= 32'h00000000;
      r5 <= 32'h00000000;
      r6 <= 32'h00000000;
      r7 <= 32'h00000000;
      r8 <= 32'h00000000;
      r9 <= 32'h00000000;
      r10 <= 32'h00000000;
      r11 <= 32'h00000000;
      r12 <= 32'h00000000;
      r13 <= 32'h00000000;
      r14 <= 32'h00000000;
      r15 <= 32'h00000000;
      r16 <= 32'h00000000;
      r17 <= 32'h00000000;
      r18 <= 32'h00000000;
      r19 <= 32'h00000000;
      r20 <= 32'h00000000;
      r21 <= 32'h00000000;
      r22 <= 32'h00000000;
      r23 <= 32'h00000000;
      r24 <= 32'h00000000;
      r25 <= 32'h00000000;
      r26 <= 32'h00000000;
      r27 <= 32'h00000000;
      r28 <= 32'h00000000;
      r29 <= 32'h00000000;
      r30 <= 32'h00000000;
      r31 <= 32'h00000000;
    end
    else begin
      if (rd == 5'd1) r1 <= rd_in;
      if (rd == 5'd2) r2 <= rd_in;
      if (rd == 5'd3) r3 <= rd_in;
      if (rd == 5'd4) r4 <= rd_in;
      if (rd == 5'd5) r5 <= rd_in;
      if (rd == 5'd6) r6 <= rd_in;
      if (rd == 5'd7) r7 <= rd_in;
      if (rd == 5'd8) r8 <= rd_in;
      if (rd == 5'd9) r9 <= rd_in;
      if (rd == 5'd10) r10 <= rd_in;
      if (rd == 5'd11) r11 <= rd_in;
      if (rd == 5'd12) r12 <= rd_in;
      if (rd == 5'd13) r13 <= rd_in;
      if (rd == 5'd14) r14 <= rd_in;
      if (rd == 5'd15) r15 <= rd_in;
      if (rd == 5'd16) r16 <= rd_in;
      if (rd == 5'd17) r17 <= rd_in;
      if (rd == 5'd18) r18 <= rd_in;
      if (rd == 5'd19) r19 <= rd_in;
      if (rd == 5'd20) r20 <= rd_in;
      if (rd == 5'd21) r21 <= rd_in;
      if (rd == 5'd22) r22 <= rd_in;
      if (rd == 5'd23) r23 <= rd_in;
      if (rd == 5'd24) r24 <= rd_in;
      if (rd == 5'd25) r25 <= rd_in;
      if (rd == 5'd26) r26 <= rd_in;
      if (rd == 5'd27) r27 <= rd_in;
      if (rd == 5'd28) r28 <= rd_in;
      if (rd == 5'd29) r29 <= rd_in;
      if (rd == 5'd30) r30 <= rd_in;
      if (rd == 5'd31) r31 <= rd_in;
    end
end

always @(*) begin
    begin
        case (ra)
            5'd0: ra_out_value = 32'h00000000;
            5'd1: ra_out_value = r1;
            5'd2: ra_out_value = r2;
            5'd3: ra_out_value = r3;
            5'd4: ra_out_value = r4;
            5'd5: ra_out_value = r5;
            5'd6: ra_out_value = r6;
            5'd7: ra_out_value = r7;
            5'd8: ra_out_value = r8;
            5'd9: ra_out_value = r9;
            5'd10: ra_out_value = r10;
            5'd11: ra_out_value = r11;
            5'd12: ra_out_value = r12;
            5'd13: ra_out_value = r13;
            5'd14: ra_out_value = r14;
            5'd15: ra_out_value = r15;
            5'd16: ra_out_value = r16;
            5'd17: ra_out_value = r17;
            5'd18: ra_out_value = r18;
            5'd19: ra_out_value = r19;
            5'd20: ra_out_value = r20;
            5'd21: ra_out_value = r21;
            5'd22: ra_out_value = r22;
            5'd23: ra_out_value = r23;
            5'd24: ra_out_value = r24;
            5'd25: ra_out_value = r25;
            5'd26: ra_out_value = r26;
            5'd27: ra_out_value = r27;
            5'd28: ra_out_value = r28;
            5'd29: ra_out_value = r29;
            5'd30: ra_out_value = r30;
            5'd31: ra_out_value = r31;
            default: ra_out_value = 32'hxxxxxxxx;
        endcase
    end
    begin
        case (rb)
            5'd0: rb_out_value = 32'h00000000;
            5'd1: rb_out_value = r1;
            5'd2: rb_out_value = r2;
            5'd3: rb_out_value = r3;
            5'd4: rb_out_value = r4;
            5'd5: rb_out_value = r5;
            5'd6: rb_out_value = r6;
            5'd7: rb_out_value = r7;
            5'd8: rb_out_value = r8;
            5'd9: rb_out_value = r9;
            5'd10: rb_out_value = r10;
            5'd11: rb_out_value = r11;
            5'd12: rb_out_value = r12;
            5'd13: rb_out_value = r13;
            5'd14: rb_out_value = r14;
            5'd15: rb_out_value = r15;
            5'd16: rb_out_value = r16;
            5'd17: rb_out_value = r17;
            5'd18: rb_out_value = r18;
            5'd19: rb_out_value = r19;
            5'd20: rb_out_value = r20;
            5'd21: rb_out_value = r21;
            5'd22: rb_out_value = r22;
            5'd23: rb_out_value = r23;
            5'd24: rb_out_value = r24;
            5'd25: rb_out_value = r25;
            5'd26: rb_out_value = r26;
            5'd27: rb_out_value = r27;
            5'd28: rb_out_value = r28;
            5'd29: rb_out_value = r29;
            5'd30: rb_out_value = r30;
            5'd31: rb_out_value = r31;
            default: ra_out_value = 32'hxxxxxxxx;
        endcase
    end
end
assign ra_out = ra_out_value;
assign rb_out = rb_out_value;

endmodule