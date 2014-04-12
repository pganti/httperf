#!/usr/bin/gnuplot

set style data linespoints
set grid
set surface
set xlabel "RTT (ms)"
set ylabel "content size (bytes)"
set zlabel "time (# of RTTs)"
# orange cyan purple
set terminal png xFFFFFF x000000 x80FF00 xFFA500 x00FFFF xA020F0

set output "data/overall.png"
set title "HTTP Results"
splot \
	"data/http-direct.lab.points" using 1:2:($3+$4+$5) title "Nginx",\
	"data/http-instart.lab.points" using 1:2:($3+$4+$5) title "Instart"
