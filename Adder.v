
module Adder(KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	input [3:0] KEY;
	
	wire [8:0] a, b;
	wire [15:0] c;
	
	wire [3:0] k = 4'b0000;
 	
	counter c0 (a[7:4], KEY[3]);
	counter c1 (a[3:0], KEY[2]);
	counter c2 (b[7:4], KEY[1]);
	counter c3 (b[3:0], KEY[0]);
	
	adder a0 (a, b, c);
	
	decoder d0 (a[7:4], HEX7);
	decoder d1 (a[3:0], HEX6);
	decoder d2 (b[7:4], HEX5);
	decoder d3 (b[3:0], HEX4);
	decoder d4 (c[15:12], HEX3);
	decoder d5 (c[11:8], HEX2);
	decoder d6 (c[7:4], HEX1);
	decoder d7 (c[3:0], HEX0);

endmodule

module adder (a, b, out);

	input [8:0] a, b;
	output reg [15:0] out;
	
	reg [4:0] tmp1, tmp2;
	reg [3:0] c1 = 0;
	reg [3:0] c2 = 0;
	
	always @ (a, b) begin
	
		tmp1 = a[3:0] + b[3:0];
		if (tmp1 > 4'b1001) c1 = 1; else c1 = 0;
		if (tmp1 > 4'b1001) tmp1 = tmp1 - 4'b1010; else tmp1 = a[3:0] + b[3:0];
		tmp2 = a[7:4] + b[7:4] + c1;
		if (tmp2 > 4'b1001) c2 = 1; else c2 = 0;
		if (tmp2 > 4'b1001) tmp2 = tmp2 - 4'b1010; else tmp2 = a[7:4] + b[7:4] + c1;
		out[3:0] = tmp1[3:0];
		out[7:4] = tmp2[3:0];
		out[11:8] = c2;
	
	end

endmodule

module decoder(a, segs);

	input [3:0] a;
	output reg [6:0] segs;
	
	always @ (a)
		begin
			case (a)
				4'b0000: segs = 7'b1000000;
				4'b0001: segs = 7'b1111001;
				4'b0010: segs = 7'b0100100;
				4'b0011: segs = 7'b0110000;
				4'b0100: segs = 7'b0011001;
				4'b0101: segs = 7'b0010010;
				4'b0110: segs = 7'b0000010;
				4'b0111: segs = 7'b1111000;
				4'b1000: segs = 7'b0000000;
				4'b1001: segs = 7'b0010000;
				default: segs = 7'b1111111;
			endcase
		end

endmodule

module counter(value, key);

	output reg [3:0] value;
	input key;
	
	always @ (posedge key) begin
		
		if (value == 9) begin
		
			value = 0;
		
		end
		else value = value + 1;
	
	end

endmodule