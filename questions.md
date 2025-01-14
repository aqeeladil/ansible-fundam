# Important Interview Questions

## 1. What is the programming language that ansible uses?

- Ansible primarily uses **YAML** (YAML Ain't Markup Language) for its playbooks, which define automation tasks in a readable and structured format. YAML is not a programming language but a data serialization language that makes writing and reading configurations straightforward.

- Ansible itself is written in **Python**, and it allows you to write custom modules, plugins, and logic in Python if needed. Python also enables you to extend Ansible’s functionality when the built-in modules don’t meet specific needs.

## 2. Does Ansible supports linux and windows? What is the protocol ansible uses to connect to windows and linux vms? 

- While Ansible works natively and seamlessly with Linux, it can manage Windows systems with some configuration adjustments, making it versatile for mixed-environment infrastructures.

- Linux hosts can be managed via ```SSH```, which Ansible uses to communicate and execute commands without requiring any additional agent software.

- Ansible also supports Windows, though it requires some specific configurations to work effectively. For Windows hosts, Ansible uses ```WinRM``` (Windows Remote Management) instead of SSH to communicate with the target machines. Windows support requires additional modules, such as win_* modules (like win_service for managing services or win_user for user management), which are specifically designed for Windows operations.

## 3. Does Ansible follows push or pull mechansim?

- Ansible follows a push-based mechanism.

- In a push-based system, the Ansible control node (where Ansible is installed) initiates the connection to the managed nodes (target machines) and pushes out configurations, commands, or tasks directly. This is done over SSH for Linux systems and WinRM for Windows systems, without needing an agent on the target machines.

- Ansible's push model makes it ideal for ad-hoc tasks and on-demand automation but can be configured to mimic a pull-based system using tools like Ansible Tower/AWX for scheduled jobs, though it remains inherently push-based.

## 4. Push vs. Pull in Ansible:

- **Push-based:** Ansible is agentless and does not require any software to be installed on the target nodes. The control node initiates all actions, so there’s no need for managed nodes to "pull" updates or configurations.

- **Pull-based:** Some other configuration management tools like Puppet follow a pull-based model where agents on each node periodically pull configurations from a central server.

## 5. Does ansible supports all cloud platforms?

For Ansible, it generally doesn't matter where the remote instance (or target node) is hosted, whether it’s on a cloud platform (like AWS, Azure, or Google Cloud), in an on-premises data center, or in a hybrid environment. 

Ansible primarily requires:

- **Network Connectivity:** The Ansible control node needs to access the remote target node’s IP address (usually a public IP for cloud instances or private IP if within a private network).

- **Connection Protocol:**

  - SSH for Linux-based systems (usually with a valid SSH key or credentials for secure access).

  - WinRM for Windows systems (along with proper authentication configuration).

## 6. Ansible playbook to install httpd service and get it running.

Here's a simple Ansible playbook (```install_httpd.yml```) to install and start the httpd service on a target machine (assuming a Red Hat/CentOS-based distribution):

```yaml 
---
- name: Install and start httpd service
  hosts: all
  become: true

  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present

    - name: Ensure httpd service is running and enabled
      service:
        name: httpd
        state: started
        enabled: true
```
```bash
ansible-playbook -i your_inventory_file install_httpd.yml
```

## 7. How ansible helped your organization?

Ansible helped our organization by automating repetitive deployment and configuration tasks, which reduced setup time by over 50% and ensured consistent server configurations across environments. 

It enabled faster scaling by simplifying new server setups and improved our disaster recovery process by providing reliable, documented configurations. This saved our team time, minimized errors, and increased overall productivity.

- Reduced Deployment Time

- Enhanced Consistency

- Improved Scalability and Flexibility

- Better Team Productivity

- Enhanced Disaster Recovery and Rollback

## 8. Ansible Tower

Ansible Tower is an enterprise-grade UI and REST API for managing Ansible projects, designed by Red Hat. It provides a visual interface to run, monitor, and schedule Ansible playbooks, along with role-based access control, centralized logging, and enhanced security features. 

Tower is particularly useful in complex, multi-user environments where teams need better control and visibility.

- Centralized Management

- Role-Based Access Control (RBAC)

- Job Scheduling

- Real-Time Monitoring and Notifications

- API-Driven

**Have I Used It?**

- Yes, I have used Ansible Tower in a team setting. We used it to centralize our Ansible operations, enabling non-technical team members to trigger playbooks and monitor runs without needing to use the command line. This made workflows more accessible, streamlined role-based access, and improved accountability with centralized logging, helping our organization manage infrastructure changes more effectively and securely.

## 9. How do you manage the RBAC of users for Ansible Tower? 

In Ansible Tower, Role-Based Access Control (RBAC) is managed by assigning roles to users or teams at different levels: (organization, project, inventory, job template, etc).

1. Users and Teams: Add users individually or group them into teams for easier role assignment.

2. Role Assignment: 
    
    - Each user or team can be assigned specific roles such as Admin, Read, Execute, etc., at various levels.

    - Roles can be granted for organizations, projects, inventories, job templates, and workflows.

3. Granular Permissions: 

    - Use custom roles to set specific permissions tailored to a user's needs, such as allowing job execution without edit permissions.

    - Control access tightly, ensuring users only interact with resources necessary for their role.

4. Auditing: Monitor permissions and access activities in Ansible Tower’s audit logs to keep track of changes and access.

## 10. What are Handlers in ansible and why are they used? 

```handlers/```: Contains handlers, which are special tasks that are triggered only when notified by other tasks. These are often used to restart services or perform actions only when there’s a change in the system (e.g., restarting a service after a configuration file is updated.
).

**Why Handlers Are Used:**

- Efficiency: Handlers help prevent unnecessary tasks from running. For example, if a configuration file is modified, only a service restart handler will be triggered, instead of restarting the service multiple times during the playbook execution.

- Optimization: By notifying handlers only when needed, it reduces redundant operations and ensures that resources are used efficiently.

**Example:** Here’s an example where a handler is used to restart the ```httpd``` service after modifying the Apache configuration:

```yaml
---
- name: Configure Apache server
  hosts: webservers
  become: true

  tasks:
    - name: Install Apache
      yum:
        name: httpd
        state: present
      notify:
        - restart apache

    - name: Update Apache configuration
      template:
        src: /path/to/apache.conf.j2
        dest: /etc/httpd/conf/httpd.conf
      notify:
        - restart apache

  handlers:
    - name: restart apache
      service:
        name: httpd
        state: restarted
```

## 11. In Ansible, I would like to run a specific set of tasks only on windows vms and not on linux vm. is it possible?? 

- Yes, it is possible to run specific tasks only on Windows VMs (and not on Linux VMs) in Ansible. You can achieve this using conditional statements or `when` clauses in your playbook to check the operating system of the target hosts.

- Ansible can detect the operating system of the target system using the `ansible_facts` gathered during playbook execution. The `ansible_facts` include details about the system, such as its OS type, distribution, and version.

**Example-1:**

```yaml
---
- name: Run tasks on Windows VMs only
  hosts: all
  gather_facts: true  # Ensures facts are gathered, including OS type

  tasks:
    - name: Install IIS on Windows
      win_feature:
        name: Web-Server
        state: present
      when: ansible_os_family == "Windows"  # Only run on Windows VMs

    - name: Install Apache on Linux
      yum:
        name: httpd
        state: present
      when: ansible_os_family == "Linux"  # Only run on Linux VMs
```
**Example-2:**
```yaml
---
- name: Run tasks on Windows VMs
  hosts: windows_vms
  gather_facts: true

  tasks:
    - name: Install IIS on Windows
      win_feature:
        name: Web-Server
        state: present

- name: Run tasks on Linux VMs
  hosts: linux_vms
  gather_facts: true

  tasks:
    - name: Install Apache on Linux
      yum:
        name: httpd
        state: present
```

## 12. Does ansible supports parallel execution of tasks?? 

Yes, Ansible supports parallel execution of tasks across multiple hosts. This is one of the key features of Ansible, as it allows you to automate tasks on a large number of systems simultaneously.

- **Multi-Host Execution:** Ansible can execute tasks on multiple hosts concurrently by default. If you specify a group of hosts in the hosts section of your playbook, Ansible will run the tasks in parallel on those hosts, subject to the forks setting.

- **Forks:** You can control the level of parallelism in Ansible using the forks setting. The forks value determines how many tasks can be executed in parallel.

By default, Ansible executes tasks sequentially, one task at a time, on one host at a time. However, you can increase the number of parallel executions by setting the forks parameter.

**Ansible Configuration File** (```ansible.cfg```):
  ```ini
  [defaults]
  forks = 10  # Number of parallel tasks
  ```

OR (**Using the Command Line**): `ansible-playbook -f 10 my_playbook.yml`

## 13. How do you handle secrets in ansible?? 

In Ansible, secrets are typically handled using Ansible Vault. Ansible Vault allows you to encrypt sensitive data, such as passwords and API keys, so that they can be securely stored in playbooks and variables files.

Ansible Vault ensures that secrets are encrypted at rest and decrypted only when needed, keeping them secure in version control.

- **Encrypt the secrets:** 
  - Use `ansible-vault encrypt <file>` to encrypt files containing secrets. You can also encrypt individual variables within a YAML file.

- **Decrypt during playbook run:**
  - When running a playbook, use `--ask-vault-pass` (or ```--vault-password-file <file>```) to provide the decryption password.

- **Access the encrypted variables:** 
  - Encrypted variables are decrypted automatically during the playbook execution, allowing secure access to the secrets.

- **Edit secrets:** Use ```ansible-vault edit <file>``` to securely modify the encrypted file contents.

## 14. Can you talk about an Ansible Playbook that you wrote and how it helped your company? 

- In a recent project, I developed an Ansible playbook to automate the deployment and configuration of our Django application across multiple environments. The playbook handled tasks like setting up dependencies, configuring the web server (Nginx), and setting environment variables.

- This automation reduced deployment time from several hours to under 30 minutes, minimized manual errors, and allowed our team to perform consistent, reliable deployments. It also helped us streamline rollbacks during updates, which was critical for maintaining high availability in our production environment. This efficiency boost enabled the team to focus more on new features rather than repetitive deployment tasks.

This playbook installs Nginx, starts the service, and sets up a custom homepage Ubuntu machine.

```yaml
---
- name: Simple Nginx Setup
  hosts: web_servers
  become: true
  vars:
    homepage_content: "Welcome to My Nginx Server!"

  tasks:
    - name: Update and upgrade apt packages
      apt:
        update_cache: yes
        upgrade: dist

    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Create a custom index.html page
      copy:
        dest: /var/www/html/index.html
        content: "{{ homepage_content }}"

    - name: Allow Nginx through UFW firewall
      ufw:
        rule: allow
        port: '80'
        proto: tcp
```











