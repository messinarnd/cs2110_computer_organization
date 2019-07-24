;;=============================================================
;;CS 2110 - Spring 2019
;;Homework 6 - Reverse
;;=============================================================
;;Name: Christopher Messina
;;=============================================================

.orig x3000

    ;;PUT YOUR CODE HERE
    ;; Clear Registers
    AND R0,R0,0 ; Array pointer
    AND R1,R1,0 ; X index
    AND R2,R2,0 ; Y index
    AND R3,R3,0
    AND R4,R4,0
    AND R5,R5,0
    AND R6,R6,0
    AND R7,R7,0

    ;; Array pointer - 1st array index (x4000)
    LD R0,ARRAY

    ;; Length of Array in R1
    LD R1, LENGTH   ;LENGTH

    ;; End the program if the length is 0 or 1
    ADD R1,R1,-1
    BRnz OUTOFLOOP
    ;; This also shortens the length by 1 so length 10 -> 9

    ;; Y = last index in array (length - 1)
    ADD R2,R1,#0
    ;ADD R2,R2,1

    ; Set X = R1 = 0
    AND R1,R1,#0

    ;; While loop with condition (x < y)
    WLOOP
    NOT R3,R2
    ADD R3,R3,#1
    ADD R3,R1,R3 ;; Add x and two's of y
    BRzp OUTOFLOOP ;; if it is negative (i.e. x<y), continue. Otherwise branch to OUTOFLOOP

    ;; Inside of while loop
    ADD R3,R0,R1
    LDR R4,R3,#0 ; Load data at postion x into R4 (temp var)
    ADD R5,R0,R2
    LDR R5,R5,#0 ; Load data at position y into R5 (temp var)
    STR R5,R3,#0 ; Store R6 into mem[R4 + 0] so store Y data into array[x+0]
    ;OUT
    ADD R5,R0,R2
    STR R4,R5,#0 ; Store R5 into mem[R2 + 0] so store X data into array[y+0]
    ;OUT
    ADD R1,R1,#1 ; x++
    ADD R2,R2,#-1 ; y--



    BRnzp WLOOP ; branch to top of loop

    OUTOFLOOP
    HALT


;; List of Registers
;; R0 = X
;; R1 = LENGTH
;; R2 = Y
;; R3 = Two's of Y
;; R4 = x-y


ARRAY .fill x4000
LENGTH .fill 7
.end

.orig x4000
.fill 2
.fill 9
.fill 7
.fill 0
.fill 5
.fill 3
.fill 10
.end
