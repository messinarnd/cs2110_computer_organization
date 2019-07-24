;;====================================================
;; CS 2110 - Spring 2019
;; Timed Lab 3
;; tl3.asm
;;====================================================
;; Name: Christopher Messina
;;====================================================

.orig x3000

;;YOUR CODE GOES HERE :D

;;Clear Registers
AND R0,R0,0
AND R1,R1,0
AND R2,R2,0
AND R3,R3,0
AND R4,R4,0

;;Load address of start of ARRAY
LD R0,ARRAY

;;Load the length of the ARRAY
LD R1,LEN
BRz END ; if length == 0, end the program

;;Load last element of array and store in CHECKPOINT1
ADD R1,R1,#-1 ; subtract 1 from the length and put it in R1 (last element of array)
ADD R2,R0,R1 ; Index of last element in ARRAY
LDR R3,R2,#0 ; Load last element into R3
ST R3,CHECKPOINT1 ; Store last element in CHECKPOINT1

;;Check if last element is negative or positive
AND R3,R3,R3 ; Just to make sure we're using R3
BRn NEGATIVE ; Go to NEGATIVE if the last element is negative
ADD R3,R3,R3 ; Just to make sure we're using R3
BRz ZERO

;;Else (last element is positive)
AND R4,R4,#0 ; clear just to make sure
ADD R4,R4,#1 ; make R4 = 1
ST R4,CHECKPOINT2 ; store 1 in CHECKPOINT2
;;Sum all of the postive integers in the array
AND R4,R4,0 ; clear R4 (this is going to be SUM)
POSLOOP
AND R1,R1,R1 ; just to make sure we're looking at R1 (length/curr index)
BRn OUTOFLOOP ; if Length is now negative, breakout of loop
ADD R2,R0,R1 ; Index in array that you are currently on
ADD R1,R1,#-1 ; Decrement the length
LDR R3,R2,#0 ; Load current element into R3
BRn POSLOOP ; ignore the element if it is negative
ADD R4,R4,R3 ; Add current element to the SUM
BR POSLOOP

;;If (last element is negative)
NEGATIVE
AND R4,R4,#0 ; clear just to make sure
ADD R4,R4,#-1 ; make R4 = -1
ST R4,CHECKPOINT2
;;Sum all of the negative integers in the array
AND R4,R4,0 ; clear R4 (this is going to be SUM)
NEGLOOP
AND R1,R1,R1 ; just to make sure we're looking at R1 (length/curr index)
BRn OUTOFLOOP ; if length is negative, breakout of loop
ADD R2,R0,R1 ; Index in array that you are currently on
ADD R1,R1,#-1 ; Decrement the length
LDR R3,R2,#0 ; Load current element into R3
BRp NEGLOOP ; ignore the element if it is positive
ADD R4,R4,R3 ; Add current element to the SUM
BR NEGLOOP

ZERO
AND R4,R4,#0
ST R4,CHECKPOINT2
ST R4,CHECKPOINT3
BR END


OUTOFLOOP
ST R4,CHECKPOINT3

END
HALT

ARRAY   .fill x5000
LEN     .fill 6

CHECKPOINT1 .blkw 1
CHECKPOINT2 .blkw 1
CHECKPOINT3 .blkw 1
.end
