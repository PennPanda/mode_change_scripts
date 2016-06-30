#/bin/bash

for ((i=0;i<50;i++))
do

sleep 0.01
#./changed
./disable_all
sleep 0.01
./enable_all
sleep 0.01
sudo xentrace -D -e 0x0002f000 trace.bin &
sleep 0.02
./test
sleep 0.07

sudo killall xentrace

./proc_trace.sh trace_proc_output/test$i
done

#xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
#sed -i 's/1v//g' p.txt

#gnuplot>load 'gnu_trace.sh'
