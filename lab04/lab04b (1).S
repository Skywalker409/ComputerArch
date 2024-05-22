	.globl lab04b
lab04b:
		//we need to save the address of main.c before we continue
	SUB SP, SP, 16 //makes space on stack for us to store values onto it
	STUR X30 , [SP,8] //Saves main's address for later us
	STUR X0, [SP,0] //saving "n" onto stack
	SUB X1, X0 ,#1// n-1
	CBNZ X1, help // if X1 is not 0 then we go to help
	ADD SP,SP,#16 
	BR X30 //jums towards the BL made in help

help:
	SUB X0,X0,#1 //decrements n by 1
	BL lab04b //recursivly calls until we reach n =0
	LDUR X1,[SP,0] //loading in n from stack
	BL my_mul //multiplies our 2 numbers and saves it into X0
	LDUR X30,[SP,#8] //loading in the return address into X30
	ADD SP, SP, 16 //shifts the stack back into place
	BR X30 //recurses back onto what teh stack wanted us to go. 

my_mul:
        //Multiply X0 and X1
        //   Does not handle negative X1!
        //   Note : This is an in efficient way to multipy!
        SUB SP, SP, 16          //make room for X19 on the stack
        STUR X19, [SP, 0]       //push X19
        ADD X19, X1, XZR        //set X19 equal to X1
        ADD X9 , XZR , XZR      //set X9 to 0
mult_loop:
        CBZ X19,  mult_eol
        ADD X9, X9, X0
        SUB X19, X19, 1
        B mult_loop
mult_eol:
        LDUR X19, [SP, 0]
	ADD SP, SP, 16
        ADD X0, X9, XZR         // Move X9 to X0 to return
        BR X30



