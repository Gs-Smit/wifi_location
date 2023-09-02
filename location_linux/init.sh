#!/bin/bash

system_init(){
server=$1
port=$2
expect -c '
set timeout 10
spawn ssh -p '${port}' admin@'${server}'
expect "password" {send "123456\r"}
expect "#" { send "cd /jffs/scripts\r" }
expect "#" { send "./services-init\r" }
expect "#" { send "exit\r" }
expect eof
'
}

system_init 192.168.50.1 2001
system_init 192.168.50.2 2002
system_init 192.168.50.3 2003
system_init 192.168.50.4 2004

echo Done.

