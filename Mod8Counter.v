module Mod8Counter(CLOCK_50, HEX0);
	input CLOCK_50;
	output [6:0] HEX0;
	
	wire nclk;
	wire [2:0]count;
	//reg count = 3'd0;

	clk c(CLOCK_50, nclk);
	mod8Count m(nclk,count);
	mux8 m1(count, HEX0);
endmodule

module mod8Count(clkin, count);
	input clkin;
	output reg [2:0] count;
	
	always @ (posedge clkin) begin
		if (count == 7) begin
			count = 3'b000;
		end
		
		else count = count + 1;
	end
endmodule

module mux8(a,hex);
	input [2:0]a;
	output reg [6:0]hex;
	
	always @ (a) begin
		case (a)
			3'd0: hex = 7'b1000000;
			3'd1: hex = 7'b1111001;
			3'd2: hex = 7'b0100100;
			3'd3: hex = 7'b0110000;
			3'd4: hex = 7'b0011001;
			3'd5: hex = 7'b0010010;
			3'd6: hex = 7'b0000010;
			3'd7: hex = 7'b1111000;
			default hex = 7'b1000000;
		endcase
	end
endmodule

module clk(clkin,clkout);
	input clkin;
	output reg clkout;
	reg [26:0] count;

	always @ (posedge clkin) begin
		if (count==25000000) begin
			clkout = ~clkout;
			count = 0;
		end
		else count = count +1;
	end
endmodule
