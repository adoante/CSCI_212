.cpu cortex-a72
.fpu neon-fp-armv8

.data
.text
.align 2
.global swap_zero_with_last
.type swap_zero_with_last, %function

swap_zero_with_last:
	push {fp, lr}
	sub fp, sp, #4
	
	@ r0 = number of piles
	@ r1 = piles array
	mov r0, r0, LSL #2
	push {r0}
	push {r1}

	mov r6, #0	@ counter
	swap_zero_with_last_loop:
		ldr r0, [sp, #4]	@ r0 = num of piles
		cmp r6, r0
		bge end_swap_zero_with_last_loop
		
		swap_zero_with_last_if:
			ldr r0, [sp]		@ r0 = piles array
			ldr r1, [r0, r6]	@ r1 = piles[r6]
			mov r3, #0
			cmp r1, r3
			bne swap_zero_with_last_loop_increment

			ldr r3, [sp, #4]
			sub r3, r3, #4

			ldr r1, [r0, r6]
			ldr r2, [r0, r3]

			str r1, [r0, r3]
			str r2, [r0, r6]
			
			ldr r2, [sp, #4]
			sub r2, r2, #4		@ r2 = num of piles - 4
			str r2, [sp, #4]	@ num of piles = r2

			swap_zero_with_last_loop_increment:
				add r6, r6, #4
				b swap_zero_with_last_loop

	end_swap_zero_with_last_loop:

	ldr r0, [sp, #4]
	mov r0, r0, LSR #2
	
	add sp, fp, #4
	pop {fp, pc}
