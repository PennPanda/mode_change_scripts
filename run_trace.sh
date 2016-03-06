#/bin/bash

sudo xentrace -D -e 0x0002f000 trace.bin &
sleep 0.5
./mode_change
sleep 2
./mode_change2
sleep 0.5
sudo killall xentrace




xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
sed -i 's/1v//g' p.txt

gnuplot>load 'gnu_trace.sh'
