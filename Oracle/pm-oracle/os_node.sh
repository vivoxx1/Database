set -x
hostname
date
uptime
uname -a
lsb_release -a
df -h
df -g
vmstat 2 10
free -mt; free -gt
env | grep ORA
ps -ef|grep pmon
ps -ef|grep tns
lsnrctl status
cat /etc/hosts
ifconfig -a
cat /proc/meminfo | grep MemTotal
cat /proc/meminfo | grep Swap
cat /proc/cpuinfo | grep "model name"
cat /proc/cpuinfo | grep "model name" | wc -l
cat /etc/hosts
cat /etc/sysctl.conf
sar