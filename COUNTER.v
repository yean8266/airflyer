module COUNTER(BTN6,BTN0,BTN7,BTNR,DISP,clk,cat,BTN4,color,led,
green,SW3,BEEP,
cow);
input BTN0;//���ȿ�ʼ��
input BTN4;//��λ���Ƽ�
input BTN6;//ʱ���λ��
input BTN7;//ʱ��ʮλ��
input BTNR;//���ü�
input clk;//1kHzʱ���ź�
input SW3;//���ػ���


output [7:0]DISP;//�������� 
output [7:0]cat;//�����ɨ���ź�
output [7:0]green;//�����ɫɨ��
output [7:0]cow;//������ɨ�� 
output [7:0]color;//������ɫɨ��
output [7:0]led;//������

output BEEP;// ������ 




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