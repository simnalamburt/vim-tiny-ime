all: set-ime.1 set-ime.2
%.1: %.m
	clang $< -o $@ -l objc -framework foundation -framework carbon -Os -Wall -Wextra -Wpedantic
%.2: %.swift
	swiftc $< -o $@ -O
