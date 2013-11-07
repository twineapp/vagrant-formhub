class python 
{      

    package { 'python':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    package { 'python-pip':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    package { 'python-setuptools':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }

    package { 'python-numpy':
	ensure	    => present,
	require	    => Exec['apt-get update']
    }

    package { 'python-scipy':
	ensure	    => present,
	require	    => [Exec['apt-get update'], Package['python-numpy']]
    }

}
