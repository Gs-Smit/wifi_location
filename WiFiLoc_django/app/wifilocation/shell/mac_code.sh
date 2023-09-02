#!/bin/bash

cd makecsiparams/

# 运行命令并将结果保存到变量中
result=$(./makecsiparams -c 1/20 -C 0xf -N 1 -m $1)

# 输出结果供Python捕获
echo "$result"
