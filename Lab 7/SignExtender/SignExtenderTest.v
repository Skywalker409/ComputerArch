`define STRLEN 15
module SignExtenderTest_v;
     initial //This initial block used to dump all wire/reg values to dump file
     begin
      $dumpfile("SignExtenderTest.vcd");
      $dumpvars(0,SignExtenderTest_v);
     end

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*12:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: \n%d\n should be:\n%d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [31:0] in;
	reg [7:0] passed;
        reg [1:0]  Ctrl;
   

	// Outputs
	wire [63:0] out;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
	         
		.BusImm(out),
		.Imm16(in),
		.Ctrl(Ctrl)
			  
	);

	initial begin
		// Initialize Inputs
		in = 'd0;
	        Ctrl = 00;
	   
		passed = 0;
	  // 00000
//in = 'd10
//     expect = -64'd10
		// Add stimulus here
	    #90; in[21:10] = 12'd10; Ctrl = 00;//testing i type with positive input 
	    #10; passTest(out, 64'd10, "Input 00,+:", passed);
	   #10 in = 'd0;
	   
	    #90; in[21:10] = -12'd10; Ctrl = 00; //testing i type with negative input 
	    #10; passTest(out,-64'd10, "Input 00,-:", passed);
	   #10 in = 'd0;

	   #90; in[20:12] = 9'd22; Ctrl = 01; //testing d type with pos input
	    #10; passTest(out, 64'd22, "Input 01,+:", passed);
	   	   #10 in = 32'd0;

	    #90; in[20:12] = -9'd22; Ctrl = 01; //testing d type with neg input
	    #10; passTest(out,-64'd22, "Input 01,-:", passed);





	   

	     #90; in[25:0] = 26'd23; Ctrl = 10; //testing b type with pos input
	    #30; passTest(out, 64'd23, "Input 10,+:", passed);
	   	   #90 in = 32'd0;

	    #90; in[25:0] = -26'd3; Ctrl = 10; //testing b type with neg input
	    #10; passTest(out,-64'd3, "Input 10,-:", passed);
	   	   #90 in = 32'd0;


	    #90; in[23:5] = 19'd22; Ctrl = 11; //testing cb type with pos input
	    #10; passTest(out, 64'd22, "Input 11,+:", passed);
	   	   #90 in = 'd0;

	    #90; in[23:5] = -19'd10; Ctrl = 11; //testing cb type with neg input
	    #10; passTest(out,-64'd10, "Input 11,-:", passed);
	   	   #90 in = 'd0;



		#90;
		
		allPassed(passed, 8);

	end
      
endmodule

