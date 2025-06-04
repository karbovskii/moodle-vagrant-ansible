# Moodle Vagrant-Ansible Deployment

This project automates the deployment of a Moodle learning management system (LMS) using Vagrant and Ansible. It was developed as part of a university assignment focused on learning concepts related to cloud and shared computing.

## 🧩 Project Goals

* Automate the setup of a Moodle-based infrastructure.
* Demonstrate shared computing using NFS and Memcached.
* Provide a reusable and portable environment for deploying Moodle using Vagrant and Ansible.

## 🏗️ Architecture Overview

The infrastructure includes:

* **2 Moodle web servers** (`webserver1`, `webserver2`)
* **1 Database server** (`dbserver`) with MariaDB and Memcached
* **1 Load balancer** (`loadbalancer`) using HAProxy
* **Shared `moodledata` directory** using NFS

Load balancing and Memcached are configured to persist user sessions and distribute traffic.

## 🔍 Features

* One-click provisioning via Vagrant and a manual `provision.sh` script.
* Moodle is accessible at **[http://192.168.56.13/](http://192.168.56.13/)**
* Memcached test script included to verify session persistence.
* Uses Ansible roles for modular, reusable configuration.

## 📁 Directory Structure

```
.
├── ansible.cfg
├── group_vars/
├── inventory/
├── provision.sh
├── requirements.yml
├── roles/
├── site.yml
└── Vagrantfile
```

## ✅ Requirements

Make sure you have the following installed:

* [Vagrant](https://www.vagrantup.com/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (or compatible provider)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* Git (optional)

## 🚀 Getting Started

Clone the project and bring up the virtual machines:

```bash
git clone https://github.com/yourusername/moodle-vagrant-ansible.git
cd moodle-vagrant-ansible
vagrant up
./provision.sh
```

> 💡 The `provision.sh` script runs the Ansible playbook to configure all VMs.

## 🌐 Accessing Moodle

After provisioning:

* Visit [http://192.168.56.13/](http://192.168.56.13/) in your browser.
* Default admin credentials:

  * **Username:** `admin`
  * **Password:** `Admin123!`

## 🧪 Testing Memcached

To verify Memcached session persistence and load balancing:

1. Visit [http://192.168.56.13/moodle/test\_memcached.php](http://192.168.56.13/moodle/test_memcached.php)
2. Refresh repeatedly. You should see:

   * Output alternating between `webserver1` and `webserver2`
   * A session counter incrementing with each refresh

## 🧩 Technologies Used

* **Ansible**: Provisioning and configuration management
* **Vagrant**: Virtual machine orchestration
* **Moodle**: LMS platform
* **HAProxy**: Load balancing
* **Memcached**: Session storage
* **NFS**: Shared file storage for `moodledata`

## 📚 License

This project was developed for educational purposes as part of a university assignment.
