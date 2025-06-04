Vagrant.configure("2") do |config|
    # Global base box
    config.vm.box = "ubuntu/jammy64"
    # Increase graceful shutdown timeout to 120 seconds
    config.vm.graceful_halt_timeout = 120

    # Webserver 1 (ws1)
    config.vm.define "webserver1" do |web|
        web.vm.hostname = "webserver1"
        web.vm.network "private_network", ip: "192.168.56.10"

        web.vm.provider "virtualbox" do |vb|
            vb.memory = 1024
        end
    end

    # Webserver 2 (ws2)
    config.vm.define "webserver2" do |web2|
        web2.vm.hostname = "webserver2"
        web2.vm.network "private_network", ip: "192.168.56.12"

        web2.vm.provider "virtualbox" do |vb|
            vb.memory = 1024
        end

        web2.vm.provision "shell", inline: <<-SHELL
        ip link set enp0s8 up || true
        dhclient enp0s8 || true
        SHELL
    end

    # DB Server
    config.vm.define "dbserver" do |db|
        db.vm.hostname = "dbserver"
        db.vm.network "private_network", ip: "192.168.56.11"

        db.vm.provider "virtualbox" do |vb|
            vb.memory = 1024
        end
    end

    # Load Balancer
    config.vm.define "loadbalancer" do |lb|
        lb.vm.hostname = "loadbalancer"
        lb.vm.network "private_network", ip: "192.168.56.13"

        lb.vm.provider "virtualbox" do |vb|
            vb.memory = 512
        end
    end

    # === Global Ansible Provisioning ===
    # config.vm.provision "ansible" do |ansible|
    #     ansible.playbook = "site.yml"
    #     ansible.inventory_path = "inventory/inventory.ini"
    #     ansible.compatibility_mode = "2.0" # Avoid fallback warning
    # end
end
