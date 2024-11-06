`timescale 1ns / 1ps
`define BROWN_PLATFORM_BREAKING_1_W 90
`define BROWN_PLATFORM_BREAKING_1_H 23
`define BROWN_PLATFORM_BREAKING_2_W 90
`define BROWN_PLATFORM_BREAKING_2_H 29
`define BROWN_PLATFORM_BREAKING_3_W 90
`define BROWN_PLATFORM_BREAKING_3_H 42
`define BROWN_PLATFORM_BREAKING_4_W 90
`define BROWN_PLATFORM_BREAKING_4_H 51
`define GREEN_PLATFORM_W 90
`define GREEN_PLATFORM_H 23
`define LIGHT_BLUE_PLATFORM_W 90
`define LIGHT_BLUE_PLATFORM_H 23
`define PURPLE_MONSTER_W 82
`define PURPLE_MONSTER_H 73
`define RED_MONSTER_W 75
`define RED_MONSTER_H 59
`define SPRING_COMPRESSED_W 28
`define SPRING_COMPRESSED_H 24
`define SPRING_FULL_W 25
`define SPRING_FULL_H 36
`define PROPELLER_W 40
`define PROPELLER_H 27
`define PROPELLER_RUNNING_W 40
`define PROPELLER_RUNNING_H 31
`define BALL_W 15
`define BALL_H 15
`define DOODLE_W 100
`define DOODLE_H 90
`define DOODLE_UP_W 66
`define DOODLE_UP_H 111
module doodle_renderer(
    input clk,
    input [31:0] addr,
    input [31:0] din,
    input we,
    input [10:0] vga_haddr,
    input [10:0] vga_vaddr,
    output reg [11:0] vga_data
);

reg [23:0] platforms[15:0];
reg [23:0] break_platforms[7:0];
reg [23:0] monsters[1:0];
reg [22:0] balls[9:0];
reg [24:0] tools[7:0];
reg [23:0] role;
integer i = 0;
initial begin
    for (i = 0; i < 16; i = i + 1) begin
        platforms[i] = 0;
    end
    monsters[0] = 0;
    monsters[1] = 0;
    for (i = 0; i < 10; i = i + 1) begin
        balls[i] = 0;
    end
    for (i = 0; i < 8; i = i + 1) begin
        tools[i] = 0;
        break_platforms[i] = 0;
    end
    role = 0;
end
always @(posedge clk) begin
    if(we) begin
        case (addr[9:6])
            4'd0: platforms[addr[5:2]] <= din[23:0];
            4'd1: break_platforms[addr[4:2]] <= din[24:0];
            4'd2: monsters[addr[2]] <= din[23:0];
            4'd3: balls[addr[5:2]] <= din[22:0];
            4'd4: tools[addr[4:2]] <= din[24:0];
            4'd5: role <= din[23:0];
        endcase
    end
end

// Internal wires for image addresses and data
reg [7:0] ball_addr;               // 15*15 = 225 -> 240
reg [11:0] brown_platform_breaking_1_addr; // 90*23 = 2070 -> 2080
//reg [11:0] brown_platform_breaking_2_addr; // 90*29 = 2610 -> 2624
reg [11:0] brown_platform_breaking_3_addr; // 90*42 = 3780 -> 3792
//reg [12:0] brown_platform_breaking_4_addr; // 90*51 = 4590 -> 4608
reg [13:0] doodle_addr;            // 100*90 = 9000 -> 9008
reg [12:0] doodle_up_addr;         // 66*111 = 7326 -> 7328
reg [11:0] green_platform_addr;     // 90*23 = 2070 -> 2080
reg [11:0] light_blue_platform_addr; // 90*23 = 2070 -> 2080
reg [12:0] purple_monster_addr;     // 82*73 = 5986 -> 6000
reg [12:0] red_monster_addr;        // 75*59 = 4425 -> 4432
reg [9:0] spring_compressed_addr;  // 28*24 = 672 -> 688
reg [9:0] spring_full_addr;        // 25*36 = 900 -> 912
reg [10:0] propeller_addr;         // 40*27 = 1080 -> 1088
reg [10:0] propeller_running_addr; // 40*31 = 1240 -> 1248

reg [7:0] ball_addr_array[9:0];               // 15*15 = 225 -> 240
reg [11:0] brown_platform_breaking_1_addr_array[7:0]; // 90*23 = 2070 -> 2080
//reg [11:0] brown_platform_breaking_2_addr_array[7:0]; // 90*29 = 2610 -> 2624
reg [11:0] brown_platform_breaking_3_addr_array[7:0]; // 90*42 = 3780 -> 3792
//reg [12:0] brown_platform_breaking_4_addr_array[7:0]; // 90*51 = 4590 -> 4608
reg [11:0] green_platform_addr_array[15:0];     // 90*23 = 2070 -> 2080
reg [11:0] light_blue_platform_addr_array[15:0]; // 90*23 = 2070 -> 2080
reg [12:0] purple_monster_addr_array[1:0];     // 82*73 = 5986 -> 6000
reg [12:0] red_monster_addr_array[1:0];        // 75*59 = 4425 -> 4432
reg [9:0] spring_compressed_addr_array[7:0];  // 28*24 = 672 -> 688
reg [9:0] spring_full_addr_array[7:0];        // 25*36 = 900 -> 912
reg [10:0] propeller_addr_array[7:0];         // 40*27 = 1080 -> 1088
reg [10:0] propeller_running_addr_array[7:0]; // 40*31 = 1240 -> 1248

wire [12:0] ball_data;
wire [12:0] brown_platform_breaking_1_data;
wire [12:0] brown_platform_breaking_2_data;
wire [12:0] brown_platform_breaking_3_data;
wire [12:0] brown_platform_breaking_4_data;
wire [12:0] doodle_data;
wire [12:0] doodle_up_data;
wire [12:0] green_platform_data;
wire [12:0] light_blue_platform_data;
wire [12:0] purple_monster_data;
wire [12:0] red_monster_data;
wire [12:0] spring_compressed_data;
wire [12:0] spring_full_data;
wire [12:0] propeller_data;
wire [12:0] propeller_running_data;

// wire [9:0] ball_en_array;
// wire [7:0] brown_platform_breaking_1_en_array;
// wire [7:0] brown_platform_breaking_2_en_array;
// wire [7:0] brown_platform_breaking_3_en_array;
// wire [7:0] brown_platform_breaking_4_en_array;
// wire [15:0] green_platform_en_array;
// wire [15:0] light_blue_platform_en_array;
// wire [1:0] purple_monster_en_array;
// wire [1:0] red_monster_en_array;
// wire [7:0] spring_compressed_en_array;
// wire [7:0] spring_full_en_array;
// wire [7:0] propeller_en_array;
// wire [7:0] propeller_running_en_array;

// Instantiate all image modules
ball ball_inst(
    .a(ball_addr),
    .spo(ball_data)
);

brown_platform_breaking_1 brown_platform_breaking_1_inst(
    .a(brown_platform_breaking_1_addr),
    .spo(brown_platform_breaking_1_data)
);

brown_platform_breaking_2 brown_platform_breaking_2_inst(
    .a(brown_platform_breaking_2_addr),
    .spo(brown_platform_breaking_2_data)
);

brown_platform_breaking_3 brown_platform_breaking_3_inst(
    .a(brown_platform_breaking_3_addr),
    .spo(brown_platform_breaking_3_data)
);

brown_platform_breaking_4 brown_platform_breaking_4_inst(
    .a(brown_platform_breaking_4_addr),
    .spo(brown_platform_breaking_4_data)
);

doodle doodle_inst(
    .a(doodle_addr),
    .spo(doodle_data)
);

doodle_up doodle_up_inst(
    .a(doodle_up_addr),
    .spo(doodle_up_data)
);

green_platform green_platform_inst(
    .a(green_platform_addr),
    .spo(green_platform_data)
);

light_blue_platform light_blue_platform_inst(
    .a(light_blue_platform_addr),
    .spo(light_blue_platform_data)
);

purple_monster purple_monster_inst(
    .a(purple_monster_addr),
    .spo(purple_monster_data)
);

red_monster red_monster_inst(
    .a(red_monster_addr),
    .spo(red_monster_data)
);

spring_compressed spring_compressed_inst(
    .a(spring_compressed_addr),
    .spo(spring_compressed_data)
);

spring_full spring_full_inst(
    .a(spring_full_addr),
    .spo(spring_full_data)
);

propeller propeller_inst(
    .a(propeller_addr),
    .spo(propeller_data)
);

propeller_running propeller_running_inst(
    .a(propeller_running_addr),
    .spo(propeller_running_data)
);

wire [3:0] platform_num;
wire platform_en;
wire [2:0] break_platform_num;
wire break_platform_en; 
wire [3:0] ball_num;
wire ball_en;
wire [2:0] tool_num;
wire tool_en;
wire monster_num;
wire monster_en;
reg role_en;

reg [15:0] platform_en_array;
reg [7:0] break_platform_en_array;
reg [1:0] monster_en_array;
reg [9:0] ball_en_array;
reg [7:0] tool_en_array;

priority_encoder164 platform_encoder(
    .a(platform_en_array),
    .num(platform_num),
    .en(platform_en)
);

priority_encoder83 break_platform_encoder(
    .a(break_platform_en_array),
    .num(break_platform_num),
    .en(break_platform_en)
);

priority_encoder164 ball_encoder(
    .a({6'b0, ball_en_array}),
    .num(ball_num),
    .en(ball_en)
);

priority_encoder83 tool_encoder(
    .a(tool_en_array),
    .num(tool_num),
    .en(tool_en)
);

assign monster_num = monster_en_array[1] ? 1 : 0;
assign monster_en = |monster_en_array;

reg [12:0] platform_final_data;
reg [12:0] break_platform_final_data;
reg [12:0] monster_final_data;
reg [12:0] ball_final_data;
reg [12:0] tool_final_data;
reg [12:0] role_final_data;

always @(*) begin
    // Assign final data based on selected addresses
    if (platform_en) begin
        case (platforms[platform_num][23:22])
            2'd1: platform_final_data = green_platform_data;
            2'd2: platform_final_data = light_blue_platform_data;
            default: platform_final_data = 0;
        endcase
    end else begin
        platform_final_data = 0;
    end

    if (break_platform_en) begin
        case (break_platforms[break_platform_num][24:22])
            3'd1: break_platform_final_data = brown_platform_breaking_1_data; 
            3'd2: break_platform_final_data = brown_platform_breaking_2_data;
            3'd3: break_platform_final_data = brown_platform_breaking_3_data;
            3'd4: break_platform_final_data = brown_platform_breaking_4_data;
            default: break_platform_final_data = 0;
        endcase
    end else begin
        break_platform_final_data = 0;
    end
            
    if (monster_en) begin
        case (monsters[monster_num][23:22])
            2'd1: monster_final_data = purple_monster_data;
            2'd2: monster_final_data = red_monster_data;
            default: monster_final_data = 0;
        endcase
    end else begin
        monster_final_data = 0;
    end

    if (ball_en) begin
        ball_final_data = ball_data;
    end else begin
        ball_final_data = 0;
    end

    if (tool_en) begin
        case (tools[tool_num][24:22])
            3'd1: tool_final_data = spring_compressed_data;
            3'd2: tool_final_data = spring_full_data; 
            3'd3: tool_final_data = propeller_data;
            3'd4: tool_final_data = propeller_running_data;
            default: tool_final_data = 0;
        endcase
    end else begin
        tool_final_data = 0;
    end

    if (role_en) begin
        case (role[23:22])
            2'd1, 2'd2: role_final_data = doodle_data;
            2'd3: role_final_data = doodle_up_data;
            default: role_final_data = 0;
        endcase
    end else begin
        role_final_data = 0;
    end
end

// Platform images address calculation
always @(*) begin
    platform_en_array = 0;
    for (integer i = 0; i < 16; i = i + 1) begin
        green_platform_addr_array[i] = 0;
        light_blue_platform_addr_array[i] = 0;
        if (platforms[i][23:22] != 0) begin
            if (vga_haddr >= platforms[i][21:11] && 
                vga_haddr < platforms[i][21:11] + get_platform_width(platforms[i][23:22]) &&
                vga_vaddr >= platforms[i][10:0] &&
                vga_vaddr < platforms[i][10:0] + get_platform_height(platforms[i][23:22])) begin
                case (platforms[i][23:22])
                    2'd1: green_platform_addr_array[i] = ((vga_vaddr - platforms[i][10:0]) << 6) + ((vga_vaddr - platforms[i][10:0]) << 4) + ((vga_vaddr - platforms[i][10:0]) << 3) + ((vga_vaddr - platforms[i][10:0]) << 1) + (vga_haddr - platforms[i][21:11]);
                    2'd2: light_blue_platform_addr_array[i] = ((vga_vaddr - platforms[i][10:0]) << 6) + ((vga_vaddr - platforms[i][10:0]) << 4) + ((vga_vaddr - platforms[i][10:0]) << 3) + ((vga_vaddr - platforms[i][10:0]) << 1) + (vga_haddr - platforms[i][21:11]);
                endcase
                platform_en_array[i] = 1;
            end
        end
    end
    green_platform_addr = green_platform_addr_array[platform_num];
    light_blue_platform_addr = light_blue_platform_addr_array[platform_num];
end

// Breaking platform images address calculation
always @(*) begin
    break_platform_en_array = 0;
    for (integer i = 0; i < 8; i = i + 1) begin
        brown_platform_breaking_1_addr_array[i] = 0;
        brown_platform_breaking_2_addr_array[i] = 0;
        brown_platform_breaking_3_addr_array[i] = 0;
        brown_platform_breaking_4_addr_array[i] = 0;
        if (break_platforms[i][24:22] != 0) begin
            if (vga_haddr >= break_platforms[i][21:11] && 
                vga_haddr < break_platforms[i][21:11] + get_break_platform_width(break_platforms[i][24:22]) &&
                vga_vaddr >= break_platforms[i][10:0] &&
                vga_vaddr < break_platforms[i][10:0] + get_break_platform_height(break_platforms[i][24:22])) begin
                case (break_platforms[i][24:22])
                    3'd1: brown_platform_breaking_1_addr_array[i] = ((vga_vaddr - break_platforms[i][10:0]) << 6)+((vga_vaddr - break_platforms[i][10:0]) << 4)+((vga_vaddr - break_platforms[i][10:0]) << 3)+((vga_vaddr - break_platforms[i][10:0]) << 1)+ (vga_haddr - break_platforms[i][21:11]);
                    3'd2: brown_platform_breaking_2_addr_array[i] = ((vga_vaddr - break_platforms[i][10:0]) << 6)+((vga_vaddr - break_platforms[i][10:0]) << 4)+((vga_vaddr - break_platforms[i][10:0]) << 3)+((vga_vaddr - break_platforms[i][10:0]) << 1) + (vga_haddr - break_platforms[i][21:11]);
                    3'd3: brown_platform_breaking_3_addr_array[i] = ((vga_vaddr - break_platforms[i][10:0]) << 6)+((vga_vaddr - break_platforms[i][10:0]) << 4)+((vga_vaddr - break_platforms[i][10:0]) << 3)+((vga_vaddr - break_platforms[i][10:0]) << 1) + (vga_haddr - break_platforms[i][21:11]);
                    3'd4: brown_platform_breaking_4_addr_array[i] = ((vga_vaddr - break_platforms[i][10:0]) << 6)+((vga_vaddr - break_platforms[i][10:0]) << 4)+((vga_vaddr - break_platforms[i][10:0]) << 3)+((vga_vaddr - break_platforms[i][10:0]) << 1) + (vga_haddr - break_platforms[i][21:11]);
                endcase
                break_platform_en_array[i] = 1;
            end
        end
    end
    brown_platform_breaking_1_addr = brown_platform_breaking_1_addr_array[break_platform_num];
    brown_platform_breaking_2_addr = brown_platform_breaking_2_addr_array[break_platform_num];
    brown_platform_breaking_3_addr = brown_platform_breaking_3_addr_array[break_platform_num];
    brown_platform_breaking_4_addr = brown_platform_breaking_4_addr_array[break_platform_num];
end

// Monster images address calculation  
always @(*) begin
    monster_en_array = 0;
    for (integer i = 0; i < 2; i = i + 1) begin
        purple_monster_addr_array[i] = 0;
        red_monster_addr_array[i] = 0;
        if (monsters[i][23:22] != 0) begin
            if (vga_haddr >= monsters[i][21:11] && 
                vga_haddr < monsters[i][21:11] + get_monster_width(monsters[i][23:22]) &&
                vga_vaddr >= monsters[i][10:0] &&
                vga_vaddr < monsters[i][10:0] + get_monster_height(monsters[i][23:22])) begin
                case (monsters[i][23:22])
                    2'd1: purple_monster_addr_array[i] = ((vga_vaddr - monsters[i][10:0]) << 6) +((vga_vaddr - monsters[i][10:0]) << 4)+((vga_vaddr - monsters[i][10:0]) << 1) + (vga_haddr - monsters[i][21:11]);
                    2'd2: red_monster_addr_array[i] = ((vga_vaddr - monsters[i][10:0])<<6)+ ((vga_vaddr - monsters[i][10:0])<<3)+((vga_vaddr - monsters[i][10:0])<<1)+((vga_vaddr - monsters[i][10:0])) + (vga_haddr - monsters[i][21:11]);
                endcase
                monster_en_array[i] = 1;
            end
        end
    end
    purple_monster_addr = purple_monster_addr_array[monster_num];
    red_monster_addr = red_monster_addr_array[monster_num];
end

// Ball images address calculation
always @(*) begin
    ball_en_array = 0;
    for (integer i = 0; i < 10; i = i + 1) begin
        ball_addr_array[i] = 0;
        if (balls[i][22] != 0) begin
            if (vga_haddr >= balls[i][21:11] && 
                vga_haddr < balls[i][21:11] + `BALL_W &&
                vga_vaddr >= balls[i][10:0] &&
                vga_vaddr < balls[i][10:0] + `BALL_H) begin
                ball_addr_array[i] = ((vga_vaddr - balls[i][10:0])<<3)+((vga_vaddr - balls[i][10:0])<<2)+((vga_vaddr - balls[i][10:0])<<1)+((vga_vaddr - balls[i][10:0]))+ (vga_haddr - balls[i][21:11]);
                ball_en_array[i] = 1;
            end
        end
    end
    ball_addr = ball_addr_array[ball_num];
end

// Tool images address calculation
always @(*) begin
    tool_en_array = 0;
    for (integer i = 0; i < 8; i = i + 1) begin
        spring_compressed_addr_array[i] = 0;
        spring_full_addr_array[i] = 0;
        propeller_addr_array[i] = 0;
        propeller_running_addr_array[i] = 0;
        if (tools[i][24:22] != 0) begin
            if (vga_haddr >= tools[i][21:11] && 
                vga_haddr < tools[i][21:11] + get_tools_width(tools[i][24:22]) &&
                vga_vaddr >= tools[i][10:0] &&
                vga_vaddr < tools[i][10:0] + get_tools_height(tools[i][24:22])) begin
                case (tools[i][24:22])
                    3'd1: spring_compressed_addr_array[i] = ((vga_vaddr - tools[i][10:0])<<4)+((vga_vaddr - tools[i][10:0])<<3)+((vga_vaddr - tools[i][10:0])<<2) + (vga_haddr - tools[i][21:11]);
                    3'd2: spring_full_addr_array[i] = ((vga_vaddr - tools[i][10:0])<<4)+((vga_vaddr - tools[i][10:0])<<3)+((vga_vaddr - tools[i][10:0])) + (vga_haddr - tools[i][21:11]);
                    3'd3: propeller_addr_array[i] = ((vga_vaddr - tools[i][10:0])<<5)+((vga_vaddr - tools[i][10:0])<<3) + (vga_haddr - tools[i][21:11]);
                    3'd4: propeller_running_addr_array[i] = ((vga_vaddr - tools[i][10:0])<<5)+((vga_vaddr - tools[i][10:0])<<3) + (vga_haddr - tools[i][21:11]);
                endcase
                tool_en_array[i] = 1;
            end
        end
    end
    spring_compressed_addr = spring_compressed_addr_array[tool_num];
    spring_full_addr = spring_full_addr_array[tool_num];
    propeller_addr = propeller_addr_array[tool_num];
    propeller_running_addr = propeller_running_addr_array[tool_num];
end

// Role images address calculation
always @(*) begin
    role_en = 0;
    doodle_addr = 0;
    doodle_up_addr = 0;
    if (role[23:22] != 0) begin
        if (vga_haddr >= role[21:11] && 
            vga_haddr < role[21:11] + get_role_width(role[23:22]) &&
            vga_vaddr >= role[10:0] &&
            vga_vaddr < role[10:0] + get_role_height(role[23:22])) begin
            case (role[23:22])
                2'd1: doodle_addr = ((vga_vaddr - role[10:0])<<6)+((vga_vaddr - role[10:0])<<5) +((vga_vaddr - role[10:0])<<2)+ (vga_haddr - role[21:11]);
                2'd2: doodle_addr = ((vga_vaddr - role[10:0])<<6)+((vga_vaddr - role[10:0])<<5) +((vga_vaddr - role[10:0])<<2) + 99 - (vga_haddr - role[21:11]);
                2'd3: doodle_up_addr = ((vga_vaddr - role[10:0])<<6)+((vga_vaddr - role[10:0])<<1) + (vga_haddr - role[21:11]);
            endcase
            role_en = 1;
        end
    end
end

wire [5:0] final_data_should_render_array;
wire [2:0] final_data_index;
wire final_en;
wire [11:0] final_data_array [7:0];

assign final_data_should_render_array[0] = platform_en & platform_final_data[12];
assign final_data_should_render_array[1] = break_platform_en & break_platform_final_data[12];
assign final_data_should_render_array[2] = monster_en & monster_final_data[12];
assign final_data_should_render_array[3] = ball_en & ball_final_data[12];
assign final_data_should_render_array[4] = role_en & role_final_data[12];
assign final_data_should_render_array[5] = tool_en & tool_final_data[12];

priority_encoder83 dataselect(
    .a({2'b0, final_data_should_render_array}),
    .num(final_data_index),
    .en(final_en)
);


assign final_data_array[0] = platform_final_data[11:0];
assign final_data_array[1] = break_platform_final_data[11:0];
assign final_data_array[2] = monster_final_data[11:0];
assign final_data_array[3] = ball_final_data[11:0];
assign final_data_array[4] = role_final_data[11:0];
assign final_data_array[5] = tool_final_data[11:0];
assign final_data_array[6] = 0;
assign final_data_array[7] = 0;

always @(*) begin
    vga_data = 12'hffd;
    if(vga_haddr[4:0] == 0 || vga_vaddr[4:0] == 0) begin
        vga_data = 12'hfec;
    end
    if (final_en) begin
        vga_data = final_data_array[final_data_index];
        // if(tool_en & tool_final_data[12]) vga_data = tool_final_data[11:0];
        // else if(role_en & role_final_data[12]) vga_data = role_final_data[11:0];
        // else if(ball_en & ball_final_data[12]) vga_data = ball_final_data[11:0];
        // else if(monster_en & monster_final_data[12]) vga_data = monster_final_data[11:0];
        // else if(break_platform_en & break_platform_final_data[12]) vga_data = break_platform_final_data[11:0];
        // else if(platform_en & platform_final_data[12]) vga_data = platform_final_data[11:0];
    end
end

function [10:0] get_platform_width;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_platform_width = `GREEN_PLATFORM_W;
            2'd2: get_platform_width = `LIGHT_BLUE_PLATFORM_W;
            default: get_platform_width = 0;
        endcase
    end
