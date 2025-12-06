#!/bin/bash
clear

echo ""
echo "======================================"
echo "     🔥 UNINSTALL DDOS PROTECTION"
echo "======================================"
echo ""

sleep 1

echo "[1] Menghapus konfigurasi Nginx Anti-DDOS..."
rm -f /etc/nginx/conf.d/antiddos.conf
systemctl restart nginx

echo "[2] Menghapus Fail2Ban rules..."
systemctl stop fail2ban
systemctl disable fail2ban
apt remove -y fail2ban >/dev/null 2>&1

echo "[3] Reset iptables..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

echo "[4] Reset sysctl ke default..."
cat <<EOF >/etc/sysctl.conf
# Reset default
net.ipv4.ip_forward=1
EOF

sysctl -p >/dev/null 2>&1

echo ""
echo "======================================"
echo "   ✅ DDOS PROTECTION BERHASIL DIHAPUS"
echo "======================================"
echo ""