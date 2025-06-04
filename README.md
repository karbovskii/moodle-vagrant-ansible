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

## 🏗️ Architecture Diagram

The diagram below illustrates the key components and data flow in the Moodle infrastructure deployed by this project:

```mermaid
graph LR
    %% Define nodes with GitHub dark/light mode optimized styling
    U["👥<br/><b>Users</b>"]
    LB["⚖️<br/><b>Load Balancer</b><br/>HAProxy"]
    
    %% Web servers positioned to minimize arrow crossing
    subgraph WS_GROUP["🌐 <b>Web Server Cluster</b>"]
        direction TB
        WS1["<b>Web Server 1</b><br/>Moodle + PHP"]
        WS2["<b>Web Server 2</b><br/>Moodle + PHP"]
    end
    
    %% Data Server components with clear positioning
    subgraph DS["🖥️ <b>Data Server Machine</b>"]
        direction TB
        DB[("💾<br/><b>MariaDB</b><br/>Database")]
        MC["⚡<br/><b>Memcached</b><br/>Cache Layer"]
        NFS["📁<br/><b>NFS Server</b><br/>File Storage"]
    end

    %% Main traffic flow with enhanced labels
    U -->|"🌐 <b>HTTP/HTTPS</b><br/>User Requests"| LB
    LB -->|"⚡ <b>Load Balanced</b><br/>Traffic Distribution"| WS_GROUP
    
    %% Database connections with enhanced styling
    WS1 -->|"🔵 <b>SQL Queries</b><br/>Data Operations"| DB
    WS2 -->|"🔵 <b>SQL Queries</b><br/>Data Operations"| DB
    
    %% Cache connections with enhanced styling
    WS1 -->|"🟣 <b>Cache R/W</b><br/>Session Storage"| MC
    WS2 -->|"🟣 <b>Cache R/W</b><br/>Session Storage"| MC
    
    %% File storage connections (dashed for NFS)
    WS1 -.->|"🟠 <b>NFS Mount</b><br/>File Operations"| NFS
    WS2 -.->|"🟠 <b>NFS Mount</b><br/>File Operations"| NFS

    %% Enhanced styling optimized for both GitHub light and dark modes
    classDef userClass fill:#4A90E2,stroke:#2E5BBA,stroke-width:3px,color:#FFFFFF
    classDef loadBalancerClass fill:#F39C12,stroke:#D68910,stroke-width:3px,color:#FFFFFF
    classDef webserverClass fill:#27AE60,stroke:#1E8449,stroke-width:3px,color:#FFFFFF
    classDef databaseClass fill:#E74C3C,stroke:#C0392B,stroke-width:3px,color:#FFFFFF
    classDef cacheClass fill:#9B59B6,stroke:#7D3C98,stroke-width:3px,color:#FFFFFF
    classDef storageClass fill:#E67E22,stroke:#CA6F1E,stroke-width:3px,color:#FFFFFF
    classDef groupClass fill:#34495E,stroke:#2C3E50,stroke-width:2px,color:#FFFFFF,stroke-dasharray: 5 5

    %% Apply enhanced styling
    class U userClass
    class LB loadBalancerClass
    class WS1,WS2 webserverClass
    class DB databaseClass
    class MC cacheClass
    class NFS storageClass
    class DS,WS_GROUP groupClass
```

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
