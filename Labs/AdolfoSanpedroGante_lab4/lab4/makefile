main: main.o mod.o fill_array.o print_array.o init_piles.o create_new_pile.o swap_zero_with_last.o sort.o sum_array.o end_game.o
	gcc -o main main.o mod.o fill_array.o print_array.o init_piles.o create_new_pile.o swap_zero_with_last.s sort.s sum_array.s end_game.s

main.o: main.s
	gcc -c main.s

mod.o: mod.s
	gcc -c mod.s

fill_array.o: fill_array.s
	gcc -c fill_array.s

print_array.o: print_array.s
	gcc -c print_array.s

init_piles.o: init_piles.s
	gcc -c init_piles.s

create_new_pile.o: create_new_pile.s
	gcc -c create_new_pile.s

swap_zero_with_last.o: swap_zero_with_last.s
	gcc -c swap_zero_with_last.s

sort.o: sort.s
	gcc -c sort.s

sum_array.o: sum_array.s
	gcc -c sum_array.s

end_game.o: end_game.s
	gcc -c end_game.s

clean:
	rm *.o main
