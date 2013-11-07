class ruby 
{
    $packages = [
        "ruby-full", 
        "rubygems"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => [ Exec['apt-get update'] ]
    }


    exec 
    { 
        'sass-setup':
            command => 'gem install sass',
            require => [    Package['ruby-full'], 
                            Package['rubygems'] ]
    }

  
}
