DEL gxx.exe, lex.yy.c, y.output, y.tab.h, y.tab.c
flex gxx.l
bison -dyv gxx.y
gcc lex.yy.c y.tab.c -o gxx.exe