.globl Lab03c
Lab03c:     
    MOVZ X1, #0//make i =0
	ADRP X2 ,my_array //stores the baseline address of UIN on X0
	ADD X2, X2, :lo12:my_array //points at the first number of my_arra
	ADRP X0, initial_value
	ADD X0, X0, :lo12:initial_value
	LDUR X0, [X0,#0]

loop:
	CMP X1, #10 //sets up the values to compare in the for loop
	B.GE  finish //checks if X11 is greater than or equal to  #10
	
	STUR X0 ,[X2, #0] //Stores the value we want in
	ADD X2, X2, #8 //shifts where we are storing by 8 since each .quad is 8 bytes

	ADD X0, X0, #1	//increments j value to the next number
	ADD X1 ,X1, #1 //adds 1 to X1 so we eventually reach 10
        B loop //resets to the top of the loop. 

finish:     
  
    BR X30	//exits
.section .data
my_array:
.space  80
initial_value: .quad 4 	
