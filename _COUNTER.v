module _COUNTER(BTN1,BTN0,BTN2,BTN6,clk,DISP);
input BTN1;
input BTN0;
input BTN2;//key plus
input BTN6;//key reset
input clk;//1kHz

output [7:0]DISP;//ge wei
reg [7:0]cat;

reg [7:0]seg;
reg [5:0]counter;
reg [5:0]counters;
reg [1:0]shi;
reg [3:0]ge;
reg [3:0]ye;
reg [1:0]cp;
reg [1:0]ap;


initial
begin
seg<=8'b0000_0000;//0
cat<=8'b1111_1101;
counter<=6'b00_0000;
counters<=6'b00_0000;
cp<=1;
ap<=0;
ye<=4'b0000;
end
//lianjie
assign DISP = seg;

always@(posedge clk or posedge BTN0)
begin
counters<=counter;
if(BTN0)
begin 
ap<=1;end else if(counters==0)
begin
ap<=0;
end
end
always@(posedge cp)
begin
if(ap)
begin 
counters=counters-1;
end
end

//jishu
always@(posedge BTN1 or posedge BTN2 or posedge BTN6)
begin

if(BTN6)
	begin
		counter<=0;
		shi<=0;
		ge<=0;
		ye<=0;
	end
	else
	if(BTN1)
	
	begin
	ye<=1;
	if(counter== 99)
	begin counter<=0;end
	else
	begin counter<=counter+1;end
	end 
	else if(BTN2)
	begin 
	ye<=1;
	if(counter== 99)
	begin counter<=0;end
	else
	begin counter<=counter+10;end
	end 
	
	shi<=counters/10;
	ge<=counters%10;
end
//xianshi
always@(posedge clk or posedge BTN6)
begin
	if(BTN6)
	begin seg<=8'b0000_0000;end
	else if(ye)
	begin
		if(cat==8'b1111_1011)
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
				9:seg<=8'b0110_1111;
				default:seg<=8'b0000_0000;endcase
				end//9
		else
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
				9:seg<=8'b0110_1111;
				default:seg<=8'b0000_0000;endcase
				end//9
		cat[1]<=~cat[1];
		cat[2]<=~cat[2];
	end
end


division division0(.clk(clk),.clk_out(cp));
endmodule