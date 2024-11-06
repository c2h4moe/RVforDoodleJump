// module priority_encoder164 (
//     input [15:0] a,
//     output [3:0] num,
//     output en
// );
// wire [1:0] level1_en;
// wire [2:0] level1_num[1:0];
// priority_encoder83 inst0(
//     .a(a[7:0]),
//     .num(level1_num[0]),
//     .en(level1_en[0])
// );
// priority_encoder83 inst1(
//     .a(a[15:8]),
//     .num(level1_num[1]),
//     .en(level1_en[1])
// );
// assign num = level1_en[1] ? {1'b1, level1_num[1]} : {1'b0, level1_num[0]};
// assign en = level1_en[0] | level1_en[1];
// endmodule
module priority_encoder164 (
    input  wire [15:0] a,     // 16-bit input
    output reg  [3:0]  num,    // 4-bit encoded output
    output reg         en   // valid output indicator
);

    always @(*) begin
        casez (a)
            16'b1???????????????: begin num = 4'd15; en = 1'b1; end
            16'b01??????????????: begin num = 4'd14; en = 1'b1; end
            16'b001?????????????: begin num = 4'd13; en = 1'b1; end
            16'b0001????????????: begin num = 4'd12; en = 1'b1; end
            16'b00001???????????: begin num = 4'd11; en = 1'b1; end
            16'b000001??????????: begin num = 4'd10; en = 1'b1; end
            16'b0000001?????????: begin num = 4'd9;  en = 1'b1; end
            16'b00000001????????: begin num = 4'd8;  en = 1'b1; end
            16'b000000001???????: begin num = 4'd7;  en = 1'b1; end
            16'b0000000001??????: begin num = 4'd6;  en = 1'b1; end
            16'b00000000001?????: begin num = 4'd5;  en = 1'b1; end
            16'b000000000001????: begin num = 4'd4;  en = 1'b1; end
            16'b0000000000001???: begin num = 4'd3;  en = 1'b1; end
            16'b00000000000001??: begin num = 4'd2;  en = 1'b1; end
            16'b000000000000001?: begin num = 4'd1;  en = 1'b1; end
            16'b0000000000000001: begin num = 4'd0;  en = 1'b1; end
            16'b0000000000000000: begin num = 4'd0;  en = 1'b0; end
        endcase
    end

endmodule