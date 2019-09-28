%{
    #include <iostream>
    #include "ASTNodes.hh"
    
    extern int yylineno;
    extern int yylex();
    void yyerror(char *s) {
      std::cerr << s << ", line " << yylineno << std::endl;
      exit(1);
    }
    #define YYSTYPE std::string
%}

%token IF ELSE WHILE EXIT
%token EQ NOEQ GEQ LEQ
%token STRING NUM ID

%left '+' '-'
%left '*' '/'

%%
program
: ops
;

ops
: op
| ops op
;

op
: expr
| op_with_else
| op_without_else
| EXIT
;

op_with_else
: '{' ops '}'
| IF '(' expr ')' op_with_else ELSE op_with_else
| WHILE '(' expr ')' op_with_else
;

op_without_else
: IF '(' expr ')' op
| IF '(' expr ')' op_with_else ELSE op_without_else
| WHILE '(' expr ')' op_without_else 
;

expr
: ID '=' expr
| binaryExpr
| boolExpr
;

binaryExpr
: values
| binaryExpr '+' binaryExpr
| binaryExpr '-' binaryExpr
| binaryExpr '*' binaryExpr
| binaryExpr '/' binaryExpr
;

boolExpr
: values
| boolExpr EQ boolExpr
| boolExpr LEQ boolExpr
| boolExpr GEQ boolExpr
| boolExpr NOEQ boolExpr
| boolExpr '>' boolExpr
| boolExpr '<' boolExpr
;

values
: NUM
| '-' values
| '!' values
| '(' expr ')'
| ID
| ID '(' args ')'
;

args
: arg
| args ',' arg
;

arg
: expr
| STRING
;
%%

int main() {
  return yyparse();
}