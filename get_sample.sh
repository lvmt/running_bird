#!/bin/bash

# 提取指定模式的结果

father=""
mather=""
child=""
other=""

while getopts ":p:m:c:o:i:h" opt; do
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

if [ -s $infile ];then
    echo "得到首行索引字典"
    get_head_index_array 
else
    echo -e "\033[31m请指定输入文件！！\033[0m"
    exit
fi


# 得到指定父母孩子的信息
function get_index() {
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
function result() {
   
    head -1 ${infile} > result.xls
    fileline=` expr $(wc -l < ${infile}) - 1 `   
    echo $fileline
    #利用sed遍历每行文件
    for i in `seq 1 ${fileline}`;do
        childtype=$(sed '1d' ${infile} | sed -n "${i}p" | cut -f ${childindex})
        fathertype=$(sed '1d' ${infile} | sed -n "${i}p" | cut -f ${fatherindex})
        mathertype=$(sed '1d' ${infile} | sed -n "${i}p" | cut -f ${matherindex})
        othertype=$(sed '1d' ${infile} | sed -n "${i}p" | cut -f ${otherindex})
        
        if [[ ${childtype} =~ "0/1" ]];then
            if [[ ${mathertype} =~ "0/1" ]];then
                if [[ ! ${fathertype} =~ "0/1"  ]];then
                    if [[ $othertype =~ "0/1" ]];then
                        echo $childtype $mathertype $fathertype $othertype
                    fi
                fi
            fi
        else
            echo "孩子不是杂合位点，删掉" $childtype
        fi
    done
  
}

result



