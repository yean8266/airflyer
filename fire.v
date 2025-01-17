module fire(BTN1,BTN6,DISP,clk,cat);
input BTN1;
input BTN6;//key reset
input clk;//1kHz

output [7:0]DISP;//ge wei
output [7:0]cat;
debounce u1(
.clk(clk),
.nrst(BTN6),
.key_in(BTN1),
.key_out(BTN1_pulse)
);
debounce u2(
.clk(clk),
.nrst(BTN6),
.key_in(BTN2),
.key_out(BTN2_pulse)
);
_fire a2(
.BTN1(BTN1_pulse),
.BTN6(BTN6),
.clk(clk),
.DISP(DISP),
.cat(cat)
);
endmodule