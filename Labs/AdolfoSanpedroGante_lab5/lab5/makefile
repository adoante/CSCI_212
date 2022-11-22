main: check_guess.o main.o getkeyword.o mod.o init_unknown.o print_array.o get_guess.o check_endgame.o flip_hangman.o collect_guessed.o
	gcc -o main check_guess.o main.o getkeyword.o mod.o init_unknown.o print_array.o get_guess.o check_endgame.o flip_hangman.o collect_guessed.o

main.o: main.s
	gcc -c -g main.s

getkeyword.o: getkeyword.s
	gcc -c -g getkeyword.s

mod.o: mod.s
	gcc -c -g mod.s

init_unknown.o: init_unknown.s
	gcc -c -g init_unknown.s

print_array.o: print_array.s
	gcc -c -g print_array.s

get_guess.o: get_guess.s
	gcc -c -g get_guess.s

check_guess.o: check_guess.s
	gcc -c -g check_guess.s

check_endgame.o: check_endgame.s
	gcc -c -g check_endgame.s

flip_hangman.o: flip_hangman.s
	gcc -c -g flip_hangman.s

collect_guessed.o: collect_guessed.s
	gcc -c -g collect_guessed.s

clean:
	rm *.o main

