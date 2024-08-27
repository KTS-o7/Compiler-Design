%{
#include <stdio.h>
#include <stdlib.h>
int yylex();

int var_count = 0;

void yyerror(const char *s);
%}

%token INT FLOAT CHAR DOUBLE
%token ID
%token SEMICOLON COMMA LBRACKET RBRACKET

%%
declaration: type var_list SEMICOLON { printf("Number of variables declared: %d\n", var_count); var_count = 0; }
           ;

type: INT { printf("Type: int\n"); }
    | FLOAT { printf("Type: float\n"); }
    | CHAR { printf("Type: char\n"); }
    | DOUBLE { printf("Type: double\n"); }
    ;

var_list: var { var_count++; }
        | var_list COMMA var { var_count++; }
        ;

var: ID
   | ID LBRACKET INT RBRACKET
   ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter a declaration statement:\n");
    yyparse();
    return 0;
}