module t_ATM_machine;
	reg clock,reset;
	reg [2:0] x_in;
	wire [2:0] y_out;
	wire y_out_flash;
	
	reg [2:0] tb_in;
	integer loop=1;
	integer i;

	always #10 clock=~clock;
	Atm_machine u0(.y_out(y_out), .y_out_flash(y_out_flash),.x_in(x_in), .clock(clock), .reset(reset));

	initial begin
		clock<=0;
		reset<=0;
		x_in<=0;

		repeat(5) @(posedge clock);
		reset<=1;

		@(posedge clock)
			x_in<=3'b000;
			$display("x_in: %b, y_out: %b Flash: %b",x_in,y_out, y_out_flash);  
		@(posedge clock) 
			x_in<=3'b010;
			$display("x_in: %b, y_out: %b Flash: %b",x_in,y_out, y_out_flash);
		@(posedge clock) 
			x_in<=3'b100;
			$display("x_in: %b, y_out: %b Flash: %b",x_in,y_out, y_out_flash);

		@(posedge clock) 
			x_in<=3'b100;
			$display("x_in: %b, y_out: %b Flash: %b",x_in,y_out, y_out_flash);
		
		
		for (i = 0; i <= loop; i= i+1) begin
			x_in<= tb_in;
			
		end
		
		#100 $finish;
	end
endmodule
