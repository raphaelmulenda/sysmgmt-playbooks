# Harbor Setup with Ansible

This project sets up Harbor, an open-source container registry, using Ansible.

## Instructions for Execution

To execute specific steps of the Harbor setup, use the `--tags` option with the `ansible-playbook` command. Below are the available tags and their corresponding commands:

- **Ping the target host**:
  ```bash
  ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_ping" -v

  Download Harbor package:
bash

ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_download_harbor" -v

Install Harbor package:
ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_install_harbor" -v

Expose Harbor service ports:
bash

ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_expose_harbor" -v

Stop Harbor service:
bash

ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_stop_harbor" -v

Start Harbor service:
bash

ansible-playbook linux_setup_harbor.yml -i inventory/hosts --tags "linux_start_harbor" -v

Run the full setup (excluding stop):
To run the full setup without stopping the Harbor service, comment out or remove the linux_stop_harbor tag in the main.yml file under roles/harbor/tasks/ and execute:
bash

    ansible-playbook linux_setup_harbor.yml -i inventory/hosts


Validation
After running the playbook, validate the Harbor service by checking the running Docker containers:

bash

docker ps


Login to the Harbor registry using the Docker CLI:

bash

docker login linuxser.stack.com
Username: admin
Password: Harbor12345


in case of my docker server 
docker login 192.168.1.27
Username: admin
Password: Harbor12345


Access the Harbor portal via the web browser:

    URL: https://linuxser.stack.com/
    Username: admin
    Password: Harbor12345

URL: https://192.168.1.27/
Username: admin
Password: Harbor12345

Note: Update the default credentials in a production environment.

Test Environment

    Fedora 41 server
    Docker version 27.3.1
    Docker Compose version v2.29.7


---

#### 5. **`roles/harbor/defaults/main.yml`**
- **Location**: `harbor/roles/harbor/defaults/main.yml`
- **Content** (Copy the following into the file):
```yaml
---
harbor_http_port: "80"
harbor_https_port: "443"
harbor_trustservice_port: "4443"


