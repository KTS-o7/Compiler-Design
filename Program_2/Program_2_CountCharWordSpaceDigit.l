%{
    // This code is to parse a given input string and output the number of digits, white spaces, lines, words and characters in the input string.

    #include <stdio.h>
    int num_lines = 0;
    int num_words = 0;
    int num_chars = 0;
    int num_digits = 0;
    int num_spaces = 0;
    int num_tabs = 0;
%}

%%
[0-9] { num_digits++; num_chars++; }
\t { num_tabs++; num_chars++; }
\n {  num_chars++; num_lines++; }
[a-zA-Z]+ { num_words++; num_chars += yyleng; }
[ ] { num_spaces++; num_chars++; }
. { num_chars++; }
%%

int yywrap(){
    return 1;
}

int main(){
    printf("Enter the input string:  - after entering the string press Ctrl+D\n");
    yylex();
    yywrap();
    printf("\n");
    printf("Number of digits: %d\n", num_digits);
    printf("Number of white spaces: %d\n", num_spaces);
    printf("Number of lines: %d\n", num_lines);
    printf("Number of words: %d\n", num_words);
    printf("Number of characters: %d\n", num_chars);
    printf("Number of tabs: %d\n", num_tabs);
    return 0;
}
