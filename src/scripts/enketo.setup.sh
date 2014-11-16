#!/bin/sh

a2enmod expires
a2enmod ssl
cd /var/www/
rm -rf enketo/ ; git clone https://github.com/enketo/enketo-legacy.git
mv enketo-legacy enketo

cd enketo
mysql -u root -ppwd -e "drop database enketo";
mysql -u root -ppwd -e "create database enketo";
mysql -u root -ppwd --database=enketo < /shared_folder/vagrant-formhub/src/sql-enketo/instances.sql
mysql -u root -ppwd --database=enketo < /shared_folder/vagrant-formhub/src/sql-enketo/languages.sql
mysql -u root -ppwd --database=enketo < /shared_folder/vagrant-formhub/src/sql-enketo/properties.sql
mysql -u root -ppwd --database=enketo < /shared_folder/vagrant-formhub/src/sql-enketo/surveys.sql
git submodule update --init --recursive

echo "init and update the submodules for enketo-core"
cd public/lib/enketo-core
git submodule update --init --recursive
cd /var/www/enketo

#temp fix for missing column
mysql -u root -ppwd --database=enketo -e "ALTER TABLE surveys ADD COLUMN last_accessed TIMESTAMP NULL";
mysql -u root -ppwd --database=enketo -e "ALTER TABLE surveys ADD COLUMN theme varchar(255) NULL";

sudo /etc/init.d/apache2 restart
cp /shared_folder/vagrant-formhub/puppet/templates/enketo.php /var/www/enketo/Code_Igniter/application/config/enketo.php
cp /shared_folder/vagrant-formhub/puppet/templates/database.php /var/www/enketo/Code_Igniter/application/config/database.php
cp /shared_folder/vagrant-formhub/puppet/templates/config.php /var/www/enketo/Code_Igniter/application/config/config.php
echo "127.0.0.1       enketo.formhub.localhost" >> /etc/hosts

npm install -g bower
bower install --allow-root --config.interactive=false

npm install -g grunt-cli
npm install
gem install sass
grunt

cp /shared_folder/vagrant-formhub/puppet/templates/enketo /etc/apache2/sites-available/enketo
cp /shared_folder/vagrant-formhub/puppet/templates/enketo-ssl /etc/apache2/sites-available/enketo-ssl
a2ensite enketo
a2ensite enketo-ssl