.cpu cortex-a72
.fpu neon-fp-armv8
.data
mess:	.asciz "The sum: %d\n"
mess1:	.asciz "Value at %d: %d\n"
.text
.align 2
.global main
.type main, %function

main:
	push {fp, lr}
	add fp, sp, #4
	
	@allocating 11 stack address for 2 - 12
	mov r0, #0	@ staring value is 0 occurences 
	@move sp by 4bits and save value on stack
	push {r0}	@ [sp, #40]
	push {r0}	@ [sp, #36]
	push {r0}	@ [sp, #32]
	push {r0}	@ [sp, #28]
	push {r0}	@ [sp, #24]
	push {r0}	@ [sp, #20]
	push {r0}	@ [sp, #16]
	push {r0}	@ [sp, #12]
	push {r0}	@ [sp, #8]
	push {r0}	@ [sp, #4]
	push {r0}	@ [sp, #0]
	mov r4, sp	@ save ending stack address
	
	@seeding rand	
	mov r0, #0
	bl time
	bl srand
	
	@gets number of rolls
	bl get_rolls
	mov r5, r0	@ r5 = num_rolls

	@counter r10
	mov r10, #0
loop1:	
	cmp r10, r5
	bge end1
	@rolls dice and sums
	bl roll_die	@ r0 = first die value
	mov r6, r0	@ r6 = first die value
	bl roll_die	@ r0 = second die value
	add r6, r6, r0	@ r6 = first + second die value
			@ r6 = diceSum	
	
	@ determines what sp to update
	mov r7, #2	@counter
	loop2:
		mov r8, #13
		cmp r7, r8
		bge update_loop2
		if:
			cmp r6, r7 @ r6 == r7
			bne update_loop2
			mov r8, #12
			sub r6, r8, r6
			mov r8, #4
			mul r6, r8, r6
			add r0, r4, r6
			bl update_count
			b end2			
	update_loop2:
		add r7, r7, #1
		b loop2

end2:	
	add r10, r10, #1	
	bl loop1	

end1:
	mov r0, r4
	bl print_table

	sub sp, fp, #4
	pop {fp, pc}
