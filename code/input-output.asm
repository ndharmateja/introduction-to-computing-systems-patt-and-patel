; The Problem Statement:
; The purpose of this program is to request two integers (between 0 and 9) from the user, add
; them, and display the result (which must also be between 0 and 9) in the console panel.

.ORIG x3000
LD R6, ASCII        ; R6 <- x30
LD R5, NEGASCII     ; R5 <- 0xFFD0 or -x30

TRAP x23            ; trap instruction to get input char from user into R0
ADD R0, R0, R5      ; convert the ascii of the digit to the digit
ADD R1, R0, #0      ; store the first integer in R1

TRAP x23            ; trap instruction to get another input char from user into R0
ADD R0, R0, R5      ; convert the ascii of the digit to the digit
ADD R2, R1, R0      ; add the two integers and store the result in R2

ADD R2, R2, R6      ; convert the resulting sum into ASCII

LEA R0, MESG        ; load the address of the message
TRAP x22            ; trap instruction to output a char
ADD R0, R2, #0      ; Move the resulting sum to R0 to be the output
TRAP x21            ; display the sum
HALT

ASCII
.FILL x30           ; we need to add x30 to the number to get its ASCII value
NEGASCII
.FILL xFFD0         ; we need to subtract x30 (sign extended to xFFD0) to convert from the ASCII value to the digit
MESG
.STRINGZ "The sum is "
.END