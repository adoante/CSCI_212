.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global sort
.type sort, %function

sort:
    push {fp, lr}
    add fp, sp, #4
    @ r0 = array
    @ r1 = number of elements

    push {r0}
    push {r1}

    mov r10, #0  @ i counter

    sort_outer_loop:
       ldr r2, [sp]
       sub r2, r2, #1
       cmp r10, r2
       bge end_sort_outer_loop

       @ get array[i]
       mov r2, r10, LSL #2
       ldr r3, [sp, #4]   @ array
       ldr r3, [r3, r2]   @ r3 = array[i]

       @ r9 = j
       add r9, r10, #1

       sort_inner_loop:
           ldr r2, [sp]
           cmp r9, r2
           bge end_sort_inner_loop

           @ get array[j]
           mov r2, r9, LSL #2
           ldr r0, [sp, #4]
           ldr r0, [r0, r2]   @ r0 = array[j]

           @ if a[i] > a[j]
           cmp r3, r0
           ble else

           @ swap array[i] and array[j]
           ldr r1, [sp, #4]  @ array
           mov r2, r10, LSL #2  @ byte offset to array[i]
           str r0, [r1, r2]
           mov r2, r9, LSL #2
           str r3, [r1, r2]

           mov r3, r0

           else:

           add r9, r9, #1

           b sort_inner_loop

        end_sort_inner_loop:

        add r10, r10, #1

        b sort_outer_loop

     end_sort_outer_loop:


   sub sp, fp, #4
   pop {fp, pc}

