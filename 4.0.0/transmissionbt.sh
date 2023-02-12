#!/bin/bash
echo "========================================================================="
echo "Thanks for using Transmission 4.0.0 for CentOS Auto-Install Script"
echo "========================================================================="
setenforce 0 && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
yum -y install wget xz gcc gcc-c++ m4 make automake libtool gettext openssl-devel pkgconfig perl-libwww-perl perl-XML-Parser curl curl-devel zlib-devel which libevent cmake iptables-services
service transmissiond stop 2&> /dev/null
mv -f /home/transmission/Downloads /home
mv -f /home/transmission/.config/transmission/resume /home
mv -f /home/transmission/.config/transmission/torrents /home
rm -rf /home/transmission
rm -rf /usr/local/share/transmission /usr/local/share/doc/transmission
mkdir -p /home/transmission
mkdir -p /home/transmission/.config/transmission
mv -f /home/Downloads /home/transmission
mv -f /home/resume /home/transmission/.config/transmission
mv -f /home/torrents /home/transmission/.config/transmission
echo install Transmisson
cd /root
wget -c http://github.itzmx.com/1265578519/transmission/master/4.0.0/transmission-4.0.0.tar.xz -O transmission-4.0.0.tar.xz
tar Jxvf transmission-4.0.0.tar.xz
cd transmission-4.0.0
mkdir build
cd build
cmake ..
make -j 2
make install
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
mv -f index.html /usr/local/share/transmission/public_html/index.html
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
