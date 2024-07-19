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
S: FUN  { printf("Accepted\n"); exit(0); } ;
FUN: TYPE IDEN '(' PARAM ')' BODY ;
BODY: ';'|'{'SS'}'
PARAM: TYPE IDEN PARAM1 | ;
PARAM1: ',' PARAM |;
SS: S1';'SS | ;
S1: A | E | D ;
D: TYPE IDEN | TYPE A ;
A : IDEN '=' E ;
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
