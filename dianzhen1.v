module dianzhen1(
clk,
color_red,
color_green,
count_down,
SW3,
cow);
 
input clk;//1kHz时钟输入
input count_down;//点阵开关状态变量 
input SW3;//开关机按键 

reg [2:0]counter;//点阵行驱动中间变量
reg [7:0]seg;//点阵驱动中间变量
reg [7:0]air;//点阵驱动中间变量
reg [7:0]gre;//点阵驱动中间变量
wire [1:0]cp;//1Hz时钟信号
reg [3:0]ap;//点阵切换变量


output [7:0]color_red;////点阵红色扫描
output [7:0]color_green;////点阵绿色扫描
output [7:0]cow;//点阵行扫描 

initial//初始设置
begin
counter<=3'b000;
ap<=4'b0000;
end
//链接 
assign color_red = seg;
assign cow = air;
assign color_green = gre;






always@(negedge cp)//点阵每帧画面切换
begin

if(SW3==1)
begin  
if(count_down==0)
begin     
ap<=4'b0000;
end else
if(ap==4'b0011)
begin
ap<=4'b0000;
end else
 if(ap<4'b0011)  
 begin     
ap<=ap+1'b1;
end


end
end


	
	










always@(posedge clk)//点阵驱动
begin


if(count_down)
begin
		case(ap)
		0:begin
		begin
         case(counter)
				0:seg<=8'b0000_0000;//0
				1:seg<=8'b0000_0000;//1
				2:seg<=8'b0010_0100;//2
				3:seg<=8'b0001_1000;//3
				4:seg<=8'b0001_1000;//4
				5:seg<=8'b0010_0100;//5
				6:seg<=8'b0000_0000;//6
				7:seg<=8'b0000_0000;//7
				default:seg<=8'b1111_1111;endcase
				end
			begin
         case(counter)
				0:gre<=8'b0000_0000;//0
				1:gre<=8'b0000_0000;//1
				2:gre<=8'b0010_0100;//2
				3:gre<=8'b0001_1000;//3
				4:gre<=8'b0001_1000;//4
				5:gre<=8'b0010_0100;//5
				6:gre<=8'b0000_0000;//6
				7:gre<=8'b0000_0000;//7
				default:gre<=8'b1111_1111;endcase
				end

          begin
			case(counter)
				0:air<=8'b1111_1110;//0
				1:air<=8'b1111_1101;//1
				2:air<=8'b1111_1011;//0
				3:air<=8'b1111_0111;//1
				4:air<=8'b1110_1111;//0
				5:air<=8'b1101_1111;//1
				6:air<=8'b1011_1111;//0
				7:air<=8'b0111_1111;//1
				default:air<=8'b1111_1111;endcase
		end
           begin
				if(counter == 7)//点阵列驱动切换
				begin counter<=0;end
				else
				begin counter<=counter+1;end
             end
  end
        1:
        begin
        begin
         case(counter)
				0:seg<=8'b0000_0000;//0
				1:seg<=8'b0000_0000;//1
				2:seg<=8'b0011_1100;//2
				3:seg<=8'b0011_1100;//3
				4:seg<=8'b0011_1100;//4
				5:seg<=8'b0011_1100;//5
				6:seg<=8'b0000_0000;//6
				7:seg<=8'b0000_0000;//7
				default:seg<=8'b1111_1111;endcase
				end
				begin
         case(counter)
				0:gre<=8'b0000_0000;//0
				1:gre<=8'b0000_0000;//1
				2:gre<=8'b0011_1100;//2
				3:gre<=8'b0011_1100;//3
				4:gre<=8'b0011_1100;//4
				5:gre<=8'b0011_1100;//5
				6:gre<=8'b0000_0000;//6
				7:gre<=8'b0000_0000;//7
				default:gre<=8'b1111_1111;endcase
				end

          begin
			case(counter)
				0:air<=8'b1111_1110;//0
				1:air<=8'b1111_1101;//1
				2:air<=8'b1111_1011;//0
				3:air<=8'b1111_0111;//1
				4:air<=8'b1110_1111;//0
				5:air<=8'b1101_1111;//1
				6:air<=8'b1011_1111;//0
				7:air<=8'b0111_1111;//1
				default:air<=8'b1111_1111;endcase
		end
           begin
				if(counter == 7)
				begin counter<=0;end
				else
				begin counter<=counter+1;end
             end
            end
          2:
           begin
            begin
         case(counter)
				0:seg<=8'b0000_0000;//0
				1:seg<=8'b0100_0010;//1
				2:seg<=8'b0011_1100;//2
				3:seg<=8'b0011_1100;//3
				4:seg<=8'b0011_1100;//4
				5:seg<=8'b0011_1100;//5
				6:seg<=8'b0100_0010;//6
				7:seg<=8'b0000_0000;//7
				default:seg<=8'b1111_1111;endcase
				end
				begin
         case(counter)
				0:gre<=8'b0000_0000;//0
				1:gre<=8'b0100_0010;//1
				2:gre<=8'b0011_1100;//2
				3:gre<=8'b0011_1100;//3
				4:gre<=8'b0011_1100;//4
				5:gre<=8'b0011_1100;//5
				6:gre<=8'b0100_0010;//6
				7:gre<=8'b0000_0000;//7
				default:gre<=8'b1111_1111;endcase
				end

          begin
			case(counter)
     			0:air<=8'b1111_1110;//0
				1:air<=8'b1111_1101;//1
				2:air<=8'b1111_1011;//0
				3:air<=8'b1111_0111;//1
				4:air<=8'b1110_1111;//0
				5:air<=8'b1101_1111;//1
				6:air<=8'b1011_1111;//0
				7:air<=8'b0111_1111;//1
				default:air<=8'b1111_1111;endcase
		end
           begin
				if(counter == 7)
				begin counter<=0;end
				else
				begin counter<=counter+1;end
             end
             end
          3:
           begin
            begin
         case(counter)
				0:seg<=8'b0000_0000;//0
				1:seg<=8'b0111_1110;//1
				2:seg<=8'b0111_1110;//2
				3:seg<=8'b0111_1110;//3
				4:seg<=8'b0111_1110;//4
				5:seg<=8'b0111_1110;//5
				6:seg<=8'b0111_1110;//6
				7:seg<=8'b0000_0000;//7
				default:seg<=8'b1111_1111;endcase
				end
				begin
         case(counter)
				0:gre<=8'b0000_0000;//0
				1:gre<=8'b0111_1110;//1
				2:gre<=8'b0111_1110;//2
				3:gre<=8'b0111_1110;//3
				4:gre<=8'b0111_1110;//4
				5:gre<=8'b0111_1110;//5
				6:gre<=8'b0111_1110;//6
				7:gre<=8'b0000_0000;//7
				default:gre<=8'b1111_1111;endcase
				end

          begin
			case(counter)
				0:air<=8'b1111_1110;//0
				1:air<=8'b1111_1101;//1
				2:air<=8'b1111_1011;//0
				3:air<=8'b1111_0111;//1
				4:air<=8'b1110_1111;//0
				5:air<=8'b1101_1111;//1
				6:air<=8'b1011_1111;//0
				7:air<=8'b0111_1111;//1
				default:air<=8'b1111_1111;endcase
		end
           begin
				if(counter == 7)
				begin counter<=0;end
				else
				begin counter<=counter+1;end
             end
             end
      endcase
      end 
end

division division0(.CLK(clk),.CLK_div_N(cp));//分频器得到1Hz时钟信号

endmodule