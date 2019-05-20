all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "  1. make run         - start tda2x docker image"
	@echo "  2. make build       - build the tda2xx image"
	@echo "  3. make release     - release the tda2xx image"

build:
	@docker build --tag=erwinchang/tda2xx .

release: build
	@docker build --tag=erwinchang/tda2xx:$(shell cat VERSION) .

