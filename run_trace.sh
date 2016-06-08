#/bin/bash



sudo xentrace -D -e 0x0002f000 trace.bin &
sleep 0.01
#./changed
./disable_all
sleep 0.01
./enable_all
sleep 0.03
./test
sleep 0.07

sudo killall xentrace

./proc_trace.sh
#xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
#sed -i 's/1v//g' p.txt

#gnuplot>load 'gnu_trace.sh'
