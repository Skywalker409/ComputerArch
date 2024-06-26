`timescale 1ns / 1ps


`define STRLEN 32
module NextPClogic_v;
	 initial //This initial block used to dump all wire/reg values to dump file
     begin
      $dumpfile("NextPClogicTest.vcd");
      $dumpvars(0,NextPClogic_v);
     end
   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0] 	  passed;
      
      if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
      else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask
   
   task allPassed;
      input [7:0] passed;
      input [7:0] numTests;
      
      if(passed == numTests) $display ("All tests passed");
      else $display("Some tests failed");
   endtask

	// Inputs
	reg [63:0] CurrentPC;
	reg [63:0] SignExtImm64;
	reg Branch;
	reg ALUZero;
	reg Uncondbranch;
	reg [7:0] passed;

	// Outputs
	wire [63:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	NextPClogic uut (
		.NextPC(NextPC), 
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64), 
		.Branch(Branch), 
		.ALUZero(ALUZero),
		.Uncondbranch(Uncondbranch)
	);



//change these**************************************************************

	initial begin
		// Initialize Inputs	
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		passed = 0;


            
        //TESTS
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h0000, 64'h1111, 1'b0, 1'b0, 1'b0}; #40; passTest({NextPC}, 64'h0004, "Default case:", passed); 
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h0000, 64'b0111, 1'b1, 1'b1, 1'b0}; #40; passTest({NextPC}, 64'd28,    "Branch Pos:  ", passed); 
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'b0100,-64'b0001, 1'b1, 1'b1, 1'b0}; #40; passTest({NextPC}, 64'h0, "Branch Neg:  ", passed);

		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h0000, 64'h1111, 1'b0, 1'b0, 1'b1}; #40; passTest({NextPC}, 64'h4444, "UncondBranch+", passed);
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'b0100, -64'b0001, 1'b0, 1'b1, 1'b1}; #40; passTest({NextPC}, 64'h0, "UncondBranch-", passed);

		

		allPassed(passed, 5);

	end
      
endmodule

