module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
   input [63:0] CurrentPC, SignExtImm64; 
   input 	Branch, ALUZero, Uncondbranch; 
   output [63:0] NextPC; 

reg [63:0] newpc;
reg [63:0] Imm;


always @(*) begin
      if (Uncondbranch) begin
        Imm = SignExtImm64*4;
        newpc = CurrentPC + Imm; end
      else if (Branch && ALUZero) begin
        Imm = SignExtImm64*4;
        newpc = CurrentPC + Imm; end
      else begin
        newpc = CurrentPC + 4; end 
        
end

assign NextPC = newpc;

endmodule




            
          
      
      
    

