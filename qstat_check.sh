#!/bin/bash

# 验收shell学习成果


function get_job_id() {
    ids=$(qstat |  less  | cut -d  " " -f1  | sed -n  '3,$p')
    num=$(echo ${ids} | tr " " "\n" | wc -l )
    
}


function get_id_info() {
    job_args=$(qstat  -j  ${id}    | grep  job_args | awk -F " " '{print $NF}')
    job_usage=$(qstat  -j ${id}    | grep  usage | awk -F " " '{print $3,$4,$5,$6,$7,$8,$9,$10}')
    echo -e """\033[32m${job_args}\033[0m"""
    echo -e """\033[32m${job_usage}\033[0m"""
}


while getopts "i:ahs" opt;do
    case $opt in 
    i)
        id=$OPTARG
        get_id_info
        ;;
    s)
        get_job_id
        echo -e """\033[32m展示目前正在运行的job名称\033[0m"""
        echo -e """\033[31m目前一共有 ${num} job在运行中\033[0m"
        echo $ids
        
        ;;
    a)
        get_job_id
        n=1
        for id in $ids;do
            echo -e """\033[31m${n}\033[0m"""
            get_id_info
            n=`expr ${n} + 1`
            echo -e "\n"
        done
        ;;
    h)
        echo -e '''\033[32m
         Usage: 查询目前正在运行的job信息

         qstatcheck -s : 展示目前哪些jobid正在运行中
         qstatcheck -i jobid : 展示具体id的简略信息
         qstatcheck -a : 展示目前所有job的简略信息
        '''
    esac
done