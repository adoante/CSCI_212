@adolfo sanpedro gante
.cpu cortex-a72
.fpu neon-fp-armv8

.data
out1:	.asciz	"----------\n"
out2:	.asciz	"Pile %d: %d\n"
out3:	.asciz	"[%d] = %d\n"

.text
.align 2
.global print_array
.type print_array, %function

print_array:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = array start (address)
	@ push array start to stack
	push {r0}	@ address = sp - 4

	@ r1 = number of piles (45 for right now)
	@ push number of elem onto stack
	mov r1 ,r1 , LSL #2
	push {r1}	@ address = sp

	ldr r0, =out1
	bl printf

	mov r9, #0	@r9 = counter
	print_array_loop:
		ldr r1, [sp]
		cmp r9, r1
		bge end_print_array_loop
	
		ldr r0, =out3
		mov r1, r9
		mov r1, r1, LSR #2
		add r1, r1, #1
		ldr r3, [sp, #4]
		ldr r2, [r3, r9]
		bl printf
		
		add r9, r9, #4
		b print_array_loop

	end_print_array_loop:

	ldr r0, =out1
	bl printf
	sub sp, fp, #4
	pop {fp, pc}
