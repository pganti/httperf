#!/usr/bin/gnuplot

set data style linespoints
set xlabel "Latency: RTT (ms)"
set ylabel "Time: (# of RTTs)"
set yrange [0:1000]
set xrange [1024:10240000]

set terminal png

set output "data/handshake.png"
set title "Latency vs. Handshake Time (BodySize=1024)"
plot \
	"data/http-web2.lab.points" using ($2==1024?$1:1/0):($3/$1) title "HTTP direct",\
	"data/http-web.lab.points" using ($2==1024?$1:1/0):($3/$1) title "HTTP tunnel"

set output "data/total.png"
set title "Latency vs. Transaction Time (BodySize=1024)"
plot \
	"data/http-web2.lab.points" using ($2==1024?$1:1/0):(($3+$4+$5)/$1) title "HTTP direct", \
	"data/http-web.lab.points" using ($2==1024?$1:1/0):(($3+$4+$5)/$1) title "HTTP tunnel"

# orange purple
set terminal png xFFFFFF x000000 x80FF00 xFFA500 xA020F0
set title "Latency vs. Time (BodySize=1024)"

set output "data/http-web2.lab.png"
set title "HTTP direct"
plot \
	"data/http-web2.lab.points" using ($2==1024?$1:1/0):($3/$1) title "handshake",\
	"data/http-web2.lab.points" using ($2==1024?$1:1/0):(($3+$4+$5)/$1) title "total"

set output "data/http-web.lab.png"
set title "HTTP tunnel"
plot \
	"data/http-web.lab.points" using ($2==1024?$1:1/0):($3/$1) title "handshake",\
	"data/http-web.lab.points" using ($2==1024?$1:1/0):(($3+$4+$5)/$1) title "total"

