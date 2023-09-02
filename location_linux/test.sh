#!/bin/bash

csi_scp()
{
ip=$1
name="AP_${ip}_${2}.pcap"
expect -c '
set timeout 15
spawn scp admin@'${ip}':/tmp/mnt/sda1/ASUS_data/gaoshang/'${name}' matlab-asus/data/
expect "password" {send "123456\r"}
expect eof
'
}

csi_scp 192.168.50.1 $1



