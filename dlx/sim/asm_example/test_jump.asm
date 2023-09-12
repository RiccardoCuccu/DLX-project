addi r1,r0,#1		; r1 <= 1
addi r2,r0,#5		; r2 <= 5
loop1:
subi r2,r2,#1		; r2 <= 4, 3, 2, 1, 0	; #8
nop
addi r1,r1,#1		; r1 <= 2, 3, 4, 5, 6
bnez r2,loop1
nop
nop
nop
subi r2,r2,#1		; r2 <= -1
nop
nop
nop
nop
nop
nop
nop
nop
beqz r0,loop2
nop
nop
nop
nop
nop
nop
nop
nop
loop2:
addi r2,r0,#5		; r2 <= 5		; #108
j loop3
nop
nop
nop
nop
nop
nop
nop
nop
loop3:
addi r4,r0,#192		; r4 <= 184		; #148
jr r4
nop
nop
nop
nop
nop
nop
nop
nop
nop
subi r2,r2,#1		; r2 <= 4		; #192
jal loop4
nop						; #200
nop
nop
nop
nop
nop
nop
nop
nop
loop4:
subi r2,r2,#2		; r2 <= 3		; #236
jalr r31
nop						; #244
