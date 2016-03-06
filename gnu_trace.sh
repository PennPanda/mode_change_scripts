#/bin/bash

set output "aaa.ps"
set terminal x11
set output 'trace.png'
set title 'vCPU on pCPU execution'
set grid
set key outside bottom center horizontal


set xlabel 'Time'
set ylabel 'VCPU'

plot "p.txt" using 2:1 with linespoints
pause -1
