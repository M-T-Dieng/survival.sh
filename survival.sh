#!/bin/bash
echo "------------------------------"
echo "SERVER PERFORMANCE STATISTICS"
echo "------------------------------"
echo ""

#utilisation CPU
echo " 1- CPU Usage:"
cpu_usage=$(top -bn1 | grep %Cpu | awk '{print $2 + $4}')
echo "${cpu_usage}%"
echo""

#utilisation memoire
echo " 2- Memory Usage"
total_memory=$(free -m | grep Mem | awk '{print $2}')
used_memory=$(free -m | grep Mem | awk '{print $3}')
free_memory=$(free -m | grep Mem | awk '{print $4}')
memory_usage=$(echo "scale=2;$used_memory * 100 / $total_memory" | bc -l)

echo "Total Memory : ${total_memory} MB"
echo "Used Memory  : ${used_memory} MB"
echo "Free Memory  : ${free_memory} MB"
echo "Memory Usage : ${memory_usage}%"
echo ""

#utilisation stockage
echo " 3- Disk Usage"
total_disk=$(df -hT / | tail -1 | awk '{print $3}' )
used_disk=$(df -hT / | tail -1 | awk '{print $4}' )
free_disk=$(df -hT / | tail -1 | awk '{print $5}' )
disk_usage=$(df -hT / | tail -1 | awk '{print $6}' )

echo "Total Disk : ${total_disk}"
echo "Used Disk  : ${used_disk}"
echo "Free Disk  : ${free_disk}"
echo "Usage      : ${disk_usage}"
echo ""

#top 5 processus  (%CPU)
echo " 4- Top 5 processes by CPU usage"
echo "$(ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6)"
echo ""

#top 5 processus  (%mem)
echo " 5- Top 5 processes by CPU usage"
echo "$(ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -6)"
echo ""

echo "============================================"
echo "        ADDITIONAL SERVER INFORMATION"
echo "============================================"

#information systeme
echo ""
echo "OS version:"
echo "$( grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
echo ""
echo "System uptime:"
echo "$(uptime -p)"
echo ""
echo "Load average:"
echo "$(cat /proc/loadavg | awk '{print $1 ", " $2 ", " $3 }')"
echo ""
echo "Logged in Users:"
echo "$(who)"
echo ""
echo "-----------------------------------------"
echo "Server stats collected successfully"
echo "-----------------------------------------"
