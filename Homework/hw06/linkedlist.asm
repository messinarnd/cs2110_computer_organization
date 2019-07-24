;;=============================================================
;;CS 2110 - Spring 2019
;;Homework 6 - Linked List
;;=============================================================
;;Name: Christopher Messina
;;=============================================================

.orig x3000

; Clear all registers
AND R0,R0,#0 ; LL.length
AND R1,R1,#0 ; head/curr
AND R2,R2,#0 ; Data Two's Complement
AND R3,R3,#0
AND R4,R4,#0

;length = LL.length
LD R0,LL ; Load memory address of LL (R0 = x6000)
LDR R0,R0,#1 ; Load data in memory address of LL+1 (R0 = mem[x6000 + 1])

; Get two's comp of Data
LD R2,DATA
NOT R2,R2
ADD R2,R2,#1

;curr = LL.head //HINT: What can an LDI instruction be used for?
LDI R1,LL ; mem[mem[x6000]] -> R1 (mem[x4000]) so R1=x4008 on first go

;while (curr != null) {
WLOOP
AND R1,R1,R1 ; Just making sure it's checking R1
BRz OUTOFLOOP ; If nothing in R1, break out of loop


;    if (curr.value == data) {
LDR R3,R1,#1 ; Load mem[R1 + 1] into R2 (for first run mem[x4008 + 1] (5) -> R2)
ADD R3,R3,R2
BRnp NOTEQUAL


;        curr.value = length;
STR R0,R1,#1 ; Store Length (R0) -> mem[R1 + 1] (first run mem[x4008 + 1])
; Are there going to be more instances of DATA (do I need to continue the loop?)


NOTEQUAL
;} else {
;        curr = curr.next
;    }
; Reload R1 with next memory address and loop back to top of loop
LDR R1,R1,#0
BR WLOOP


OUTOFLOOP
HALT


DATA .fill 10
LL .fill x6000
.end

.orig x4000
.fill x4008
.fill 5
.fill x400A
.fill 2
.fill x4002
.fill 9
.fill x0000
.fill 3
.fill x4004
.fill 10
.fill x4006
.fill 7
.end

.orig x6000
.fill x4000
.fill 6
.end
