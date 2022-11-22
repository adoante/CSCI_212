.cpu cortex-a72
.fpu neon-fp-armv8
.data
.text
.align 2
.global checkPrimeNumber
.type checkPrimeNumber, %function

checkPrimeNumber:
	push {fp, lr}
	add fp, sp, #4
	
	mov r9, #1		@ flag
	@r0 contains "int n"
	mov r10, r0
	mov r4, #2		@ n / 2
	udiv r4, r10, r4	
	mov r5, #2		@ counter
loop:
	cmp r5, r4
	bgt end
	
	if:
		mov r0, r10
		mov r1, r5
		bl mod
		mov r1, #0
		cmp r0, r1
		bne update_loop
		mov r9, #0
		b end
		
update_loop:
	add r5, r5, #1
	b loop
end:
	mov r0, r9
	sub sp, fp, #4
	pop {fp, pc}
