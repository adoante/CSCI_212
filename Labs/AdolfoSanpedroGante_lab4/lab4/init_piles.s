.cpu cortex-a72
.fpu neon-fp-armv8

.data

.text
.align 2
.global init_piles
.type init_piles, %function

init_piles:
	push {fp, lr}
	sub fp, sp, #4

	@ r0 = 45
	@ r1 = number of piles
	@ r2 = piles address
	@ r3 = cards address
	mov r0, r0, LSL #2
	push {r0}
	push {r1}
	push {r2}
	push {r3}

	@loop
	mov r8, #0	@ counter
	init_piles_loop:
		ldr r0, [sp, #12]
		cmp r8, r0
		bge end_init_piles_loop
		
		bl rand	@ r0 = random number
		ldr r1, [sp, #8]	@num of piles
		bl mod	@ r0 = 0 - num of piles
		mov r0, r0, LSL #2

		ldr r2, [sp, #4]	@ load piles array
		ldr r1, [r2, r0]	@ r1 = piles[r0]
		
		ldr r2, [sp]		@ load cards array
		ldr r3, [r2, r8]	@ r3 = cards[r8]
	
		@ load r1 + r3 into piles[r0]
		add r2, r1, r3	@ r2 = r1 + r3
		ldr r1, [sp, #4]	@ load piles array
		str r2, [r1, r0]	@ piles[r0] = r2
		
		@ sub 1 from cards[1] to b/c that "card" is gone
		ldr r2, [sp]
		mov r3, #0
		str r3, [r2, r8]		@ cards[r8] = 0

		@ increment loop counter
		add r8, r8, #4

		b init_piles_loop

	end_init_piles_loop:
	add sp, fp, #4
	pop {fp, pc}
