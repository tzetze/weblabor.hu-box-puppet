VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/wheezy64"
  config.vm.network "private_network", :ip => "192.168.3.1"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
  end
end