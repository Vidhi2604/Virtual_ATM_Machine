module Atm_machine(output reg [2:0] y_out,
		   output reg y_out_flash,
			 input [2:0] x_in, 
			 input clock, reset);
	reg [2:0] state,next_state;
	parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101,S6=3'b110;
	parameter I1=3'b000,I2=3'b001,I3=3'b010,I4=3'b011,I5=3'b100,I6=3'b101,I7=3'b110;
	parameter Z1=3'b000,Z2=3'b001,Z3=3'b010,Z4=3'b011,Z5=3'b100,Z6=3'b101,Z7=3'b110;
	always @(posedge clock, negedge reset)
		if(reset==0) state<=S0;
		else state<=next_state;

	always @(state,x_in)
		case(state)
			S1 : if(x_in==I1) next_state=S3; else if(x_in==I2) next_state=S6; else next_state=S1;
			S3 : if(x_in==I3) next_state=S4; else if(x_in==I4) next_state=S5; else next_state=S3;
			S4 : if(x_in==I5) next_state=S0; else if(x_in==I6) next_state=S0; else next_state=S4;
			S5 : if(x_in==I3) next_state=S4; else if(x_in==I7) next_state=S0; else next_state=S5;
			S6 : if(x_in==I1) next_state=S3; else next_state=S6;
		endcase

	always @(state,x_in)
		case(x_in)
			I1: y_out=Z1;
			I2: y_out=Z2;
			I3: y_out=Z5;
			I4: y_out=Z3;
			I5: y_out=Z7;
			I6: y_out=Z6;
			I7: y_out=Z4;
		endcase
	always @(state,x_in)		
		case(state)
			S2: y_out_flash=1'b0;
			S1,S3,S4,S5,S6: y_out_flash=1'b1;
		endcase
	

endmodule
