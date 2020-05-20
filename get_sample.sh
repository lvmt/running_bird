#!/bin/bash

# 提取指定模式的结果

father=""
mather=""
child=""
other=""

while getopts "p:m:c:o:i:h" opt;do
    case $opt in 
    p)
        father=$OPTARG
        ;;
    m)
        mather=$OPTARG
        ;;
    c)
        child=$OPTARG
        ;;
    o)
        other=$OPTARG
        ;;
    i)
        infile=$OPTARG
        ;;
    h)
        echo -e """
        这是帮助信息，
        筛选符合指定变异类型的位点
        """
    esac
done



## 定义处理函数
# 得到表头索引数组
declare -A headindex 

function get_head_index_array() {
    head=$(head -1 ${infile} | tr "\t" " ")
    n=1
    for i in ${head};do
        headindex[${i}]=$n
        n=`expr $n + 1 `
    done
}

get_head_index_array 


# 得到指定父母孩子的信息
function get_index(){
    childindex=${headindex[$child]}
    fatherindex=${headindex["$father"]}
    matherindex=${headindex["$mather"]}
    otherindex=${headindex[$other]}

    echo """
    孩子id ${childindex}
    妈妈id ${matherindex}
    爸爸id ${fatherindex}
    其他人id ${otherindex}
    """

}

get_index


## 根据指定条件，得到结果文件
function result(){
   
    head -1 ${infile} > result.xls
    sed '1d' ${infile} | awk -F "\t" '{print $${{childindex}} }'
   
}

result

    
# infile=$1

# # test  head_index_array
# echo ${headindex[@]}
# echo ${headindex["Expression_Visual_Link"]} 
# echo ${headindex["Priority"]}

