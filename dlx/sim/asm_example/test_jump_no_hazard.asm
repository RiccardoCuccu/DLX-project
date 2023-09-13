addi	r1, r0, #1		; r1 <= 1		; #0
addi	r2, r0, #10		; r2 <= 10		; #4
nop							; #8
nop							; #12
nop							; #16
nop							; #20
nop							; #24
slli	r1, r1, #1		; r1 <= 2		; #28
nop							; #32
nop							; #36
nop							; #40
nop							; #44

loop1:
subi	r2, r2, #1		; r2 <= 9, 8, 7, ...	; #48
bnez	r2, loop1					; #52

nop							; #54
nop							; #60
nop							; #64
nop							; #68
nop							; #72
bnez	r0, #4						; #76

nop							; #80
nop							; #84
nop							; #88
j	#120						; #92

nop							; #96
nop							; #100
nop							; #104
nop							; #108
nop							; #112
nop							; #116
addi	r4, r0, #148		; r4 <= 148		; #120
jr	r4						; #124

nop							; #128
nop							; #132
nop							; #136
nop							; #140
nop							; #144
jal	#184						; #148

nop							; #152
nop							; #156
nop							; #160
nop							; #164
nop							; #168
nop							; #172
nop							; #176
nop							; #180
jalr	r31						; #184

nop							; #188
