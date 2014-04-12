#!/usr/bin/sh

DUMMYNET=dummynet
# other traffic on .lab
WEB=10.0.2.1
HOST='pganti-vm'
HTTP_OPTS="--hog --server-name $HOST --timeout 60"
HTTP_OPTS="$HTTP_OPTS${DEBUG:+ --debug $DEBUG}"
HTTPS_OPTS="$HTTP_OPTS --ssl --ssl-no-reuse --ssl-ciphers RC4-MD5"

PERF_OPTS="--send-buffer=16384 --recv-buffer=65535 --num-conns 2"

# {direct, tunnel, proxy} x {http, https}
for base in \
	"http $WEB 80"
do
	read scheme server port <<-EOF
		$base
	EOF

	if [ $scheme = https ]
	then
		OPTS="$HTTPS_OPTS $PERF_OPTS --server $server --port $port"
	else
		OPTS="$HTTP_OPTS $PERF_OPTS --server $server --port $port"
	fi

	for delay in 5 16 50 158
	do
		echo "RTT is $((2*delay))"
		echo # blank line

		# configure dummynet
		ssh -T $DUMMYNET <<-EOF
			ipfw pipe 23 config delay $delay queue 100
			ipfw pipe 32 config delay $delay queue 100
		EOF

		for size in 1k.txt 10k.txt 64k.txt 512k.txt
		do
			httperf $OPTS --uri /$size
		done
	done > data/$scheme-$server.log
	awk -f filter.awk data/$scheme-$server.log > data/$scheme-$server.points
done
