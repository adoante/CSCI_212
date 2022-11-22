.cpu cortex-a72
.fpu neon-fp-armv8

.data

.text
.align 2
.global sum_array
.type sum_array, %function

sum_array:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = array start (address)
	@ push array start to stack
	push {r0}	@ address = sp - 4

	@ r1 = number of piles (45 for right now)
	@ push number of elem onto stack
	mov r1 ,r1 , LSL #2
	push {r1}	@ address = sp

	mov r9, #0	@r9 = counter
	sum_array_loop:
		ldr r1, [sp]
		cmp r9, r1
		bge end_sum_array_loop
	
		ldr r0, [sp, #4]
		ldr r0, [r0, r9]
		add r3, r3, r0

		add r9, r9, #4
		b sum_array_loop

	end_sum_array_loop:
	mov r0, r3
	sub sp, fp, #4
	pop {fp, pc}
