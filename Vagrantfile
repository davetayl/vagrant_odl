Vagrant.configure("2") do |config|
  config.vm.define "odl" do |odl|
	odl.vm.box = "centos/7"
	odl.vm.box_version = "1905.1"
	odl.vm.network "private_network", ip: "10.0.0.17", netmask:"255.255.255.0"
	odl.vm.network "forwarded_port", guest: 8101, host: 8101
	odl.vm.network "forwarded_port", guest: 8181, host: 8181
	odl.vm.provision "shell", path: "./provision-odl.sh"
	end
  config.vm.define "mn" do |mn|
	mn.vm.box = "fedora/31-cloud-base"
	mn.vm.box_version = "31.20191023.0"
	mn.vm.network "private_network", ip: "10.0.0.18", netmask:"255.255.255.0"
	mn.vm.provision "shell", path: "./provision-mn.sh"
	end
end