#!/bin/sh

echo "Formhub: Make directory structure and clone formhub:"
cd /var/www
rm -rf formhub/ ; git clone https://github.com/SEL-Columbia/formhub.git
cd formhub
git submodule update --init --recursive

echo "Formhub: Install requirements:"
pip install numpy  --use-mirrors
#temp fix for django version in requirements.pip
sed 's,.*Django.*,Django==1.5,g' /var/www/formhub/requirements.pip > tmpfile && mv tmpfile /var/www/formhub/requirements.pip
pip install -r requirements.pip
sudo ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/
sudo ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/

echo "Formhub: Create a database and start server:"
cp /shared_folder/vagrant-formhub/puppet/templates/settings.py /var/www/formhub/formhub/settings.py
cp /shared_folder/vagrant-formhub/puppet/templates/default_settings.py /var/www/formhub/formhub/preset/default_settings.py
#sudo -u postgres psql -c "drop database formhub;"
sudo -u postgres psql -c "create database formhub;"
sudo -u postgres psql -c "grant all privileges on database formhub to admin;"
python manage.py syncdb --noinput
python manage.py migrate

echo "Formhub: Deploy static files"
python manage.py collectstatic --noinput

echo "Formhub: Configure the celery daemon:"
cp /var/www/formhub/extras/celeryd/etc/init.d/celeryd /etc/init.d/celeryd
cp /shared_folder/vagrant-formhub/puppet/templates/celeryd /etc/default/celeryd
/etc/init.d/celeryd start
echo "127.0.0.1       formhub.localhost" >> /etc/hosts


cp /shared_folder/vagrant-formhub/puppet/templates/formhub.wsgi /var/www/formhub/formhub.wsgi
cp /shared_folder/vagrant-formhub/puppet/templates/formhub /etc/apache2/sites-available/formhub
a2ensite formhub

mkdir /var/www/formhub/media
chmod -R 777 /var/www/formhub/media
