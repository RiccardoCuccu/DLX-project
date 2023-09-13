addi	r1, r0, #2		; r1 <= 2
subi	r2, r1, #1		; r2 <= 1
addi	r3, r1, #-4		; r3 <= -2
subi	r4, r3, #-7		; r4 <= 5
add	r5, r1, r2		; r5 <= 3
sub	r6, r5, r2		; r6 <= 2
add	r7, r1, r3		; r7 <= 0
sub	r8, r5, r4		; r8 <= -2
addui	r11, r0, #2		; r11 <= 2
subui	r12, r1, #1		; r12 <= 1
addui	r13, r1, #-4		; r13 <= 65534
subui	r14, r3, #-7		; r14 <= -65531 = 4294901765
addu	r15, r1, r2		; r15 <= 3
subu	r16, r5, r2		; r16 <= 2
addu	r17, r1, r3		; r17 <= 0 = 4294967296 (overflow)
subu	r18, r5, r4		; r18 <= -2 = 4294967294 (underflow)
nop
