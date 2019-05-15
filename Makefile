bin/changeInput: src/changeInput.m
	mkdir -p bin
	clang \
	  src/changeInput.m -o bin/changeInput \
	  -l objc -framework foundation -framework carbon \
	  -O2 -Wall -Wextra -Wpedantic
