%{
#include "y.tab.h"
%}

%%
"int"      { return INT; }
"float"    { return FLOAT; }
"char"     { return CHAR; }
"double"   { return DOUBLE; }
";"        { return SEMICOLON; }
","        { return COMMA; }
"["        { return LBRACKET; }
"]"        { return RBRACKET; }
[0-9]+     { yylval = atoi(yytext); return INT; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[ \t\n]    { /* ignore whitespace */ }
.          { return yytext[0]; }
%%

int yywrap() {
    return 1;
}