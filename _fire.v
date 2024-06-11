module _fire(BTN1,BTN6,clk,DISP,cat);
input BTN1;//key plus
input BTN6;//key reset
input clk;//1kHz

output [7:0]DISP;//ge wei
output reg [7:0]cat;

reg [7:0]seg;
reg [5:0]counter;
reg [3:0]ge;
reg [3:0]ye;

initial
begin
seg<=8'b0000_0000;//0
counter<=6'b00_0000;
ye<=4'b0000;
cat<=8'b1111_0111;
end
//lianjie
assign DISP = seg;

//jishu
always@(posedge BTN1 or posedge BTN6)
begin
if(BTN6)
	begin
		counter<=0;
		ge<=0;
		ye<=0;
	end
	if(BTN1)
	
	begin
	ye<=1;
	if(counter== 3)
	begin counter<=0;end
	else
	begin counter<=counter+1;end
	end 
	ge<=counter%10;
end
//xianshi
always@(posedge clk or posedge BTN6)
begin
	if(BTN6)
	begin seg<=8'b0000_0000;end
	else if(ye)
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
		
	end

endmodule