class wsgi 
{   
    package 
    { 
        "apache2-dev":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec 
    { 
        'wsgi-setup':
            command => '/shared_folder/vagrant-formhub/src/scripts/wsgi.setup.sh',
            require => [    Package['apache2-dev'] ]
    }
}
