# Compiler Design codes for the course 21CS63 conducted at RV College of Engineering, Bangalore.

- The following codes are written in C and are meant to be compiled with CC or GCC compilers.

## LABEXAM TO REPO MAPPING

| LAB Question                         | Repo Program path                                 |
| ------------------------------------ | ------------------------------------------------- |
| Words,lines,chars,Special Characters | [Link](../Prog1/Lex/lex.l)                        |
| a^m b^m+n c^n                        | [Link](../Prog1/Yacc/yacc.y)                      |
| Integers and Fractions               | [Link](../Prog2/Lex/lex.l)                        |
| Arithmetic Expression                | [Link](../Prog2/Yacc/yacc.y)                      |
| Remove comment lines                 | [Link](../Lab%20New%20Codes/commentRemover/lex.l) |
| Nested For loops                     | [Link](../Prog3/a/lex.l)                          |
| Number of identifiers and operators  | [Link](../Lab%20New%20Codes/keywordCount/lex.l)   |
| Nested IF statements                 | [Link](../Lab%20New%20Codes/nestedIf/lex.l)       |
| Variable Declaration                 | [Link](../Lab%20New%20Codes/declCount/lex.l)      |
| Three address code                   | [Link](../Prog4/lex.l)                            |
| Function definition                  | [Link](../Prog3/b/lex.l)                          |
| Assembly code generation             | [Link](../Prog5/lex.l)                            |

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
    int main(){};
    int foo(int a){}
    int bar(int a,int b){return a;}
    ```
4.  > Generate the intermediate 3 address code and quadruples for a given expression

    ```bash
    a=b+c*d
    a+b+c+d+e+f
    a=(b+d)*(c+e)
    ```

5.  > Generate the assembly code for a given set of arithmetic expressions

    ```bash
    ./outputfilename.out < input.txt
    ```

---

## LLVM Programs

### Program 1

This program is to print the unoptimised and optimised code for a bubble sort code

```bash
# to print the unoptimised assembly code
clang filename.c -S -emit-llvm -o filename

# to print the optimised assembly code
clang filename.c -S -emit-llvm -o filename -O3
```

### Program 2

This program is to print the unoptimised and optimised code for a binary search code

```bash
# to print the unoptimised assembly code
clang filename.c -S -emit-llvm -o filename

# to print the optimised assembly code
clang filename.c -S -emit-llvm -o filename -O3
```

### Program 3

this is about loop unrolling

```bash
# comment out the unroll pragma to see the difference
clang filename.c -S -emit-llvm -o filename

# for unrolled optimisation
clanf filename.c -S -emit-llvm -o filename -O3
```

# Change Log

## Version 1

- Added all 5 programs
- Had some conflicts in Shift/Reduce and Reduce/ Reduce

## Version 2

- @DeathStroke1991(https://github.com/DeathStroke19891) Fixed the issues in 3a and 3b
- Added comments on grammer.

## Version 3

- Added LLVM programs
- Added the new commands to run the programs

## Version 4

- Added Extra lab codes
- Added lab to repo mapping

---

# Contribution

This repo is open for contributions. Please open an Issue or open a PR with appropriate edits.
