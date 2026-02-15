; The Problem Statement:
; Our goal is to multiply the values in R4 and R5 and store the result in R2.

.ORIG x3200
AND R2, R2, #0          ; R2 <- 0
ADD R5, R5, #0          ; R5 <- R5, just touch R5 to test the condition

; As long as R5 is greater than 0, keep adding R4 to the accumulator R2
LOOP
BRz LOOPEND             ; We make sure that R5 is updated preceding this BRz and if it becomes 0, we exit the loop
ADD R2, R2, R4          ; R2 <- R2 + R4
ADD R5, R5, #-1         ; R5 <- R5 - 1
BRnzp LOOP                ; unconditional jump to LOOP
LOOPEND

HALT
.END

