BINARY := gin-gorm-binary
LDFLAGS := -w

build:
	go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY)

deps:
	go get -u github.com/Masterminds/glide
	glide install

PHONY: deps build
