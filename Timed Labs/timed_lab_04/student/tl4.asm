;;=======================================
;; CS 2110 - Spring 2019
;; Timed Lab 4
;;=======================================
;; Name: Christopher Messina
;;=======================================

;; A little reminder from your friendly neighborhood 2110 TA staff:
;; Do not try to run this directly by pressing 'RUN' in Complx.
;; Instead, load it and use 'Debug' -> 'Simulate Subroutine Call'
;; and choose the 'countMult7' label.

.orig x3000

halt ; Do not remove this line – see note above

; mod(a, b)
;
; This looks funky, but it is a subroutine you can call
; like normal. Just be sure to use the LC3 calling convention!
;
; return 1 if a % b == 0 and 0 otherwise
mod
    .fill x1dbf
    .fill x1dbf
    .fill x7f80
    .fill x1dbf
    .fill x7b80
    .fill x1dbf
    .fill x1ba0
    .fill x1dbe
    .fill x7381
    .fill x7580
    .fill x6344
    .fill x6545
    .fill x94bf
    .fill x14a1
    .fill x1242
    .fill x0402
    .fill x0805
    .fill x03fc
    .fill x5260
    .fill x1261
    .fill x7343
    .fill x0e02
    .fill x5260
    .fill x7343
    .fill x6580
    .fill x6381
    .fill x1d63
    .fill x6f42
    .fill x6b41
    .fill xc1c0

; return count of arguments that are multiples of 7
countMult7 ; countMult7(a, ...)
    ; TODO Stack SETUP code here
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

    ; TODO your function body code here
    ; number of arguments remaining is the leftmost arg (stored at R5 + 4)
    LDR R0,R5,#4 ; Load the number of remaining arguments into R0
    ST R0,CHECKPOINT1 ; Store number of arguments remaining in CHECKPOINT1

    AND R0,R0,R0 ; Just to make sure we have the right cc
    BRnz SKIPCHECK2

    ADD R1,R5,#5 ; get the address of a[0]
    ST R1,CHECKPOINT2 ; Store the effective address of a[0] at CHECKPOINT2

    SKIPCHECK2

    AND R2,R2,#0 ; Clear R2 and reserve it for count
    AND R3,R3,#0 ; Clear R3 and reserve if for i
    WLOOP
    AND R0,R0,R0 ; Get correct cc
    BRnz OUTOFLOOP

    ;Inside the loop
    ADD R4,R1,R3 ; get memory location of a[i]
    LDR R4,R4,#0 ; Load a[i] into R4 (this is num)
    ADD R6,R6,#-1 ; push R4 onto stack to free up the register
    STR R4,R6,#0

        ;;CALL TO MOD
        ;ADDR6, R6, -1 ; push(3(
        ;ANDR0, R0, 0
        ;ADDR0, R0, 3
        ;STRR0, R6, 0
        ADD R6,R6,#-1 ; push 7
        AND R4,R4,#0
        ADD R4,R4,#7
        STR R4,R6,#0
        ADD R6,R6,#-1 ; push num
        LDR R4,R6,#2
        STR R4,R6,#0
        JSR mod ;Call mod subroutine
        ;Now we're back from length and have our RV on the stack at R6
        LDR R4,R6,#0 ; Load the mod result into R4
        ADD R6,R6,#1 ;pop RETVAL
        ADD R6,R6,#1 ; pop first arg
        ADD R6,R6,#1 ; pop second arg

    ADD R6,R6,#1 ;pop the saved variable that we no longer need

    AND R4,R4,R4
    ADD R4,R4,#-1
    BRnp AFTERIF

    ;if
    ADD R2,R2,#1 ;count++

    AFTERIF
    ADD R0,R0,#-1 ; n--;
    ADD R3,R3,#1 ; i++

    BR WLOOP

    OUTOFLOOP
    STR R2,R5,#3 ; return count



;int countMult7(n, a[0], a[1], ... a[n-1]) {
;    int count = 0;
;    int i = 0;
;    CHECKPOINT1 = n;

;    if (n > 0)
;        CHECKPOINT2 = a; // store the *address* (not the value) of a[0] here
;                         // note that a[0] is the second parameter
;    while (n > 0) {
;        int num = a[i];
;        if (mod(num, 7) == 1) {
;            count++;
;        } n--; i++;
;    }
;    return count;
;}



    ; TODO your TEARDOWN code here
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

; Do not remove or modify anything below this line
; Needed for subroutine calls and grading
STACK .fill xF000
CHECKPOINT1 .blkw 1 ; Should store n
CHECKPOINT2 .blkw 1 ; Should store address of first variable argument

.end
