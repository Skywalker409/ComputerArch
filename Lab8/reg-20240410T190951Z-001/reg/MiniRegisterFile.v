module MiniRegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
//declaratio of the types of inuputs and outputs
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0]RW;
    input [4:0]RA;
    input [4:0]RB;
    input RegWr;
    input Clk;

    
    //creation of the 32x64 registers
    reg [31:0] registers [63:0];


     //activate IF on the negative edge of the CLK
    always @ (negedge Clk) begin
    //only write to the specified register witht the input IF RegWr =1
        if(RegWr)begin
            registers[RW] <= #3 BusW;
     
        end
    end
    
    //transfer data over to respected Bus's after #2 delay
    assign #2 BusA = (RA!=5'd31)? registers[RA]:64'b0;
    assign #2 BusB = (RB!=5'd31)? registers[RB]:64'b0;
    
    
endmodule
