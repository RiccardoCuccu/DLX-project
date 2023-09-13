addi	r1, r0, #100		; r1 <= 100
xor	r2, r2, r2		; r2 <= 0

ciclo:
lw	r3, 0(r2)		; r3 <= m0, m4, m8, ...
nop 
addi	r3, r3, #10		; r3 <= 10, 10, 10, ...
sw	100(r2), r3		; m100 <= 10, m104 <= 10, m108 <= 10, ...
subi	r1, r1, #1		; r1 <= 99, 98, 97, ...
addi	r2, r2, #4		; r2 <= 4, 8, 12, ...
bnez	r1, ciclo		; jump back 99 times

nop
nop
nop
addi	r4, r0, #65535		; r4 <= -1
ori	r5, r4, #100000		; r5 <= -1
add	r6, r4, r5		; r6 <= -2

end:
j	end
