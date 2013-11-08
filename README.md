#vagrant-formhub

Vagrant dev / test environment for formhub / enketo

Virtual OS: Ubuntu 12.04 (Precise) x64, with Packages:

- Apache
- MySQL
- PostgreSQL
- Formhub
- Enketo
- Java JRE
- PHP
- phpMyAdmin
- Curl
- OAuth
- Mongo
- Prince
- Python
- Sendmail

## Requirements:
- VirtualBox (https://www.virtualbox.org/wiki/Downloads), tested with v4.2.12
- Vagrant (http://downloads.vagrantup.com), tested with v1.2.1

## Guide:  
1. Download and install software from Requirements  
2. Create a folder named 'formhubapp/' and clone this repository (formhubapp/vagrant-formhub).  
3. Clone / copy in the formhub repo and datasets  
    - clone 'formhub' github repository into 'formhubapp/formhub/' directory
4. Run terminal, go into 'formhubapp/vagrant-formhub/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the formhub vm
5. Install dnsmasq on your local machine nameserver

    **ubuntu**

    - sudo apt-get install dnsmasq	
    - edit /etc/dnsmasq.conf and add these entries to bottom of file
        - address=/formhub.localhost/192.168.50.5
        - address=/enketo.formhub.localhost/192.168.50.5
    - edit /etc/resolv.conf and add this entry to top of file
        - nameserver 127.0.0.1
        
    **OS X**

    - there is a good description here (using homebrew): http://blakeembrey.com/articles/local-development-with-dnsmasq/
    - brew install dnsmasq
    - edit /etc/dnsmasq.conf and add these entries to bottom of file
        - address=/formhub.localhost/192.168.50.5
        - address=/enketo.formhub.localhost/192.168.50.5
    - add nameserver entry at System Preferences -> Network -> Advanced -> DNS
        - nameserver 127.0.0.1 (as first entry)
        - your other DNS name servers
        
6. View Formhub: http://formhub.localhost/
7. View Enketo: https://enketo.formhub.localhost/

## Working with the vagrant:
- "vagrant up" starts the virtual machine
- "vagrant suspend" suspends the vm, this is normally how you would end your work session
- "vagrant halt" shuts down the vm, you would do this to autoload additional db patches for example
- "vagrant reload" is equivelent to a halt and up, and should be run after changes to the vagrant repo. Before a reload, delete the dbs
- "vagrant destroy" completely removes the vm from your machine. You would do this to save disk space if you won't be working on the vagrant for a while, or to do a full rebuild after significant changes to the vagrant repo
- command reference: http://docs.vagrantup.com/v2/cli/index.html

## Notes:
- Server should be ready to use at 192.168.50.5 (modify this static IP in Vagrantfile before bringing up the vagrant if required)
- Test via http://192.168.50.5/phpinfo.php
- src in the directory is linked to the webserver document root

## VM Passwords
- mysql username:password are root:pwd
- rockmongo username:password are admin:admin
- postgresql username:password are admin:pwd

## Deployment via Standalone method (details: http://puppetlabs.com/blog/deploying-puppet-in-client-server-standalone-and-massively-scaled-environments)
- ssh into a clean install of Ubuntu 12.04 (Precise) x64
- sudo su
- apt-get update
- apt-get install git puppet
- mkdir /shared_folder/
- cd /shared_folder/
- git clone https://github.com/twineapp/vagrant-formhub.git
- cd vagrant-formhub/
- nano puppet/manifests/formhub.pp (to uncomment the list of imports)
- puppet apply puppet/manifests/formhub.pp
- nano src/scripts/server.setup.sh (to edit the config settings for server)
- src/scripts/server.setup.sh (to deploy the config settings for server)

