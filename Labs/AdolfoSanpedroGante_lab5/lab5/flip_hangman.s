.cpu cortex-a72
.fpu neon-fp-armv8

.data

char:	.asciz	"%c\n"

.text
.align 2
.global flip_hangman
.type flip_hangman, %function

flip_hangman:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = check_guess return -1 or 1
	@ r1 = hangman word address
	@ r2 = hangman unkown address

	push {r0} @ sp #8
	push {r1} @ sp #4
	push {r2} @ sp

	@ hangman will always be 7 length
	check_guess_if:
	ldr r0, [sp, #8]
	cmp r0, #1
	beq end_loop

	mov r10, #0	@ counter
	flip_loop:
		cmp r10, #7
		bge end_loop

		@ load hangman char
		ldr r0, [sp, #4]
		ldrb r0, [r0, r10]

		@ load hangman unknown char
		ldr r1, [sp]
		ldrb r1, [r1, r10]

		flip_if:
			cmp r0, r1
			beq flip_else
			
			ldr r1, [sp]

			strb r0, [r1, r10]

			b end_loop
	
		flip_else:
			add r10, r10, #1
			b flip_loop

	end_loop:

	sub sp, fp, #4
	pop {fp, pc}
