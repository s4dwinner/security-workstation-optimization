#!/bin/bash
# Network Optimization Script

configure_dns() {
    echo "Configuring Cloudflare DNS..."
    local connection="HUAWEI_B320_8A59"
    
    nmcli connection modify "$connection" ipv4.dns "1.1.1.1 1.0.0.1"
    nmcli connection modify "$connection" ipv4.ignore-auto-dns yes
    nmcli connection modify "$connection" ipv6.dns "2606:4700:4700::1111 2606:4700:4700::1001"
    nmcli connection modify "$connection" ipv6.ignore-auto-dns yes
    
    nmcli connection down "$connection"
    nmcli connection up "$connection"
}

disable_power_management() {
    echo "Disabling WiFi power management..."
    iwconfig wlan0 power off
}

optimize_tcp_stack() {
    echo "Optimizing TCP/IP stack..."
    sysctl -w net.core.default_qdisc=fq_codel
    sysctl -w net.ipv4.tcp_congestion_control=bbr
}

main() {
    configure_dns
    disable_power_management
    optimize_tcp_stack
    echo "Network optimization complete"
}
