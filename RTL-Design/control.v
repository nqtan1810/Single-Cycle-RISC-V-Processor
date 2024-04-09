module control (branch,
					 slt,
					 lui,
					 jal,
					 memToReg,
					 memWrite,
					 memRead,
					 aluOp,
					 aluSrc,
					 regWrite,
					 opcode,
					 funct3
					 );
						 
	output [1:0] branch;
	output slt;
	output lui;
	output jal;
	output memToReg;
	output memWrite;
	output memRead;
	output [1:0] aluOp;
	output aluSrc;
	output regWrite;
	
	input [6:0] opcode;
	input [2:0] funct3;

	reg [11:0] controlSignals;
	
	always @(opcode or funct3) begin
	
		case(opcode)
		
		  7'b0110011: case(funct3)
								3'b010: controlSignals = 12'b001000001001;  // SLT
								default: controlSignals = 12'b000000001001;  // ADD, SUB, OR, AND
						  endcase
		  
		  7'b0000011: controlSignals = 12'b000001010011;  // LW
		  
		  7'b0010011: controlSignals = 12'b000000001111;  // ADDI, ORI, ANDI
		  
		  7'b0100011: controlSignals = 12'b000000100010;  // SW
		  
		  7'b1100011: case(funct3)
								3'b000: controlSignals = 12'b100000000100;  // BEQ
								default: controlSignals = 12'b010000000100;  // BNE
						  endcase
		  
		  7'b0110111: controlSignals = 12'b00010000xx01;  // LUI
		  
		  7'b1101111: controlSignals = 12'b00001000xx01;  // JAL
		  
		  default: controlSignals = 12'bxxxxxxxxxxxx; // illegal op
		  
		endcase
	
	end
	
	assign {branch, slt, lui, jal, memToReg, memWrite, memRead, aluOp, aluSrc, regWrite} = controlSignals;

endmodule 