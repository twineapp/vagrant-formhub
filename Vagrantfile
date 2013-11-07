# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define :formhub do |inv_config|
        inv_config.vm.box = "precise64"
        inv_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
        inv_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", 2048, "--cpus", 2]
        end
        inv_config.ssh.max_tries = 360
        
        #inv_config.vm.network :forwarded_port, guest: 22, host: 2223
        #inv_config.vm.network :forwarded_port, guest: 80, host: 8081
        #inv_config.vm.network :forwarded_port, guest: 3306, host: 3316
        config.vm.network :private_network, ip: "192.168.50.5"

        inv_config.vm.hostname = "formhub"
        
        inv_config.vm.synced_folder "../", "/shared_folder/", :extra => "dmode=777,fmode=777"

        inv_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "formhub.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
            #puppet.options = "--verbose"
        end

    end
end
