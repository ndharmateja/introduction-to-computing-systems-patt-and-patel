;
; Program to count occurrences of a character in a file.
; Character to be input from the keyboard.
; Result to be displayed on the monitor.
; Program works only if no more than 9 occurrences are found.
;
;
; Initialization
;
            .ORIG   x3000
            AND     R2, R2, #0          ; R2 is coutner, initialize to 0
            LD      R3, PTR             ; R3 is pointer to characters
            TRAP    x23                 ; R0 gets character input from keyboard
            LDR     R1, R3, #0          ; R1 has the next character
;
; Test character for end of file
;
TEST        ;ADD     R4, R1, #-4         ; Test for EOT
            BRz     OUTPUT              ; If R1 is 0 or the null char then stop
                                        ; If we are looking for EOT, then uncomment the above line
                                        ; If above line is commented, then the GPR loaded before
                                        ; this line is the R1 register which has the next char
;
; Test character for match. If match is found, increment count.
;
            NOT     R1, R1
            ADD     R1, R1, #1          ; R1 <- -R1
            ADD     R1, R1, R0          ; R1 <- R0 - R1, if R1==0, then it is a match!
            BRnp    GETCHAR             ; If no match, do not increment
            ADD     R2, R2, #1
;
; Get next character from file
;
GETCHAR     ADD     R3, R3, #1          ; Increment the pointer
            LDR     R1, R3, #0          ; R1 gets the next character to test
            BRnzp   TEST                ; Unconditional jump to TEST
;
; Output the count
;
OUTPUT      LD      R0, ASCII           ; load the ASCII template x30 in R0
            ADD     R0, R0, R2          ; Convert binary to ASCII and store in R0
            TRAP    x21                 ; ASCII code in R0 is displayed
            TRAP    x25                 ; Halt machine
;
; Storage for pointer and ASCII template
;
ASCII       .FILL   x0030
PTR         .FILL   x4000
            .END
;
; Test file data
;
            .ORIG   x4000
            .STRINGZ "the quick brown fox jumped over the lazy dog!"
            .END