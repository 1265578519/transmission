#!/bin/bash
echo "========================================================================="
echo "Thanks for using Transmission 4.0.0 for CentOS Auto-Install Script"
echo "========================================================================="
yum -y install wget xz gcc gcc-c++ m4 make automake libtool gettext openssl-devel pkgconfig perl-libwww-perl perl-XML-Parser curl curl-devel libidn-devel zlib-devel which libevent
service transmissiond stop 2&> /dev/null
mv -f /home/transmission/Downloads /home
mv -f /home/transmission/.config/transmission/resume /home
mv -f /home/transmission/.config/transmission/torrents /home
rm -rf /home/transmission
rm -rf /usr/share/transmission
mkdir -p /home/transmission
mkdir -p /home/transmission/.config/transmission
mv -f /home/Downloads /home/transmission
mv -f /home/resume /home/transmission/.config/transmission
mv -f /home/torrents /home/transmission/.config/transmission
cd /root
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/intltool-0.40.6.tar.gz -O intltool-0.40.6.tar.gz
tar zxf intltool-0.40.6.tar.gz
cd intltool-0.40.6
./configure --prefix=/usr
make -s
make -s install
cd ..
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/libevent-2.0.21-stable.tar.gz -O libevent-2.0.21-stable.tar.gz
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
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/transmission-4.0.0.tar.xz -O transmission-4.0.0.tar.xz
tar Jxvf transmission-4.0.0.tar.xz
cd transmission-4.0.0
./configure --prefix=/usr
make -s
make -s install
useradd -m transmission
passwd -d transmission
wget http://github.itzmx.com/1265578519/transmission/master/4.0.0/transmission.sh -O /etc/init.d/transmissiond
chmod 755 /etc/init.d/transmissiond
chkconfig --add transmissiond
chkconfig --level 2345 transmissiond on
mkdir -p /home/transmission/Downloads/
chmod g+w /home/transmission/Downloads/
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/settings.json -O settings.json
mkdir -p /home/transmission/.config/transmission/
mv -f settings.json /home/transmission/.config/transmission/settings.json
chown -R transmission.transmission /home/transmission
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/index.html -O index.html
mv -f index.html /usr/share/transmission/web/index.html
service transmissiond start
/sbin/iptables -I INPUT -p tcp --dport 9091 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 22222 -j ACCEPT
/sbin/iptables -I INPUT -p udp --dport 22222 -j ACCEPT
service iptables save
service ip6tables stop 2&> /dev/null
chkconfig ip6tables off 2&> /dev/null
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
