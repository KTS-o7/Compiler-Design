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

// List of statements
STMTS: STMT
     | STMTS STMT
     ;

// Possible statements
STMT: FORSTMT                // For loop
    | IDEN '=' EXPR ';'      // Assignment
    | IDEN ';'               // Identifier followed by semicolon
    | '{' STMTS '}'          // Block of statements
    | ';'                    // Empty statement
    ;

// For loop structure
FORSTMT: FOR '(' ASSGN ';' COND ';' ASSGN ')' 
            {
                total_for_count++;              // Increment for loop count
                current_nesting++;              // Increase nesting level
                if (current_nesting > max_nesting) {
                    max_nesting = current_nesting;  // Track maximum nesting level
                }
            }
            STMT
            {
                current_nesting--;              // Decrease nesting level after loop ends
            }
            ;

// Assignment inside for loop (initialization or update)
ASSGN: IDEN '=' EXPR
    | IDEN 
    |
      ;

// Condition inside for loop
COND: IDEN OP IDEN
     | IDEN OP NUM
     | IDEN
     | NUM
     ;


// Expressions (simple arithmetic or identifier/number)
EXPR: IDEN
     | NUM
     | IDEN '+' IDEN
     | IDEN '-' IDEN
     | IDEN '*' IDEN
     | IDEN '/' IDEN
     ;

%%

// Main function to handle user input and parse
int main() {
    printf("Enter the code snippet (Ctrl+D to end input on Unix, Ctrl+Z on Windows):\n");
    yyparse();
    printf("\nTotal FOR loops: %d\n", total_for_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

// Error handling
int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}
