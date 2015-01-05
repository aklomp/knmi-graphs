YEARS = $(shell seq 2001 2010)
IMGS = $(addprefix png/year-, $(addsuffix .png, $(YEARS)))

.PHONY: all clean

all: $(IMGS)

png:
	mkdir png

png/year-%.png: year-%.svg | png
	rsvg-convert "$<" -f png -o "$@"

year-%.svg: uurgeg_210_2001-2010.xml year.xsl
	xsltproc -param target-year $* year.xsl uurgeg_210_2001-2010.xml | xmllint --format /dev/stdin > "$@"

uurgeg_210_2001-2010.xml: uurgeg_210_2001-2010.txt
	awk -f uur_to_xml.awk "$<" > "$@"

uurgeg_210_2001-2010.txt: uurgeg_210_2001-2010.zip
	unzip -u "$<"
	touch "$@"

uurgeg_210_2001-2010.zip:
	wget -O "$@" "http://www.knmi.nl/klimatologie/uurgegevens/datafiles/210/uurgeg_210_2001-2010.zip"
	touch "$@"

clean:
	rm -rf png
