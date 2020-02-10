#!/bin/sh

MYSQL="mysql -h mysql -u root --password=pass1234"

conn_error()
{
	echo Connection error! Exiting...
	exit 1
}

# crash if connection error
$MYSQL -e '' || conn_error

# init database
if ! $MYSQL -e 'USE wordpress;'
then
	echo Initializing database...

	$MYSQL -e 'CREATE DATABASE wordpress;' ||
		( $MYSQL -e 'DROP DATABASE wordpress;'; conn_error)
	$MYSQL wordpress < /wordpress.sql ||
		( $MYSQL -e 'DROP DATABASE wordpress;'; conn_error)
fi

# Apache server name change
if [ ! -z "${APACHE_SERVER_NAME}" ]
	then
		sed -i "s/#ServerName www.example.com:80/ServerName ${APACHE_SERVER_NAME}:80/" /etc/apache2/httpd.conf
		echo "Changed server name to '${APACHE_SERVER_NAME}'..."
	else
		echo "NOTICE: Change 'ServerName' globally and hide server message by setting environment variable >> 'SERVER_NAME=your.server.name' in docker command or docker-compose file"
fi

# Start (ensure apache2 PID not left behind first) to stop auto start crashes if didn't shut down properly
echo "Clearing any old processes..."
rm -f /run/apache2/apache2.pid
rm -f /run/apache2/httpd.pid

echo "Updating HTTPD config"
sed -i "s/ErrorLog logs\/error.log/Errorlog \/dev\/stderr\nTransferlog \/dev\/stdout/" /etc/apache2/httpd.conf

echo "Starting all process ..."
exec httpd -DFOREGROUND &
telegraf
