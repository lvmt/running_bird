clear

if [ $1"x" == "-hx" ];then
    echo -e "usage:
    qsj              -- show the jobs of yourself
    qsj <username>   -- show the jobs of the username
    qsj <jobid>      -- show the jobs of the given jobid(s)"
    exit
elif [ $1 ];then
    if [ "$1" -gt 0 ] 2> /dev/null ;then
        jobs="$@"
    else
        cmd="qstat -u $1"
        jobs="`$cmd | awk 'NR>2 && $5=="r"{print $1}'`"
    fi
else
    cmd="qstat"
    jobs="`$cmd | awk 'NR>2 && $5=="r"{print $1}'`"
fi

n=1
for job in $jobs;do

  jobname=`qstat -j $job | grep -oE 'job_name.*$' | awk '{print $NF}'`
  shell=`qstat -j $job | grep -oE 'job_args.*$' | awk '{print $NF}'`
  usage=`qstat -j $job | grep -oE '\bcpu=(.+?),|\bvmem=(.+?),|\bmaxvmem=(.+?)$' | tr ',\n' '  ' | grep '^.*$'`
  host=`qstat -j $job | grep -oE 'hostname=(.+?).local'`

  if [ ! $shell ];then
      shell=`qstat -j $job | grep -oE 'script_file:.*$' | awk '{print $NF}'`
  fi

  sub_time=`qstat -j $job | grep submission_time | awk -F'submission_time:            ' '{print $NF}'`
  sub_time=`date -d "$sub_time" '+%F %T'`

  start_time=`$cmd | grep $job | awk '{print $6, $7}'`
  start_time=`date -d "$start_time" '+%F %T'`

  if [ "$usage" ];then

  echo -e "\033[1;37m>>> $n
  \033[31mjobinfo:\t$job $jobname \033[32m$usage \033[34m$host
  \033[36msubmit_time:\t$sub_time
  start_time:\t$start_time
  \033[33mshell:\t$shell\033[0m"
  
  ((n++))

  fi

done

