#!/bin/bash

# 验收shell学习成果
# 增加查询其他用户

clear 

echo -e "\033[32m\n地球是圆的，而看似像终点的地方可能也只是起点。\n \033[0m"

function get_job_id() {
    if [ $user ];then
        ids=$(qstat -u ${user} |  less  | cut -d  " " -f1  | sed -n  '3,$p')
    else
        ids=$(qstat  |  less  | cut -d  " " -f1  | sed -n  '3,$p')
        
    fi

    testhead=$(echo $ids | tr " " "\n" | head -1)

    if [ $testhead ];then
        num=$(echo ${ids} | tr " " "\n" | wc -l )
    else 
        num=0
    fi
}


function get_id_info() {
    shell=$(qstat  -j  ${id}    | grep  job_args | awk -F " " '{print $NF}')
    usage=$(qstat  -j ${id}    | grep  usage | awk -F " " '{print $3,$4,$5,$6,$7,$8,$9,$10}')
    if [ ! $shell ];then
        shell=$(qstat  -j  ${id}    | grep  script_file | awk -F " " '{print $NF}')
    fi

    echo -e """
    \033[36mshell: \033[34m${shell}
    \033[36musage: \033[33m${usage}
    \033[0m"""

}

function print_hello() {
    if [ ! $user ];then
        user=$(who am i | cut -d " " -f1)
    fi
    echo -e "\033[36mhello $user, 世界在你想象\033[0m\n"
}

print_hello

while getopts ":i:u:ahs" opt;do
    case $opt in 
    i)
        id=$OPTARG
        get_id_info
        ;;
    s)
        get_job_id
        echo -e """\033[31m目前一共有 ${num} job在运行中\033[0m"
        echo  "ids名称：" $ids
        ;;
    a)
        get_job_id
        n=1
        for id in $ids;do
            echo -e """\033[31m>>> ${n}\t${id}\033[0m"""
            get_id_info
            n=`expr ${n} + 1`
        done
        ;;
    u)
        user=$OPTARG
        echo "查询用户： "$user
        ;;
    h)
        echo -e '''\033[32m
         Usage: 查询目前正在运行的job信息

         qstatcheck -s : 展示目前哪些jobid正在运行中
         qstatcheck -i jobid : 展示具体id的简略信息
         qstatcheck -a : 展示目前所有job的简略信息
         
         展示指定用户的job信息:
         qstatcheck -u aaa -s 
         qstatcheck -u aaa -i jobid
         qstatcheck -u aaa -a

        '''
    esac
done