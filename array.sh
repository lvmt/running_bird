#!/bin/bash


# 练习declare的用法


declare -A database_operation
declare -A database_argument

while read databaseName operationClass argums
do 
    # echo ${operationClass}
    # echo ${argums}
    database_operation[$databaseName]=$operationClass
    database_argument[$databaseName]=$argums
done < test.txt


echo "操作类型数组"
echo ${database_operation[@]}

echo  "操作参数数组"
echo ${database_argument[@]}

