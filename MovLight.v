

module MovLight( CLOCK_50, LEDG, KEY);

	input [3:0] KEY;
	input CLOCK_50;
	output [7:0] LEDG;
	
	wire nclk;
	wire [26:0] rate;
	
	button but (KEY[0], rate);
	clocker c (CLOCK_50, nclk, rate);
	bar b (nclk, LEDG, KEY[0]);

endmodule

module bar(clk, leds, key);

	input clk;
	input key;

	output reg [7:0] leds;
	
	reg [7:0] barlight = 8'b00000001;
	
	always@ (posedge clk) begin
	
		if (barlight == 8'b00000001) begin
			
			barlight = 8'b10000000;
			
		end
		else begin
			barlight = barlight >> 1;
		end
			
		leds = barlight;
	
	end

endmodule

module button(key, rate);

	input key;
	output reg [26:0] rate;
	
	reg [1:0] index;
	reg [26:0] speed1 = 250000;
	reg [26:0] speed2 = 2500000;
	reg [26:0] speed3 = 25000000;
	reg [26:0] speed4 = 250000000;
	
	always@ (posedge key) begin
	
			if (index == 2'b11) begin
			
				index = 2'b00;
			
			end
			else index = index + 1;
			
			case (index)
				2'b00: rate = speed1;
				2'b01: rate = speed2;
				2'b10: rate = speed3;
				2'b11: rate = speed4;
				default: rate = speed1;
			endcase
	
	end
 
endmodule

module clocker(clk, l, rate);

	input [26:0] rate;
	input clk;
	output reg l;

	reg [26:0] w0;
	
	always@ (posedge clk) begin
		if (w0 == rate) begin
			l = ~l;
			w0 = 0;
		end
		else w0 = w0 + 1;
	
	end

endmodule

module mux4to1 (a, b, c, d, ctrl, out);

	input [26:0] a, b, c, d;
	input [1:0] ctrl;
	output [26:0] out;
	
	wire [26:0] w0, w1;

	mux2to1 m0 (a, b, ctrl[1], w0);
	mux2to1 m1 (c, d, ctrl[1], w1);
	mux2to1 m2 (w0, w1, ctrl[0], out);
	
endmodule

module mux2to1(a, b, ctrl, out);

	input [26:0] a, b;
	input ctrl;
	output [26:0] out;
	
	assign out = (~ctrl&a) | (ctrl&b);

endmodule