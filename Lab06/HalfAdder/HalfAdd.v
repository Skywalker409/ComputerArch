module HalfAdd(Cout, Sum, A, B);

   input A, B; // declaration of all the inputs 
   output Cout, Sum; // declaration of all the outputs 
   assign Sum = A ^ B; //Makes the sum XOR of the two inputs 
   assign Cout = A & B; // Make the cout the AND of the two inputs
endmodule
