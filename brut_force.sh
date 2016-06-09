#/bin/bash

FILES=("single_xml/max_period_offset.xml" "single_xml/min_offset_no_peri.xml" "single_xml/min_offset_with_peri.xml" "single_xml/async_no_period.xml" "single_xml/async_period.xml")

for (( i=1; i <= 36000; i++ ))
do
        p=$(($RANDOM%5))
        f=${FILES[$p]}
#        echo $p
#        echo $f
        echo $f > log.txt
        sleep 0.01
        ./disable_all
        sleep 0.01
        ./enable_all
        sleep 0.03
        sudo /usr/local/sbin/mc $f
        sleep 0.1
done
