

module Progress( CLOCK_50, LEDR);

	input CLOCK_50;
	output [17:0] LEDR;
	
	wire nclk;

	clocker c (CLOCK_50, nclk);
	bar b (nclk, LEDR);

endmodule

module bar(clk, leds);

	input clk;

	output reg [17:0] leds;
	
	reg [17:0] barlight;
	
	always@ (posedge clk) begin
	
		if (barlight == 18'b111111111111111111) begin
			
			barlight = 0;
			
		end
		else begin
			barlight = ~barlight;
			barlight = barlight >> 1;
			barlight = ~barlight;
		end
			
		leds = barlight;
	
	end

endmodule

module clocker(clk, l);

	input clk;
	output reg l;

	reg [26:0] w0;
	
	always@ (posedge clk) begin
		if (w0 == 25000000) begin
			l = ~l;
			w0 = 0;
		end
		else w0 = w0 + 1;
	
	end

endmodule