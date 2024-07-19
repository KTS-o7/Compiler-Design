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

// Tokens

// FOR -> for
// IDEN -> identifier
// NUM -> number
// TYPE -> datatype
// OP -> relational operator

// Non-terminals

// S -> Start symbol
// B -> Body  of For loop
// C -> Condition
// S1 -> Single Statement
// SS -> Set of statements
// T -> Term
// E -> Expression
// F -> For loop block
// DA -> Declaration or assignment
// D -> Declaration
// A -> Assignment

S:F;
F:FOR'('DA';'C';'S1')'B { cnt++; } |
  FOR'(' ';'C';'S1')'B { cnt++; } |
  FOR'('DA';' ';'S1')'B { cnt++; } |
  FOR'(' ';' ';'S1')'B { cnt++; } ;

DA:D|A
D: TYPE IDEN | TYPE A;
A : IDEN '=' E;
C : T OP T;
T : NUM | IDEN ;

B: S1';' | '{'SS'}' | F |';';

SS: S1 ';' SS | F SS |;
S1: A | E | D ;
E : E '+' E | E '-' E | E '*' E | E '/' E | '-''-'E | '+''+'E | E'+''+' | E'-''-' | T ;
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
