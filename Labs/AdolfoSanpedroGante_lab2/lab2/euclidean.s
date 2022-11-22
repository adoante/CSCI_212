@define computer architecture
.cpu cortex-a72
.fpu neon-fp-armv8

.data
input:	.asciz "%d"
mess1:	.asciz "Enter the first positive integer: "
mess2:	.asciz "Enter the second positive integer: "
mess3:	.asciz "The GCD is %d\n"

.text
.align 2
.global main
.type main, %function

main:
	@save the link reg (lr) into r4
	mov r4, lr

	@printf("Enter the first positive integer: ");
	ldr r0, =mess1		@r0 = "Enter the first positive integer
	bl printf

	@scanf("%d", &num1);
	sub sp, sp, #4		@sp = sp - 4
				@move stack pointer to next
				@free spot
	ldr r0, =input		@r0 = "%d"
	mov r1, sp		
	bl scanf
	ldr r5, [sp]		@saves first int into r5
	add sp, sp, #4		@resets sp

	@printf("Enter the second positive integer: ")
	ldr r0, =mess2		@ro = 'Enter the second positive integer
	bl printf
	
	@scanf("%d");
	sub sp, sp, #4
	ldr r0, =input
	mov r1, sp
	bl scanf
	ldr r6, [sp]		@saves second int into r6
	add sp, sp, #4

	@exchanges num1 and num2 if num1 < num2
	cmp r5, r6
	bge modulo
	mov r8, r5
	mov r5, r6
	mov r6, r8	

	@remainder (r7) = num1 (r5) % num2 (r6)
modulo:
	udiv r7, r5, r6
	mul r7, r7, r6
	sub r7, r5, r7

start_while:
	cmp r7, #0
	ble results
	mov r5, r6
	mov r6, r7
	
	udiv r7, r5, r6
	mul r7, r7, r6
	sub r7, r5, r7
	b start_while

	@printf("The GCD is %d\n", num2);
results:
	ldr r0, =mess3		@r0 = "The GCD is %d\n", num2);
	mov r1, r6
	bl printf

	@return 0 - need to put 0 in r0
	mov r0, #0

	@restore the lr from r4
	mov lr, r4
	
	@quits the main function
	bx lr
