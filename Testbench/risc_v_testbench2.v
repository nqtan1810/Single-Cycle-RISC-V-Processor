module risc_v_testbench2();
	
	parameter PATH_IMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/iMem2.bin";
	parameter PATH_REGFILE = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/regFile.bin";
	parameter PATH_DMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/dMem.bin";
	
	reg clock;
	reg rstn;
	
	initial begin
		{clock, rstn} = 0;						// reset and prepare for starting
		repeat(2) @(posedge clock);
		rstn = 1;

		repeat(200) @(posedge clock);			// calculate 25th fibonacci
		
		if(risc_v_core.risc_v_datapath.regfile.regfile[10] == 32'd75025) 
			$display("PASSED");
		else
			$display("FAILED");
		
		$stop;
	end
		
	always #5 clock = ~clock;
	
	RISC_V #(.PATH_IMEM(PATH_IMEM),
				.PATH_REGFILE(PATH_REGFILE),
				.PATH_DMEM(PATH_DMEM)) risc_v_core (.clock(clock),
																.rstn(rstn));

	initial begin
		//$monitor("[%2t],	%d,	%d", $time, risc_v_core.risc_v_datapath.pc, risc_v_core.risc_v_controller.branch, risc_v_core.risc_v_controller.jal, risc_v_core.risc_v_datapath.zero, risc_v_core.risc_v_controller.PCsrc);
		$monitor("[%2t],	%d", $time, risc_v_core.risc_v_datapath.writeData);
	end

endmodule 