endfunction

function [10:0] get_break_platform_width;
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_break_platform_width = `BROWN_PLATFORM_BREAKING_1_W;
            3'd2: get_break_platform_width = `BROWN_PLATFORM_BREAKING_2_W;
            3'd3: get_break_platform_width = `BROWN_PLATFORM_BREAKING_3_W;
            3'd4: get_break_platform_width = `BROWN_PLATFORM_BREAKING_4_W;
            default: get_break_platform_width = 0;
        endcase
    end
endfunction
            
function [10:0] get_monster_width;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_monster_width = `PURPLE_MONSTER_W;
            2'd2: get_monster_width = `RED_MONSTER_W;
            default: get_monster_width = 0;
        endcase
    end
endfunction
function [10:0] get_tools_width;
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_tools_width = `SPRING_COMPRESSED_W;
            3'd2: get_tools_width = `SPRING_FULL_W;
            3'd3: get_tools_width = `PROPELLER_W;
            3'd4: get_tools_width = `PROPELLER_RUNNING_W;
            default: get_tools_width = 0;
        endcase
    end
endfunction
function [10:0] get_role_width;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_role_width = `DOODLE_W;
            2'd2: get_role_width = `DOODLE_W;
            2'd3: get_role_width = `DOODLE_UP_W;
            default: get_role_width = 0;
        endcase
    end
