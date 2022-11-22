.cpu cortex-a72
.fpu neon-fp-armv8

.data

.text
.align 2
.global fill_array
.type fill_array, %function

fill_array:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = start of array (address)
	@ r1 = number of elem in array
	@ r2 = number to fill array with
	push {r0}
	push {r1}
	push {r2}
	
	@ loop to fill array
	mov r10, #0				@ r10 = counter
	fill_array_loop:
		ldr r1, [sp, #4]
		cmp r10, r1
		bge end_fill_array_loop
		
		@ array[r10] = 0
		ldr r0, [sp, #8]
		ldr r2, [sp]
		str r2, [r0, r10]

		add r10, r10, #4	@increment loop
		b fill_array_loop

	end_fill_array_loop:
		
	sub sp, fp, #4
	pop {fp, pc}
