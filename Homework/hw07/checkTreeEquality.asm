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

checkTreeEquality
;; Arguments of checkTreeEquality: Node b1 (a tree root), Node b2 (another tree root)

    ;;BUILDUP
    BUILDUP
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
    SUBROUTINE
        LDR R0,R5,#4 ; Load Node b1 (1st tree root) address into R0
        LDR R1,R5,#5 ; Load Node b2 (2nd tree root) address int0 R1

        ;;If both are empty, return 1. Otherwise return 0
        EMPTY
            AND R0,R0,R0 ; Just making sure
            BRnp FIRSTNOTZERO ; if not zero, continue to next case
            AND R1,R1,R1
            BRnp NOTEQUAL ; if 1st is 0 and 2nd is not, go to else (return 0)
            BRz EQUAL ; If both are empty, then they are equal


        FIRSTNOTZERO
            AND R1,R1,R1
            BRz NOTEQUAL
            BRnp NONEMPTY


        ;;If both are non-empty, compare their data and then their left subtree then right subtree
        NONEMPTY
            ;Compare the data. If not equal, return 0, Else, move on
            LDR R2,R0,#2 ; Load 1st Root data into R2
            LDR R3,R1,#2 ; Load 2nd Root data into R3
            NOT R3,R3
            ADD R3,R3,#1 ;two's comp of data in 2nd tree's root
            ADD R2,R2,R3 ; R2 = 1st root's data - 2nd root's data
            BRnp NOTEQUAL

            ;Recurse on the left subtree
            LDR R2,R0,#0 ; Load 1st left subtree address into R2
            LDR R3,R1,#0 ; Load 2nd left subtree address into R3
                ;;RECURSIVE CALL
                ADD R6,R6,#-1 ; push 1st left subtree address (R2)
                STR R2,R6,#0
                ADD R6,R6,#-1 ; push 2nd left subtree address (R3)
                STR R3,R6,#0
                JSR checkTreeEquality ; Call checkTreeEquality
                ;Now we're back from checkTreeEquality and have our RV on the stack at R6
                LDR R2,R6,#0 ; Load RV into R2: R2 = checkTreeEqulaity(1st left subtree, 2nd left subtree)
                ADD R6,R6,#3 ; pop RET VAL, 1st subtree, and 2nd subtree
            AND R2,R2,R2 ; Check R2
            BRnz NOTEQUAL

            ;Recures on the right subtree
            LDR R2,R0,#1 ; Load 1st right subtree address into R2
            LDR R3,R1,#1 ; Load 2nd right subtree address into R3
                ;;RECURSIVE CALL
                ADD R6,R6,#-1 ; push 1st right subtree address (R2)
                STR R2,R6,#0
                ADD R6,R6,#-1 ; push 2nd right subtree address (R3)
                STR R3,R6,#0
                JSR checkTreeEquality ; Call checkTreeEquality
                ;Now we're back from checkTreeEquality and have our RV on the stack at R6
                LDR R2,R6,#0 ; Load RV into R2: R2 = checkTreeEqulaity(1st right subtree, 2nd right subtree)
                ADD R6,R6,#3 ; pop RET VAL, 1st subtree, and 2nd subtree
            AND R2,R2,R2 ; Check R2
            BRnz NOTEQUAL
            BRp EQUAL ; if it has made it here, then data, left subtrees, and right subtrees are equal so the trees are equal


        NOTEQUAL
            AND R2,R2,#0 ; Clear it
            STR R2,R5,#3 ; Store 0 in RET VAL
            BR TEARDOWN

        EQUAL
            AND R2,R2,#0 ; Clear it
            ADD R2,R2,#1 ; Put the number 1 in R2
            STR R2,R5,#3 ; Store 1 in RET VAL on stack
            BR TEARDOWN

    ;;TEARDOWN
    TEARDOWN
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





; Needed by Simulate Subroutine Call in complx
STACK .fill xF000
.end
