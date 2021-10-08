SCRIPT=build-script
TARGET=index

all: build 

build: $(SCRIPT).R
	Rscript $(SCRIPT).R

open: _book/$(TARGET).html
	xdg-open _book/$(TARGET).html &

clean:
	rm -r _book # scripts/bibnotes.json scripts/bibliography/*
