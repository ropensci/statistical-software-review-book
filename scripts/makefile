SCRIPT=getZoteroNotes

all: build 

build: $(SCRIPT).R
	Rscript $(SCRIPT).R

clean:
	rm bibnotes.json bibliography/*
