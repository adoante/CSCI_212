.cpu cortex-a72
.fpu neon-fp-armv8

.data
mess:	.asciz	"R3 End of loop: %d\n"
mess1:	.asciz	"R3 Inside If: %d\n"
mess2:	.asciz	"R3 Inside Else: %d\n"
.text
.align 2
.global end_game
.type end_game, %function

end_game:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = num of piles
	@ r1 = piles arr address
	@ r3 = will be returned

	push {r0}	@ sp, #12
	push {r1}	@ sp, #8

	mov r3, #0
	push {r3}	@ sp, #4

	mov r2, #0
	push {r2}	@ sp

	mov r5, #1	@ counter
	end_game_loop:
		ldr r0, [sp, #12]
		add r0, r0, #2
		cmp r5, r0
		bge end_end_game_loop

		end_game_if:
			ldr r0, [sp, #8]
			sub r1, r5, #1
			mov r1, r1, LSL #2
			ldr r0, [r0, r1]
			cmp r0, r5
			bne end_game_loop_increment

			ldr r2, [sp, #4]
			add r2, r2, #1
			str r2, [sp, #4]

	end_game_loop_increment:
		add r5, r5, #1
		b end_game_loop

	end_end_game_loop:

	ldr r0, [sp, #4]

	sub sp, fp, #4
	pop {fp, pc}
