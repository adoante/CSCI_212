.cpu cortex-a72
.fpu neon-fp-armv8

.data

.text
.align 2
.global check_endgame
.type check_endgame, %function

check_endgame:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = address of keyword
	@ r1 = address of unknown

	push {r0}
	push {r1}

	@ find keyword size
	ldr r0, [sp, #4]
	bl strlen	@ r0 = strlen
	push {r0}

	mov r5, #0	@ counter

	mov r6, #1	@ flag

	@int flag = 1
	@for (int i = 0; i < keywordSize; i++) {
	@	if (keyword[i] != unknown[i]) {
	@		flag = -1;
	@		break;
	@	}
	@}
	@return flag;

	endgame_loop:
		ldr r0, [sp]
		cmp r5, r0
		bge end_loop

		ldr r0, [sp, #8]
		ldrb r0, [r0, r5]

		ldr r1, [sp, #4]
		ldrb r1, [r1, r5]
		
		loop_if:
			cmp r0, r1
			beq loop_else

			mov r6, #-1
			b end_loop

		loop_else:
			add r5, r5, #1
			b endgame_loop

	end_loop:

	mov r0, r6
	sub sp, fp, #4
	pop {fp, pc}
