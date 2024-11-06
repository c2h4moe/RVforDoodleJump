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

reg [24:0] platforms[15:0];
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
    end
    role = 0;
end
always @(posedge clk) begin
    if(we) begin
        case (addr[9:6])
            4'd0: platforms[addr[5:2]] <= din[24:0];
            4'd1: monsters[addr[2]] <= din[23:0];
            4'd2: balls[addr[5:2]] <= din[22:0];
            4'd3: tools[addr[4:2]] <= din[24:0];
            4'd4: role <= din[23:0];
        endcase
    end
end

// Internal wires for image addresses and data
reg [7:0] ball_addr;               // 15*15 = 225 -> 240
reg [11:0] brown_platform_breaking_1_addr; // 90*23 = 2070 -> 2080
reg [11:0] brown_platform_breaking_2_addr; // 90*29 = 2610 -> 2624
reg [11:0] brown_platform_breaking_3_addr; // 90*42 = 3780 -> 3792
reg [12:0] brown_platform_breaking_4_addr; // 90*51 = 4590 -> 4608
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

reg brown_platform_breaking_1_en;
reg brown_platform_breaking_2_en;
reg brown_platform_breaking_3_en;
reg brown_platform_breaking_4_en;
reg green_platform_en;
reg light_blue_platform_en;
reg purple_monster_en;
reg red_monster_en;
reg spring_compressed_en;
reg spring_full_en;
reg propeller_en;
reg propeller_running_en;
reg ball_en;
reg doodle_en;
reg doodle_up_en;
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

reg found, found_platform, found_tool, found_role, found_monster, found_ball;

// Complete case statements
always @(*) begin
    found_platform = 0;
    brown_platform_breaking_1_en = 0;
    brown_platform_breaking_2_en = 0;
    brown_platform_breaking_3_en = 0;
    brown_platform_breaking_4_en = 0;
    green_platform_en = 0;
    light_blue_platform_en = 0;
    brown_platform_breaking_1_addr = 0;
    brown_platform_breaking_2_addr = 0;
    brown_platform_breaking_3_addr = 0;
    brown_platform_breaking_4_addr = 0;
    green_platform_addr = 0;
    light_blue_platform_addr = 0;
    for (i = 0; i < 16; i = i + 1) begin
        if (platforms[i][24:22] != 0) begin
            if (vga_haddr >= platforms[i][21:11] && 
                vga_haddr < platforms[i][21:11] + get_platform_width(platforms[i][24:22]) &&
                vga_vaddr >= platforms[i][10:0] &&
                vga_vaddr < platforms[i][10:0] + get_platform_height(platforms[i][24:22])) begin
                found_platform = found_platform | 1;
                case (platforms[i][24:22])
                    3'd1: brown_platform_breaking_1_en = brown_platform_breaking_1_en | 1;
                    3'd2: brown_platform_breaking_2_en = brown_platform_breaking_2_en | 1;
                    3'd3: brown_platform_breaking_3_en = brown_platform_breaking_3_en | 1;
                    3'd4: brown_platform_breaking_4_en = brown_platform_breaking_4_en | 1;
                    3'd5: green_platform_en = green_platform_en | 1;
                    3'd6: light_blue_platform_en = light_blue_platform_en | 1;
                endcase
                if (brown_platform_breaking_1_en) brown_platform_breaking_1_addr = (vga_vaddr - platforms[i][10:0]) * `BROWN_PLATFORM_BREAKING_1_W + (vga_haddr - platforms[i][21:11]);
                if (brown_platform_breaking_2_en) brown_platform_breaking_2_addr = (vga_vaddr - platforms[i][10:0]) * `BROWN_PLATFORM_BREAKING_2_W + (vga_haddr - platforms[i][21:11]);
                if (brown_platform_breaking_3_en) brown_platform_breaking_3_addr = (vga_vaddr - platforms[i][10:0]) * `BROWN_PLATFORM_BREAKING_3_W + (vga_haddr - platforms[i][21:11]);
                if (brown_platform_breaking_4_en) brown_platform_breaking_4_addr = (vga_vaddr - platforms[i][10:0]) * `BROWN_PLATFORM_BREAKING_4_W + (vga_haddr - platforms[i][21:11]);
                if (green_platform_en) green_platform_addr = (vga_vaddr - platforms[i][10:0]) * `GREEN_PLATFORM_W + (vga_haddr - platforms[i][21:11]);
                if (light_blue_platform_en) light_blue_platform_addr = (vga_vaddr - platforms[i][10:0]) * `LIGHT_BLUE_PLATFORM_W + (vga_haddr - platforms[i][21:11]);
            end
        end
        
    end
