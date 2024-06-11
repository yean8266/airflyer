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
        //�����κζ�������������λ����ͨ������ʵ�ֵ�
        //��Ϊ��������£����»����ɿ��������ᵼ��key_in�����仯
        //�����ں�key_out����ȡ����ԣ��������ˣ�˵���м�key_in�����˱仯��
        //��ô���Ǿ���Ҫ���¸�λ�����¼���������һ��������ǣ�key_inѹ��һ��ʼ��û�仯��
        //���簴��û�б����»����ɿ�����ô����Ҳһֱ��λ�����������������key_outҲ���Բ��仯�ˡ�
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
            //��20ms�������Ž�key_in��ֵ��key_out
            else if(cnt == TIME_20MS - 1)
                key_out <= key_in;
     end
endmodule