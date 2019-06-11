#!/bin/bash
yum -y install wget unzip
wget -c http://github.itzmx.com/1265578519/transmission/master/2.94/index.html -O index.html
mv -f index.html /usr/share/transmission/web/index.original.html
rm -rf /usr/share/transmission/web/index.html
wget -c http://github.itzmx.com/1265578519/transmission/master/2.94/webgui.zip -O webgui.zip
unzip -o webgui.zip
cd webgui
mv -f * /usr/share/transmission/web/*
