.cpu cortex-a72
.fpu neon-fp-armv8

.data

pchar1:       .asciz " %c"
message:      .asciz "Enter a guess: "

.text

.align 2
.global get_guess
.type get_guess, %function


get_guess:
     push {fp, lr}
     add fp, sp, #4

     @ r0 = address on stack to write to
     push {r0}
     
     @ print out prompt
     ldr r0, =message
     bl printf

     @ scanf("%c", address)
     ldr r0, =pchar1
     pop {r1}
     bl scanf

     sub sp, fp, #4
     pop {fp, pc}
