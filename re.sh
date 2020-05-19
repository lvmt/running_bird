#!/bin/bash

# shell 字符串比较
# 正则表达式


echo "开始测试"
infile=$1

if [[ "$infile" =~ ".vcf" ]]
then
    if [[ "$infile" =~ "_sn.vcf.gz" ]]
    then    
        filename=${infile/_sn.vcf.gz/}
        infile=${filename}_sn.vcf.gz
        echo "我是样本 ${filename}"
        echo "我是个sn.vcf文件喔 ${infile}"
    else
        echo "我就是个vcf文件"
    fi
else
    echo "必须输入vcf文件啥"
fi

