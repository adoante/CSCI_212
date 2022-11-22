.cpu cortex-a72
.fpu neon-fp-armv8
.data
.text
.align 2
.global roll_die
.type roll_die, %function

roll_die:
	push {fp, lr}
	add fp, sp, #4

	bl rand
	mov r1, #6
	bl mod
	add r0, r0, #1

	sub sp, fp, #4
	pop {fp, pc}
