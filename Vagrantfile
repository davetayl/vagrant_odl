Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_version = "1905.1"
  config.vm.network "forwarded_port", guest: 8101, host: 8101
  config.vm.network "forwarded_port", guest: 8181, host: 8181
  config.vm.provision "shell", path: "./provision.sh"
end