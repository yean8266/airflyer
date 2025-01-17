module debounce(
    input wire clk, nrst,
    input wire key_in,
    output reg key_out
    );

    localparam TIME_20MS = 15;

    reg key_cnt;
    reg [20:0] cnt;

    always @(posedge clk or posedge nrst) begin
        if(nrst)
            key_cnt <= 0;
        else if(cnt == TIME_20MS - 1)
            key_cnt <= 0;
        else if(key_cnt == 0 && key_out != key_in)
            key_cnt <= 1;
    end

    always @(posedge clk or posedge nrst) begin
        if(nrst)
            cnt <= 0;
        else if(key_cnt) begin
        //发生任何抖动，都立即复位，是通过这里实现的
        //因为正常情况下，按下或者松开按键都会导致key_in发生变化
        //以至于和key_out不相等。所以，如果相等了，说明中间key_in发生了变化，
        //那么我们就需要重新复位，重新计数。还有一种情况就是，key_in压根一开始就没变化，
        //例如按键没有被按下或者松开，那么我们也一直复位，不让其计数，这样key_out也可以不变化了。
            if(key_out == key_in)
                cnt <= 0;
            else
                cnt <= cnt + 1'b1;
        end
        else
            cnt <= 0;
    end
     
     always @(posedge clk or posedge nrst) begin
            if(nrst)
                key_out <= 0;
            //在20ms结束，才将key_in赋值给key_out
            else if(cnt == TIME_20MS - 1)
                key_out <= key_in;
     end
endmodule