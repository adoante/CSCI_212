.cpu cortex-a72
.fpu neon-fp-armv8

.data

inp1:   .asciz  "%s"
inp2:   .asciz  "%d"

.text
.align 2
.global getkeyword
.type getkeyword, %function


getkeyword:
     push {fp, lr}
     add fp, sp, #4

     @ r0 = address of file
     @ r1 = address of keyword

     push {r0}  @ fp - 8
     push {r1}  @ fp - 12

     @ reset random seed
     mov r0, #0
     bl time
     bl srand

     @ fscanf(fp, "%d", address of number)
     @ Get the number in the file as the first line
     ldr r0, [fp, #-8]   
     ldr r1, =inp2
     sub sp, sp, #4
     mov r2, sp
     bl fscanf

     @ Generate a random number between 1 and r0
     bl rand  @ returns large number into r0
     ldr r1, [sp]
     bl mod   @ mod(largenumber, number of words)
     add r0, r0, #1   @ map to number between 1 and number of words
     mov r9, r0

     @ Read from file up to r9
     mov r10, #0

     getkeyword_loop:
         cmp r10, r9
         beq end_getkeyword_loop

         @ read next word
         ldr r0, [fp, #-8]
         ldr r1, =inp1
         ldr r2, [fp, #-12]

         bl fscanf

         add r10, r10, #1

         b getkeyword_loop


     end_getkeyword_loop:

     sub sp, fp, #4
     pop {fp, pc}

