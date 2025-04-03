#!/bin/bash

# Fungsi untuk menampilkan pesan
print_message() {
    echo -e "\n\033[1;32m$1\033[0m"
}

# Fungsi untuk menampilkan error
print_error() {
    echo -e "\n\033[1;31mError: $1\033[0m"
}

# Fungsi untuk menampilkan status
print_status() {
    echo -e "\033[1;34m$1:\033[0m $2"
}

# Fungsi untuk menampilkan header
print_header() {
    echo -e "\n\033[1;33m=== $1 ===\033[0m"
}

# Fungsi untuk menampilkan garis pemisah
print_separator() {
    echo -e "\033[1;36m----------------------------------------\033[0m"
}

# Fungsi untuk menampilkan status CPU
show_cpu_status() {
    print_header "CPU Status"
    print_status "CPU Usage" "$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"
    print_status "Load Average" "$(uptime | awk -F'load average: ' '{print $2}')"
    print_status "CPU Temperature" "$(sensors | grep 'Core 0' | awk '{print $3}')"
}

# Fungsi untuk menampilkan status Memory
show_memory_status() {
    print_header "Memory Status"
    free -h | awk '/^Mem:/ {print "Total: " $2 ", Used: " $3 ", Free: " $4}'
    print_status "Swap Usage" "$(free -h | awk '/^Swap:/ {print $3 "/" $2}')"
}

# Fungsi untuk menampilkan status Disk
show_disk_status() {
    print_header "Disk Status"
    df -h | grep -v "tmpfs" | grep -v "udev" | awk '{print $1 ": " $3 "/" $2 " (" $5 ")"}'
}

# Fungsi untuk menampilkan status Network
show_network_status() {
    print_header "Network Status"
    print_status "Public IP" "$(curl -s ifconfig.me)"
    print_status "Local IP" "$(hostname -I | awk '{print $1}')"
    print_status "Network Interfaces" "$(ip -o -4 addr show | awk '{print $2 ": " $4}')"
}

# Fungsi untuk menampilkan status Services
show_services_status() {
    print_header "Services Status"
    print_status "SSH" "$(systemctl is-active ssh)"
    print_status "VNC" "$(systemctl is-active vncserver@:1)"
    print_status "Linux Server Bot" "$(systemctl is-active linux-server-bot)"
    print_status "Firewall" "$(systemctl is-active ufw)"
    print_status "Fail2ban" "$(systemctl is-active fail2ban)"
}

# Fungsi untuk menampilkan status System
show_system_status() {
    print_header "System Status"
    print_status "Uptime" "$(uptime -p)"
    print_status "OS" "$(lsb_release -d | cut -f2)"
    print_status "Kernel" "$(uname -r)"
    print_status "Hostname" "$(hostname)"
}

# Fungsi untuk menampilkan status VNC
show_vnc_status() {
    print_header "VNC Status"
    print_status "VNC Server" "$(vncserver -list | grep -c ':1')"
    print_status "VNC Port" "5901"
    print_status "VNC Display" ":1"
}

# Fungsi untuk menampilkan status Security
show_security_status() {
    print_header "Security Status"
    print_status "Failed SSH Attempts" "$(grep "Failed password" /var/log/auth.log | wc -l)"
    print_status "Banned IPs" "$(fail2ban-client status sshd | grep "Currently banned" | awk '{print $4}')"
    print_status "Firewall Rules" "$(ufw status | grep -c "ALLOW")"
}

# Main function
main() {
    clear
    print_message "Linux Server Bot - System Status Monitor"
    print_separator
    
    show_system_status
    print_separator
    
    show_cpu_status
    print_separator
    
    show_memory_status
    print_separator
    
    show_disk_status
    print_separator
    
    show_network_status
    print_separator
    
    show_services_status
    print_separator
    
    show_vnc_status
    print_separator
    
    show_security_status
    print_separator
    
    print_message "Status terakhir diupdate: $(date)"
}

# Jalankan main function
main 