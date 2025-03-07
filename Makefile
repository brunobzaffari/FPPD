.PHONY: all build

all: build

go.mod:
	go mod init jogo
	go get -u github.com/nsf/termbox-go
	go get -u github.com/google/uuid

build: go.mod
	go build jogo.go
	
clean:
	rm -f jogo

distclean: clean
	rm -f go.mod go.sum

run:
	go run jogo.go