module Decode24(out, in);
   input [1:0] in;
   output reg [3:0]	out;
   
   
   always @(*) //always block checks if ANYTHING has changed in any way
     case(in) //checking the value of in
       2'b00 : assign out = 4'b0001; //assigning the proper output values...
       2'b01 : assign out = 4'b0010;    
       2'b10 : assign out = 4'b0100;
       2'b11 : assign out = 4'b1000;
       default : assign out = 4'b0000; //if we recieve an improper input, then we make it 0000 
     endcase // case (in)
  endmodule
     
   
