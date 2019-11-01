#!/usr/bin/sh

DUMMYNET=root@dummynet.lan
CLIENT=client.lan
CLIENT2=client2.lan
# other traffic on .lab
WEB=web.lab
WEB2=web2.lab
#PROXY=p1-loc-netwk3.lab
#PROXY_S=p1-loc-netwk4.lab

HTTP_OPTS="--hog --http-version 1.0 --timeout 60"
HTTP_OPTS="$HTTP_OPTS${DEBUG:+ --debug $DEBUG}"
HTTPS_OPTS="$HTTP_OPTS --ssl --ssl-no-reuse --ssl-ciphers RC4-MD5"

PERF_OPTS="--send-buffer=16384 --recv-buffer=65535 --num-conns 2"

# {direct, tunnel, proxy} x {http, https}
for base in \
	"http $WEB2 80"
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

	# rtt 0 1 3 10 31 100 316
	#for delay in 0 1 5 16 50 158
	for delay in 5 16 50 158
	do
		echo "RTT is $((2*delay))"
		echo # blank line

		# configure dummynet
		ssh -T $DUMMYNET <<-EOF
			ipfw pipe 6030 config delay $delay bw 128Kbps
			ipfw pipe 3060 config delay $delay bw 512Kbps
		EOF

		for size in 10K 100K 1M
		do
			echo httperf $OPTS --uri /$size
		done | ssh -T $CLIENT2 
	done | tee data/$scheme-$server.log \
		| awk -f filter.awk > data/$scheme-$server.points
done
