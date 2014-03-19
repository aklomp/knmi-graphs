#out.pdf: out.fo
#	/home/alfred/bin/fop-1.0/fop -fo out.fo -pdf out.pdf

all: \
  year-2001.png \
  year-2002.png \
  year-2003.png \
  year-2004.png \
  year-2005.png \
  year-2006.png \
  year-2007.png \
  year-2008.png \
  year-2009.png \
  year-2010.png

year-%.png: year-%.svg
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
