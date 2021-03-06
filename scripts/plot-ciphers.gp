#!/usr/bin/gnuplot

# very dependent on order in data file
set label "DES-CBC-SHA" at 0,1 rotate
set label "EXP1024-RC4-MD5" at 1,1 rotate
set label "IDEA-CBC-SHA" at 2,1 rotate
set label "RC4-MD5" at 3,1 rotate
set label "RC4-SHA" at 4,1 rotate
set label "AES128-SHA" at 5,1 rotate
set label "AES256-SHA" at 6,1 rotate
set label "EXP1024-DES-CBC-SHA" at 7,1 rotate
set label "EXP1024-RC4-SHA" at 8,1 rotate
set label "DES-CBC3-SHA" at 9,1 rotate
set label "EXP1024-RC2-CBC-MD5" at 10,1 rotate
set label "EXP-DES-CBC-SHA" at 11,1 rotate
set label "EXP-RC4-MD5" at 12,1 rotate
set label "EXP-RC2-CBC-MD5" at 13,1 rotate
set label "EXP-ADH-DES-CBC-SHA" at 14,1 rotate
set label "EXP-ADH-RC4-MD5" at 15,1 rotate
set label "EXP-EDH-RSA-DES-CBC-SHA" at 16,1 rotate
set label "ADH-AES128-SHA" at 17,1 rotate
set label "ADH-DES-CBC-SHA" at 18,1 rotate
set label "ADH-RC4-MD5" at 19,1 rotate
set label "ADH-AES256-SHA" at 20,1 rotate
set label "ADH-DES-CBC3-SHA" at 21,1 rotate
set label "EDH-RSA-DES-CBC-SHA" at 22,1 rotate
set label "DHE-RSA-AES128-SHA" at 23,1 rotate
set label "DHE-RSA-AES256-SHA" at 24,1 rotate
set label "EDH-RSA-DES-CBC3-SHA" at 25,1 rotate
set xrange [-0.75:25.75]
set yrange [0:150]

set xlabel "Cipher Suite"
set ylabel "Time: Handshake (ms)"
set noxtics
set boxwidth 0.95

set terminal png
set output "data/ciphers-direct.lab.png"
set title "Nginx Time less 3 RTTs"
plot 'data/ciphers-direct.lab.points' using 0:($1==10?$3:1/0) \
		title "RTT 10ms" with boxes lw 2, \
	'data/ciphers-direct.lab.points' using 0:($1==32?$3-96:1/0) \
		title "RTT 32ms" with boxes

set output "data/ciphers-instart.lab.png"
set title "Tunnel Time less 2 RTTs"
plot 'data/ciphers-instart.lab.points' using 0:($1==10?$3:1/0) \
		title "RTT 10ms" with boxes lw 2,\
	'data/ciphers-instart.lab.points' using 0:($1==32?$3-64:1/0) \
		title "RTT 32ms" with boxes

