#/bin/sh

/etc/init.d/mysql start
/usr/sbin/apache2ctl -D FOREGROUND
