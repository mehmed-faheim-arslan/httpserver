# c compiler
CC=gcc
# compiler flags - warnings, c11, include debug info, tell compiler to look for headers in include/, link pthreads.
CFLAGS=-Wall -Wextra -std=c11 -g -Iinclude -pthread
# list all .c files under src  
SRC=$(wildcard src/*.c)
TARGET=build/httpserver
TESTS=$(wildcard tests/*.c)

# these are all targets.
# target called 'all'. when running 'make', it builds this.
# so make -> all -> build/httpserver
all: $(TARGET)

# to build 'build/httpserver', prerequisites: build $(SRC)
# build dir should exist, src files must be available, if anything changes, rerun this.
# $(CC) $(CFLAGS) -o $@ $(SRC): gcc <flags> <current_target>(build/httpserver) <list_of_src_files>
# e.g.: gcc -Wall -Wextra -std=c11 -g -Iinclude -pthread -o build/httpserver src/main.c src/server.c

$(TARGET): build $(SRC)
	$(CC) $(CFLAGS) -o $@ $(SRC)

build:
	mkdir -p build

test:
	$(CC) $(CFLAGS) -o build/tests $(TESTS) $(SRC)
	./build/tests

clean:
	rm -rf build/

run: $(TARGET)
	./$(TARGET)

# declares all,test,clean,run as commands not real files.
.PHONY: all test clean run
