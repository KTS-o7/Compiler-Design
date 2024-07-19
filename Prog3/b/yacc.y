%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror();
    int yylex();
%}

%token TYPE IDEN NUM
%left '+' '-'
%left '*' '/'

%%
// Tokens

// IDEN -> identifier
// NUM -> number
// TYPE -> datatype

// Non-terminals

// S -> Start symbol
// FUN -> function block
// PARAMS -> parameters
// PARAM -> parameter
// BODY -> Function body
// S1 -> Single Statement
// SS -> Set of statements
// T -> Term
// E -> Expression
// DECL -> Declaration
// ASSGN -> Assignment

S: FUN  { printf("Accepted\n"); exit(0); } ;
FUN: TYPE IDEN '(' PARAMS ')' BODY ;
BODY: S1';' | '{'SS'}'
PARAMS: PARAM','PARAMS | PARAM | ;
PARAM:  TYPE IDEN;
SS: S1';'SS | ;
S1: ASSGN | E | DECL ;
DECL: TYPE IDEN | TYPE ASSGN ;
ASSGN : IDEN '=' E ;
E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;
T : NUM | IDEN ;
%%
int main()
{
    printf("enter input: ");
    yyparse();
    printf("successfull\n");
    return 0;
}
int yyerror()
{
    printf("ERROR\n");
    exit(0);
}
