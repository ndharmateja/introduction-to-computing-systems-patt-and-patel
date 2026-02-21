.ORIG x3000
MAIN        LD  R6, STACKTOP    ; initialize stack pointer with xFDFF
            AND R0, R0, #0
            ADD R0, R0, #3
            AND R1, R1, #0
            ADD R1, R1, #10     ; store 10 in R1 to see if it is preserved after
                                ; calling the recursive function
            JSR SUMN            ; call the SUMN function with value 3 in R0
                                ; and it should produce 1+2+3 = 6 in R0 after the call
            HALT                ; at this point, R0 should have 6 and R1 should have 10
            
SUMN        ADD R6, R6, #-1
            STR R1, R6, #0      ; store R1 which we will use on the stack (callee-save)
            
            ADD R1, R0, #0      ; R1 <- n
            BRz BASECASE        ; If R1 has 0, it means that n = 0 and we can go to base case
            
            ADD R6, R6, #-1
            STR R7, R6, #0      ; store R7 which has the return address on the stack
            
            ADD R0, R0, #-1     ; R0 <- n-1
            JSR SUMN            ; call the function recursively
                                ; R0 <- sum(n-1)
            ADD R0, R0, R1      ; R0 <- n + sum(n-1)
            
            LDR R7, R6, #0      ; restore return address from the stack to R7
            ADD R6, R6, #1
        
BASECASE    LDR R1, R6, #0      ; restore R1's value from the stack
            ADD R6, R6, #1
            RET                 ; if base case, we jumped from the BRz so R0 will have 0
                                ; but if it is normal execution R0 will have n * f(n-1)
STACKTOP    .FILL xFDFF
.END                                
