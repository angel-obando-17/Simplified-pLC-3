main:   LD  R1, 0x10
        LD  R2, 0x10
        AND R0, R0, #0
        ADD R6, R0, #5
        ADD R3, R0, #10 ; 10 Iterations 
        BRn reset 
        ADD R4, R2, R1
        ADD R5, R0, R2
        ADD R2, R0, R4
        ADD R1, R0, R5
        ADD R7, R0, #1  ; A2 complement of '1'
        NOT R7, R7      
        ADD R7, R7, #1
        ADD R3, R3, R7
        JMP R6
reset:  ADD R7, R0, #0
        JMP R7

