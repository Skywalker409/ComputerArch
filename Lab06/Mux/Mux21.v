module Mux21(out, in , sel);
   input [1:0] in;

   input       sel;

   output      out;
   
   wire	       net1, net2; //creating middle points to simplify the code
   assign net1 = in[1] & sel; // assigning the middle points
   assign net2 = in[0] & !sel;
   assign out = net1 | net2; //finally making the last value output
   endmodule
   
   
