class nodejs
{
    package 
    { 
        "python-software-properties":
            ensure  => present,
            require => [ Exec['apt-get update'] ]
    }

    exec 
    { 
        'add-apt-repo-node':
            command => 'add-apt-repository -y ppa:chris-lea/node.js ; apt-get update',
            require => [    Package['python-software-properties'] ]
    }

    package 
    { 
        "nodejs":
            ensure  => present,
            require => [ Exec['apt-get update'], Exec['add-apt-repo-node'] ]
    }

}
