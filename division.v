module division(
input CLK,// 基准时钟
output wire CLK_div_N// N分频后得到的时钟
);
wire[31:0]N=1000;// N为分频系数,N≥2即可,N的值为CLK除以CLK_div_N后取整(四舍五入)
/******************** 产生备用时钟1 ***************/
reg[31:0]cnt1;
reg CLK_div_N_1;
always @ (posedge CLK)
begin
if(N%2==0)// 如果N为偶数
begin
if(N==2)// 如果N为2
CLK_div_N_1 <= ~CLK_div_N_1;
else
begin
if(cnt1==(N-2)/2)
begin
cnt1 <= 0;
CLK_div_N_1 <= ~CLK_div_N_1;
end
else
cnt1 <= cnt1+1;
end
end
else// 如果N为奇数
begin
if(cnt1==N-1)
cnt1 <= 0;
else
cnt1 <= cnt1+1;
if((cnt1==N-1) || (cnt1==(N-1)/2))
CLK_div_N_1 <= ~CLK_div_N_1;
else ;
end
end
/*********************** 产生备用时钟2 *********************/
wire CLK0 =(N%2)?(~CLK):0;// 如果N为偶数，备用时钟2（CLK_div_N_2）恒为0，即不需要用到此备用时钟
reg[31:0]cnt2;
reg CLK_div_N_2;
always @ (posedge CLK0)
begin
if(cnt2==N-1)
cnt2 <= 0;
else
cnt2 <= cnt2+1;
if((cnt2==N-1) || (cnt2==(N-1)/2))
CLK_div_N_2 <= ~CLK_div_N_2;
end
/******************** 产生最终分频时钟************************/
assign CLK_div_N = CLK_div_N_1 | CLK_div_N_2;
endmodule