#!/usr/bin/gnuplot

set data style linespoints
set terminal png

set xlabel "Size: response body (bytes)"
set ylabel "Time: (# of RTTs)"
set logscale
#set yrange [1:100]

set output "data/size.png"
set title "Size vs. Time (RTT=100)
plot \
	"data/http-web2.lab.points" using ($1==100?$2:1/0):(($3+$4+$5)/$1) title "HTTP direct", \
	"data/http-web.lab.points" using ($1==100?$2:1/0):(($3+$4+$5)/$1) title "HTTP tunnel"

f(x) = fa*x + fb
fit f(x) "data/http-web2.lab.points" using ($1==100?$2:1/0):(($3+$4+$5)/$1) via fa, fb
g(x) = ga*x + gb
fit g(x) "data/http-web.lab.points" using ($1==100?$2:1/0):(($3+$4+$5)/$1) via ga, gb

set xrange [1024:10240000]
set output "data/size-fit.png"
plot \
	f(x) title "HTTP direct", \
	g(x) title "HTTP tunnel"
