module SignExtender(BusImm, Imm16, Ctrl); 
   output reg [63:0] BusImm; 
   input [31:0]  Imm16; 
   input [2:0]	 Ctrl; 
   reg		 polarity;
   always @(*) begin
   case(Ctrl) 
      3'b000: begin //I- type
	 //get the bits from 21-10 (12 bits) and extend that to 64
	  polarity  = Imm16[21];
	  BusImm = {{52{polarity}} , Imm16[21:10]};
	 
	 
      end
      3'b001: begin //D-Type
	 //get the bits from 20-12 and sign extend that to 64
	  polarity  = Imm16[20];
	  BusImm = {{55{polarity}} , Imm16[20:12]};
	 
      end
      3'b010: begin //B-type
	 //get bits from 25-0 and sign extend that to 64
	  polarity  = Imm16[25];
	  BusImm = {{38{polarity}} , Imm16[25:0]};
	 
      end
      3'b011: begin //CB-type
	 // get bits from 23 - 5
	   polarity  = Imm16[23];
	  BusImm = {{45{polarity}} , Imm16[23:5]};
	 
      end
      3'b100:begin //MOVZ case
	 // get the bits from immediate[22-21] to determin how much we need to logic shift it.
	 polarity = 1'b0;
	 
	 case(Imm16[22:21])
	     2'b00: begin //shift by 0 bits 
	       BusImm = {{48{polarity}}, Imm16[20:5]};
	    end
	     2'b01: begin //shift by 16 bits
	       BusImm = {{32{polarity}}, Imm16[20:5], {16{1'b0}}};

	    end
	     2'b10: begin //shift by 32 bits
	       BusImm = {{16{polarity}}, Imm16[20:5], {32{1'b0}}};

	    
	    end
	     2'b11: begin //shift by 48 bits
	       BusImm = { Imm16[20:5], {48{1'b0}}};

	    
	    end
	    
	    endcase //case Imm[22:21]
      end

      default: begin

	 end

   endcase // case (Ctrl)
     end //end for always
   
endmodule
