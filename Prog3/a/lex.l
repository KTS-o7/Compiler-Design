%{
	#include "y.tab.h"
%}
%%
"for" return FOR;
">"|"<"|">="|"<="|"=="|"!=" return OP;
[a-zA-Z]* return IDEN;
[0-9]+ return NUM;
[\n\t ]  ;
.   return yytext[0];
%%
