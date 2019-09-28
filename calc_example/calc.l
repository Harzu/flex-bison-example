%{
  #include "calc.tab.h"
%}

%option yylineno
%option noyywrap

numbers  ([0-9])+

%%
[/][/].*\n  ; // Comment
{numbers}   {
              yylval = atoi(yytext);
              return NUMBER;
            }
[ \t\r\n]   ; // Whitespace
.           { return *yytext; }

%%
