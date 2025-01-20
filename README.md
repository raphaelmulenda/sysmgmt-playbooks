# sysmgmt-playbooks
A collection of Ansible playbooks for system management and configuration, designed to automate various administrative tasks across different environments.
markdown

# System Management Playbooks

Welcome to the **System Management Playbooks** repository! This collection is designed to streamline and automate various system administration tasks across multiple Linux servers, enhancing efficiency and reducing manual effort for Sysadmins.

## Overview

This repository contains Ansible playbooks tailored for:

- **Configuration Management**: Standardizing configurations across servers to ensure consistency.
- **Software Deployment**: Automating the installation, updates, and management of software packages.
- **User Management**: Handling user accounts, permissions, and access rights.
- **Security Enhancements**: Implementing security best practices, including firewall rules, SSH configurations, and more.
- **Monitoring Setup**: Configuring monitoring tools to keep track of system health and performance.
- **Backup Solutions**: Automating backup processes to protect data integrity.
- **System Maintenance**: Routine tasks like log rotation, disk cleanup, and system updates.

## Getting Started

### Prerequisites

- **Ansible**: Ensure you have Ansible installed on your control machine. You can install it via:
  ```bash
  sudo apt-get install ansible  # For Debian/Ubuntu
  sudo yum install ansible       # For CentOS/RHEL
  sudo dnf install ansible       # For Fedora


    SSH Access: You need SSH access to the target Linux servers with key-based authentication preferred for security.


Usage

    Clone the Repository:
    bash

    git clone https://github.com/raphaelmulenda/sysmgmt-playbooks.git
    cd sysmgmt-playbooks

    Inventory File: Create or edit the hosts file in the repository to list your servers:
    ini

    [webservers]
    server1 ansible_host=192.168.1.10
    server2 ansible_host=192.168.1.11

    [dbservers]
    db1 ansible_host=192.168.1.20

    Run Playbooks: Execute playbooks using Ansible. For example, to run a playbook for updating all systems:
    bash

    ansible-playbook -i hosts playbooks/update_systems.yml


Playbooks
Here's a brief overview of some of the playbooks available:

    update_systems.yml: Updates all packages on the target servers.
    configure_ssh.yml: Secures SSH configuration across servers.
    setup_users.yml: Manages user accounts, adding or removing users as needed.
    install_monitoring.yml: Installs and configures monitoring tools like Nagios or Prometheus.
    backup_config.yml: Sets up automated backups for critical data.





