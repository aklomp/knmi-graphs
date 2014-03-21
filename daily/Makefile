YEARS = $(shell seq 1951 $(shell date -d '-1 year' '+%Y'))
PNGS = $(addprefix year-, $(addsuffix .png, ${YEARS}))

.PHONY: all clean

all: \
  $(PNGS) \
  yearblock.png

yearblock.png: yearblock.svg
	rsvg-convert "$<" -f png -o "$@"

yearblock.svg: yearblock.xsl etmgeg_210.xml
	xsltproc $* $^ | xmllint --format /dev/stdin > "$@"

year-%.png: year-%.svg
	rsvg-convert "$<" -f png -o "$@"

year-%.svg: year.xsl etmgeg_210.xml
	xsltproc -param target-year $* $^ | xmllint --format /dev/stdin > "$@"

etmgeg_210.xml: etmgeg_210.txt
	awk -f etm_to_xml.awk "$<" > "$@"

etmgeg_210.txt: etmgeg_210.zip
	unzip -u "$<"
	touch "$@"

etmgeg_210.zip:
	wget -O "$@" "http://www.knmi.nl/klimatologie/daggegevens/datafiles3/210/etmgeg_210.zip"
	touch "$@"

clean:
	rm -f etmgeg_210.txt etmgeg_210.xml year-*.svg year-*.png
