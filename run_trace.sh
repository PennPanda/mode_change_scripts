#/bin/bash



sudo xentrace -D -e 0x0002f000 trace.bin &
sleep 0.03
#./changed
./max_period_offset
#sleep 0.3
#./mode_change2
sleep 0.07
./mode_change2
sleep 0.03
./disable_all
sleep 0.03
./enable_all
sleep 0.03

sudo killall xentrace

./proc_trace.sh
#xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
#sed -i 's/1v//g' p.txt

#gnuplot>load 'gnu_trace.sh'
