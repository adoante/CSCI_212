.cpu cortex-a72
.fpu neon-fp-armv8

.data


.text

.align 2
.global init_unknown
.type init_unknown, %function


init_unknown:
     push {fp, lr}
     add fp, sp, #4
     @ r0 = address of unknown
     @ r1 = number of characters

     mov r10, #0

     unknown_loop:
         cmp r10, r1
         bge done_unknown_loop

         @ store character '-' into r3
         mov r3, #'_
         @ calculate byte offset
         add r2, r0, r10
 
         @ store the character into unknown array
         strb r3, [r2]


         add r10, r10, #1

         b unknown_loop

     done_unknown_loop:

     sub sp, fp, #4
     pop {fp, pc}
