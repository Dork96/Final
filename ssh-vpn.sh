#!/bin/bash
#
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- https://icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=THIRASTORE
organizationalunit=www.wuzzzssh.xyz
commonname=www.wuzzzssh.xyz
email=admin@wuzzzssh.xyz

# simple password minimal
wget -q -O /etc/pam.d/common-password "https://raw.githubusercontent.com/Dork96/Final/main/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt-get update -y
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt-get -y install wget curl > /dev/null

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget neofetch screen rsyslog cmake iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl python git lsof
#echo "clear" >> .profile
#echo "neofetch" >> .profile
# Admin Welcome
wget -q -O /usr/bin/welcomeadmin "https://raw.githubusercontent.com/Dork96/Final/main/welcomeadmin.sh"
chmod +x /usr/bin/welcomeadmin
echo "welcomeadmin" >> .profile

# install webserver
apt-get -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -q -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Dork96/Final/main/nginx.conf"
mkdir -p /home/vps/public_html
wget -q -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Dork96/Final/main/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd
dpkg --configure -a
wget -q -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/Dork96/Final/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 > /dev/null &' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 > /dev/null &
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 > /dev/null &

# setting port ssh
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
apt-get -y install squid3 > /dev/null
wget -q -O /etc/squid/squid.conf "https://raw.githubusercontent.com/Dork96/Final/main/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf

# setting vnstat
apt-get -y install vnstat > /dev/null
/etc/init.d/vnstat restart
apt-get -y install libsqlite3-dev > /dev/null
wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz > /dev/null
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install stunnel
apt-get install stunnel4 -y > /dev/null
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 127.0.0.1:109

[ssh]
accept = 777
connect = 127.0.0.1:22

[openvpn]
accept = 442
connect = 127.0.0.1:1194

[stunnelws]
accept = 222
connect = 127.0.0.1:700

[dropbearws]
accept = 567
connect = 127.0.0.1:109



END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# install fail2ban
apt-get -y install fail2ban 

#OpenVPN
wget -q https://raw.githubusercontent.com/Dork96/Final/main/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh


# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'
clear
# banner /etc/issue.net
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/Dork96/Final/main/banner.conf"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
cd
# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

#SSLH
apt-get install sslh -y 
#Forward 443 = 109 = 567
wget -q -O /etc/default/sslh "https://raw.githubusercontent.com/Dork96/DorkScript/main/sslh.conf"
service sslh restart

#install websocket
wget -q https://raw.githubusercontent.com/Dork96/DorkScript/main/websock.sh && chmod +x websock.sh && ./websock.sh

cd
echo "Installed Websocket Success..." | lolcat

# download script
cd /usr/bin
wget -q -O /usr/bin/add-host "https://raw.githubusercontent.com/Dork96/Final/main/add-host.sh"
wget -q -O /usr/bin/about "https://raw.githubusercontent.com/Dork96/Final/main/about.sh"
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/Dork96/Final/main/menu.sh"
wget -q -O /usr/bin/add-ssh "https://raw.githubusercontent.com/Dork96/Final/main/add-ssh.sh"
wget -q -O /usr/bin/trial-ssh "https://raw.githubusercontent.com/Dork96/Final/main/trial-ssh.sh"
wget -q -O /usr/bin/del-ssh "https://raw.githubusercontent.com/Dork96/Final/main/del-ssh.sh"
wget -q -O /usr/bin/list-ssh "https://raw.githubusercontent.com/Dork96/Final/main/list-ssh.sh"
wget -q -O /usr/bin/delete "https://raw.githubusercontent.com/Dork96/Final/main/delete.sh"
wget -q -O /usr/bin/cek-ssh "https://raw.githubusercontent.com/Dork96/Final/main/cek-ssh.sh"
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/Dork96/Final/main/restart.sh"
wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/Dork96/Final/main/speedtest_cli.py"
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/Dork96/Final/main/info.sh"
wget -q -O /usr/bin/ram "https://raw.githubusercontent.com/Dork96/Final/main/ram.sh"
wget -q -O /usr/bin/renew-ssh "https://raw.githubusercontent.com/Dork96/Final/main/renew-ssh.sh"
wget -q -O /usr/bin/autokill "https://raw.githubusercontent.com/Dork96/Final/main/autokill.sh"
wget -q -O /usr/bin/mulog "https://raw.githubusercontent.com/Dork96/Final/main/mulog.sh"
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/Dork96/Final/main/tendang.sh"
wget -q -O /usr/bin/change-port "https://raw.githubusercontent.com/Dork96/Final/main/change-port.sh"
wget -q -O /usr/bin/port-ovpn "https://raw.githubusercontent.com/Dork96/Final/main/port-ovpn.sh"
wget -q -O /usr/bin/port-ssl "https://raw.githubusercontent.com/Dork96/Final/main/port-ssl.sh"
wget -q -O /usr/bin/port-wg "https://raw.githubusercontent.com/Dork96/Final/main/port-wg.sh"
wget -q -O /usr/bin/port-tr "https://raw.githubusercontent.com/Dork96/Final/main/port-tr.sh"
wget -q -O /usr/bin/port-sstp "https://raw.githubusercontent.com/Dork96/Final/main/port-sstp.sh"
wget -q -O /usr/bin/port-squid "https://raw.githubusercontent.com/Dork96/Final/main/port-squid.sh"
wget -q -O /usr/bin/port-ws "https://raw.githubusercontent.com/Dork96/Final/main/port-ws.sh"
wget -q -O /usr/bin/port-vless "https://raw.githubusercontent.com/Dork96/Final/main/port-vless.sh"
wget -q -O /usr/bin/webmin "https://raw.githubusercontent.com/Dork96/Final/main/webmin.sh"
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/Dork96/Final/main/xp.sh"
wget -q -O /usr/bin/kernel-up "https://raw.githubusercontent.com/Dork96/Final/main/kernel.sh"
#wget -O /usr/bin/update "https://raw.githubusercontent.com/Dork96/Final/main/update-1.2.sh"
wget -q -O /usr/bin/auto-reboot "https://raw.githubusercontent.com/Dork96/Final/main/reboot.sh"

