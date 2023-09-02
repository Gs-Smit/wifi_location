#!/bin/bash
server=$1
port=$2
par=$3
PRO_PATH="/tmp/mnt/sda1/ASUS_data/gaoshang/$4"
expect -c '
set timeout 10
spawn ssh -p '${port}' admin@'${server}'
expect "password" {send "123456\r"}
expect "#" { send "/jffs/nexutil -Ieth5 -s500 -b -l34 -v'${par}'\r" }
expect "#" { send "/usr/sbin/wl -i eth5 monitor 1\r"}
expect "#" { send "/jffs/tcpdump -i eth5 dst port 5500 -vv  -c 200 -w '${PRO_PATH}'\r"}
expect "#" { send "exit\r" }
expect eof
'