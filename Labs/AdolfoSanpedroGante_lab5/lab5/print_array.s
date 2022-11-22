.cpu cortex-a72
.fpu neon-fp-armv8

.data

pchar:       .asciz "%c"
pret1:      .asciz "\n"

.text

.align 2
.global print_array
.type print_array, %function


print_array:
     push {fp, lr}
     add fp, sp, #4

     @ r0 = array addres
     @ r1 = number of characters
     push {r0}   @ fp-8
     push {r1}   @ fp-12

     mov r10, #0
 
     print_array_loop:
         ldr r1, [fp, #-12]
         cmp r10, r1
         bge done_print_array

         @ load the character from array
         ldr r0, [fp, #-8]  @ address of the array
         add r2, r0, r10
         ldrb r1, [r2]

         ldr r0, =pchar

         bl printf

         add r10, r10, #1

         b print_array_loop

     done_print_array:

     @ print carriage return
     ldr r0, =pret1
     bl printf


     sub sp, fp, #4
     pop {fp, pc}
