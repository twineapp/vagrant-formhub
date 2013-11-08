#!/bin/sh

### EDIT CONFIG SETTINGS FOR SERVER ###

DOMAIN="example.com"
MYSQL_PASSWORD="pwd"
ROCKMONGO_PASSWORD="pwd"
POSTGRESQL_PASSWORD="pwd"


### DO NOT EDIT BELOW THIS LINE ###

echo "CHANGING DOMAIN SETTINGS"

SEDFILE="/etc/apache2/sites-available/enketo"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/etc/apache2/sites-available/enketo-ssl"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/var/www/enketo/Code_Igniter/application/config/enketo.php"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/etc/apache2/sites-available/formhub"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/var/www/formhub/formhub/settings.py"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/etc/hosts"
sed "s,formhub.localhost,formhub.$DOMAIN,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

service apache2 reload

echo "CHANGING MYSQL SETTINGS"

mysqladmin -uroot -ppwd password $MYSQL_PASSWORD

SEDFILE="/var/www/enketo/Code_Igniter/application/config/database.php"
sed "s,pwd,$MYSQL_PASSWORD,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

SEDFILE="/var/www/formhub/formhub/preset/default_settings.py"
sed "s,pwd,$MYSQL_PASSWORD,g" $SEDFILE > tmpfile && mv tmpfile $SEDFILE

echo "CHANGING ROCKMONGO SETTINGS"

SEDFILE="/var/www/rockmongo/config.php"
sed 's,"admin";,"'$ROCKMONGO_PASSWORD'";,g' $SEDFILE > tmpfile && mv tmpfile $SEDFILE

echo "CHANGING POSTGRESQL SETTINGS"

sudo -u postgres psql -c "alter user admin with password '"$POSTGRESQL_PASSWORD"';"

