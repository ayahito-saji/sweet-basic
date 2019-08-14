CC = cc

build: ./bin ./bin/parser.o ./bin/lexer.o ./bin/ast.o ./bin/main.o ./bin/ir.o
	$(CC) -o ./bin/sbas ./bin/main.o ./bin/parser.o ./bin/lexer.o ./bin/ast.o ./bin/ir.o -lm

./bin:
	mkdir ./bin

./bin/main.o: ./src/main.c
	$(CC) -c -O0 -o ./bin/main.o ./src/main.c

./bin/parser.o: ./src/y.tab.c
	$(CC) -c -O0 -o ./bin/parser.o ./src/y.tab.c -g

./bin/lexer.o: ./src/lex.yy.c
	$(CC) -c -O0 -o ./bin/lexer.o ./src/lex.yy.c

./bin/ast.o: ./src/ast.c
	$(CC) -c -O0 -o ./bin/ast.o ./src/ast.c

./bin/ir.o: ./src/ir.c
	$(CC) -c -O0 -o ./bin/ir.o ./src/ir.c


./src/y.tab.c: ./src/parser.y
	yacc -o ./src/y.tab.c -d ./src/parser.y -r all

./src/lex.yy.c: ./src/lexer.l
	lex -t ./src/lexer.l > ./src/lex.yy.c

clean:
	rm -rf ./bin/*.o
	rm -rf ./src/lex.yy.c
	rm -rf ./src/y.tab.*
	rm -rf ./src/y.output

test: ./bin/sbas
	sh ./test/test.sh
