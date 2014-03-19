# Filter out only the average temperature per day
#
BEGIN {
	FS = ",";
	last_year  = -1;
	last_month = -1;
	last_day   = -1;
	last_hour  = -1;
	in_body    = 0;
	printf( "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" );
	printf( "<knmi>\n" );
}

END {
	printf( "\t\t\t\t</hour>\n" );
	printf( "\t\t\t</day>\n" );
	printf( "\t\t</month>\n" );
	printf( "\t</year>\n" );
	printf( "</knmi>\n" );
}

(in_body) && /^ / {
	year  = substr($(date_field), 1, 4);
	month = substr($(date_field), 5, 2);
	day   = substr($(date_field), 7, 2);
	hour  = $(hour_field); sub(/^ +/, "", hour);

	if (year != last_year) {
		if (last_year > 0) {
			printf("\t\t\t\t</hour>\n");
			printf("\t\t\t</day>\n");
			printf("\t\t</month>\n");
			printf("\t</year>\n");
		}
		printf("\t<year year=\"%s\">\n", year);
		printf("\t\t<month month=\"%s\">\n", month);
		printf("\t\t\t<day day=\"%s\">\n", day);
		printf("\t\t\t\t<hour hour=\"%s\">\n", hour);
	}
	else if (month != last_month) {
		if (last_month > 0) {
			printf("\t\t\t\t</hour>\n");
			printf("\t\t\t</day>\n");
			printf("\t\t</month>\n");
		}
		printf("\t\t<month month=\"%s\">\n", month)
		printf("\t\t\t<day day=\"%s\">\n", day);
		printf("\t\t\t\t<hour hour=\"%s\">\n", hour);
	}
	else if (day != last_day) {
		if (last_day > 0) {
			printf("\t\t\t\t</hour>\n");
			printf("\t\t\t</day>\n");
		}
		printf("\t\t\t<day day=\"%s\">\n", day);
		printf("\t\t\t\t<hour hour=\"%s\">\n", hour);
	}
	else if (hour != last_hour) {
		if (last_hour > 0) {
			printf("\t\t\t\t</hour>\n");
		}
		printf("\t\t\t\t<hour hour=\"%s\">\n", hour);
	}
	last_year  = year;
	last_month = month;
	last_day   = day;
	last_hour  = hour;

	# Print temperature, divide by 10 because the unit is 0.1 deg C:
	printf("\t\t\t\t\t<T>%s</T>\n", $(temp_field) / 10);
}

/^# / {
	# Trim leading '# ' from first field:
	sub(/^# /, "", $1);

	# Loop over all fields, find date and average temperature fields:
	for (i = 1; i < NF; i++) {
		sub( /^ +/, "", $(i) );
		if ($(i) == "YYYYMMDD") {
			date_field = i;
		}
		if ($(i) == "T") {
			temp_field = i;
		}
		if ($(i) == "HH") {
			hour_field = i;
		}
	}
	# Set flag to indicate we're now in the body:
	in_body = 1;
}
