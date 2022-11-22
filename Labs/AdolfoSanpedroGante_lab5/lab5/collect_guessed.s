.cpu cortex-a72
.fpu neon-fp-armv8

.data
out:	.asciz "%c"

.text
.align 2
.global collect_guessed
.type collect_guessed, %function

collect_guessed:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = guessed char address
	@ r1 = array of guessed char

	push {r0}
	push {r1}

	mov r10, #0	@ counter

	ldr r0, [sp]
	bl strlen
	mov r3, r0	@ length of guesed char array

	collect_guessed_loop:
		cmp r10, r3
		bge end_guessed_loop
		
		@ load guessed char
		ldr r0, [sp, #4]
		ldrb r0, [r0]
		
		@ load guessed letters
		ldr r1, [sp]
		ldrb r1, [r1, r10]	

		mov r2, #'_
		if_guessed:
			cmp r1, r2
			bne else_guessed
			
			ldr r1, [sp]
			strb r0, [r1, r10]

			b end_guessed_loop

		else_guessed:
			add r10, r10, #1
			b collect_guessed_loop

	end_guessed_loop:
	sub sp, fp, #4
	pop {fp, pc}
