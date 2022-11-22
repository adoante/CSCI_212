.cpu cortex-a72
.fpu neon-fp-armv8

.data

.text
.align 2
.global mod
.type mod, %function

mod:
	push {fp,lr}
	add fp, sp, #4
	
	@ a --> r0
	@ b --> r1

	udiv r2, r0, r1	@ c = a / b
	mul r2, r2, r1	@ c = a * b
	sub r2, r0,r2	@ c = a - c
		
	@ return value from function --> r0
	mov r0, r2

	sub sp, fp, #4
	pop {fp, pc}
