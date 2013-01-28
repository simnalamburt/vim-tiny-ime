bin/changeInput: src/changeInput.m
	[ -d bin ] || mkdir bin
	gcc src/changeInput.m -o bin/changeInput -l objc -framework foundation -framework carbon
