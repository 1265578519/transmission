#!/bin/bash
echo "========================================================================="
echo "Thanks for using Transmission 2.84 for CentOS Auto-Install Script"
echo "========================================================================="
yum -y install wget xz gcc gcc-c++ m4 make automake libtool gettext openssl-devel pkgconfig perl-libwww-perl perl-XML-Parser curl curl-devel libidn-devel zlib-devel which libevent
service transmissiond stop
mv -f /home/transmission/Downloads /home
rm -rf /home/transmission
rm -rf /usr/share/transmission
mkdir /home/transmission
mv -f /home/Downloads /home/transmission
cd /root
wget -c http://github.itzmx.com/1265578519/transmission/master/2.84/intltool-0.40.6.tar.gz -O intltool-0.40.6.tar.gz
tar zxf intltool-0.40.6.tar.gz
cd intltool-0.40.6
./configure --prefix=/usr
make -s
make -s install
cd ..
wget -c http://github.itzmx.com/1265578519/transmission/master/2.84/libevent-2.0.21-stable.tar.gz -O libevent-2.0.21-stable.tar.gz
tar zxf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make -s
make -s install
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib/libevent-2.0.so.5
ln -s /usr/local/lib/libevent-2.0.so.5.1.9 /usr/lib/libevent-2.0.so.5.1.9
ln -s /usr/lib/libevent-2.0.so.5 /usr/local/lib/libevent-2.0.so.5
ln -s /usr/lib/libevent-2.0.so.5.1.9 /usr/local/lib/libevent-2.0.so.5.1.9
echo install Transmisson
cd /root
wget -c http://github.itzmx.com/1265578519/transmission/master/2.84/transmission-2.84.tar.xz -O transmission-2.84.tar.xz
tar Jxvf transmission-2.84.tar.xz
cd transmission-2.84
./configure --prefix=/usr
make -s
make -s install
useradd -m transmission
passwd -d transmission
wget http://github.itzmx.com/1265578519/transmission/master/2.84/transmission.sh -O /etc/init.d/transmissiond
chmod 755 /etc/init.d/transmissiond
chkconfig --add transmissiond
chkconfig --level 2345 transmissiond on
mkdir -p /home/transmission/Downloads/
chmod g+w /home/transmission/Downloads/
wget -c http://github.itzmx.com/1265578519/transmission/master/2.84/settings.json
mkdir -p /home/transmission/.config/transmission/
mv -f settings.json /home/transmission/.config/transmission/settings.json
chown -R transmission.transmission /home/transmission
wget -c http://github.itzmx.com/1265578519/transmission/master/2.84/index.html
mv -f index.html /usr/share/transmission/web/index.html
service transmissiond start
iptables -t nat -F
iptables -t nat -X
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -P PREROUTING ACCEPT
iptables -t mangle -P INPUT ACCEPT
iptables -t mangle -P FORWARD ACCEPT
iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -P POSTROUTING ACCEPT
iptables -F
iptables -X
iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t raw -F
iptables -t raw -X
iptables -t raw -P PREROUTING ACCEPT
iptables -t raw -P OUTPUT ACCEPT
service iptables save
echo "========================================================================="
echo "Install end"
echo "========================================================================="
echo ""
echo "Login: http://ip:9091"
echo ""
echo "Default username: itzmx.com"
echo ""
echo "Default password: itzmx.com"
echo ""
echo "Download Folder: /home/transmission/Downloads/"
echo ""
echo "Please change your username(rpc-username) and password(rpc-password) in the file :"
echo "/home/transmission/.config/transmission/settings.json"
echo ""
echo "http://bbs.itzmx.com"
echo ""
echo "Thank you!"
echo "========================================================================="
