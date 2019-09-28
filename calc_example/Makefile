all: calc clear

clear: clear_calc_tab clear_lex_trash clear_output
clear_calc_tab:
	rm -rf calc.tab.c calc.tab.h
clear_lex_trash:
	rm -rf lex.yy.c
clear_output:
	rm -rf calc.output

# START COMPILE
calc: 
	lex calc.l
	bison -dt calc.y
	cc -o calc -ly lex.yy.c calc.tab.c
