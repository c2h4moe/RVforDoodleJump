module doodle_controller (
    input vga_clk,
    input [10:0] vga_haddr,
    input [10:0] vga_vaddr,
    output [11:0] vga_data
);
wire ball_en;
wire [7 : 0] ball_a;
wire [12 : 0] ball_data;
ball ball_inst (
  .a(ball_a),      // input wire [7 : 0] a
  .spo(ball_data)  // output wire [15 : 0] spo
);
assign ball_en = (vga_haddr >= 11'd640 && vga_haddr < 11'd655) && (vga_vaddr >= 11'd512 && vga_vaddr < 11'd527);
assign ball_a = ball_en?(vga_haddr-11'd640)*15+vga_vaddr - 11'd512:0;
wire doodle_en;
wire [13 : 0] doodle_a;
wire [12 : 0] doodle_data;
doodle doodle_inst (
  .a(doodle_a),      // input wire [13 : 0] a
  .spo(doodle_data)  // output wire [12 : 0] spo
);
assign doodle_en = (vga_haddr >= 11'd0 && vga_haddr < 11'd100) && (vga_vaddr >= 11'd0 && vga_vaddr < 11'd90);
assign doodle_a = doodle_en?(vga_haddr-11'd0)*90+vga_vaddr - 11'd0:0;
wire green_platform_en;
wire [11 : 0] green_platform_a;
wire [12 : 0] green_platform_data;
green_platform green_platform_inst (
  .a(green_platform_a),      // input wire [11 : 0] a
  .spo(green_platform_data)  // output wire [12 : 0] spo
);
assign green_platform_en = (vga_haddr >= 11'd0 && vga_haddr < 11'd90) && (vga_vaddr >= 11'd60 && vga_vaddr < 11'd83);
assign green_platform_a = green_platform_en?(vga_haddr-11'd0)*23+vga_vaddr - 11'd60:0;

wire brown_platform_breaking_4_en;
wire [12 : 0] brown_platform_breaking_4_a;
wire [12 : 0] brown_platform_breaking_4_data;
assign brown_platform_breaking_4_en = (vga_haddr >= 11'd0 && vga_haddr < 11'd90) && (vga_vaddr >= 11'd83 && vga_vaddr < 11'd134);
assign brown_platform_breaking_4_a = brown_platform_breaking_4_en?(vga_haddr-11'd0)*51+vga_vaddr - 11'd83:0;
brown_platform_breaking_4 bp4 (
  .a(brown_platform_breaking_4_a),      // input wire [12 : 0] a
  .spo(brown_platform_breaking_4_data)  // output wire [12 : 0] spo
);
wire light_blue_platform_en;
wire [11 : 0] light_blue_platform_a;
wire [12 : 0] light_blue_platform_data;
assign light_blue_platform_en = (vga_haddr >= 11'd0 && vga_haddr < 11'd90) && (vga_vaddr >= 11'd134 && vga_vaddr < 11'd157);
assign light_blue_platform_a = light_blue_platform_en?(vga_haddr-11'd0)*23+vga_vaddr - 11'd134:0;
light_blue_platform lbp (
  .a(light_blue_platform_a),      // input wire [11 : 0] a
  .spo(light_blue_platform_data)  // output wire [12 : 0] spo
);
wire spring_compressed_en;
wire [9 : 0] spring_compressed_a;
wire [12 : 0] spring_compressed_data;
assign spring_compressed_en = (vga_haddr >= 11'd37 && vga_haddr < 11'd65) && (vga_vaddr >= 11'd157 && vga_vaddr < 11'd181);
assign spring_compressed_a = spring_compressed_en?(vga_haddr-11'd37)*24+vga_vaddr - 11'd157:0;
spring_compressed sc (
  .a(spring_compressed_a),      // input wire [9 : 0] a
  .spo(spring_compressed_data)  // output wire [12 : 0] spo
);
wire spring_full_en;
wire [9 : 0] spring_full_a;
wire [12 : 0] spring_full_data;
assign spring_full_en = (vga_haddr >= 11'd65 && vga_haddr < 11'd90) && (vga_vaddr >= 11'd157 && vga_vaddr < 11'd193);
assign spring_full_a = spring_full_en?(vga_haddr-11'd65)*36+vga_vaddr - 11'd157:0;
spring_full sf (
  .a(spring_full_a),      // input wire [9 : 0] a
  .spo(spring_full_data)  // output wire [12 : 0] spo
);
wire doodle_up_en;
wire [12 : 0] doodle_up_a;
wire [12 : 0] doodle_up_data;
assign doodle_up_en = (vga_haddr >= 11'd120 && vga_haddr < 11'd186) && (vga_vaddr >= 11'd0 && vga_vaddr < 11'd111);
assign doodle_up_a = doodle_up_en?(vga_haddr-11'd120)*111+vga_vaddr - 11'd0:0;
doodle_up du (
  .a(doodle_up_a),      // input wire [12 : 0] a
  .spo(doodle_up_data)  // output wire [12 : 0] spo
);
wire brown_platform_breaking_1_en;
wire [11 : 0] brown_platform_breaking_1_a;
wire [12 : 0] brown_platform_breaking_1_data;
assign brown_platform_breaking_1_en = (vga_haddr >= 11'd1 && vga_haddr < 11'd91) && (vga_vaddr >= 11'd500 && vga_vaddr < 11'd523);
assign brown_platform_breaking_1_a = brown_platform_breaking_1_en?(vga_haddr-11'd1)*23+vga_vaddr - 11'd500:0;
brown_platform_breaking_1 bp1 (
  .a(brown_platform_breaking_1_a),      // input wire [11 : 0] a
  .spo(brown_platform_breaking_1_data)  // output wire [12 : 0] spo
);
wire red_monster_en;
wire [12 : 0] red_monster_a;
wire [12 : 0] red_monster_data;
assign red_monster_en = (vga_haddr >= 11'd300 && vga_haddr < 11'd375) && (vga_vaddr >= 11'd0 && vga_vaddr < 11'd59);
assign red_monster_a = red_monster_en?(vga_haddr-11'd300)*59+vga_vaddr - 11'd0:0;
red_monster rm (
  .a(red_monster_a),      // input wire [12 : 0] a
  .spo(red_monster_data)  // output wire [12 : 0] spo
);
wire purple_monster_en;
wire [12 : 0] purple_monster_a;
wire [12 : 0] purple_monster_data;
assign purple_monster_en = (vga_haddr >= 11'd300 && vga_haddr < 11'd382) && (vga_vaddr >= 11'd80 && vga_vaddr < 11'd153);
assign purple_monster_a = purple_monster_en?(vga_haddr-11'd300)*73+vga_vaddr - 11'd80:0;
purple_monster pm (
  .a(purple_monster_a),      // input wire [12 : 0] a
  .spo(purple_monster_data)  // output wire [12 : 0] spo
);
assign vga_data = doodle_en?(doodle_data[12]?doodle_data[11:0]:{4'd15,4'd15,4'd13}):
                    purple_monster_en?purple_monster_data[11:0]:
                    red_monster_en?red_monster_data[11:0]:
                    brown_platform_breaking_1_en?brown_platform_breaking_1_data[11:0]:
                    doodle_up_en?doodle_up_data[11:0]:
                    spring_full_en?spring_full_data[11:0]:
                    light_blue_platform_en?light_blue_platform_data[11:0]:
                    brown_platform_breaking_4_en?brown_platform_breaking_4_data[11:0]:
                    spring_compressed_en?spring_compressed_data[11:0]:
                    green_platform_en?green_platform_data[11:0]:
                    ball_en?ball_data[11:0]:{4'd15,4'd15,4'd13};
endmodule