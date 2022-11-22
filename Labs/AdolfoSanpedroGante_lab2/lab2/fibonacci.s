@define computer architecture
.cpu cortex-a72
.fpu neon-fp-armv8

.data
input:		.asciz "%d"
output1:	.asciz "Enter Fibonacci term: "
output2:	.asciz "The %dth Fibonacci number is %d\n.",
output3:	.asciz "Not part of our Fibonacci squence!\n"
output4:	.asciz "The %dst Fibonacci number is 1.\n"
output5:	.asciz "The %dnd Fibonacci number is 1.\n"

.text
.align 2
.global main
.type main. %function

main:
	@save the link reg (lr) into r4
	mov r4, lr

	@init variables
	mov r6, #3
	mov r7, #1
	mov r8, #1
	add r9, r7, r8
	
	@printf("Enter Fibonacci term: ");
	ldr r0, =output1	@r0 = "Enter Fibonacci term: "
	bl printf

	@scanf("%d", &terms);
	sub sp, sp, #4		@sp = sp - 4
				@move stack pointer to next free spot
	ldr r0, =input		@r0 = "%d"
	mov r1, sp		@r1 = sp which is an address
	bl scanf		@gets input and puts into sp

	@if(terms <= 0){printf("Not part of our Fibonacci squence!\n")}
	@return 0 and exit program
	ldr r5, [sp]		@r5 = sp
	add sp, sp, #4		@resets sp
	cmp r5, #0		@r5 <= 0
	bgt next_if1
	ldr r0, =output3	@r0 = "Not part of out Fibonacci squence!\n"
	bl printf
	b end_program
	
	@if(terms == 1){printf("The %dst Fibonacci number is 1.\n", terms);
	@returns 0 and exit program
next_if1:
	cmp r5, #1		@r5 == 1
	bne next_if2
	ldr r0, =output4	@r0 = "The %dst Fibonacci number is 1.\n"
	mov r1, r5
	bl printf
	b end_program
	
	@if(terms == 2){printf("The %dnd Fibonacci number is 1.\n", terms);
	@returns 0 and exits
next_if2:
	cmp r5, #2		@r5 == 2
	bne for_loop
	ldr r0, =output5	@r0 = "The %dnd Fibonacci number is 1.\n"
	mov r1, r5
	bl printf
	b end_program

	@for (int i == 3; i < terms; ++i) {
	@firstTerm = secondTerm;
	@secondTerm = nthTerm;
	@nthTerm = secondTerm + firstTerm; }
for_loop:
	cmp r6, r5		@i < terms
	bge final_printf
	mov r7, r8		@firstTerm = secondTerm
	mov r8, r9		@secondTerm = nthTerm
	add r9, r7, r8		@nthTerm = firstTerm + secondTerm
	add r6, r6, #1		@++i
	b for_loop		@loop back
	
	@printf("The %dth Fibonacci number is %d\n.", terms, nthTerm);
	@return 0 and end program	
final_printf:
	ldr r0, =output2	@r0 = "The %dth Fibonacci number is %d\n."
	mov r1, r5
	mov r2, r9
	bl printf
	b end_program

end_program:

	@return 0 - need to put 0 in r0
	mov r0, #0
	
	@restore the LR from r4
	mov lr, r4	@lr = r4

	@quit the main function
	bx lr
	
