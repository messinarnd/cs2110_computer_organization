;;=============================================================
;;CS 2110 - Spring 2019
;;Homework 7 - Recursive Reverse Linked List
;;=============================================================
;;Name: Christopher Messina
;;=============================================================

.orig x3000
    ;; Below is a main function that will:
    ;;      - Print the linked list before reversing
    ;;      - Reverse the linked list
    ;;      - Print the reversed linked list
    ;; You shouldn't need to change this main function.

    LDI R1, LL          ; Load first node to R1
    JSR print_ll

    LD R6, STACK        ; Initialize stack pointer
    ADD R6, R6, -1      ; Make room on stack for argument
    STR R1, R6, 0       ; Place first node on stack as argument
    JSR reverse

    LDR R1, R6, 0       ; Load result of reverse
    JSR print_ll
    halt


reverse
;;=============================================================
;;Arguments of reverse: Node head (the address of the current node - head to begin)


;reverse_ll(Node head) {
;    if (head == null || head.next == null) {
;        return head
;    }
;    new_head = reverse_ll(head.next)
;    head.next.next = head
;    head.next = null
;    return new_head
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
    LDR R1,R5,#4 ; Load the address of the curr node into R1
    ; R1 is 24576
    ;LDR R0,R1,#1
    ; Data at R1+1 is 5 so R3
    ; mem[24577] is 5 not 7
    ; mem[24576] is 24624
    BRz RETHEAD ; if curr node == null: return curr node

    LDR R2,R1,#0 ; Load the address of the next node into R2
    ;R2 is 24624
    LDR R3,R1,#1 ; Load the data of the curr node into R3
    ; R3 is 5

    AND R2,R2,R2 ; Checking R2
    BRz RETHEAD ; if address of next node == null: return curr node

        ;;RECURSIVE CALL
        ADD R6,R6,#-1 ; push Node next (address of next node)
        STR R2,R6,#0
        JSR reverse ; Call reverse subroutine
        ;Now we're back from reverse and have our RV on the stack at R6
        LDR R4,R6,#0 ; Load RV into R4: R4 = reverse(curr.next) = new_head
        ADD R6,R6,#2 ; pop RET VAL, next node address

    ;What should happen on first iteration:
    ;R4 = new_head = 24832
    ;R1 = head = 24656
    ;R2 = head.next = 24832
    ;R0 = head.next.next = null
    ;Then:
    ;head.next.next = head / this changes the direction of the arrow => mem[R2] = R1
    ;head.next = null / this points it to nothing (breaking link) => mem[R1] = 0
    STR R1,R2,#0 ; head.next.next = head
    AND R0,R0,#0 ; Clear i.e. null
    STR R0,R1,#0 ; head.next = null (R1,#0 should be 24832 on first iteration)
    BR RETNEWHEAD

    RETHEAD
        STR R1,R5,#3
        BR TEARDOWN

    RETNEWHEAD
        STR R4,R5,#3
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

;;=============================================================


; A subroutine that will print a linked list
; given the first node is in R1
print_ll
    ST R0, Save0        ; Save R0
    ST R1, Save1        ; Save R1
    ST R7, Save7        ; Save R7
    LD R0, QUOTES       ; print('"')
    OUT
loop
    LDR R0, R1, 1       ; R0 = curr.val
    OUT                 ; print(curr.val)
    LDR R1, R1, 0       ; R1 = curr.next
    BRz print_done      ; curr.next == null -> done
    BRnzp loop          ;
print_done
    LD R0, QUOTES       ; print('"')
    OUT
    LD R0, NEWLINE      ; print('\n')
    OUT
    LD R0, Save0        ; Restore R0
    LD R1, Save1        ; Restore R1
    LD R7, Save7        ; Restore R7
    RET
Save0       .blkw 1
Save1       .blkw 1
Save7       .blkw 1
QUOTES      .fill '"'
NEWLINE     .fill '\n'

LL .fill x6000
STACK .fill xF000
.end

.orig x4000
.fill x4002         ; x4000
.fill 'a'           ; x4001
.fill x4004         ; x4002
.fill 'b'           ; x4003
.fill x4006         ; x4004
.fill 'c'           ; x4005
.fill x4008         ; x4006
.fill 'd'           ; x4007
.fill x400A         ; x4008
.fill 'e'           ; x4009
.fill x0000         ; x400A
.fill 'f'           ; x400B
.end


.orig x6000
.fill x4000
.fill 6
.end
