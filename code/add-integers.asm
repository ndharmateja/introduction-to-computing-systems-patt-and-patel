; The Problem Statement:
; Our goal is to take the ten numbers which are stored in memory locations x3100 through
; x3109, and add them together, leaving the result in register 1. 

.ORIG x3000         ; start the program at location x3000
LEA R2, x0FF        ; LEA's instruction addr = x3000 => R2 <- x3001 + 255 => R2 <- x3100
AND R1, R1, #0      ; R1 <- 0 which maintains the running sum
AND R4, R4, #0      ; R4 <- 0
ADD R4, R4, #10     ; R4 <- 10 which maintains the number of ints left to be added

LOOP 
BRz LOOPEND         ; jump to LOOPEND if R4 is 0 (we make sure that R4 register update precedes this BRz instruction)
LDR R3, R2, #0      ; load the next number to be added into R3
ADD R1, R1, R3      ; store the running sum in R1
ADD R2, R2, #1      ; increment R2 to point to the next number
ADD R4, R4, #-1     ; decrement the number of remaining numbers to be added
BRnzp LOOP          ; unconditionally jump to LOOP (the previous GPR update is R4)
LOOPEND

HALT                ; halt the program
.END

.ORIG x3100         ; start the data at location x3100
.FILL #1            ; the value of the first data element at x3100 is 1
.FILL #2
.FILL #3
.FILL #4
.FILL #5
.FILL #6
.FILL #7
.FILL #8
.FILL #9
.FILL #10
.END