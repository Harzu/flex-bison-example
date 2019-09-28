%{
  #include <stdio.h>

  void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
  }

  #define YYPRINT(file, type, value) fprintf(file, "%d", value);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

program
: expr { printf("%d\n", $$); }
;

expr
: NUMBER
| expr '+' expr { $$ = $1 + $3; }
| expr '-' expr { $$ = $1 - $3; }
| expr '*' NUMBER { $$ = $1 * $3; }
| expr '/' NUMBER { $$ = $1 / $3; }
;

%%

int main() {
  yydebug = 0;
  yyparse();
  return 0;
}