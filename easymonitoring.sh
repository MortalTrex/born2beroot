ARCH=$(uname -srvmo)
PCPU=$(grep -c 'physical id' /proc/cpuinfo)
VCPU=$(grep -c processor /proc/cpuinfo)
RAM_TOTAL=$(free -h | awk '/^Mem/ {print $2}')
RAM_USED=$(free -h | awk '/^Mem/ {print $3}')
RAM_PERC=$(free | awk '/^Mem/ {printf("%.2f%%"), $3 / $2 * 100}')
DISK_TOTAL=$(df -h --total | awk '/total/ {print $2}')
DISK_USED=$(df -h --total | awk '/total/ {print $3}')
DISK_PERC=$(df -h --total | awk '/total/ {print $5}')
CPU_LOAD=$(top -bn1 | awk '/^%Cpu/ {printf("%.1f%%"), $2 + $4}')
LAST_BOOT=$(who -b | awk '{print($3 " " $4)}')
LVM=$(lsblk -o TYPE | grep -q lvm && echo yes || echo no)
TCP=$(grep TCP /proc/net/sockstat | awk '{print $3}')
USER_LOG=$(who | wc -l)
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip link show | awk '/link\/ether/ {print $2}')
SUDO_LOG=$(grep -c COMMAND /var/log/sudo/sudo.log)

wall "
       ------------------------------------------------
       Architecture    : $ARCH
       Physical CPUs   : $PCPU
       Virtual CPUs    : $VCPU
       Memory Usage    : $RAM_USED/$RAM_TOTAL ($RAM_PERC)
       Disk Usage      : $DISK_USED/$DISK_TOTAL ($DISK_PERC)
       CPU Load        : $CPU_LOAD
       Last Boot       : $LAST_BOOT
       LVM use         : $LVM
       TCP Connections : $TCP ESTABLISHED
       Users logged    : $USER_LOG
       Network         : $IP_ADDR ($MAC_ADDR)
       Sudo            : $SUDO_LOG commands used
       ------------------------------------------------"


