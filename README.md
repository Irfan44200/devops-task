## System Monitor Script

This script provides comprehensive monitoring of system metrics on a Linux machine. It includes features for monitoring memory and CPU usage, network activity, disk usage, system load, and more.

### Prerequisites

Ensure you have the following installed on your system:

- `bash` (or compatible shell)
- `awk`
- `grep`
- `netsat`
- `ifsat`

### Features

- **Top 10 Memory and CPU Usage Applications**: Identifies and lists the top 10 applications consuming the most memory and CPU resources.
- **Network Monitoring**: Tracks network usage and activity.
- **Disk Usage**: Displays the disk space usage of various file systems.
- **System Load**: Monitors system load averages over time.
- **Memory Usage**: Provides detailed information about memory usage.
- **Process Monitoring**: Lists active processes and their resource consumption.
- **Service Monitoring**: Checks the status of key system services.



#### To start the application

Step 1: Clone the repository

    git clone https://github.com/Irfan44200/readme-test/

Step 2: Change the directory

    cd /DevOps-task
    
Step 3: Make the Script Executable by changing the permission of file

    chmod u+x system-monitor.sh

Step 4: Run the script

    ./system-monitor.sh
 
Step 5: After running the script, a user-friendly dashboard will open, showing various system monitoring options.

![Screenshot from 2024-08-25 15-39-02](https://github.com/user-attachments/assets/80e2b0ff-ec01-4dd3-b059-c80296708f43)


### Dashboard Components


 1. Top 10 Memory and CPU Usage Applications:

- Memory Usage:

        ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%mem | head -10
    
 **This command will sort the Top 10 Application by CPU usage.**

    ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%CPU | head -10


> 2. When the user selects option 2, the Network Monitoring will open.

 **This command will display the Number of concurrent connections.**

    netstat -an | grep 'ESTABLISHED' | wc -l

 **This command will display the Number of Packets dropped.**
 
    ip -s link

> 3. When the user selects option 3, the Disk Usage will open.

 **This command will display the total Disk usage.**

    df -h

 **This command will display the Disk usage more than 80%.**
 
    df -h | awk 'NR==1 || $5+0 > 80 {print}' | awk 'NR==1 {print; next} $5+0 > 80 {print "\033[1;31m" $0 "\033[0m"}'

> 4. When the user selects option 4, the System Load will open.

 **This command will display the Current load average of system.**

    uptime

 **This command will display the Breakdown of CPU usage.**
 
    mpstat
    
> 5. When the user selects option 5, the Swap and Memory usage will open.

 **This command will display the Memory and swap free and used usage.**

    free -h

> 6. When the user selects option 6, the Process Monitoring will open.

 **This command will display the number of active processes.**

    top -bn1 | grep "Tasks:"

 **This command will display the top 5 Application by Memory Usage.**
 
    ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%mem | head -5


 **This command will display the top 5 Application by CPU Usage.**
 
    ps -eo pid,ppid,cmd,comm,%mem,%cpu --sort=-%CPU | head -5


> 7. When the user selects option 7, the Service Monitoring will open.

 **This command will check the status of services in for loop and display the status of essential services print a message indicating whether each service is running or not.**

    for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $SERVICE; then
        echo -e "\e[1;32m$SERVICE is running.\e[0m";echo
    else
        echo -e "\e[1;31m$SERVICE is NOT running!\e[0m";echo
    fi
    done
    }
