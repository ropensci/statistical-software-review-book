.PHONY: all build test open clean help

TARGET=index

all: help

build: ## Build the book
	Rscript scripts/build.R

test: ## Test that all standards conform to expected format
	Rscript scripts/test-standards.R

open: ## open the rendered book in default browser
	xdg-open _book/$(TARGET).html &

clean: ## Remove all quarto build artefacts
	rm -rf _book
	find . -maxdepth 1 -type d -name "*_cache" -exec rm -rf {} + 2>/dev/null || true

help: ## Show this help
	@printf "Usage:\033[36m make [target]\033[0m\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
