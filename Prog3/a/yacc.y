%{
	#include<stdio.h>
	#include<stdlib.h>
	int yylex();
	int yyerror();
	int cnt=0;
%}
%token FOR IDEN NUM TYPE OP
%left '+' '-'
%left '*' '/'
%%

S:I;
I:FOR'('D';'C';'S1')'B { cnt++; } |
  FOR'(' ';'C';'S1')'B { cnt++; } |
  FOR'('D';' ';'S1')'B { cnt++; } |
  FOR'(' ';' ';'S1')'B { cnt++; } ;

B: S1';' | '{'SS'}' | I ;
SS: S1 ';' SS | I SS |;
S1: A | E | D ;
D: TYPE IDEN | TYPE A;
A : IDEN '=' E ;
E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;
C : T OP T;
T : NUM | IDEN ;
%%
int main()
{
	printf("Enter the snippet:\n");
	yyparse();
	printf("Count of for : %d\n",cnt);
	return 0;
}
int yyerror()
{
	printf("Invalid\n");
	exit(0);
}
