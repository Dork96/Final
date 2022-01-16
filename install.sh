#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed"
exit 0
fi 


apt-get update --allow-releaseinfo-change > /dev/null

apt-get update > /dev/null && apt-get upgrade > /dev/null
#install figlet & lolcat
clear


apt-get install figlet > /dev/null
apt-get install ruby > /dev/null
gem install lolcat > /dev/null

echo "Process Install Script..." | lolcat
echo "Please be patient..." | lolcat

mkdir /var/lib/premium-script;
echo "IP=" >> /var/lib/premium-script/ipvps.conf

#install ssh ovpn
echo "Installation SSH OVPN" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh > /dev/null
#install ohp-server
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ohp.sh && chmod +x ohp.sh && ./ohp.sh > /dev/null
#sstp
echo "Installation SSTP" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/sstp.sh && chmod +x sstp.sh && ./sstp.sh > /dev/null
#install ssr
echo "Installation ShadowSock" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ssr.sh && chmod +x ssr.sh && ./ssr.sh > /dev/null
#sodosok
wget -q https://raw.githubusercontent.com/Dork96/Final/main/sodosok.sh && chmod +x sodosok.sh && ./sodosok.sh > /dev/null
#installwg
echo "Installation Wireguard" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/wg.sh && chmod +x wg.sh && ./wg.sh > /dev/null
#install L2TP
echo "Installation L2TP" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ipsec.sh && chmod +x ipsec.sh && ./ipsec.sh > /dev/null
#install v2ray
echo "Installation V2RAY" | lolcat
wget -q https://raw.githubusercontent.com/Dork96/Final/main/cf.sh && chmod +x cf.sh && ./cf.sh > /dev/null
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ins-vt.sh && chmod +x ins-vt.sh && ./ins-vt.sh > /dev/null
#br-set
wget https://raw.githubusercontent.com/Dork96/Final/main/set-br.sh && chmod +x set-br.sh && ./set-br.sh > /dev/null

# Set Index
cd /home/vps/public_html
wget -q https://raw.githubusercontent.com/Dork96/Final/main/index.html
# Encrypt
cd
wget -q https://raw.githubusercontent.com/Dork96/Final/main/encrypt.sh && chmod +x encrypt.sh && ./encrypt.sh > /dev/null

rm -f /root/encrypt.sh
rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/ohp.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://www.wuzzzssh.xyz

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
history -c
echo "1.0" > /home/ver
clear
echo " "
figlet -c Instalation Success | lolcat
echo " "
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo "================================= Premium Final ===========================" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442, OHP 8087"  | tee -a log-install.txt
echo "   - Stunnel4                : 443, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - WebSocket Dropbear      : 8143" | tee -a log-install.txt
echo "   - WebSocket OpenSSH       : 8022" | tee -a log-install.txt
echo "   - WebSocket OpenVPN       : 2082" | tee -a log-install.txt
echo "   - WebSocket TLS           : 700" | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - Trojan                  : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [OFF]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Script By               : THIRASTORE " | tee -a log-install.txt
echo "   - Telegram                : t.me/T_STORE17"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "================================================================================" | tee -a log-install.txt
echo "-------------------------- Created By THIRASTORE ---------------------------" | tee -a log-install.txt
echo "================================================================================" | tee -a log-install.txt
echo ""
echo "	 Your VPS Will Be Automatical Reboot In 10 s"
rm -f install.sh
MYIP=$(wget -qO- https://icanhazip.com);
host=$(hostname);
cat > /etc/hosts <<-END
127.0.0.1       localhost.localdomain localhost
127.0.1.1       localhost
$MYIP   $host
END

apt-get install dbus -y > /dev/null
sudo hostnamectl set-hostname SETUP-BY-THIRASTORE

sleep 10
reboot
