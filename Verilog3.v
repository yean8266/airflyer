always@(posedge BTN4 or posedge BTN6)
begin
if(BTN6)
	begin
		counter1<=0;
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

//jishu
always@(posedge BTN1 or posedge BTN2 or posedge BTN6 or posedge BTN4)
begin

    if(BTN6)
	begin
		counter<=10;
		shi<=0;
		ge<=0;
		ye<=0;
        counter1<=0;
	end
	
	if(BTN1)
	begin
	ye<=1;
	if(counter== 99)
	begin counter<=10;end
	else
	begin counter<=counter+1;end
	end 
	
	if(BTN2)
	begin 
	ye<=1;
	if(counter== 99)
	begin counter<=0;end
	else
	begin counter<=counter+10;end
	end 
	
	if(BTN4)
	
	begin
	ye<=1;
	if(counter1== 3)
	begin counter1<=0;end
	else
	begin counter1<=counter1+1;end
	end 
end
	ge1<=counter1%10;
	shi<=counters/10;
	ge<=counters%10;
end