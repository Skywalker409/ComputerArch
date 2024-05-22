.globl lab03b.S

lab03b:     
    MOVZ X1, #0//makes X0 equal to 0 so we can itterate through 
	ADRP X2 ,UIN //stores the baseline address of UIN on X0
	ADD X2, X2, :lo12:UIN //points at the first number of UIN
	LDUR X0, [X2,#0] //loads the value o uin into X0

loop:
	CMP X1, #10 //sets up the values to compare in the for loop
	B.GE  finish //checks if X11 is greater than or equal to  #10
	SUB X0 ,X0, #1 //decrements the UIN
	ADD X1 ,X1, #1 //adds 1 to X1 so we eventually reach 10
        B loop //resets to the top of the loop. 

finish:     
    STUR X0, [X2, #0] //stores final value of UIN 
    BR X30	//exits
.section .data
UIN:
.quad 33
