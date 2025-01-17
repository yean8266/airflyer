module _COUNTER1(BTN6,BTN0,BTN7,BTNR,clk,DISP,cat,BTN4,color,SW3,BEEP,
green,led,
cow);
input BTN0;//加热开始键
input BTN4;//档位控制键
input BTN6;//时间个位键
input BTN7;//时间十位键
input BTNR;//重置键
input clk;//1kHz时钟信号
input SW3;//开关机键


output [7:0]DISP;//数码管输出 
output reg[7:0]cat;//数码管扫描信号
output [7:0]green;//点阵红色扫描
output [7:0]cow;//点阵行扫描 
output [7:0]color;//点阵绿色扫描
output reg BEEP;// 蜂鸣声 
output [7:0]led;//进度条


reg [7:0]seg;//数码管数据
reg [7:0]segs;//进度条数据 
reg [8:0]counter ;//输入时间
reg [8:0]counters;//倒计时时间
reg [3:0]shi;//显示十位 
reg [3:0]ge;// 显示个位
reg [3:0]ge1;//显示档位
reg ye;// 数码管点亮状态变量
reg z;//蜂鸣器鸣响状态量
reg x;//进度条状态量 
wire[1:0]cp;//1Hz时钟信号
reg [1:0]ap;//倒计时开始状态变量
reg [3:0]ze;
reg [3:0]sw;// 输入十位
reg [3:0]gw;//输入个位
reg [3:0]jg;//进度条控制量
reg [8:0]jgs;//
reg [8:0]jiange;//进度条计算间隔
reg [1:0] buzzer_TIME;

reg [9:0]count;

initial//初始设置
begin
seg<=8'b0000_0000;//0
cat<=8'b1111_1110;
counters<=10;
ap<=0;
counter<=8'b0000_0000;
ye<=0;
gw<=0;
jg<=0;
jgs<=0;
sw<=1;
buzzer_TIME<=0;
end
//lianjie
assign DISP = seg;
assign led = segs;




always@(negedge cp )//按键功能切换和倒计时功能实现
begin 
if(SW3) 
begin
if(BTN0) 
begin
ap<=1;
ye<=1;
x<=1;
counters<=counter;
end 
else  if(BTNR)
begin
ap<=0;
ye<=0;
x<=0;
end 
else if(BTN4)
begin
ye<=1;
if(ap==0)
begin
if(ge1==3)
begin ge1<=1;end  
else
ge1<=ge1+1;//sw gw
end 
end
else 
if(counters==0)
begin ap<=0;
ye<=0;
z<=1;
x<=0;
if(buzzer_TIME== 3)
begin counters<=10;
buzzer_TIME<=0;end
else  begin buzzer_TIME <= buzzer_TIME + 1;end


end else
if(ap==1)
begin 
counters<=counters-1;
end
else if(counters==10)
begin z<=0;
end
end

if(!SW3) 
begin
ap<=0;
ye<=0;
x<=0;
end

end

always@(negedge cp)//按键加数
begin 
if(SW3) 
begin
if(ap==0)
begin
if(BTN6)
begin
if(gw==9)
begin gw<=0;end 
else
gw<=gw+1;
end
else if(BTN7)
begin
if(sw==9)
begin sw<=1;end 
else
sw<=sw+1;//sw gw
end

end
end
end




always@(negedge clk )//蜂鸣器
begin 
counter<=(gw+10*sw);
if(z)
begin
if(count == 1000)
begin
count <= 0;
end
else
begin
count <= count + 1;
end
	//蜂鸣器鸣响
if(count <= 500)
begin
BEEP <= count%2; //count对2取余，获得一个脉冲
end
else
begin
BEEP <= 0;
end
end



case(ap)//数码管显示选择
0:begin shi<=counter/10;
ge<=counter%10;end
1:begin  shi<=counters/10;
ge<=counters%10; end

endcase

end





//数码管显示
always@(posedge clk or posedge BTNR)
begin
if(BTNR)
begin seg<=8'b0000_0000;end
else if(ye==0)
begin seg<=8'b0000_0000;

end else if(SW3==0)
begin seg<=8'b0000_0000;

end
else
if(ye)
begin
if(cat == 8'b1110_1111)
begin
case(ge)
0:seg<=8'b0011_1111;//0
1:seg<=8'b0000_0110;//1
2:seg<=8'b0101_1011;//2
3:seg<=8'b0100_1111;//3
4:seg<=8'b0110_0110;//4
5:seg<=8'b0110_1101;//5
6:seg<=8'b0111_1101;//6
7:seg<=8'b0000_0111;//7
8:seg<=8'b0111_1111;//8
9:seg<=8'b0110_1111;//9
default:seg<=8'b0000_0000;endcase
end
else if(cat == 8'b1011_1111)
begin
case(shi)
0:seg<=8'b0011_1111;//0
1:seg<=8'b0000_0110;//1
2:seg<=8'b0101_1011;//2
3:seg<=8'b0100_1111;//3
4:seg<=8'b0110_0110;//4
5:seg<=8'b0110_1101;//5
6:seg<=8'b0111_1101;//6
7:seg<=8'b0000_0111;//7
8:seg<=8'b0111_1111;//8
9:seg<=8'b0110_1111;//9
default:seg<=8'b0000_0000;endcase
end
else if(cat == 8'b0111_1111)
begin
case(ge1)

1:seg<=8'b0000_0110;//1
2:seg<=8'b0101_1011;//2
3:seg<=8'b0100_1111;//3
default:seg<=8'b0000_0000;endcase
end
end
end


always@(posedge clk )//数码管显示扫描
begin
if(ze==3)
begin ze<=1;end
else begin ze<=ze+1; end


case(ze)

1:cat<=8'b1011_1111;
2:cat<=8'b0111_1111;
3:cat<=8'b1110_1111;
endcase
end

always@(negedge cp)//进度条实现
begin 
jiange<=counter/8;
if(x)
begin if(jgs==jiange) begin jgs<=1;jg<=jg+1;end else jgs<=jgs+1;end
if(!x)
begin jg<=0;jgs<=0;end
case(jg)
0:segs<=8'b0000_0000;
1:segs<=8'b0000_0001;
2:segs<=8'b0000_0011;
3:segs<=8'b0000_0111;
4:segs<=8'b0000_1111;
5:segs<=8'b0001_1111;
6:segs<=8'b0011_1111;
7:segs<=8'b0111_1111;
8:segs<=8'b1111_1111;
endcase
end


division division0(.CLK(clk),.CLK_div_N(cp));//分频器得到1Hz时钟信号
dianzhen1 c1(//点阵调用
.clk(clk),
.color_red(color),
.color_green(green),
.count_down(ap),
.SW3(SW3),
.cow(cow)
);
endmodule