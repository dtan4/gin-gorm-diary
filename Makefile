BINARY := gin-gorm-binary
LDFLAGS := -w

POSTGRES := postgres
POSTGRES_IMAGE := postgres:9.5
POSTGRES_PASSWORD := password
POSTGRES_PORT := 5432

build:
	go build -ldflags="$(LDFLAGS)" -o bin/$(BINARY)

deps:
	go get -u github.com/Masterminds/glide
	glide install

psql:
	psql postgres://postgres:$(POSTGRES_PASSWORD)@localhost:$(POSTGRES_PORT)

run-pg:
	@docker run --name $(POSTGRES) -d -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) -p $(POSTGRES_PORT):$(POSTGRES_PORT) $(POSTGRES_IMAGE)

stop-pg:
	@docker stop $(POSTGRES)
	@docker rm $(POSTGRES)

PHONY: deps build run-pg
