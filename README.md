# CPP Makefile Template

## GCC/Clang Compiler Steps

### Compilation steps

1. Preprocessing
2. Compilation
3. Assembler
4. Linking

**Preprocessing**

-   Removes comments from the source code
-   Macro expansion
-   Expansion of header files
-   Command: g++ -E main.cc > main.i

**Compilation**

-   Translates the preprocessing file into assembly language.
-   Checks the C/C++ language syntax for error
-   Command: g++ -S main.i
-   Produces: main.s

**Assembler**

-   Translates the assembly code into low-level machine code
-   Command: g++ -c main.s
-   Produces: main.o

**Linker**

-   Linking all the source files together, that is all the other object codes in the project.
-   Generates the executable file
-   Command: g++ main.o -o main
-   Produces: main.out (.exe for Windows)

### Compiler Flags

Debug: `-g`
Release: `-O0 -O1 -O2 -O3 -Og`
Includes: `-I`
Warnings: `-Wall -Wextra -Wpedantic -Wconversion`
