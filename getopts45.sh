#!/bin/bash
 
# 给参数设置默认值

method="GATK"
thread="1"
svtype="INDEL"


while getopts "m:t:s:h" opt; do

    case $opt in 
    m)
        method="$OPTARG"
        ;;
    t)
        thread="$OPTARG"
        ;;
    s)
        svtype="$OPTARG"
        ;;
    h)
        echo "这是一个帮助文档啥"
        echo "测试函数啥"
        echo "有三个参数啥, m, t, s"
    esac
done

if [ $method != "GATK" ]
then
    echo "method's value have changed. GATK --> ${method}"
else
    echo "method's use it's default value. GATK --> ${method}"
fi


if [ ${thread} != "1" ]
then
    echo "thread's value have changed. 1 --> ${thread}"
else
    echo "thread's use it's default values. 1 --> ${thread}"
fi


if [ ${svtype} != "INDEL" ]
then 
    echo "svtype values have changed. INDEL --> ${svtype}"
else
    echo "svtype use it's default values. INDEL --> ${svtype}"
fi






    