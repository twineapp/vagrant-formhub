class enketo 
{      

    package { 'php5-xsl':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    package { 'libapache2-mod-auth-mysql':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    exec 
    { 
        'enketo-setup':
            command => 'nohup /shared_folder/vagrant-formhub/src/scripts/enketo.setup.sh >> /var/log/vagrant_install.log',
            timeout => '0',
            require => [    Package['php5-xsl'], 
                            Package['libapache2-mod-auth-mysql'],
                            Exec[set-mysql-password],
                            Package['nodejs'], 
                            Package['ruby-full'], 
                            Package['rubygems'] ]
    }

}