end
always @(*) begin
    found_monster = 0;
    purple_monster_en = 0;
    red_monster_en = 0;
    purple_monster_addr = 0;
    red_monster_addr = 0;
    for (i = 0; i < 2; i = i + 1) begin
        if (monsters[i][23:22] != 0) begin
            if (vga_haddr >= monsters[i][21:11] && 
                vga_haddr < monsters[i][21:11] + get_monster_width(monsters[i][23:22]) &&
                vga_vaddr >= monsters[i][10:0] &&
                vga_vaddr < monsters[i][10:0] + get_monster_height(monsters[i][23:22])) begin
                found_monster =  found_monster | 1'b1;
                case(monsters[i][23:22])
                    2'd1: purple_monster_en = purple_monster_en | 1;
                    2'd2: red_monster_en = red_monster_en | 1;
                endcase
                purple_monster_addr = (purple_monster_en) ? (vga_vaddr - monsters[i][10:0]) * `PURPLE_MONSTER_W + (vga_haddr - monsters[i][21:11]) : 0;
                red_monster_addr = (red_monster_en) ? (vga_vaddr - monsters[i][10:0]) * `RED_MONSTER_W + (vga_haddr - monsters[i][21:11]) : 0;
            end
        end
        
    end
end
always @(*) begin
    found_ball = 0;
    ball_addr = 0;
    ball_en = 0;
    for (i = 0; i < 10; i = i + 1) begin
        if (balls[i][22] != 0) begin
            if (vga_haddr >= balls[i][21:11] && 
                vga_haddr < balls[i][21:11] + `BALL_W &&
                vga_vaddr >= balls[i][10:0] &&
                vga_vaddr < balls[i][10:0] + `BALL_H) begin
                found_ball = found_ball | 1;
                ball_en = 1;
                ball_addr = (ball_en) ? (vga_vaddr - balls[i][10:0]) * `BALL_W + (vga_haddr - balls[i][21:11]) : 0;
            end
        end
        
    end
end
always @(*) begin
    found_tool = 0;
    spring_compressed_en = 0;
    spring_full_en = 0;
    propeller_en = 0;
    propeller_running_en = 0;
    spring_compressed_addr = 0;
    spring_full_addr = 0;
    propeller_addr = 0;
    propeller_running_addr = 0;
    for (i = 0; i < 8; i = i + 1) begin
        if (tools[i][24:22] != 0) begin
            if (vga_haddr >= tools[i][21:11] && 
                vga_haddr < tools[i][21:11] + get_tools_width(tools[i][24:22]) &&
                vga_vaddr >= tools[i][10:0] &&
                vga_vaddr < tools[i][10:0] + get_tools_height(tools[i][24:22])) begin
                found_tool = found_tool | 1;
                case(tools[i][24:22])
                    3'd1: spring_compressed_en = spring_compressed_en | 1;
                    3'd2: spring_full_en = spring_full_en | 1;
                    3'd3: propeller_en = propeller_en | 1;
                    3'd4: propeller_running_en = propeller_running_en | 1;
                endcase
                spring_compressed_addr = (spring_compressed_en) ? (vga_vaddr - tools[i][10:0]) * `SPRING_COMPRESSED_W + (vga_haddr - tools[i][21:11]) : 0;
                spring_full_addr = (spring_full_en) ? (vga_vaddr - tools[i][10:0]) * `SPRING_FULL_W + (vga_haddr - tools[i][21:11]) : 0;
                propeller_addr = (propeller_en) ? (vga_vaddr - tools[i][10:0]) * `PROPELLER_W + (vga_haddr - tools[i][21:11]) : 0;
                propeller_running_addr = (propeller_running_en) ? (vga_vaddr - tools[i][10:0]) * `PROPELLER_RUNNING_W + (vga_haddr - tools[i][21:11]) : 0;
            end
        end
        
    end
end

always @(*) begin
    found_role = 0;
    doodle_en = 0;
    doodle_up_en = 0;
    doodle_addr = 0;
    doodle_up_addr = 0;
    if (role[23:22] != 0) begin
        if (vga_haddr >= role[21:11] && 
            vga_haddr < role[21:11] + get_role_width(role[23:22]) &&
            vga_vaddr >= role[10:0] &&
            vga_vaddr < role[10:0] + get_role_height(role[23:22])) begin
            found_role = found_role | 1;
            case(role[23:22])
                2'd1: doodle_en = doodle_en | 1;
                2'd2: doodle_en = doodle_en | 1;
                2'd3: doodle_up_en = doodle_up_en | 1;
            endcase
        end
        doodle_addr = (doodle_en) ? (vga_vaddr - role[10:0]) * `DOODLE_W + (role[23:22] == 2 ? 99 - (vga_haddr - role[21:11]) : vga_haddr - role[21:11]) : 0;
        doodle_up_addr = (doodle_up_en) ? (vga_vaddr - role[10:0]) * `DOODLE_UP_W + (vga_haddr - role[21:11]) : 0;
    end
    
end

always @(*) begin
    vga_data = 12'hffd;
    if(vga_haddr[4:0] == 0 || vga_vaddr[4:0] == 0) begin
        vga_data = 12'hfec;
    end
    found = found_ball | found_monster | found_platform | found_tool | found_role;
    if (found) begin
        if (doodle_up_en && doodle_up_data[12]) vga_data = doodle_up_data[11:0];
        else if (doodle_en && doodle_data[12]) vga_data = doodle_data[11:0];
        else if (ball_en && ball_data[12]) vga_data = ball_data[11:0];
        else if (propeller_running_en && propeller_running_data[12]) vga_data = propeller_running_data[11:0];
        else if (propeller_en && propeller_data[12]) vga_data = propeller_data[11:0];
        else if (spring_full_en && spring_full_data[12]) vga_data = spring_full_data[11:0];
        else if (spring_compressed_en && spring_compressed_data[12]) vga_data = spring_compressed_data[11:0];
        else if (red_monster_en && red_monster_data[12]) vga_data = red_monster_data[11:0];
        else if (purple_monster_en && purple_monster_data[12]) vga_data = purple_monster_data[11:0];
        else if (light_blue_platform_en && light_blue_platform_data[12]) vga_data = light_blue_platform_data[11:0];
        else if (green_platform_en && green_platform_data[12]) vga_data = green_platform_data[11:0];
        else if (brown_platform_breaking_4_en && brown_platform_breaking_4_data[12]) vga_data = brown_platform_breaking_4_data[11:0];
        else if (brown_platform_breaking_3_en && brown_platform_breaking_3_data[12]) vga_data = brown_platform_breaking_3_data[11:0];
        else if (brown_platform_breaking_2_en && brown_platform_breaking_2_data[12]) vga_data = brown_platform_breaking_2_data[11:0];
        else if (brown_platform_breaking_1_en && brown_platform_breaking_1_data[12]) vga_data = brown_platform_breaking_1_data[11:0];
    end
end

function [10:0] get_platform_width;
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_platform_width = `BROWN_PLATFORM_BREAKING_1_W;
            3'd2: get_platform_width = `BROWN_PLATFORM_BREAKING_2_W;
            3'd3: get_platform_width = `BROWN_PLATFORM_BREAKING_3_W;
            3'd4: get_platform_width = `BROWN_PLATFORM_BREAKING_4_W;
            3'd5: get_platform_width = `GREEN_PLATFORM_W;
            3'd6: get_platform_width = `LIGHT_BLUE_PLATFORM_W;
            default: get_platform_width = 0;
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
    input [2:0] img_num;
    begin
        case (img_num)
            3'd1: get_platform_height = `BROWN_PLATFORM_BREAKING_1_H;
            3'd2: get_platform_height = `BROWN_PLATFORM_BREAKING_2_H;
            3'd3: get_platform_height = `BROWN_PLATFORM_BREAKING_3_H;
            3'd4: get_platform_height = `BROWN_PLATFORM_BREAKING_4_H;
            3'd5: get_platform_height = `GREEN_PLATFORM_H;
            3'd6: get_platform_height = `LIGHT_BLUE_PLATFORM_H;
            default: get_platform_height = 0;
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