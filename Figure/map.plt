#!/bin/bash
set term context size 20,20 standalone color font ",5"
set output 'MAP_all.tex'

set multiplot

a=0

#do for [t=0:9] {
#
#dataFile1=sprintf('rep%1.0f/thickness.out_avg.dat',t)
#dataFile2=sprintf('rep%1.0f/contr.dat',t)
#
#set pm3d map
#set samples 200,200
#set isosamples 200,200
#set ticslevel 0
##set hidden3d front
#load "palette.pal"
#
#lm=sprintf('%1.4f',t/10.0+1.0/10.0-0.09+a)
#rm=sprintf('%1.4f',t/10.0+1.0/10.0+a)
#
#tm=0.90
#bm=0.81
#
#set lmargin at screen lm; set rmargin at screen rm; set tmargin at screen tm; set bmargin at screen bm
#
#unset key
#unset xtics
#unset ytics
#unset label
##unset border
#
#set cbrange [2.5:4.5]
#set xrange [xmin:xmax]
#set yrange [ymin:ymax]
#
##set cbtics topx,$grid,topy
#unset colorbox 
#
#if (t != 7 && t != 9){
#sp dataFile1 matrix w pm3d notitle, dataFile2 u 1:2:($3>=4.5 ? $3 : 1/0)  w l lw 0.3 lc rgb "black" notitle
#}else{
#sp 1/0
#}
#
#a=a-0.005
#
#}
#

do for [t=0:9] {

dataFile1=sprintf('rep%1.0f/thickness.out_avg.dat',t)
dataFile2=sprintf('rep%1.0f/contr2.dat',t)

set pm3d interpolate 5,5 map
set samples 200,200
set isosamples 200,200
set ticslevel 0
#set hidden3d front
load "palette.pal"

lm=sprintf('%1.4f',t/10.0+1.0/10.0-0.09+a)
rm=sprintf('%1.4f',t/10.0+1.0/10.0+a)

tm=0.90
bm=0.81

set lmargin at screen lm; set rmargin at screen rm; set tmargin at screen tm; set bmargin at screen bm

unset key
unset xtics
unset ytics
unset label
#unset border

#set cbrange [topx:topy]
set xrange [xmin+15:xmax-15]
set yrange [ymin+15:ymax-15]

set cbrange [3.5:5.5]
set cbtics 3.5,1,5.5 scale 0.5
#set grid cb

unset colorbox

set contour
set cntrparam bspline
set cntrparam order 10
set cntrparam levels incremental 3.0,0.2,3.8

sp dataFile1 matrix w pm3d notitle lw 0.5 lc rgb "blue"

unset contour 

sp dataFile2 u 1:2:($3==4.5 ? $3 : 1/0) w l lw 0.4 lc rgb "black" notitle, dataFile2 u 1:2:($3==5.0 ? $3 : 1/0)  w l lw 0.7 lc rgb "black" notitle, 'position.dat' u ($0==t ? $2 : 1/0):($0==t ? 59-$3 : 1/0):(5.0) w p ps 0.5 pt 7 lw 1.0 lc rgb "#0cc638" notitle, "" u ($0==t ? $2 : 1/0):($0==t ? 59-$3 : 1/0):(5.0) w p ps 0.6 pt 6 lw 1.0 lc rgb "#008000" notitle, "" u ($0==t ? $4 : 1/0):($0==t ? 59-$5 : 1/0):(5.0) w p ps 0.5 pt 7 lw 1.0 lc rgb "#0cc638" notitle, "" u ($0==t ? $4 : 1/0):($0==t ? 59-$5 : 1/0):(5.0) w p ps 0.6 pt 6 lw 1.0 lc rgb "#008000" notitle
if (t < 1) {
set ylabel '$\lambda = 1.0$' offset 0.5
p "dim.dat" w l lw 1.5 lc rgb "white"
unset ylabel
}
a=a-0.005

}

a=0

do for [t=0:9] {

dataFile1=sprintf('rep%1.0f/thickness_prot.out_avg.dat',t)
dataFile2=sprintf('rep%1.0f/contr.dat',t)

set pm3d interpolate 5,5 map
set samples 200,200
set isosamples 200,200
set ticslevel 0

load "palette.pal"

lm=sprintf('%1.4f',t/10.0+1.0/10.0-0.09+a)
rm=sprintf('%1.4f',t/10.0+1.0/10.0+a)

tm=0.805
bm=0.715

set lmargin at screen lm; set rmargin at screen rm; set tmargin at screen tm; set bmargin at screen bm

unset key
unset xtics
unset ytics
unset label
#unset border

#set cbrange [topx:topy]
set xrange [xmin+15:xmax-15]
set yrange [ymin+15:ymax-15]

set cbrange [3.5:5.5]
set cbtics 3.5,1,5.5 scale 0.5
#set grid cb

#unset colorbox


if (t < 9) {
       unset colorbox
} else {
       set colorbox horiz 
       set colorbox user origin .88,.7 size .06,.01
}


set contour
set cntrparam bspline
set cntrparam order 10
set cntrparam levels incremental 3.0,0.2,3.8

sp dataFile1 matrix w pm3d notitle lw 0.5 lc rgb "blue"

unset contour

sp dataFile2 u 1:2:($3==4.5 ? $3 : 1/0) w l lw 0.4 lc rgb "black" notitle, dataFile2 u 1:2:($3==5.0 ? $3 : 1/0)  w l lw 0.7 lc rgb "black" notitle, 'position.dat' u ($0==t ? $2 : 1/0):($0==t ? 59-$3 : 1/0):(5.0) w p ps 0.5 pt 7 lw 1.0 lc rgb "#0cc638" notitle, "" u ($0==t ? $2 : 1/0):($0==t ? 59-$3 : 1/0):(5.0) w p ps 0.6 pt 6 lw 1.0 lc rgb "#008000" notitle, "" u ($0==t ? $4 : 1/0):($0==t ? 59-$5 : 1/0):(5.0) w p ps 0.5 pt 7 lw 1.0 lc rgb "#0cc638" notitle, "" u ($0==t ? $4 : 1/0):($0==t ? 59-$5 : 1/0):(5.0) w p ps 0.6 pt 6 lw 1.0 lc rgb "#008000" notitle
if (t < 1) {
set ylabel '$\lambda = 1.5$' offset 0.5
p "dim.dat" w l lw 1.5 lc rgb "white"
unset ylabel
}

a=a-0.005

}

unset multiplot

