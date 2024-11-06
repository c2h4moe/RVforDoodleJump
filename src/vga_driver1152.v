module vga_driver(
    input           pclk,     
    input           reset,    //置位
    input [11:0] vga_data,
    output reg [10:0]   h_addr,   //提供给上层模块的当前扫描像素点坐标
    output reg [10:0]   v_addr,
    output reg         hsync_dly,    //行同步和列同步信号
    output reg         vsync_dly,
    output reg [3:0]    vga_r_dly,    //红绿蓝颜色信号
    output reg [3:0]    vga_g_dly,
    output reg [3:0]    vga_b_dly
);

  //640x480分辨率下的VGA参数设置
  parameter    h_frontporch = 120;
  parameter    h_active = 304;
  parameter    h_backporch = 1456;
  parameter    h_total = 1520;

  parameter    v_frontporch = 3;
  parameter    v_active = 30;
  parameter    v_backporch = 894;
  parameter    v_total = 895;


  //像素计数值
  reg [10:0]    x_cnt;
  reg [10:0]    y_cnt;
  reg hsync, vsync;
  reg h_valid, v_valid;
  // wire [11:0] vga_data;
  // wire         h_valid;
  // wire         v_valid;

  always @(posedge pclk) //行像素计数
      if (reset == 1'b1)
        x_cnt <= 1;
      else
      begin
        if (x_cnt == h_total)
            x_cnt <= 1;
        else
            x_cnt <= x_cnt + 11'd1;
      end

  always @(posedge pclk)  //列像素计数
      if (reset == 1'b1)
        y_cnt <= 1;
      else
      begin
        if (y_cnt == v_total & x_cnt == h_total)
            y_cnt <= 1;
        else if (x_cnt == h_total)
            y_cnt <= y_cnt + 11'd1;
      end
  always @(*) begin
    hsync = (x_cnt > h_frontporch);
    vsync = (y_cnt > v_frontporch);
    //生成消隐信号
    h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
    v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch); 
    h_addr = h_valid ? (x_cnt - 11'd305) : {11{1'b0}};
    v_addr = v_valid ? (y_cnt - 11'd31) : {11{1'b0}};
  end
  //生成同步信号
  // assign hsync = (x_cnt > h_frontporch);
  // assign vsync = (y_cnt > v_frontporch);
  // //生成消隐信号
  // assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
  // assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch);
  // //计算当前有效像素坐标
  // assign h_addr = h_valid ? (x_cnt - 11'd361) : {11{1'b0}};
  // assign v_addr = v_valid ? (y_cnt - 11'd42) : {11{1'b0}};
  //设置输出的颜色值
  // assign vga_data = ((h_addr < 11'd10) & (v_addr < 11'd10)) ? 12'hff0 : 12'hfff;
  // wire [3:0] vga_r_tmp, vga_g_tmp, vga_b_tmp;
  
  // assign vga_r_tmp = (h_valid & v_valid) ? vga_data[11:8] : 4'b0;
  // assign vga_g_tmp = (h_valid & v_valid) ? vga_data[7:4] : 4'b0;
  // assign vga_b_tmp = (h_valid & v_valid) ? vga_data[3:0] : 4'b0;
always @(posedge pclk) begin
    hsync_dly <= hsync;
    vsync_dly <= vsync;
    if(h_valid & v_valid) begin
      vga_r_dly <= vga_data[11:8];
      vga_g_dly <= vga_data[7:4];
      vga_b_dly <= vga_data[3:0];
    end else begin
      vga_r_dly <= 4'b0;
      vga_g_dly <= 4'b0;
      vga_b_dly <= 4'b0;
    end
    
end
initial begin
  x_cnt = 11'b1;
  y_cnt = 11'b1;
  vga_r_dly = 4'b0;
  vga_g_dly = 4'b0;
  vga_b_dly = 4'b0;
  hsync_dly = 1'b0;
  vsync_dly = 1'b0;
end
endmodule
