%{
    #include <stdio.h>
    int posint = 0, negint = 0, posfloat = 0, negfloat = 0, posfrac = 0, negfrac = 0;
%}

%%
"-"[0-9]+"/"[0-9]+|[0-9]+"/""-"[0-9]+ {printf("%s is negetive fraction",yytext);negfrac++;}
"+"?[0-9]+"/""+"?[0-9]+|"-"[0-9]+"/""-"[0-9]+ {printf("%s is positive fraction",yytext);posfrac++;}
"-"[0-9]+"."?[0-9]+|"-"[0-9]+"."|"-""."[0-9]+ {printf("%s is negetive float",yytext);negfloat++;}
"+"?[0-9]+"."?[0-9]+|"+"?[0-9]+"."|"+"?"."[0-9]+ {printf("%s is positive float",yytext);posfloat++;}
"-"[0-9]+ {printf("%s is negetive integer",yytext);negint++;}
"+"?[0-9]+ {printf("%s is positive integer",yytext);posint++;}
%%
int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the number: ");
    printf("\nPress Ctrl+D to exit\n");
    yylex();
    yywrap();
    printf("\nNumber type \t\t Count\n");
    printf("--------------------------\n");
    printf("Positive Integer \t %d\n", posint);
    printf("Negative Integer \t %d\n", negint);
    printf("Positive Float \t\t %d\n", posfloat);
    printf("Negative Float \t\t %d\n", negfloat);
    printf("Positive Fraction \t %d\n", posfrac);
    printf("Negative Fraction \t %d\n", negfrac);
    return 0;
}