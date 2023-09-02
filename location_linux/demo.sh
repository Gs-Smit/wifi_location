#!/bin/bash

csi_scp()
{
ip=$1
name="AP_${ip}_${2}.pcap"
expect -c '
set timeout 3
spawn scp admin@'${ip}':/tmp/mnt/sda1/ASUS_data/gaoshang/'${name}' matlab-asus/data/
expect "password" {send "123456\r"}
expect eof
'

if [ -f "matlab-asus/data/$name" ];then
    echo "CSI Collection Finish!"
else
    cp matlab-asus/raw_csi3/csidata_4ant_1117_AP_${ip}_1.pcap  matlab-asus/data/AP_${ip}_${2}.pcap
fi
}


csi_scp 192.168.50.1 test_ggb

