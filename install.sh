#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed"
exit 0
fi 

cd
apt-get update --allow-releaseinfo-change -y > /dev/null

apt-get update -y > /dev/null 
apt-get upgrade -y > /dev/null
#install figlet & lolcat
clear
MYIP=$(wget -qO- https://icanhazip.com);
host=$(hostname);
cat > /etc/hosts <<-END
127.0.0.1       localhost.localdomain localhost
127.0.1.1       localhost
$MYIP   $host
END

apt-get install dbus -y > /dev/null
sudo hostnamectl set-hostname SETUP-BY-THIRASTORE

apt-get install figlet -y > /dev/null
apt-get install ruby -y > /dev/null
gem install lolcat
clear
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
cd
wget -q https://raw.githubusercontent.com/Dork96/Final/main/cf.sh && chmod +x cf.sh && ./cf.sh
wget -q https://raw.githubusercontent.com/Dork96/Final/main/ins-vt.sh && chmod +x ins-vt.sh && ./ins-vt.sh > /dev/null
#br-set
wget https://raw.githubusercontent.com/Dork96/Final/main/set-br.sh && chmod +x set-br.sh && ./set-br.sh > /dev/null

# Set Index
cd /home/vps/public_html
wget -q https://raw.githubusercontent.com/Dork96/Final/main/index.html
# Encrypt
sleep 10
echo "Set Index" | lolcat
cd
wget -q https://raw.githubusercontent.com/Dork96/Final/main/encrypt.sh && chmod +x encrypt.sh && ./encrypt.sh	

cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://www.wuzzzssh.xyz

[Service]: 7100, 7200, 7300"  | tee -a log-install.txt
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

sleep 10
reboot
