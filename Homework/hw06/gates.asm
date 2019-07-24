;;=============================================================
;;CS 2110 - Spring 2019
;;Homework 6 - Gates
;;=============================================================
;;Name: Christopher Messina
;;=============================================================

.orig x3000

    ;;YOUR CODE GOES HERE

    ;;Clear Everything
    AND R0,R0,0   ; CLEAR!
    AND R1,R1,0   ; CLEAR!
    AND R2,R2,0   ; CLEAR!
    AND R3,R3,0   ; CLEAR!

    ;;Load variables and not variables into registers
    LD R0,A   ; Load A ->  R0
    LD R1,B   ; Load B -> R1
    LD R2,X   ; Load X -> R2
    NOT R3,R0  ; Not A -> R3
    NOT R4,R1  ; Not B -> R4
    NOT R2,R2  ; Not X -> R2
    ADD R2,R2,#1    ; Two's comp of X -> R2

    ;;A-X and branch on nzp (A<X, A=X, A>X)
    ADD R5,R0,R2
    BRn ALESSX
    BRz ELSE
    BRp AGREATERX

    ;; B-X and branch on nzp (B<X, B=X, B>X)
    AGREATERX
    ADD R5,R1,R2
    BRn AGREATBLESS
    BRz ELSE
    BRp AGREATBGREAT

    ;; B-X and branch on nzp (B<X, B=X, B>X)
    ALESSX
    ADD R5,R1,R2
    BRn ALESSBLESS
    BRz ELSE
    BRp AGLESSBGREAT

    ;; NAND
    ;; ~(A&B)
    AGREATBLESS
    AND R5,R0,R1
    NOT R5,R5
    ST R5, ANSWER ; Store data from R5 into VALUE memory address
    HALT

    ;;NOR
    ;; ~(A|B)
    ;; ~A & ~B
    AGREATBGREAT
    AND R5,R3,R4
    ST R5, ANSWER
    HALT

    ;;OR
    ;; A|B
    ;; NOT NOR
    ;; ~(~A & ~B)
    ALESSBLESS
    AND R5,R3,R4
    NOT R5,R5
    ST R5, ANSWER
    HALT

    ;;AND
    AGLESSBGREAT
    AND R5,R0,R1
    ST R5, ANSWER
    HALT

    ;;NOT A
    ELSE
    ST R3,ANSWER
    HALT



A   .fill x3030
B   .fill x4040
X   .fill x4040

ANSWER .blkw 1

.end


;if (A > X) && (B < X)
;        ANSWER = A NAND B
;    else if (A > X) && (B > X)
;        ANSWER = A NOR B
;    else if (A < X) && (B < X)
;        ANSWER = A OR B
;    else if (A < X) && (B > X)
;        ANSWER = A AND B
;    else
;        ANSWER = !A
