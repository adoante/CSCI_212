@adolfo sg
.cpu cortex-a72
.fpu neon-fp-armv8

.data

filename:  .asciz "data.txt"
inp:       .asciz "r"
outp:      .asciz "%s\n"
outp1:     .asciz "%d\n"
outp2:	   .asciz "Guessed Letters: "
outp3:	   .asciz "\n"
hangman:   .asciz "hangman"
lives:	   .asciz "Attempts: "
Lose:	   .asciz "Dang bruh you lost smh.\n"
Win:	   .asciz "Lets go. Easy dub.\n"
word:	   .asciz "Word: "
rules:	   .asciz "A random word will be picked,\nyou will have 7 attempts to\nguess the word untill the word\nhangman is spelled out.\nRepeated guesses will be\ncounted as a guess. Good Luck!\n\n"


.text

.align 2
.global main
.type main, %function


main:
     push {fp, lr}
     add fp, sp, #4

     @ Allocate memory for keyword
     mov r0, #80
     bl malloc
     push {r0}  @ fp - 8

     @ open file for reading
     @ fopen("data.txt", "r);
     ldr r0, =filename
     ldr r1, =inp
     bl fopen
     push {r0}  @ fp - 12

     @ getkeyword(address of file, address of keyword)
     ldr r0, [fp, #-12]
     ldr r1, [fp, #-8]
     bl getkeyword

     @ close the open file
     ldr r0, [fp, #-12]  @ gets the address inside stack location
     bl fclose  @ fclose(fp);

     @ Allocate memory for unknown
     ldr r0, [fp, #-8]
     bl strlen  @ get length of keyword
     bl malloc
     push {r0} @ fp - 16

	 @ allocate memory for hangman
	 mov r0, #7
	 bl malloc
	 push {r0} @ fp - 20

	 @ store hangman
	 ldr r0, =hangman
	 str r0, [fp, #-20]

	 @ Allocate memory for number of lives
	 ldr r0, [fp, #-20]
	 bl strlen
	 bl malloc
	 push {r0} @ fp - 24

	 @ allocate memory for number of guessed letters
	 mov r0, #80		@ assuming it wont take more than 80 guesses
	 bl malloc
	 push {r0} @ fp - 28

	 @ allocate memory for counter
	 mov r0, #1
	 bl malloc
	 push {r0} @ fp - 32

     @ Initialize guessed letters to '_'
     mov r1, #7
     ldr r0, [fp, #-28]
     bl init_unknown

	 @ inti hangman unknown to '_'
	 ldr r0, [fp, #-20]
	 bl strlen
	 mov r1, r0
	 ldr r0, [fp, #-24]
	 bl init_unknown

     @ Initialize unknown to '_'
     ldr r0, [fp, #-8]
     bl strlen
     mov r1, r0
     ldr r0, [fp, #-16]
     bl init_unknown

     @ print out word
     ldr r0, =outp
     ldr r1, [fp, #-8]   @ keyword address
     bl printf

     @ play hangman, need to loop until game is over

	@ counter = 1
	ldr r0, [fp, #-32]
	mov r1, #1
	str r1, [r0]

	ldr r0, =rules
	bl printf

play_hangman_loop:
	 
     @ print out unknown
	 ldr r0, =word
	 bl printf
     ldr r0, [fp, #-8]
     bl strlen
     mov r1, r0
     ldr r0, [fp, #-16]  @ address of unknown array
     bl print_array

     @ Get user guess
     @ get_guess(address to write to)
     @ Use the stack to get the guess
     sub sp, sp, #4
     mov r0, sp
     bl get_guess

	 ldr r0, =outp3
	 bl printf

	 @ prints letters guessed
	 ldr r0, =outp2
	 bl printf
     mov r0, sp
	 ldr r1, [fp, #-28]
     bl collect_guessed
	 ldr r0, [fp, #-28]
	 @ r1 = number of iterations = number of guesses
	 ldr r1, [fp, #-32]
	 ldr r1, [r1]
     bl print_array

     @ Check the guess
     @ check guess returns -1 if the guess is not in the keyword
     @ else flips the unknown characters matching guess
     @ index = check_guess(keyword, unknown, guess)
     ldr r0, [fp, #-8]
     ldr r1, [fp, #-16]
     mov r2, sp
     bl check_guess  @ return integer into r0

	 ldr r1, [fp, #-20]	@ address of hangman
	 ldr r2, [fp, #-24] @ address of hangman unknown
	 bl flip_hangman

     @ print out hangman unknown
	 ldr r0, =lives
	 bl printf
     ldr r0, [fp, #-20]
     bl strlen
     mov r1, r0
     ldr r0, [fp, #-24] @ address of unknown array
     bl print_array

	 @ checks for end_game WIN
	 ldr r0, [fp, #-8]	@ address of keyword
	 ldr r1, [fp, #-16]	@ address of unknown
	 bl check_endgame

	 @ if win end loop else check for lose
	 if_endgame_win:
		cmp r0, #1
		bne if_endgame_lose
			
     @ print out unknown
	 ldr r0, =word
	 bl printf
     ldr r0, [fp, #-8]
     bl strlen
     mov r1, r0
     ldr r0, [fp, #-16]  @ address of unknown array
     bl print_array

		ldr r0, =Win
		bl printf

		b end_hangman_loop

		
	 @ checks for end_game LOSE
	 @ if lose end loop else loop back
	 if_endgame_lose:
		ldr r0, [fp, #-20]	@ address of keyword
		ldr r1, [fp, #-24]	@ address of unknown
		bl check_endgame

		cmp r0, #1
		bne increment_hangman_loop

     @ print out unknown
	 ldr r0, =word
	 bl printf
     ldr r0, [fp, #-8]
     bl strlen
     mov r1, r0
     ldr r0, [fp, #-16]  @ address of unknown array
     bl print_array

		ldr r0, =Lose
		bl printf

		b end_hangman_loop

increment_hangman_loop:
	ldr r0, [fp, #-32]
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]

	b play_hangman_loop

end_hangman_loop:

     @ free memory
     ldr r0, [fp, #-8]
     bl free

     ldr r0, [fp, #-16]
     bl free

	 ldr r0, [fp, #-24]
	 bl free

     sub sp, fp, #4
     pop {fp, pc}

