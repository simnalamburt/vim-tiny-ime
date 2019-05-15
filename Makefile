all: set-ime
%: %.m
	clang $< -o $@ -l objc -framework foundation -framework carbon -Os -Wall -Wextra -Wpedantic
