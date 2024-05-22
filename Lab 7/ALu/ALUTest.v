`timescale 1ns / 1ps


`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;


                
        //ADD TESTS
		{BusA, BusB, ALUCtrl} = {64'hACEB, 64'hABDDE000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABDE8CEB, "ADD 0xACEB,0xABDDE000", passed);
		{BusA, BusB, ALUCtrl} = {64'h562D, 64'h23560000, 4'h2}; #40; passTest({Zero, BusW}, 65'h02356562D, "ADD 0x562D,0x23560000", passed);
		{BusA, BusB, ALUCtrl} = {64'h8932, 64'h78925000, 4'h2}; #40; passTest({Zero, BusW}, 65'h07892D932, "ADD 0x8932,0x78925000", passed);
		
		//AND TESTS
		{BusA, BusB, ALUCtrl} = {64'h23890000, 64'h00FA5000, 4'h0}; #40; passTest({Zero, BusW}, 65'h000880000, "AND 0X23890000,0x00FA5000", passed);
		{BusA, BusB, ALUCtrl} = {64'h31580000, 64'hFFFD0000, 4'h0}; #40; passTest({Zero, BusW}, 65'h031580000, "AND 0x31580000,0xFFFD0000", passed);
		{BusA, BusB, ALUCtrl} = {64'h98760000, 64'h00000000, 4'h0}; #40; passTest({Zero, BusW}, {1'b1, 64'h0}, "AND 0x98760000,0x00000000", passed);
		
		//SUB TESTS
		{BusA, BusB, ALUCtrl} = {64'hFF110000, 64'h00546700, 4'h6}; #40; passTest({Zero, BusW}, 65'h0febc9900, "SUB 0XFF110000,0x00546700", passed);
		{BusA, BusB, ALUCtrl} = {64'hAAAD0000, 64'hADCE, 4'h6}; #40; passTest({Zero, BusW}, 65'h0aaac5232, "SUB 0xAAAD0000,0x0000ADCE", passed);
		{BusA, BusB, ALUCtrl} = {64'h00000000, 64'h12ED, 4'h6}; #40; passTest({Zero, BusW}, 65'h0ffffffffffffed13, "SUB 0x00000000,0x000012ED", passed);

		//OR TESTS
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h00000000, 4'h1}; #40; passTest({Zero, BusW}, 65'h011111111, "OR 0X11111111,0x00000000", passed);
		{BusA, BusB, ALUCtrl} = {64'h10101010, 64'h01010101, 4'h1}; #40; passTest({Zero, BusW}, 65'h011111111, "OR 0x10101010,0x01010101", passed);
		{BusA, BusB, ALUCtrl} = {64'h1101BDE,  64'h1010ABC, 4'h1}; #40; passTest({Zero, BusW}, 65'h01111BFE, "OR 0x1101BDE0,0x01010ABC", passed);
		
		//PASS B TESTS
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h12345678, 4'h7}; #40; passTest({Zero, BusW}, 65'h012345678, "OR 0X11111111,0x00000000", passed);
		{BusA, BusB, ALUCtrl} = {64'h10101010, 64'h87654321, 4'h7}; #40; passTest({Zero, BusW}, 65'h087654321, "OR 0x10101010,0x01010101", passed);
		{BusA, BusB, ALUCtrl} = {64'h1101BDE,  64'h00000000, 4'h7}; #40; passTest({Zero, BusW}, {1'b1, 64'h0}, "OR 0x1101BDE0,0x01010ABC", passed);


	


		allPassed(passed, 15);
	end
      
endmodule

