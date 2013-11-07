# Default path
Exec 
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec 
{ 
    'apt-get update':
        command => '/usr/bin/apt-get update'
}

#uncomment the imports below only if running the puppets outside vagrant
/*
import "/shared_folder/vagrant-formhub/puppet/modules/bootstrap/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/other/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/apache/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/php/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/postgresql/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/ruby/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/nodejs/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/formhub/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/enketo/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/mysql/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/phpmyadmin/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/mongo/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/python/manifests/init.pp"
import "/shared_folder/vagrant-formhub/puppet/modules/wsgi/manifests/init.pp"
*/

include bootstrap
include other
include apache
include php
include postgresql
include ruby
include nodejs
include formhub
include enketo
include mysql
include phpmyadmin
include mongo
include python
include wsgi

exec 
{ 
    'service apache2 reload':
        command => 'service apache2 reload',
        require => [ Exec["add-oauth-extension"], Exec["add-mongo-extension"] ]
}