wget -q -O /usr/bin/menu-l2tp "https://raw.githubusercontent.com/Dork96/Final/main/menu-l2tp.sh"
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/Dork96/Final/main/menu-ssh.sh"
wget -q -O /usr/bin/menu-system "https://raw.githubusercontent.com/Dork96/Final/main/menu-system.sh"
wget -q -O /usr/bin/menu-tr "https://raw.githubusercontent.com/Dork96/Final/main/menu-tr.sh"
wget -q -O /usr/bin/menu-v2ray "https://raw.githubusercontent.com/Dork96/Final/main/menu-v2ray.sh"
wget -q -O /usr/bin/menu-wr "https://raw.githubusercontent.com/Dork96/Final/main/menu-wr.sh"


chmod +x /usr/bin/add-host
chmod +x /usr/bin/menu
chmod +x /usr/bin/add-ssh
chmod +x /usr/bin/trial-ssh
chmod +x /usr/bin/del-ssh
chmod +x /usr/bin/list-ssh
chmod +x /usr/bin/delete
chmod +x /usr/bin/cek-ssh
chmod +x /usr/bin/restart
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/info
chmod +x /usr/bin/about
chmod +x /usr/bin/autokill
chmod +x /usr/bin/mulog
chmod +x /usr/bin/tendang
chmod +x /usr/bin/ceklim
chmod +x /usr/bin/ram
chmod +x /usr/bin/renew-ssh
chmod +x /usr/bin/clear-log
chmod +x /usr/bin/change-port
chmod +x /usr/bin/port-ovpn
chmod +x /usr/bin/port-ssl
chmod +x /usr/bin/port-wg
chmod +x /usr/bin/port-sstp
chmod +x /usr/bin/port-tr
chmod +x /usr/bin/port-squid
chmod +x /usr/bin/port-ws
chmod +x /usr/bin/port-vless
chmod +x /usr/bin/webmin
chmod +x /usr/bin/xp
chmod +x /usr/bin/kernel-up
#chmod +x /usr/bin/update
chmod +x /usr/bin/auto-reboot

chmod +x /usr/bin/menu-l2tp
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/menu-system
chmod +x /usr/bin/menu-tr
chmod +x /usr/bin/menu-v2ray
chmod +x /usr/bin/menu-wr

# should replace this with -i
cd
#sudo sed 's/#\?\(PermitRootLogin\s*\).*$/\1 yes/' /etc/ssh/sshd_config > sshd.txt
#mv -f sshd.txt /etc/ssh/sshd_config
#sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config > sshd.txt
#mv -f sshd.txt /etc/ssh/sshd_config
#rm -r sshd.txt

echo "0 5 * * * root clear-log && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
# remove unnecessary files
cd
apt-get autoclean -y
apt-get -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt-get autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

rm -r master.zip
clear
echo "Instaled SSH SSL OVPN Succes..." | lolcat
# finihsing

