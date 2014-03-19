BEGIN {
	FS=","
	last_year = -1;
	last_month = -1;
	last_day = -1;

	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
	print "<knmi>"
}

END {
	print "   </day>"
	print "  </month>"
	print " </year>"
	print "</knmi>"
}

/^  / {
	year = substr($2, 1, 4)
	month = substr($2, 5, 2)
	day = substr($2, 7, 2)

	if (year != last_year) {
		if (last_year > 0) {
			print "   </day>"
			print "  </month>"
			print " </year>"
		}
		printf(" <year year=\"%s\">\n", year)
		printf("  <month month=\"%s\">\n", month);
		printf("   <day day=\"%s\">\n", day);
	}
	else if (month != last_month) {
		if (last_month > 0) {
			print "   </day>"
			print "  </month>"
		}
		printf("  <month month=\"%s\">\n", month);
		printf("   <day day=\"%s\">\n", day);
	}
	else if (day != last_day) {
		if (last_day > 0) {
			print "   </day>"
		}
		printf("   <day day=\"%s\">\n", day);
	}
	last_year = year;
	last_month = month;
	last_day = day;

	printf("    <TG>%0.1f</TG>\n", $(12) / 10);
	printf("    <TN>%0.1f</TN>\n", $(13) / 10);
	printf("    <TX>%0.1f</TX>\n", $(15) / 10);
}