endfunction

function [10:0] get_platform_height;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_platform_height = `GREEN_PLATFORM_H;
            2'd2: get_platform_height = `LIGHT_BLUE_PLATFORM_H;
            default: get_platform_height = 0;
        endcase
    end
endfunction

function [10:0] get_break_platform_height;
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_break_platform_height = `BROWN_PLATFORM_BREAKING_1_H;
            3'd2: get_break_platform_height = `BROWN_PLATFORM_BREAKING_2_H;
            3'd3: get_break_platform_height = `BROWN_PLATFORM_BREAKING_3_H;
            3'd4: get_break_platform_height = `BROWN_PLATFORM_BREAKING_4_H;
            default: get_break_platform_height = 0;
        endcase
    end
endfunction

function [10:0] get_monster_height;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_monster_height = `PURPLE_MONSTER_H;
            2'd2: get_monster_height = `RED_MONSTER_H;
            default: get_monster_height = 0;
        endcase
    end
endfunction
function [10:0] get_tools_height;
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_tools_height = `SPRING_COMPRESSED_H;
            3'd2: get_tools_height = `SPRING_FULL_H;
            3'd3: get_tools_height = `PROPELLER_H;
            3'd4: get_tools_height = `PROPELLER_RUNNING_H;
            default: get_tools_height = 0;
        endcase
    end
endfunction

function [10:0] get_role_height;
    input [1:0] img_num;
    begin
        case (img_num)
            2'd1: get_role_height = `DOODLE_H;
            2'd2: get_role_height = `DOODLE_H;
            2'd3: get_role_height = `DOODLE_UP_H;
            default: get_role_height = 0;
        endcase
    end
endfunction
endmodule