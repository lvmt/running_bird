#!/bin/bash
# Calling one function from another
number_one () {
    echo "Url_1 is http://see.xidian.edu.cn/cpp/shell/"
    number_two
}
number_two () {
    echo "Url_2 is http://see.xidian.edu.cn/cpp/u/xitong/"
}
number_one