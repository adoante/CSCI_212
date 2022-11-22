.cpu cortex-a72
.fpu neon-fp-armv8
.data
msg1:	.asciz "Enter two positive integers: "
msg2:	.asciz "Prime numbers between %d and %d are: "
msg3:	.asciz "%d "
inpu:	.asciz "%d %d"
msg4:	.asciz "\n"
.text
.align 2
.global main
.type main, %function

main:
	push {fp, lr}
	add fp, sp, #4

	ldr r0, =msg1
	bl printf

	ldr r0, =inpu
	sub r1, sp, #4
	mov r1, sp
	sub sp, sp, #4
	mov r2, sp
	bl scanf
	ldr r8, [sp]
	add sp, sp, #4
	ldr r7, [sp]
	add sp, sp, #4

	ldr r0, =msg2
	mov r1, r7
	mov r2, r8
	bl printf

	add r7, r7, #1
loop:
	cmp r7, r8
	bge end
	mov r0, r7
	bl checkPrimeNumber
if:
	mov r6, #1
	cmp r0, r6
	bne update_loop
	ldr r0, =msg3
	mov r1, r7
	bl printf

update_loop:
	add r7, r7, #1
	b loop	

end:
	ldr r0, =msg4
	bl printf
	sub sp, fp, #4
	pop {fp, pc}
