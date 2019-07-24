;;=============================================================
;;CS 2110 - Spring 2019
;;Homework 6 - Phone Number
;;=============================================================
;;Name: Christopher Messina
;;=============================================================

.orig x3000

	;;INSERT CODE AT THIS LOCATION
; Clear all registers
AND R0,R0,0 ; STRING pointer
AND R1,R1,0 ; i
AND R2,R2,0 ; TEMPLATE pointer
AND R3,R3,0 ; char in STRING
AND R4,R4,0 ; char in TEMPLATE
AND R5,R5,0
AND R6,R6,0

; This loads the starting index of STRING into R0
LD R0, STRING

; while (i < j)
WLOOP
ADD R3,R1,#-15 ; i = R1 and j= 15 so (i-j)>=<0
BRzp OUTOFLOOP

; if (i == 0 || i == 4 || i == 5
;                   || i == 9 || i == 14)
ADD R3,R1,#0
BRz SPECIAL0
ADD R3,R1,#-4
BRz SPECIAL4
ADD R3,R1,#-5
BRz SPECIAL5
ADD R3,R1,#-9
BRz SPECIAL9
ADD R3,R1,#-14
BRz SPECIAL14


;ELSE
ADD R3,R0,R1
LDR R3,R3,#0
LD R4,TODEC
ADD R3,R3,R4
BRn OUTOFLOOP
ADD R3,R3,#-9
BRp OUTOFLOOP
BR INCREMENT

; If i = 0 expect open parentheses
; If not, break out of loop
SPECIAL0
ADD R3,R0,R1
LDR R3,R3,#0
LD R4,OPENPAR
ADD R4,R3,R4
BRnp OUTOFLOOP
BR INCREMENT

SPECIAL4
ADD R3,R0,R1
LDR R3,R3,#0
LD R4,ClOSEPAR
ADD R4,R3,R4
BRnp OUTOFLOOP
BR INCREMENT

SPECIAL5
ADD R3,R0,R1
LDR R3,R3,#0
LD R4,SPACE
ADD R4,R3,R4
BRnp OUTOFLOOP
BR INCREMENT

SPECIAL9
ADD R3,R0,R1
LDR R3,R3,#0
LD R4,DASH
ADD R4,R3,R4
BRnp OUTOFLOOP
BR INCREMENT

SPECIAL14
ADD R3,R0,R1
LDR R3,R3,#0
BRnp OUTOFLOOP
BR INCREMENT

INCREMENT
ADD R1,R1,#1
BR WLOOP

OUTOFLOOP
ADD R1,R1,#-15
BRn ZERO

AND R5,R5,#0
ADD R5,R5,#1
ST R5,ANSWER
HALT


ZERO
AND R5,R5,#0
ST R5,ANSWER
HALT

TODEC .fill #-48
OPENPAR .fill #-40
ClOSEPAR .fill #-41
SPACE .fill #-32
DASH .fill #-45
;TEMPLATE .stringz "(704) 555-2110"
STRING .fill x4000
ANSWER .blkw 1
.end

.orig x4000
TEMPLATE .stringz "(704) 555-2110"
.end
