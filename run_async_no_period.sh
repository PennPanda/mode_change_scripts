#/bin/bash
nr_vcpu=0;
nr_vcpu=$1;
if [[ "$nr_vcpu" -eq 0 ]]; then
    echo 'enter nr_vcpu'
    exit 0
fi
echo protocol with $nr_vcpu vcpu

ID=$(sudo xl list | awk '$1 == "ubuntu1"' | awk '{print $2}')

echo -----------------------------------------------
echo running async without periodicity on domain $ID
echo -----------------------------------------------
sleep 3
#load the transitions into the hypervisor
load_scripts/load_disable_all_mode $nr_vcpu $ID 0 #0
load_scripts/load_enable_all_mode $nr_vcpu $ID 1 #1
sleep 1
load_scripts/load_pre_async_period_mode $nr_vcpu $ID 2 #2
load_scripts/load_async_period_mode $nr_vcpu $ID 3 > mode_change_info_matlab #3

#prepare the initial state
#disable all
sudo /usr/local/sbin/mc_trigger $ID 0
sudo xl debug-keys r && xl dmesg | tail -n 20

sleep 1

#enable_all
sudo /usr/local/sbin/mc_trigger $ID 1
sleep 0.5
sudo xl debug-keys r && xl dmesg | tail -n 20
#sleep 100

for ((i=0;i<1000;i++))
do
    sleep 0.01
    #/pre_async_period
    sudo /usr/local/sbin/mc_trigger $ID 2
    sleep 0.08

    sudo xentrace -D -e 0x0002f000 trace.bin &
    sleep 0.07
    sudo /usr/local/sbin/mc_trigger $ID 3
    sleep 0.07

    sudo killall xentrace
    #disable_all
    sudo /usr/local/sbin/mc_trigger $ID 0

    ./proc_trace.sh trace_proc_output/test$i

    #enable_all
    sudo /usr/local/sbin/mc_trigger $ID 1
    sleep 0.05

    echo "done test$i"
done

rm mode_change_info_matlab

#xenalyze --scatterplot-pcpu trace.bin | grep ^1v > p.txt
#sed -i 's/1v//g' p.txt

#gnuplot>load 'gnu_trace.sh'
