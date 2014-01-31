class formhub 
{
    $packages = [
        "default-jre", 
        "gcc",
        "git",
        "python-dev",
        "libjpeg-dev",
        "libfreetype6-dev",
        "zlib1g-dev",
        "rabbitmq-server",
        "libxml2-dev",
        "libxslt1-dev",
        "python-mysqldb",
        "sendmail"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => [ Exec['apt-get update'] ]
    }


    exec 
    { 
        'formhub-setup':
            command => 'nohup /shared_folder/vagrant-formhub/src/scripts/formhub.setup.sh >> /var/log/vagrant_install.log',
            timeout => '0',
            require => [    Package['default-jre'], 
                            Package['gcc'], 
                            Package['git'], 
                            Package['python-dev'], 
                            Package['libjpeg-dev'], 
                            Package['libfreetype6-dev'], 
                            Package['zlib1g-dev'], 
                            Package['rabbitmq-server'],
                            Package['mongodb-10gen'],
                            Package['libxml2-dev'],
                            Package['libxslt1-dev'],
                            Package['python-mysqldb'],
                            Exec['wsgi-setup'],
                            Package['sendmail'] ]
    }

    file 
    { 
        "/etc/apache2/sites-available/default":
            ensure  => present,
            source  => "/shared_folder/vagrant-formhub/puppet/templates/vhost",
            require => [ Package["apache2"] ],
            notify  => Service["apache2"]
    }
}
