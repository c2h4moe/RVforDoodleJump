module priority_encoder42 (
    input [3:0] a,
    output reg [1:0] num,
    output reg en
);

always @(*) begin
    en = |a;
    casez (a)
        4'b1???: num = 2'd3;
        4'b01??: num = 2'd2;
        4'b001?: num = 2'd1;
        4'b0001: num = 2'd0;
        default: num = 2'd0;
    endcase
end
endmodule