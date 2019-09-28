all: tl clear

clear: clear_tl_tab clear_lex_trash clear_output
clear_tl_tab:
	rm -rf tl.tab.c tl.tab.h
clear_lex_trash:
	rm -rf lex.yy.c
clear_output:
	rm -rf tl.output

# START COMPILE
tl: 
	lex tl.l
	bison -dt tl.y
	c++ -o tl -ly lex.yy.c tl.tab.c
