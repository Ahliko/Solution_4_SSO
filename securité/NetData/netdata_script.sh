#!/bin/bash
dnf update
dnf install epel-release -y
dnf install wget -y
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh -y
systemctl start netdata
systemctl enable netdata
firewall-cmd --permanent --add-port=19999/tcp
firewall-cmd --reload
echo "NetData is ready let's check !"
echo "visit http://<Your IP>:19999/"