%{
    #include <stdio.h>
    #include <stdlib.h>
    int total_for_count = 0;      // Total count of for loops
    int current_nesting = 0;      // Current level of nesting
    int max_nesting = 0;          // Maximum level of nesting encountered
    int yylex();
    int yyerror(const char *s);
%}

%token FOR IDEN NUM OP

%%

STMTS: STMT
     | STMTS STMT
     ;

STMT: FORSTMT                
    | IDEN '=' EXPR ';'      
    | IDEN ';'               
    | '{' STMTS '}'          
    | ';'                    
    ;


FORSTMT: FOR '(' ASSGN ';' COND ';' ASSGN ')' 
            {
                total_for_count++;             
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

ASSGN: IDEN '=' EXPR
    | IDEN 
    |
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
     | IDEN '*' IDEN
     | IDEN '/' IDEN
     ;

%%

int main() {
    printf("Enter the code snippet (Ctrl+D to end input on Unix, Ctrl+Z on Windows):\n");
    yyparse();
    printf("\nTotal FOR loops: %d\n", total_for_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}
