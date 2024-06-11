module COUNTER(BTN6,BTN0,BTN7,BTNR,DISP,clk,cat,BTN4,color,led,
green,SW3,BEEP,
cow);
input BTN0;//加热开始键
input BTN4;//档位控制键
input BTN6;//时间个位键
input BTN7;//时间十位键
input BTNR;//重置键
input clk;//1kHz时钟信号
input SW3;//开关机键


output [7:0]DISP;//数码管输出 
output [7:0]cat;//数码管扫描信号
output [7:0]green;//点阵红色扫描
output [7:0]cow;//点阵行扫描 
output [7:0]color;//点阵绿色扫描
output [7:0]led;//进度条

output BEEP;// 蜂鸣声 




_COUNTER1 a2(
.BTN0(BTN0),
.BTN6(BTN6),
.BTN7(BTN7),
.BTNR(BTNR),
.clk(clk),
.DISP(DISP),
.cat(cat),
.color(color),
.green(green),
.cow(cow),
.SW3(SW3),
.BEEP(BEEP),
.led(led),
.BTN4(BTN4)
);
endmodule