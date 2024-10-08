%{
#include "y.tab.h"
%}

%%
"if"        { return IF; }
">"|"<"|">="|"<="|"=="|"!=" return OP;
[a-zA-Z][a-zA-Z0-9]* { return IDEN; }
[0-9]+      { return NUM; }
[ \t\n]+    ; 
.           { return yytext[0]; }
%%

int yywrap() {
    return 1;
}