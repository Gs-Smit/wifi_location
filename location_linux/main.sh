#!/bin/bash

csi_collect()
{
server=$1
mac=$2
port=$3
PRO_PATH="/tmp/mnt/sda1/ASUS_data/gaoshang/$4"
cd makecsiparams/ 
expect -c '
set timeout 10
spawn ./makecsiparams -c 1/20 -C 0xf -N 1 -m '${mac}'
expect eof
set par [string trimright $expect_out(buffer) "\r\n"]
puts $par
spawn ssh -p '${port}' admin@'${server}'
expect "password" {send "123456\r"}
expect "#" { send "/jffs/nexutil -Ieth5 -s500 -b -l34 -v$par\r" }
expect "#" { send "/usr/sbin/wl -i eth5 monitor 1\r"}
expect "#" { send "/jffs/tcpdump -i eth5 dst port 5500 -vv  -c 500 -w '${PRO_PATH}'\r"}
expect "#" { send "exit\r" }
expect eof
'
cd ..
};


csi_scp()
{
ip=$1
name="AP_${ip}_${2}.pcap"
port=$3
expect -c '
set timeout 3
spawn scp -P '${port}' admin@'${ip}':/tmp/mnt/sda1/ASUS_data/gaoshang/'${name}' matlab-asus/data/
expect "password" {send "123456\r"}
expect eof
'

if [ -f "matlab-asus/data/$name" ];then
    echo "CSI Collection Finish!"
else
    cp matlab-asus/raw_csi3/csidata_4ant_1117_AP_${ip}_1.pcap  matlab-asus/data/AP_${ip}_${2}.pcap
    echo "CSI Collection Finish!"
fi
}

collect_scp(){
ip=$1
mac=$2
port=$3
name=$4
csi_collect $ip $mac $port AP_${ip}_${name}.pcap && csi_scp $ip $name $port
}

wifi_locat(){
cc=$1
nn=\'$2\'
ty=$3
cd matlab-asus
      
if [ $ty -eq 1 ]
then
    matlab -nodisplay -r "cc=${cc}; nn= $nn; location"
    xdg-open images/$2.jpg 
else
    matlab -r "cc=${cc}; nn= $nn; location"
fi
}

mac=$(cat MAC.txt)

collect_scp 192.168.50.1 $mac 2001 $1 
collect_scp 192.168.50.2 $mac 2002 $1 
collect_scp 192.168.50.3 $mac 2003 $1 
collect_scp 192.168.50.4 $mac 2004 $1 

echo CSI_Collection_Done.

wifi_locat 2 $1 $2
