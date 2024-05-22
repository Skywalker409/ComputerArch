module SignExtender(BusImm, Imm16, Ctrl); 
   output reg [63:0] BusImm; 
   input [31:0]  Imm16; 
   input [1:0]	 Ctrl; 
   reg		 polarity;
   always @(*) begin
   case(Ctrl) 
      2'b00: begin //I- type
	 //get the bits from 21-10 (12 bits) and extend that to 64
	  polarity  = Imm16[21];
	  BusImm = {{52{polarity}} , Imm16[21:10]};
	 
	 
	 
      end
      2'b01: begin //D-Type
	 //get the bits from 20-12 and sign extend that to 64
	  polarity  = Imm16[20];
	  BusImm = {{55{polarity}} , Imm16[20:12]};
	 
      end
      2'b10: begin //B-type
	 //get bits from 25-0 and sign extend that to 64
	  polarity  = Imm16[25];
	  BusImm = {{38{polarity}} , Imm16[25:0]};
	 
      end
      2'b11: begin //CB-type
	 // get bits from 23 - 5
	   polarity  = Imm16[23];
	  BusImm = {{45{polarity}} , Imm16[23:5]};
	 
      end


      default: begin

	 end

   endcase // case (Ctrl)
     end
   
endmodule
