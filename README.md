# Compiler Design codes for the course 21CS63 conducted at RV College of Engineering, Bangalore.

- The following codes are written in C and are meant to be compiled with CC or GCC compilers.

## Pre-requisites

- Need to have the following installed :
  - GCC Compiler
  - Flex
  - Yacc

## How to run the code

### Running just the Lexical Analyser

```bash
 lex <filename>.l
 gcc lex.yy.c
 ./a.out
```

### Running the Lexical Analyser and Parser

```bash
 lex <filename>.l
 yacc -d <filename>.y
 gcc lex.yy.c y.tab.c -lfl
 ./a.out
```

---

Input format for each of the programs

1.  > a. Count the number of characters, words, lines and special characters in a given input file.
    ```bash
     any string with numbers and special characters
    ```
    > b Validate the strings of the type a^m b^m+n c^n where m,n>=0
    ```bash
      aabbcc
      abc
      ab
      bc
    ```
2.  > a. Count the number of positive and negetive integers and positive and negetive fractions

    ```bash
    > 1 -2 3/4 -5/6 7/-8 -9/-10 +11/12
    > // Just give a series fo space separated numbers
    ```

    > b. Evaluate a given arithmetic expression with + - \* / operators.

    ```bash
    1+2*3/4-5
    ```

3.  > a. Count the number of valid nested FOR loops
    ```bash
    for(a;b;c){}
    for(a;b;c){for(a;b;c){d;}}
    ```
    > b. Validate function defination
    ```bash
    int main(){}
    int foo(int a){}
    int bar(int a,int b){return a;}
    ```
4.  > Generate the intermediate 3 address code and quadruples for a given expression
    ```bash
    a=b+c*d
    a+b+c+d+e+f
    a=(b+d)*(c+e)
    ```
