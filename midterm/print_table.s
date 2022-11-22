.cpu cortex-a72
.fpu neon-fp-armv8
.data
mess:	.asciz "The frequency counts are:\n"
mess1:	.asciz	"Sum of dice	Number of Occurences\n"
mess2:	.asciz	"    %02d                %d           \n"
.text
.align 2
.global print_table
.type print_table, %function

print_table:
	push {fp, lr}
	add fp, sp, #4

	mov sp, r0
	
	ldr r0, =mess
	bl printf

	ldr r0, =mess1
	bl printf
	
	mov r9, #0
	mov r8, #2
	loop1:
		mov r10, #44
		cmp r9, r10
		bge end
		
		ldr r0, =mess2
		mov r1, r8
		ldr r2, [sp, r9]
		bl printf	

		add r8, r8, #1
		add r9, r9, #4
		b loop1
	end:
		sub sp, fp, #4
		pop {fp, pc}
