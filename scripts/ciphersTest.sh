#!/usr/bin/sh
OPENSSL=openssl
#other traffic on .lab
WEB=int10.newokl.com
HOST='pganti-vm'
HTTP_OPTS="--hog --server-name $HOST --timeout 60"
HTTPS_OPTS="$HTTP_OPTS --num-conns 2  --ssl --ssl-no-reuse"
DSS_LIST="`openssl ciphers -ssl3 ALL:-DSS | sed -e 's/:/ /g'`"
DH_LIST="`openssl ciphers -ssl3 ALL:-DH | sed -e 's/:/ /g'`"

for base in \
	"https $WEB 443"
do
	read scheme server port <<-EOF
		$base
	EOF

	OPTS="$HTTPS_OPTS --server $server --port $port"

	for cipher in $DH_LIST
        #for cipher in $($OPENSSL ciphers -ssl3 "ALL:-DSS")
	do
		echo "cipher is $cipher"
		httperf $OPTS --uri /10k.txt --ssl-ciphers $cipher > data/ciphers-$server.log
		echo # blank line
	done 
	awk -f filter.awk data/ciphers-$server.log > data/ciphers-$server.points
done
