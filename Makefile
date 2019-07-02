build: ./bin ./bin/main.o
	cc -o ./bin/sbas ./bin/main.o

./bin:
	mkdir ./bin

./bin/main.o: ./src/main.c
	cc -c -O0 -o ./bin/main.o ./src/main.c

clean:
	rm -rf ./bin/*.o

test: ./bin/sbas
	sh ./test/test.sh
