.cpu cortex-a72
.fpu neon-fp-armv8

.data
pchar2:   .asciz "%c\n"

.text

.align 2
.global check_guess
.type check_guess, %function


check_guess:
     push {fp, lr}
     add fp, sp, #4

     @ r0 = address of keyword
     @ r1 = address of unknown
     @ r2 = guess character

     push {r0}
     push {r1}
     push {r2}

     @ calculate length of keyword
     bl strlen  @ returns address 
     mov r8, r0

     mov r10, #0

     mov r9, #-1  @ use r9 to flag found/not found

     check_guess_loop:
          cmp r10, r8  @ r0 contains length of keyword
          bge done_check_guess

          ldr r2, [sp]  @ load the guess char into r2
          ldrb r2, [r2]
          ldr r3, [sp, #8]  @ gets array address of keyword
          ldrb r3, [r3, r10]  @ gets char at index r10

          @ldr r0, =pchar2
          @mov r1, r2
          @bl printf
          @b done_check_guess

          @ compare the keyword char vs. gues
          cmp r2, r3
          bne else
          
          mov r9, #1
          ldr r3, [sp, #4]  @ address of the known array
          strb r2, [r3, r10]  @ unknown[r10] = r2

          else:

          add r10, r10, #1

          b check_guess_loop


     done_check_guess:

     mov r0, r9  @ returns the found/not found flag

     sub sp, fp, #4
     pop {fp, pc}
