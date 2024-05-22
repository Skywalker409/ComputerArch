module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output [63:0] NextPC; 

reg [63:0] newpc; //assigns temporary register for newpc to be assigned values in the always block
reg [63:0] Imm;  //assigns temporary register for imm to be assigned values in the always block


always @(*) begin //to be updated whenever any values changed
      if (Uncondbranch) begin //if uncondbranch is true, then newpc is set equal to 4 times SignExtImm64
        Imm = SignExtImm64*4;
        newpc = CurrentPC + Imm; end
      else if (Branch && ALUZero) begin //if Branch and ALUZero is true, then newpc is set equal to 4 times SignExtImm64
        Imm = SignExtImm64*4;
        newpc = CurrentPC + Imm; end
      else begin                   //if neither of the two if statements are true, then newpc is equal to currentPC + 4
        newpc = CurrentPC + 4; end 
        
end

assign NextPC = newpc; //assigns NextPC output, equal to the value assigned to newpc

endmodule




            
          
      
      
    

