%{
    #include <stdio.h>
    #include <stdlib.h>
    int total_if_count = 0;
    int current_nesting = 0;
    int max_nesting = 0;
    int yylex();
    int yyerror(const char *s);
%}

%token IF IDEN NUM OP

%%

STMTS: STMT
     | STMTS STMT
     ;

STMT: IFSTMT
    | IDEN '=' EXPR ';'
    | IDEN ';'
    | '{' STMTS '}'
    | ';'
    ;

IFSTMT: IF '(' COND ')' 
            {
                total_if_count++;
                current_nesting++;
                if (current_nesting > max_nesting) {
                    max_nesting = current_nesting;
                }
            }
            STMT
            {
                current_nesting--;
            }
            ;

COND: IDEN OP IDEN
         | IDEN OP NUM
         | IDEN
         | NUM
         ;

EXPR: IDEN
          | NUM
          | IDEN '+' IDEN
          | IDEN '-' IDEN
          ;

%%

int main() {
    printf("Enter the code snippet (Ctrl+D to end input on Unix, Ctrl+Z on Windows):\n");
    yyparse();
    printf("\nTotal IF STMTS: %d\n", total_if_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}