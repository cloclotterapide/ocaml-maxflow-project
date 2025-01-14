.PHONY: all build format edit demo clean

src?=-1
dst?=-2
graph?=cricket_match1.txt
state?=1 #0 for the graph before ford fulkerson is applied and 1 for after

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile $(state)
	dot -Tsvg outfile > graphe.svg
	firefox graphe.svg
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"


clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
