@adolfo sanpedro gante
.cpu cortex-a72
.fpu neon-fp-armv8

.data
mess:	.asciz	"Iteration: %d\n"
.text
.align 2
.global main
.type main, %function

main:
	push {fp, lr}
	add fp, sp, #4

	@ randomize seed value
	mov r0, #0
	bl time
	bl srand

	@ used to save the starting address of both arrays
	sub sp, sp, #12	@ 1st arr = fp - 8
					@ 2nd arr = fp - 12
					@ number of piles = fp - 16
	@ init arrays with 45 elements
	@ 1st cards array
	sub sp, sp, #180	@ 4 * 45 = 180
	str sp, [fp, #-8]

	@ set each elem in cards arr == to 1
	mov r0, sp
	mov r1, #180
	mov r2, #1
	bl fill_array
	
	@ init arrays with 46 elements
	@ 2nd piles array
	sub sp, sp, #180 @ 4 * 46 = 184
	str sp, [fp, #-12]

	@ set each elem in piles arr == to 0
	mov r0, sp
	mov r1, #180
	mov r2, #0
	bl fill_array

	@ get rand num for initial num of piles 1 - 45
	@ [fp, #-16] or number of piles is used a lot
	bl rand	@ r0 = random number
	mov r1, #45
	bl mod	@ r0 = random number from 0 - 44
	str r0, [fp, #-16]

	@ add cards randomly to each pile for initial game start
	mov r0, #45
	ldr r1, [fp, #-16]
	@adolfo sanpedro gante
	ldr r2, [fp, #-12]
	ldr r3, [fp, #-8]
	bl init_piles

mov r4, #0
main_loop:
	@ prints num of iterations
	ldr r0, =mess
	mov r1, r4
	bl printf

	mov r0, #1
	mov r1, #1
	cmp r0, r1
	bne end_main_loop

	mov r0, #46
	ldr r1, [fp, #-12]
	ldr r2, [fp, #-16]
	bl create_new_pile
	
	@ increments number of piles
	ldr r0, [fp, #-16]
	add r0, r0, #1
	str r0, [fp, #-16]

	@ swaps pile with zero value with the last pile
	ldr r0, [fp, #-16]
	ldr r1, [fp, #-12]
	bl swap_zero_with_last

	@ set num of piles
	@ r0 = new num of piles
	str r0, [fp, #-16]

	ldr r0, [fp, #-12]
	ldr r1, [fp, #-16]
	bl sort

	@ print piles array
	ldr r0, [fp, #-12]
	ldr r1, [fp, #-16]
	bl print_array

	@ check exit condition
	ldr r0, [fp, #-16]	@ num of piles
	ldr r1, [fp, #-12]	@ piles array address
	bl end_game	@ returns r0
	
	end_game_if:
		mov r1, #9
		cmp r1, r0
		bne main_loop_increment
		b end_main_loop
		add r4, r4, #1

	main_loop_increment:
		add r4, r4, #1
		b main_loop

end_main_loop:
	sub sp, fp, #4
	pop {fp, pc}
