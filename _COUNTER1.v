module _COUNTER1(BTN6,BTN0,BTN7,BTNR,clk,DISP,cat,BTN4,color,SW3,BEEP,
green,led,
cow);
input BTN0;//���ȿ�ʼ��
input BTN4;//��λ���Ƽ�
input BTN6;//ʱ���λ��
input BTN7;//ʱ��ʮλ��
input BTNR;//���ü�
input clk;//1kHzʱ���ź�
input SW3;//���ػ���


output [7:0]DISP;//�������� 
output reg[7:0]cat;//�����ɨ���ź�
output [7:0]green;//�����ɫɨ��
output [7:0]cow;//������ɨ�� 
output [7:0]color;//������ɫɨ��
output reg BEEP;// ������ 
output [7:0]led;//������


reg [7:0]seg;//���������
reg [7:0]segs;//���������� 
reg [8:0]counter ;//����ʱ��
reg [8:0]counters;//����ʱʱ��
reg [3:0]shi;//��ʾʮλ 
reg [3:0]ge;// ��ʾ��λ
reg [3:0]ge1;//��ʾ��λ
reg ye;// ����ܵ���״̬����
reg z;//����������״̬��
reg x;//������״̬�� 
wire[1:0]cp;//1Hzʱ���ź�
reg [1:0]ap;//����ʱ��ʼ״̬����
reg [3:0]ze;
reg [3:0]sw;// ����ʮλ
reg [3:0]gw;//�����λ
reg [3:0]jg;//������������
reg [8:0]jgs;//
reg [8:0]jiange;//������������
reg [1:0] buzzer_TIME;

reg [9:0]count;

initial//��ʼ����
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




always@(negedge cp )//���������л��͵���ʱ����ʵ��
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

always@(negedge cp)//��������
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




always@(negedge clk )//������
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
	//����������
if(count <= 500)
begin
BEEP <= count%2; //count��2ȡ�࣬���һ������
end
else
begin
BEEP <= 0;
end
end



case(ap)//�������ʾѡ��
0:begin shi<=counter/10;
ge<=counter%10;end
1:begin  shi<=counters/10;
ge<=counters%10; end

endcase

end





//�������ʾ
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


always@(posedge clk )//�������ʾɨ��
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

always@(negedge cp)//������ʵ��
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


division division0(.CLK(clk),.CLK_div_N(cp));//��Ƶ���õ�1Hzʱ���ź�
dianzhen1 c1(//�������
.clk(clk),
.color_red(color),
.color_green(green),
.count_down(ap),
.SW3(SW3),
.cow(cow)
);
endmodule