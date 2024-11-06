// module priority_encoder83 (
//     input [7:0] a,
//     output [2:0] num,
//     output en
// );
// wire level1_en[3:0];
// wire level2_en[1:0];
// wire [2:0] level1_num[3:0];
// wire [2:0] level2_num[1:0];
// assign level1_en[0] = a[0] | a[1];
// assign level1_en[1] = a[2] | a[3];
// assign level1_en[2] = a[4] | a[5];
// assign level1_en[3] = a[6] | a[7];
// assign level2_en[0] = level1_en[0] | level1_en[1];
// assign level2_en[1] = level1_en[2] | level1_en[3];
// assign level1_num[0] = a[1] ? 1 : 0;
// assign level1_num[1] = a[3] ? 3 : 2;
// assign level1_num[2] = a[5] ? 5 : 4;
// assign level1_num[3] = a[7] ? 7 : 6;
// assign level2_num[0] = level1_en[1] ? level1_num[1] : level1_num[0];
// assign level2_num[1] = level1_en[3] ? level1_num[3] : level1_num[2];
// assign num = level2_en[1] ? level2_num[1] : level2_num[0];
// assign en = level2_en[0] | level2_en[1];
// endmodule
module priority_encoder83 (
    input [7:0] a,
    output reg [2:0] num,
    output en
);

assign en = |a;

always @(*) begin
    casez (a)
        8'b1???????: num = 3'd7;
        8'b01??????: num = 3'd6;
        8'b001?????: num = 3'd5;
        8'b0001????: num = 3'd4;
        8'b00001???: num = 3'd3;
        8'b000001??: num = 3'd2;
        8'b0000001?: num = 3'd1;
        8'b00000001: num = 3'd0;
        default: num = 3'd0;
    endcase
end

endmodule
// module priority_encoder_8to3 (
//     input  [7:0] a,
//     output [2:0] y,
//     output       en
// );
//     assign en = |a;
//     assign y = (a[7] ? 3'd7 :
//                (a[6] ? 3'd6 :
//                (a[5] ? 3'd5 :
//                (a[4] ? 3'd4 :
//                (a[3] ? 3'd3 :
//                (a[2] ? 3'd2 :
//                (a[1] ? 3'd1 :
//                (a[0] ? 3'd0 : 3'd0))))))));
// endmodule