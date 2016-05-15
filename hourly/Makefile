URL	:= "http://cdn.knmi.nl/knmi/map/page/klimatologie/gegevens/uurgegevens/uurgeg_210_2001-2010.zip"
YEARS	:= $(shell seq 2001 2010)
IMGS	:= $(addprefix png/year-, $(addsuffix .png, $(YEARS)))

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
	wget -O "$@" "$(URL)"
	touch "$@"

clean:
	rm -rf png
