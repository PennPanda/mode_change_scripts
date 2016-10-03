#/bin/bash
nr_vcpu=8;
#load the modes into the hypervisor
load_scripts/load_disable_all_mode $nr_vcpu #0
load_scripts/load_enable_all_mode $nr_vcpu #1
load_scripts/load_pre_async_period_mode $nr_vcpu #2
load_scripts/load_test_mode $nr_vcpu > mode_change_info_matlab #3



for ((i=0;i<30;i++))
do
    sleep 0.01
#./changed
    trigger_scripts/disable_all
    sleep 0.1
    trigger_scripts/enable_all
    sleep 0.1

    trigger_scripts/pre_async_period
    sleep 0.1

    sudo xentrace -D -e 0x0002f000 trace.bin &
    sleep 0.02
    trigger_scripts/test
    sleep 0.05

    sudo killall xentrace
    sleep 0.02
    ./proc_trace.sh trace_proc_output/test$i
    echo "done test$i"
done

rm mode_change_info_matlab

#xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
#sed -i 's/1v//g' p.txt

#gnuplot>load 'gnu_trace.sh'
