;;=======================================
;; CS 2110 - Spring 2019
;; Homework 7
;;=======================================
;; Name: Christopher Messina
;;=======================================

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'decimalStringToInt' label.

.orig x3000

halt

MULT
    ;;BUILDUP
    ADD R6,R6,#-4 ; moves R6 down 4 to point (EFFC)
    ;Return Value will go in R6,#3 once we are done
    STR R7,R6,#2 ; save return address (EFFC)
    STR R5,R6,#1 ; save old FP (EFFD)
    ADD R5,R6,#0 ; establish FP (move FP to current stack pointer) (this is where first temp variable is - answer)
    ADD R6,R6,#-5 ; make space for saved registers (4 of them) and move stack pointer
    STR R0,R5,#-1 ; SAVE REGISTERS
    STR R1,R5,#-2 ;
    STR R2,R5,#-3 ;
    STR R3,R5,#-4 ;
    STR R4,R5,#-5 ;


    ;;SUBROUTINE CODE
    ;; int a is the leftmost arg (R5 + 4)
    LDR R0,R5,#4 ; Load int a into R0
    LDR R1,R5,#5 ; Load int b into R1

    AND R2,R2,#0 ; Clear R2 and reserve it for VALUE (the thing you'll return)
    MULTLOOP
    AND R1,R1,R1 ; Just to make sure we're looking at int b
    BRnz OUTOFMULTLOOP ; if b ≤ 0, break the loop
    ADD R2,R2,R0 ; Add a to VALUE
    ADD R1,R1,#-1 ; decrement b
    BR MULTLOOP

    OUTOFMULTLOOP
    STR R2,R5,#3 ; Store VALUE in the return value spot on stack (R5 + 3)


    ;;TEARDOWN
    LDR R4,R5,#-5 ; RESTORE SAVED REGISTERS
    LDR R3,R5,#-4 ;
    LDR R2,R5,#-3 ;
    LDR R1,R5,#-2 ;
    LDR R0,R5,#-1 ;
    ADD R6,R5,#0 ; move stack pointer back down
    LDR R5,R6,#1 ; Restore old FP
    LDR R7,R6,#2 ; Restore return address
    ADD R6,R6,#3 ; move stack pointer to RV (return value)
    RET


LENGTH
    ;;BUILDUP
    ADD R6,R6,#-4 ; moves R6 down 4 to point (EFFC)
    ;Return Value will go in R6,#3 once we are done
    STR R7,R6,#2 ; save return address (EFFC)
    STR R5,R6,#1 ; save old FP (EFFD)
    ADD R5,R6,#0 ; establish FP (move FP to current stack pointer) (this is where first temp variable is - answer)
    ADD R6,R6,#-5 ; make space for saved registers (4 of them) and move stack pointer
    STR R0,R5,#-1 ; SAVE REGISTERS
    STR R1,R5,#-2 ;
    STR R2,R5,#-3 ;
    STR R3,R5,#-4 ;
    STR R4,R5,#-5 ;


    ;;SUBROUTINE CODE
    ;String a is the address of the start of the string and is at leftmost arg R5 + 4
    LDR R0,R5,#4 ; Load address of first character of String a into R0
    ;LDR R0,R0,#0 ; Load the first character of String a into R0

    AND R1,R1,#0 ; Clear R1 and reserve it for LENGTH
    LENLOOP
    ADD R2,R0,R1 ; Get the address of the current character in string
    LDR R2,R2,#0 ; Get the current character in the string
    BRz OUTOFLENLOOP ; if character is null, break out of loop
    ADD R1,R1,#1 ; increment LENGTH
    BR LENLOOP

    OUTOFLENLOOP
    STR R1,R5,#3 ; Store LENGTH in return value spot on stack


    ;;TEARDOWN
    LDR R4,R5,#-5 ; RESTORE SAVED REGISTERS
    LDR R3,R5,#-4 ;
    LDR R2,R5,#-3 ;
    LDR R1,R5,#-2 ;
    LDR R0,R5,#-1 ;
    ADD R6,R5,#0 ; move stack pointer back down
    LDR R5,R6,#1 ; Restore old FP
    LDR R7,R6,#2 ; Restore return address
    ADD R6,R6,#3 ; move stack pointer to RV (return value)
    RET


