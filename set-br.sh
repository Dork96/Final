#!/bin/bash
curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config
wget -q -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/Dork96/Final/main/rclone.conf"
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
apt-get install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user 5faktadunia@gmail.com
from Backup VPS Successfull
password bvymaxrrnqgcmskv 
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
cd /usr/bin
wget -q -O autobackup "https://raw.githubusercontent.com/Dork96/Final/main/autobackup.sh"
wget -q -O backup "https://raw.githubusercontent.com/Dork96/Final/main/backup.sh"
wget -q -O restore "https://raw.githubusercontent.com/Dork96/Final/main/restore.sh"
wget -q -O strt "https://raw.githubusercontent.com/Dork96/Final/main/strt.sh"
wget -q -O speed-limiter "https://raw.githubusercontent.com/Dork96/Final/main/speed-limiter.sh"
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x strt
chmod +x speed-limiter
cd
rm -f /root/set-br.sh

