module zhaguo(BTN0,BTN4,BTN6,BTN7,BTNR,DISP ,SW3,clk,LD15,color,cat,
green,BEEP,cow,led);
input BTN0;//加热开始键
input BTN4;//档位控制键
input BTN6;//时间个位键
input BTN7;//时间十位键
input BTNR;//重置键
input clk;//1kHz时钟信号
input SW3;//开关机键

output [7:0]DISP;//数码管输出 
output  LD15;//开关机信号灯

output [7:0]cat;//数码管扫描信号


output [7:0]green;//点阵红色扫描
output [7:0]cow;//点阵行扫描 
output [7:0]color;//点阵绿色扫描
output  BEEP;// 蜂鸣声 
output [7:0]led;//进度条
reg LD;
wire BTN6_pulse;
wire BTN7_pulse;
wire BTN0_pulse;
wire BTN4_pulse;

//开关机信号灯
assign LD15 = LD;
always@(negedge  clk  )
begin
if(SW3==1)
begin 
LD<=1;
end else 
begin
LD<=0;
end
end
debounce a1(//消抖模块
.clk(clk),
.nrst(BTNR),
.key_in(BTN0),
.key_out(BTN0_pulse)
);
debounce a2(//消抖模块
.clk(clk),
.nrst(BTNR),
.key_in(BTN4),
.key_out(BTN4_pulse)
);
debounce a3(//消抖模块
.clk(clk),
.nrst(BTNR),
.key_in(BTN6),
.key_out(BTN6_pulse)
);
debounce a4(//消抖模块
.clk(clk),
.nrst(BTNR),
.key_in(BTN7),
.key_out(BTN7_pulse)
);

COUNTER s1(//倒计时模块
.BTN0(BTN0_pulse),
.BTN6(BTN6_pulse),
.BTN7(BTN7_pulse),
.BTN4(BTN4_pulse),
.BTNR(BTNR),
.clk(clk),
.DISP(DISP),
.color(color),
.green(green),
.cow(cow),
.SW3(SW3),
.BEEP(BEEP),
.led(led),
.cat(cat)
);


endmodule