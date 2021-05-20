#! /bin/bash

sourceWord="a"
targetWord="b"

#读取目录
echo "输入要替换的目录"
read dir
#读取后缀
echo "输入要求的后缀"
read suffix

#遍历读取文件函数
function read_dir() {
    for file in $(#注意此处这是两个反引号，表示运行系统命令
        ls ${1}
    ); do
        subFile="${1}/${file}"
        if [ -d ${subFile} ]; then #注意此处之间一定要加上空格，否则会报错
            read_dir ${subFile}
        else
            if [[ ${suffix} == "" || "${subFile##*.}"x = "${suffix}"x ]]; then
                handle_file ${subFile} #处理文件
            fi
        fi
    done
}

#替换逻辑
function handle_file() {
    echo ${1}
    sed -i "s/${sourceWord}/${targetWord}/g" ${1}
}

read_dir $dir
