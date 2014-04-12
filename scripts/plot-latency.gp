#!/usr/bin/gnuplot
set style data linespoints
set xlabel "Latency: RTT (ms)"
set ylabel "Time: (# of RTTs)"
set yrange [0:1000]
set xrange [1024:10240000]

set terminal png

set output "data/handshake.png"
set title "Latency vs. Handshake Time (BodySize=1024)"
plot \
	"data/http-instart.lab.points" using ($2==11737?$1:1/0):($3/$1) title "HTTP direct",\
	"data/http-direct.lab.points" using ($2==11737?$1:1/0):($3/$1) title "HTTP instart"

set output "data/total.png"
set title "Latency vs. Transaction Time (BodySize=1024)"
plot \
	"data/http-instart.lab.points" using ($2==11737?$1:1/0):(($3+$4+$5)/$1) title "HTTP direct", \
	"data/http-direct.lab.points" using ($2==11737?$1:1/0):(($3+$4+$5)/$1) title "HTTP instart"

# orange purple
set terminal png xFFFFFF x000000 x80FF00 xFFA500 xA020F0
set title "Latency vs. Time (BodySize=1024)"

set output "data/http-instart.lab.png"
set title "HTTP direct"
plot \
	"data/http-instart.lab.points" using ($2==11737?$1:1/0):($3/$1) title "handshake",\
	"data/http-instart.lab.points" using ($2==11737?$1:1/0):(($3+$4+$5)/$1) title "total"

set output "data/http-direct.lab.png"
set title "HTTP instart"
plot \
	"data/http-direct.lab.points" using ($2==11737?$1:1/0):($3/$1) title "handshake",\
	"data/http-direct.lab.points" using ($2==11737?$1:1/0):(($3+$4+$5)/$1) title "total"


