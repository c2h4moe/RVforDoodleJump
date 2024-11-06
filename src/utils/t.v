module priority_encoder_16_4 (
    input  wire [15:0] in,     // 16-bit input
    output reg  [3:0]  out,    // 4-bit encoded output
    output reg         valid   // valid output indicator
);

    always @(*) begin
        casez (in)
            16'b1???????????????: begin out = 4'd15; valid = 1'b1; end
            16'b01??????????????: begin out = 4'd14; valid = 1'b1; end
            16'b001?????????????: begin out = 4'd13; valid = 1'b1; end
            16'b0001????????????: begin out = 4'd12; valid = 1'b1; end
            16'b00001???????????: begin out = 4'd11; valid = 1'b1; end
            16'b000001??????????: begin out = 4'd10; valid = 1'b1; end
            16'b0000001?????????: begin out = 4'd9;  valid = 1'b1; end
            16'b00000001????????: begin out = 4'd8;  valid = 1'b1; end
            16'b000000001???????: begin out = 4'd7;  valid = 1'b1; end
            16'b0000000001??????: begin out = 4'd6;  valid = 1'b1; end
            16'b00000000001?????: begin out = 4'd5;  valid = 1'b1; end
            16'b000000000001????: begin out = 4'd4;  valid = 1'b1; end
            16'b0000000000001???: begin out = 4'd3;  valid = 1'b1; end
            16'b00000000000001??: begin out = 4'd2;  valid = 1'b1; end
            16'b000000000000001?: begin out = 4'd1;  valid = 1'b1; end
            16'b0000000000000001: begin out = 4'd0;  valid = 1'b1; end
            16'b0000000000000000: begin out = 4'd0;  valid = 1'b0; end
        endcase
    end

endmodule