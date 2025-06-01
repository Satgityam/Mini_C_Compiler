all: compiler

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l parser.tab.h
	flex lexer.l

compiler: parser.tab.c lex.yy.c symbol_table.o codegen.o
	gcc -o compiler parser.tab.c lex.yy.c symbol_table.o codegen.o -ll

symbol_table.o: symbol_table.c symbol_table.h
	gcc -c symbol_table.c

codegen.o: codegen.c codegen.h
	gcc -c codegen.c

clean:
	rm -f *.o lex.yy.c parser.tab.* compiler
