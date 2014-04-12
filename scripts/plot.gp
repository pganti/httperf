#!/usr/bin/gnuplot

set logscale
set zeroaxis 1
set style data linespoints
set grid
set surface
set xlabel "RTT (ms)"
set ylabel "content size (bytes)"
set zlabel "time (# of RTTs)"
# orange cyan purple
set terminal png xFFFFFF x000000 x80FF00 xFFA500 x00FFFF xA020F0

set output "data/http-direct.lab.png"
set title "HTTP Nginx"
splot \
	"data/http-direct.lab.points" using 1:2:($3/$1) title "handshake",\
	"data/http-direct.lab.points" using 1:2:(($3+$4)/$1) title "response",\
	"data/http-direct.lab.points" using 1:2:(($3+$4+$5)/$1) title "total"

set output "data/http-instart.lab.png"
set title "HTTP Instart"
splot \
	"data/http-instart.lab.points" using 1:2:($3/$1) title "handshake",\
	"data/http-instart.lab.points" using 1:2:(($3+$4)/$1) title "response",\
	"data/http-instart.lab.points" using 1:2:(($3+$4+$5)/$1) title "total"
