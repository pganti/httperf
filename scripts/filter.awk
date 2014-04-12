#!/usr/bin/awk -f

/^cipher is/ {
	cipher = $3;
}

/^RTT is/ {
	rtt = $3;
	if (rtt) print ""
}

/^Reply size/ {
	size = $7;
}

#  $5 mean
#  $7 minimum
# $10 median
# $15 maximum

/^Connection life/ {
	total = $5;
}

/^Handshake time/ {
	handshake = $5;
}

/^Response time/ {
	response = $5;
}

/^Transfer time/ {
	transfer = $5;
}

# trigger to print results
/^CPU/ {
	print rtt, size, handshake, response, transfer, cipher
}
