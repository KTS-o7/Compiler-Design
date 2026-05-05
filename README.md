# Compiler Design Lab Programs

[![Course](https://img.shields.io/badge/course-21CS63-blue)](#)
[![Language](https://img.shields.io/badge/language-C%20%7C%20Lex%20%7C%20Yacc-green)](#)
[![License: MIT](https://img.shields.io/badge/license-MIT-yellow.svg)](LICENSE)

Compiler Design lab solutions for the 21CS63 course at RV College of
Engineering, Bangalore. The repository is organized as a study and reference
collection for lexical analysis, syntax analysis, intermediate code generation,
target code generation, and LLVM optimization exercises.

## Table of Contents

- [Project Scope](#project-scope)
- [Repository Layout](#repository-layout)
- [Lab Exam Mapping](#lab-exam-mapping)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Usage Examples](#usage-examples)
- [LLVM Programs](#llvm-programs)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [License](#license)

## Project Scope

This project contains small, focused programs that demonstrate common compiler
construction tasks:

- Lex/Flex scanners for counting tokens, removing comments, and classifying
  input.
- Lex + Yacc parser pairs for grammar validation and expression evaluation.
- Intermediate representation examples such as three-address code and
  quadruples.
- Target-code style output for arithmetic expressions.
- LLVM IR generation examples with optimized and unoptimized output.

The code is intentionally educational. Each folder maps to a lab exercise rather
than a single production application.

## Repository Layout

```text
.
|-- Prog1/              # Word/line counting and a^m b^(m+n) c^n grammar
|-- Prog2/              # Number classification and arithmetic expressions
|-- Prog3/              # Nested for loops and function definition grammar
|-- Prog4/              # Three-address code and quadruple generation
|-- Prog5/              # Target code generation for arithmetic expressions
|-- Lab New Codes/      # Additional lab exam practice programs
|-- Practice/           # Extra practice scanners
|-- LLVM_Prog/          # LLVM optimization examples
|-- docs/               # Secondary documentation copy
|-- Makefile            # Generic build helper
`-- LICENSE             # MIT license
```

## Lab Exam Mapping

| Lab question | Repo program path |
| --- | --- |
| Words, lines, characters, and special characters | [Prog1/Lex/lex.l](Prog1/Lex/lex.l) |
| Validate strings of the form `a^m b^(m+n) c^n` | [Prog1/Yacc/yacc.y](Prog1/Yacc/yacc.y) |
| Count positive/negative integers and fractions | [Prog2/Lex/lex.l](Prog2/Lex/lex.l) |
| Evaluate arithmetic expressions | [Prog2/Yacc/yacc.y](Prog2/Yacc/yacc.y) |
| Remove comment lines | [Lab New Codes/commentRemover/lex.l](Lab%20New%20Codes/commentRemover/lex.l) |
| Count nested `for` loops | [Prog3/a/lex.l](Prog3/a/lex.l) |
| Count identifiers and operators | [Lab New Codes/keywordCount/lex.l](Lab%20New%20Codes/keywordCount/lex.l) |
| Validate nested `if` statements | [Lab New Codes/nestedIf/lex.l](Lab%20New%20Codes/nestedIf/lex.l) |
| Validate variable declarations | [Lab New Codes/declCount/lex.l](Lab%20New%20Codes/declCount/lex.l) |
| Generate three-address code | [Prog4/lex.l](Prog4/lex.l) |
| Validate function definitions | [Prog3/b/lex.l](Prog3/b/lex.l) |
| Generate assembly-style target code | [Prog5/lex.l](Prog5/lex.l) |

## Prerequisites

Install these tools before running the examples:

| Tool | Tested version | Notes |
| --- | --- | --- |
| C compiler | GCC 13+ or Clang 17+ | `gcc` is used in the examples. Clang also works for most programs. |
| Flex | 2.6.x | Provides the `lex`/`flex` scanner generator. |
| Yacc/Bison | Berkeley Yacc or GNU Bison 3.x | Some macOS installations require full Xcode or Homebrew Bison. |
| LLVM/Clang | 17+ | Needed only for `LLVM_Prog/`. |

Run `make versions` to print the compiler and generator versions available on
your machine.

## Quick Start

Use the root `Makefile` for repeatable builds.

### Build and run a Lex-only program

```bash
make lex LEX_SRC=Prog1/Lex/lex.l
./build/lex_runner
```

### Build and run a Lex + Yacc program

```bash
make yacc YACC_SRC=Prog2/Yacc/yacc.y YACC_LEX_SRC=Prog2/Yacc/lex.l
./build/parser_runner
```

If your platform uses a different lexical library, override `LEX_LIB`:

```bash
make yacc YACC=byacc LEX_LIB=-ll YACC_SRC=Prog2/Yacc/yacc.y YACC_LEX_SRC=Prog2/Yacc/lex.l
```

The included `Makefile` defaults to `-ll` on macOS and `-lfl` elsewhere.

### Manual commands

Lex-only:

```bash
lex path/to/lex.l
gcc lex.yy.c -lfl -o scanner
./scanner
```

Lex + Yacc:

```bash
yacc -d path/to/yacc.y
lex path/to/lex.l
gcc lex.yy.c y.tab.c -lfl -o parser
./parser
```

## Usage Examples

### Program 1a: Count lines, words, characters, and spaces

```bash
make lex LEX_SRC=Prog1/Lex/lex.l
./build/lex_runner
```

Sample input:

```text
hello compiler design
#
```

Expected output:

```text
Enter the string:
Lines: 1
Words: 3
Chars: 19
Spaces: 2
```

### Program 1b: Validate `a^m b^(m+n) c^n`

```bash
make yacc YACC_SRC=Prog1/Yacc/yacc.y YACC_LEX_SRC=Prog1/Yacc/lex.l
./build/parser_runner
```

Sample inputs:

```text
aabbcc
abc
ab
bc
```

Expected result: valid strings are accepted by the grammar, while strings that
break the required `a`, `b`, and `c` ordering are rejected.

### Program 2a: Classify integers and fractions

```bash
make lex LEX_SRC=Prog2/Lex/lex.l
./build/lex_runner
```

Sample input:

```text
1 -2 3/4 -5/6 7/-8 -9/-10 +11/12
```

Expected result: the scanner prints counts for positive integers, negative
integers, positive fractions, and negative fractions.

### Program 2b: Evaluate arithmetic expressions

```bash
make yacc YACC_SRC=Prog2/Yacc/yacc.y YACC_LEX_SRC=Prog2/Yacc/lex.l
./build/parser_runner
```

Sample input:

```text
1+2*3/4-5
```

Expected output:

```text
Enter operation:
Result is -3
Valid
```

### Program 3a: Count nested `for` loops

```bash
make yacc YACC_SRC=Prog3/a/yacc.y YACC_LEX_SRC=Prog3/a/lex.l
./build/parser_runner
```

Sample input:

```text
for(i=0;i<10;i++){for(j=0;j<10;j++){}}
```

Expected result: the parser accepts valid nested-loop syntax and reports the
loop count.

### Program 3b: Validate function definitions

```bash
make yacc YACC_SRC=Prog3/b/yacc.y YACC_LEX_SRC=Prog3/b/lex.l
./build/parser_runner
```

Sample inputs:

```text
int main(){}
int foo(int a){}
int bar(int a,int b){return a;}
```

Expected result: syntactically valid function definitions are accepted.

### Program 4: Generate three-address code and quadruples

```bash
make yacc YACC_SRC=Prog4/yacc.y YACC_LEX_SRC=Prog4/lex.l
./build/parser_runner
```

Sample input:

```text
a=b+c*d
```

Expected output:

```text
Three address code:
@A = c * d
@B = b + @A

Quadruples:
0:      @A      c       d       *
1:      @B      b       @A      +
```

### Program 5: Generate assembly-style target code

```bash
make yacc YACC_SRC=Prog5/yacc.y YACC_LEX_SRC=Prog5/lex.l
./build/parser_runner < Prog5/input.txt
```

Sample input:

```text
a=b+c
```

Expected output:

```text
Target code:
LOAD     R1, b
LOAD     R2, c
ADD      R3, R1, R2
STORE    a, R3
```

## LLVM Programs

The `LLVM_Prog/` folder contains C programs and generated LLVM IR examples.
Use Clang to generate unoptimized and optimized LLVM output.

### Bubble sort

```bash
clang LLVM_Prog/Prog1/bubbleSort.c -S -emit-llvm -o LLVM_Prog/Prog1/bubbleSort_unoptimized.ll
clang LLVM_Prog/Prog1/bubbleSort.c -S -emit-llvm -O3 -o LLVM_Prog/Prog1/bubbleSort_optimized.ll
```

### Binary search

```bash
clang LLVM_Prog/Prog2/binSrch.c -S -emit-llvm -o LLVM_Prog/Prog2/binSrch_unoptimized.ll
clang LLVM_Prog/Prog2/binSrch.c -S -emit-llvm -O3 -o LLVM_Prog/Prog2/binSrch_optimized.ll
```

### Loop unrolling

```bash
clang LLVM_Prog/Prog3/loop.c -S -emit-llvm -o LLVM_Prog/Prog3/loop_unoptimized.ll
clang LLVM_Prog/Prog3/loop.c -S -emit-llvm -O3 -o LLVM_Prog/Prog3/loop_optimized.ll
```

Comment or uncomment the unroll pragma in [LLVM_Prog/Prog3/loop.c](LLVM_Prog/Prog3/loop.c)
to compare the generated IR.

## Contributing

Contributions are welcome for fixes, additional examples, and clearer lab notes.
Please keep each pull request focused on one program or documentation topic.

Before opening a pull request:

- Build the affected Lex/Yacc program.
- Add or update sample input and expected output when behavior changes.
- Keep generated files out of version control unless they are intentionally used
  as LLVM comparison artifacts.

## Changelog

### Version 4

- Added extra lab codes.
- Added lab-to-repo mapping.

### Version 3

- Added LLVM programs.
- Added commands to generate LLVM IR.

### Version 2

- Fixed issues in Programs 3a and 3b.
- Added grammar comments.

### Version 1

- Added the first five lab programs.
- Recorded known shift/reduce and reduce/reduce conflicts.

## License

This repository is licensed under the [MIT License](LICENSE).
