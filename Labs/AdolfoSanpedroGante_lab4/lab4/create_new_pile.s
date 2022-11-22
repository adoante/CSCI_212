.cpu cortex-a72
.fpu neon-fp-armv8

.data
mess:	.asciz "R3: %d\n"
.text
.align 2
.global create_new_pile
.type create_new_pile, %function

create_new_pile:
	push {fp, lr}
	sub fp, sp, #4

	@ r0 = 45
	@ r1 = piles array address
	@ r2 = number of piles
	mov r0, r0, LSL #2
	push {r0}
	push {r1}
	mov r2, r2, LSL #2
	push {r2}

	mov r7, #0	@ counter
	create_new_pile_loop:
		ldr r0, [sp, #8]
		cmp r7, r0
		bge end_create_new_pile_loop

		create_new_pile_if:
			mov r0, #0	@ r0 = 0
			ldr r1, [sp, #4]	@ r1 = piles arr address
			ldr r2, [r1, r7]	@ r2 = piles[r7]
			cmp r2, r0			@ piles[r7] > 0
			ble create_new_pile_loop_increment

			@ piles[r7] = piles[r7] - 1
			sub r2, r2, #1	@ r2 = r2 - 1 
			str r2, [r1, r7]	@ piles[r7] = r2

			@ piles[num of piles + 4] = piles[num of piles + 4] + 1
			ldr r2, [sp]		@ r2 = num of piles
			@add r2, r2, #4		@ r2 = num of pile + 4
			ldr r3, [r1, r2]	@ r3 = piles[r2]
			add r3, r3, #1		@ r3 = piles[r2] + 1
			str r3, [r1, r2]	@ piles[r2] = piles[r3]

			create_new_pile_loop_increment:
				add r7, r7, #4
				b create_new_pile_loop

	end_create_new_pile_loop:
	add sp, fp, #4
	pop {fp, pc}
