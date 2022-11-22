midtermS: main.o get_rolls.o roll_die.o update_count.o print_table.o mod.o
		gcc -o midtermS main.o get_rolls.o roll_die.o update_count.o print_table.o mod.o

main.o:	main.s
	gcc -c -g main.s

get_rolls.o:	get_rolls.s
		gcc -c -g get_rolls.s

roll_die.o:	roll_die.s
		gcc -c -g roll_die.s

update_count.o:	update_count.s
		gcc -c -g update_count.s

print_table.o:	print_table.s
		gcc -c -g print_table.s

mod.o:	mod.s
	gcc -c -g mod.s

clean:
	rm *.o


