`define OPCODE_ANDREG 11'b?0001010???
`define OPCODE_ORRREG 11'b?0101010???
`define OPCODE_ADDREG 11'b?0?01011???
`define OPCODE_SUBREG 11'b?1?01011???

`define OPCODE_ADDIMM 11'b?0?10001???
`define OPCODE_SUBIMM 11'b?1?10001???

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b?00101?????
`define OPCODE_CBZ    11'b?011010????

`define OPCODE_LDUR   11'b??111000010
`define OPCODE_STUR   11'b??111000000

module control(
	       output reg 	reg2loc,
	       output reg 	alusrc,
	       output reg 	mem2reg,
	       output reg 	regwrite,
	       output reg 	memread,
	       output reg 	memwrite,
	       output reg 	branch,
	       output reg 	uncond_branch,
	       output reg [3:0] aluop,
	       output reg [2:0] signop,
	       input [10:0] 	opcode
	       );

   always @(*)
     begin
	casez (opcode)

          /* Add cases here for each instruction your processor supports */
	  11'b11111000010: begin //lDUR
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'bx, 1'b0,1'b0,1'b1,1'b1};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b1,1'b1, 4'b0010, 3'b001};
	  
	  end
	  11'b11111000000: begin //STUR
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b1, 1'b0,1'b0,1'b0,1'bx};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b1,1'b1,1'b0, 4'b0010, 3'b001};
	  
	  end
	  11'b10001011000: begin// ADD
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b0, 1'b0,1'b0,1'b0,1'b0};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b0,1'b1, 4'b0010, 3'b000};
	  
	  end
	  11'b11001011000: begin // SUB
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b0, 1'b0,1'b0,1'b0,1'b0};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b0,1'b1, 4'b0110, 3'b000};
	  
	  end
	  11'b10001010000: begin  // AND
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b0, 1'b0,1'b0,1'b0,1'b0};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b0,1'b1, 4'b0000, 3'b000};
	  end
	  11'b10101010000: begin //ORR
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b0, 1'b0,1'b0,1'b0,1'b0};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b0,1'b1, 4'b0001, 3'b000};
	  end
	  11'b10110100???: begin // CBZ
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'b1, 1'b0,1'b1,1'b0,1'bx};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b0,1'b0, 4'b0111, 3'b011};
	  end
	  11'b000101?????: begin //B
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'bx, 1'b1,1'bx,1'b0,1'bx};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'bx,1'b0, 4'bxxxx, 3'b010};
	  end
	  11'b110100101??: begin //MOVZ
	  {reg2loc,uncond_branch, branch,memread, mem2reg} = {1'bx, 1'b0,1'b0,1'b0,1'b0};
	  {memwrite, alusrc, regwrite, aluop, signop} ={1'b0,1'b1,1'b1, 4'b0111, 3'b100};
	  end
	       
          default:
            begin
               reg2loc       = 1'bx;
               alusrc        = 1'bx;
               mem2reg       = 1'bx;
               regwrite      = 1'b0;
               memread       = 1'b0;
               memwrite      = 1'b0;
               branch        = 1'b0;
               uncond_branch = 1'b0;
               aluop         = 4'bxxxx;
               signop        = 3'bxxx;
            end
	endcase
     end

endmodule

