class postgresql 
{
    $packages = [
        "postgresql-9.3-postgis", 
        "pgadmin3",
        "php5-pgsql",
        "phppgadmin"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => [ Exec['apt-get update'], Exec['postgresql-key'], Exec['postgresql-repo'] ]
    }

    exec 
    { 
        'postgresql-key':
            command => 'wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -',
    }
    
    exec 
    { 
        'postgresql-repo':
            command => 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list',
            require => Exec['postgresql-key'],
            notify  => Exec['apt-get update']
    }

    exec 
    { 
        'postgresql-setup':
            command => '/shared_folder/vagrant-formhub/src/scripts/postgresql.setup.sh',
            require => [ Package['postgresql-9.3-postgis'], Package['phppgadmin'] ]
    }  
}
