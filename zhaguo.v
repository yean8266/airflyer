module zhaguo(BTN0,BTN4,BTN6,BTN7,BTNR,DISP ,SW3,clk,LD15,color,cat,
green,BEEP,cow,led);
input BTN0;//���ȿ�ʼ��
input BTN4;//��λ���Ƽ�
input BTN6;//ʱ���λ��
input BTN7;//ʱ��ʮλ��
input BTNR;//���ü�
input clk;//1kHzʱ���ź�
input SW3;//���ػ���

output [7:0]DISP;//�������� 
output  LD15;//���ػ��źŵ�

output [7:0]cat;//�����ɨ���ź�


output [7:0]green;//�����ɫɨ��
output [7:0]cow;//������ɨ�� 
output [7:0]color;//������ɫɨ��
output  BEEP;// ������ 
output [7:0]led;//������
reg LD;
wire BTN6_pulse;
wire BTN7_pulse;
wire BTN0_pulse;
wire BTN4_pulse;

//���ػ��źŵ�
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
debounce a1(//����ģ��
.clk(clk),
.nrst(BTNR),
.key_in(BTN0),
.key_out(BTN0_pulse)
);
debounce a2(//����ģ��
.clk(clk),
.nrst(BTNR),
.key_in(BTN4),
.key_out(BTN4_pulse)
);
debounce a3(//����ģ��
.clk(clk),
.nrst(BTNR),
.key_in(BTN6),
.key_out(BTN6_pulse)
);
debounce a4(//����ģ��
.clk(clk),
.nrst(BTNR),
.key_in(BTN7),
.key_out(BTN7_pulse)
);

COUNTER s1(//����ʱģ��
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