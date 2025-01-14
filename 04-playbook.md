# Ansible Playbook 

An Ansible Playbook is a YAML file that contains a series of instructions (tasks) to configure remote systems.

**Why YAML?**

- Preferred for its readability and simplicity.

- Standardized, unlike plain text files.

- Easy to use compared to JSON.

Example:

```yaml
---
name: "Aqeel"
age: 26
is_working: true
tasks:
  - learn devops
  - exercise
address:
  street: "Main Expressway"
  city: "Islamabad"
```

## Playbooks and Plays

**Playbook:** A collection of one or more plays.

**Play:** A set of tasks to execute on a specific group of hosts. Each play has:

- *Hosts:* Target machines where tasks will run.

- *Remote User:* The user running the tasks.

- *Tasks:* List of actions to perform.

**Example**

```yaml
---
- name: Deploy Apache and Web Page
  hosts: all
  become: true       # Escalate privileges to root
  tasks:
    - name: Update apt cache
      ansible.builtin.apt:
        update_cache: yes

    - name: Install Apache
      ansible.builtin.apt:
        name: apache2
        state: present

    - name: Copy web page to Apache directory
      ansible.builtin.copy:
        src: index.html
        dest: /var/www/html/index.html

    - name: Start and enable Apache service
      ansible.builtin.service:
        name: apache2
        state: started
        enabled: true
```

## Tasks and Modules

**Task:** A task is a single action to perform on a host, like installing software or copying files.

**Module:** A reusable unit of code to perform specific tasks (e.g., apt for installing packages or copy for copying files).

**Common Modules**

- `apt`: Manages packages on Debian-based systems.
- `yum`: Manages packages on RHEL-based systems.
- `copy`: Copies files to remote machines.
- `service`: Manages services like starting or stopping them.

**Examples:**

Install Apache using the apt module:
```yaml
---
- name: Install Apache
  ansible.builtin.apt:
    name: apache2
    state: present
```

## Advanced Concepts

**Variables:** Use variables to make Playbooks reusable. Then, reference it in tasks.

```yaml
---
vars:
  apache_package: apache2

tasks:
    - name: Install Apache
      ansible.builtin.apt:
        name: "{{ apache_package }}"
        state: present
```

**Conditional Tasks:** Run tasks only if specific conditions are met.

```yaml
---
    - name: Install Apache only if not already installed
      ansible.builtin.apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"
```

**Handlers:** Define actions that run only when triggered.

```yaml
---
    - name: Restart Apache
      ansible.builtin.service:
        name: apache2
        state: restarted
  notify: Restart Apache
handlers:
  - name: Restart Apache
    ansible.builtin.service:
      name: apache2
      state: restarted
```