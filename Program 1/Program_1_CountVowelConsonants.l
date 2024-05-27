
%{
    // This is a program that will take a string as input and returns the number of Vowels and consonants in the string.

    #include <stdio.h>
    int vowel = 0, consonants = 0;    
%}

%%
[aAeEiIoOuU] {printf("\n The parsed substring %s is vowel.",yytext);vowel++;}
[a-zA-Z] {printf("\n The parsed substring %s is consonant.",yytext);consonants++;}
%%

int yywrap()
{
    return 1;
}
int main()
{
    printf("\n Enter the string:  when done press Ctrl+D to view output\n");
    yylex();
    yywrap();
    printf("\n The number of vowels in the string is %d\n",vowel);
    printf("\n The number of consonants in the string is %d\n",consonants);
    return 0;
}