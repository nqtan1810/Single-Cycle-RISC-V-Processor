module shiftLeft(out,
					  a,
					  b
					  );

	parameter DATA_WIDTH = 32;

	output [DATA_WIDTH-1 : 0] out;

	input [DATA_WIDTH-1 : 0] a;
	input [DATA_WIDTH-1 : 0] b;

	assign out = a << b;
					  
endmodule 