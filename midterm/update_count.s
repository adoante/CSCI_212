.cpu cortex-a72
.fpu neon-fp-armv8
.data
.text
.align 2
.global update_count
.type update_count, %function

update_count:
	push {fp, lr}
	add fp, sp, #4

	@ r0 = stack address
	mov sp, r0

	ldr r9, [sp]
	add r9, r9, #1
	str r9, [sp]	
end:
	sub sp, fp, #4
	pop {fp, pc}
