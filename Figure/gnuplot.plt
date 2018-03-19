#!/bin/bash
set terminal postscript enhanced size 6in,6in
set output 'MAP.ps'

dataFile1=sprintf('../Example/PRO.dat')
dataFile2=sprintf('../Example/MSD.dat')
dataFile3=sprintf('contour.dat')

unset surface
set contour
set cntrparam bspline
set cntrparam order 10
set cntrparam levels incremental -5,1,0  

set table dataFile3
sp dataFile1 matrix notitle
unset table

reset

set multiplot
set pm3d map interpolate 10,10
set samples 200,200
set isosamples 200,200
set ticslevel 0
set hidden3d front
load "palette.pal"

lm=0.1
rm=0.8
tm=0.9
bm=0.2

set lmargin at screen lm; set rmargin at screen rm; set tmargin at screen tm; set bmargin at screen bm

unset key
unset xtics
unset ytics

xmin=20
xmax=80
ymin=20
ymax=80

set cbrange [0:0.6]
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set cbtics 0,0.2,0.6

sp dataFile2 matrix w pm3d notitle, dataFile3 u ($1+1):2:($3>-1.0 ? $3 : 1/0)  w l lw 0.3 lc rgb "black" notitle

unset multiplot

