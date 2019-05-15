all: input-method
%: %.m
	clang $< -o $@ -l objc -framework foundation -framework carbon -Os -Wall -Wextra -Wpedantic
