class other 
{
    package 
    { 
        "curl":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec { 'pecl-oauth-install':
        command => 'pecl install oauth',
        timeout => 3600,
        unless => "pecl info oauth",
        require => [ Package["make"], Package["build-essential"], Package["libpcre3-dev"], Package["php-pear"] ]
    }

    exec 
    { 
        'add-oauth-extension':
            command => 'echo "extension=oauth.so" >> /etc/php5/apache2/php.ini',
            require => Exec['pecl-oauth-install'],
    }

    package 
    { 
        "libpcre3-dev":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec
    {
        "wget-prince":
            command => 'wget http://www.princexml.com/download/prince_8.1-5_ubuntu12.04_amd64.deb -O /tmp/prince_8.1-5_ubuntu12.04_amd64.deb',
            timeout => 3600,
            creates =>  "/tmp/prince_8.1-5_ubuntu12.04_amd64.deb",
    }

    package 
    { 
        "libtiff4":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "libgif4":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "prince":
            provider => dpkg,
            ensure   => present,
            source   => "/tmp/prince_8.1-5_ubuntu12.04_amd64.deb",
            require => [ Package["libtiff4"], Package["libgif4"], Exec['wget-prince'] ]
    }

    package 
    { 
        "make":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "build-essential":
            ensure  => present,
            require => Exec['apt-get update']
    }
}
