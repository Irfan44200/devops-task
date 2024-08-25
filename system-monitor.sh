#!/bin/bash
show_dashboard(){
clear
echo "-------- Dashboard --------"
    echo "1. Top 10 Memory and CPU usage Application"
    echo "2. Network Monitoring"
    echo "3. Disk Usage"
    echo "4. System Load"
    echo "5. Memory Usage"
    echo "6. Process Monitoring"
    echo "7. Service Monitoring"
    echo "----------------------------"
    echo "Press 'q' to quit"
}

show_most_used_app(){
clear
echo '======================== Memory and CPU usage =================================';echo

echo -e '\e[1;44mTop 10 Application by Memory Usage:\e[0m';echo
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%mem | head -10

echo;echo -e '\e[1;44mTop 10 Application by CPU Usage:\e[0m';echo
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%cpu | head -10

}

show_network_monitoring(){
clear
echo;echo '========================= Network Monitoring =================================';echo
echo -e '\e[1;44mNumber of concurrent connections:\e[0m'
netstat -an | grep 'ESTABLISHED' | wc -l

echo;echo -e '\e[1;44mNumber of Packets dropped:\e[0m';echo
ip -s link

echo;echo -e '\e[1;44mNumber of MB in and out:\e[0m';echo
echo -e '\e[1;31mPLEASE wait for process to complete:\e[0m';echo
timeout 20 ifstat
}


show_disk_usage(){
clear
echo;echo '========================= Disk Usage =================================';echo

echo -e '\e[1;44mTotal Disk usage:\e[0m';echo
df -h;echo;

echo -e '\e[1;44mDisk usage more than 80%:\e[0m';echo
df -h | awk 'NR==1 || $5+0 > 80 {print}' | awk 'NR==1 {print; next} $5+0 > 80 {print "\033[1;31m" $0 "\033[0m"}'

}

show_system_load(){
clear
echo;echo '========================= System Load =================================';echo

echo -e '\e[1;44mCurrent load average of system:\e[0m';echo;uptime;echo

echo -e '\e[1;44mBreakdown of CPU usage:\e[0m';echo;mpstat

}

show_memory_usage(){
clear
echo;echo '========================= Swap and Memory usage =================================';echo
free -h
}

show_process_monitoring(){
clear
echo;echo '========================= Process Monitoring =================================';echo

echo -e '\e[1;44mDisplay the number of active processes\e[0m';top -bn1 | grep "Tasks:";echo

echo -e '\e[1;44mTop 5 Application by Memory Usage:\e[0m';echo
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%mem | head -5

echo;echo -e '\e[1;44mTTop 5 Application by CPU Usage:\e[0m';echo
ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%cpu | head -5
}

show_service_monitoring(){
clear
echo '========================= Service Monitoring ================================='

# Define services to check
SERVICES=("nginx" "apache2" "sshd" "iptables" "docker") 

# Loop through services and check status
for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $SERVICE; then
        echo -e "\e[1;32m$SERVICE is running.\e[0m";echo
    else
        echo -e "\e[1;31m$SERVICE is NOT running!\e[0m";echo
    fi
done
}

# Main loop to handle user input
while true ; do
    show_dashboard
    echo -n "Press a key to view specific stats: "
    read -n 1 key

    case $key in
        1)
            show_most_used_app
            ;;
        2)
            show_network_monitoring
            ;;
        3)
            show_disk_usage
            ;;
 	4)
            show_system_load
            ;;
        5)
            show_memory_usage
            ;;
        6)
            show_process_monitoring
            ;;
        7)
            show_service_monitoring
            ;;
            
               
        q|Q)
            clear
            echo "Exiting dashboard..."
            break
            ;;
        *)
            echo "Invalid option. Please press 1, 2, 3, or q."
            ;;
    esac

    echo "Press any key to return to the dashboard."
    read -n 1
done






