#/bin/bash

trace_proc_output=$1
echo saving this trace to $1

cat trace.bin | xentrace_format ~/event_driven/event_driven/tools/xentrace/formats | grep "rtds" > $trace_proc_output/temp

#echo soriting
sort -k 2 -n $trace_proc_output/temp > $trace_proc_output/rtds
#echo removing
rm $trace_proc_output/temp
#echo partioning

cat $trace_proc_output/rtds | awk '$5 == "rtds:job_release"' > $trace_proc_output/release_job.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:schedule"' > $trace_proc_output/schedule.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:dis_running"' > $trace_proc_output/dis_running.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:dis_not_running"' > $trace_proc_output/dis_not_running.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:vcpu_enable"' > $trace_proc_output/vcpu_enable.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:mcr"' > $trace_proc_output/mcr.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:job_queued"' > $trace_proc_output/job_queued.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:update_changed"' > $trace_proc_output/update_changed.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:backlog_satisfied"' > $trace_proc_output/backlog.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:sched_time"' > $trace_proc_output/sched_time.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:context_time"' > $trace_proc_output/context_time.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:mc_time"' > $trace_proc_output/time.txt

cat $trace_proc_output/rtds | awk '$5 == "rtds:repl_time"' > $trace_proc_output/repl_time.txt



cp mode_change_info_matlab $trace_proc_output/
#scp trace_proc_output/*.txt tim@home:~/modechange/
