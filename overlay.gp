#!/usr/bin/gnuplot

set data style linespoints
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
	"data/http-web2.lab.points" using 1:2:($3+$4+$5) title "Direct",\
	"data/http-web.lab.points" using 1:2:($3+$4+$5) title "Mrasu"


