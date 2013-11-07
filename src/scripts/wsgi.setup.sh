#!/bin/sh

cd ~
wget http://modwsgi.googlecode.com/files/mod_wsgi-3.3.tar.gz
tar xvzf mod_wsgi-3.3.tar.gz
cd mod_wsgi-3.3
./configure
make
make install
echo "LoadModule wsgi_module /usr/lib/apache2/modules/mod_wsgi.so" >> /etc/apache2/apache2.conf
