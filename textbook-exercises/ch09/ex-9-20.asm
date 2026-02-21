; Program objective: If an uppercase character is entered, convert it to a lower case
; and vice versa. If any other character is entered, exit the program.
; ASCII of A - x0041 and negative of it is xFFBF
; ASCII of Z - x005A and negative of it is xFFA6
; ASCII of a - x0061 and negative of it is xFF9F
; ASCII of z - x007A and negative of it is xFF86
            .ORIG   x3000
            LD      R2, U_2_L
            LD      R3, L_2_U

; print the start string
            LEA     R1, START_STR_1
            JSR     PRINT_STR
            LEA     R1, START_STR_2
            JSR     PRINT_STR
            
AGAIN       TRAP    x23             ; request keyboard input

            ; terminate if R0 < x41 <=> R0 - x41 < 0
            LD      R1, NEG_UPPER_A
            ADD     R1, R1, R0  
            BRn     EXIT            

            ; terminate if R0 > x7A <=> R0 - x7A > 0
            LD      R1, NEG_LOWER_Z 
            ADD     R1, R1, R0
            BRp     EXIT

            ; At this point x41 <= R0 <= x7A
            ; If uppercase (if R0 <= x5A <=> R0 - x5A <= 0) go to the UPPER section
            LD      R1, NEG_UPPER_Z
            ADD     R1, R1, R0
            BRnz    UPPER

            ; If lowercase (if R0 >= x61 <=> R0 - x61 >= 0) go to the LOWER section
            LD      R1, NEG_LOWER_A
            ADD     R1, R1, R0
            BRzp    LOWER

            ; If any other value x5A < R0 < x61, jump to exit
            BRnzp   EXIT

            ; If char is lowercase, convert to uppercase and output it to monitor
LOWER       ADD     R0, R0, R3
            TRAP    x21
            BRnzp   AGAIN

            ; If char is uppercase, convert to lowercase and output it to monitor
            ; and jump to loop increment
UPPER       ADD     R0, R0, R2      ; change to lowercase
            TRAP    x21             ; output to monitor
            BRnzp   AGAIN

; print the exit string and halt the program
EXIT        LEA     R1, END_STR
            JSR     PRINT_STR
            TRAP    x25

; subroutine to print a string
; the address of the starting char should be in R1
PRINT_STR   LDR     R0, R1, #0      ; store the starting char in R1
            BRz     FN_EXIT         ; if it is a null char exit the program
            TRAP    x21             ; print char in R0
            ADD     R1, R1, #1      ; increment R1
            BRnzp   PRINT_STR       ; jump to the start of the loop (also the start of the fn)
FN_EXIT     LD      R0, NEWLINE     
            TRAP    x21             ; print newline at the end
            RET

; all the required constants
U_2_L       .FILL   x0020           ; to convert from upper to lower => add x0020
L_2_U       .FILL   xFFE0           ; to convert from lower to upper => add -x0020

NEG_UPPER_A .FILL   xFFBF           ; negative of ASCII upper A
NEG_UPPER_Z .FILL   xFFA6           ; negative of ASCII upper Z
NEG_LOWER_A .FILL   xFF9F           ; negative of ASCII lower a
NEG_LOWER_Z .FILL   xFF86           ; negative of ASCII lower z

NEWLINE     .FILL   x000A           ; newline char

; all the required strings
START_STR_1 .STRINGZ "Lowercase will be uppercase and vice versa."
START_STR_2 .STRINGZ "Enter any non-alphabet character to exit the program."
END_STR     .STRINGZ "Got a non-alphabet character. Exiting the program!"

            .END