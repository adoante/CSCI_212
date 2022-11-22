.cpu cortex-a72
.fpu neon-fp-armv8
.data
mess1:	.asciz	"Input the number of times to roll the pair of dice: "
input1:	.asciz	"%d"
.text
.align 2
.global get_rolls
.type get_rolls, %function

get_rolls:
	push {fp, lr}
	add fp, sp, #4
	
	@printf("Input the number of times to roll the pair of dice: ");
	ldr r0, =mess1
	bl printf

	@scanf("%d", &rolls);
	sub sp, sp, #4
	ldr r0, =input1
	mov r1, sp
	bl scanf

	ldr r0, [sp]

	sub sp, fp, #4
	pop {fp, pc}

