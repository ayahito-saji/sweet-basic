build: ./bin ./bin/main.o ./bin/parser.o ./bin/lexer.o
	cc -o ./bin/sbas ./bin/main.o
	cc -o ./bin/parser ./bin/parser.o ./bin/lexer.o

./bin:
	mkdir ./bin

./bin/main.o: ./src/main.c
	cc -c -O0 -o ./bin/main.o ./src/main.c

./bin/parser.o: ./src/y.tab.c
	cc -c -O0 -o ./bin/parser.o ./src/y.tab.c

./bin/lexer.o: ./src/lex.yy.c
	cc -c -O0 -o ./bin/lexer.o ./src/lex.yy.c

./src/y.tab.c: ./src/parser.y
	yacc -o ./src/y.tab.c -d ./src/parser.y

./src/lex.yy.c: ./src/lexer.l
	lex -t ./src/lexer.l > ./src/lex.yy.c

clean:
	rm -rf ./bin/*.o

test: ./bin/sbas
	sh ./test/test.sh