decimalStringToInt
;; Put the code for the DECIMALSTRINGTOINT subroutine here
;decimalStringToInt(String decimal) {
;    int ret = 0
;    for (int i = 0 i < length(decimal) i++) {
;        ret = mult(ret, 10);
;        ret = ret + decimal.charAt(i) - 48;
;    }
;    return ret
;}

    ;;BUILDUP
    ADD R6,R6,#-4 ; moves R6 down 4 to point (EFFC)
    ;Return Value will go in R6,#3 once we are done
    STR R7,R6,#2 ; save return address (EFFC)
    STR R5,R6,#1 ; save old FP (EFFD)
    ADD R5,R6,#0 ; establish FP (move FP to current stack pointer) (this is where first temp variable is - answer)
    ADD R6,R6,#-5 ; make space for saved registers (4 of them) and move stack pointer
    STR R0,R5,#-1 ; SAVE REGISTERS
    STR R1,R5,#-2 ;
    STR R2,R5,#-3 ;
    STR R3,R5,#-4 ;
    STR R4,R5,#-5 ;


    ;;SUBROUTINE CODE
    ;;String decimal is the address of the first character in the string (R5 + 4)
    LDR R0,R5,#4 ; load address of first character address into R0

    AND R1,R1,#0 ; Clear R1 and reserve for ret

        ;;CALL TO LENGTH
        ;ADDR6, R6, -1 ; push(3(
        ;ANDR0, R0, 0
        ;ADDR0, R0, 3
        ;STRR0, R6, 0
        ADD R6,R6,#-1 ; push address of decimal onto stack
        STR R0,R6,#0
        JSR LENGTH ;Call Length subroutine
        ;Now we're back from length and have our RV on the stack at R6
        LDR R2,R6,#0 ; Load the length of the string into R2
        ADD R6,R6,#2 ; pop RET VAL and the argument of length (restore the SP)

    NOT R2,R2
    ADD R2,R2,#1 ; two's comp of length
    AND R3,R3,#0 ; Clear R3 and reserve for i (counter)
    DECLOOP
    ADD R4,R3,R2 ; i-length
    BRzp OUTOFDECLOOP; if (i > length), break out of loop
        ;;CALL TO MULT
        ADD R6,R6,#-1 ; push int b (10)
        AND R4,R4,#0
        ADD R4,R4,#10
        STR R4,R6,#0
        ADD R6,R6,#-1 ; push int a (ret)
        STR R1,R6,#0
        JSR MULT ; Call MULT subroutine
        ;Now we're back from MULT and have our RV on the stack at R6
        LDR R1,R6,#0 ; Load RV into ret (returned from mult) ret = mult(ret,10)
        ADD R6,R6,#3 ; pop RET VAL, int a, and int b
    ADD R4,R0,R3 ; address of charAt(i)
    LDR R4,R4,#0 ; decimal.charAt(i)
    ADD R1,R1,R4 ; ret = ret + decimal.charAt(i)
    LD R4,NUM ; Load 48 into R4
    NOT R4,R4
    ADD R4,R4,#1 ; Load -48 into R4
    ADD R1,R1,R4 ; ret = ret - 48
    ADD R3,R3,#1 ; i++
    BR DECLOOP

    OUTOFDECLOOP
    STR R1,R5,#3 ; store ret on stack at return value spot (R5 + 3)


    ;;TEARDOWN
    LDR R4,R5,#-5 ; RESTORE SAVED REGISTERS
    LDR R3,R5,#-4 ;
    LDR R2,R5,#-3 ;
    LDR R1,R5,#-2 ;
    LDR R0,R5,#-1 ;
    ADD R6,R5,#0 ; move stack pointer back down
    LDR R5,R6,#1 ; Restore old FP
    LDR R7,R6,#2 ; Restore return address
    ADD R6,R6,#3 ; move stack pointer to RV (return value)
    RET


NUM .fill 48
; Needed by Simulate Subroutine Call in complx
STACK .fill xF000
.end

.orig x6000
.stringz "10098"
.end
