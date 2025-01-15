# Error Handling in Ansible Playbooks

## Introduction
Error handling in Ansible allows you to manage and control how your playbooks behave when tasks fail.

---

## 1. Ansible Task Execution Flow

### Default Behavior
- **Sequential Execution**: Tasks in a playbook are executed sequentially across all managed nodes.
- **Failure Handling**: If a task fails on a node, Ansible skips subsequent tasks for that node.

### Example:
```yaml
- name: Example Task 1
  ansible.builtin.command: some_command

- name: Example Task 2
  ansible.builtin.command: another_command
```
If `Task 1` fails on `Node 1`, `Task 2` will not execute on `Node 1` but may still execute on other nodes.

---

## 2. Error Handling Techniques

### 2.1 `ignore_errors`
- **Purpose**: Allows the playbook to continue execution even if a task fails.
- **Syntax**:
  ```yaml
  - name: Example Task
    ansible.builtin.command:
      cmd: some_command
    ignore_errors: yes
  ```
- **Behavior**: If the task fails, it prints a warning but continues to the next task.

#### Example:
```yaml
- name: Verify if Docker is installed
  ansible.builtin.command: docker --version
  ignore_errors: yes
```

---

### 2.2 `register` and `when`
- **Purpose**: Captures the output of a task in a variable and adds conditions for subsequent tasks.
- **Example**:
```yaml
- name: Verify if Docker is installed
  ansible.builtin.command: docker --version
  register: docker_check
  ignore_errors: yes

- name: Install Docker if not installed
  ansible.builtin.apt:
    name: docker.io
    state: present
  when: docker_check.failed
```

---

### 2.3 `failed_when`
- **Purpose**: Customizes the failure criteria for a task based on its output.
- **Syntax**:
  ```yaml
  - name: Custom failure criteria
    ansible.builtin.command: ls /nonexistent_folder
    register: command_result
    failed_when: "'No such file' not in command_result.stderr"
  ```
- **Behavior**: The task fails only if the specified condition evaluates to `true`.

---

## 3. Practical Examples

### Scenario 1: Updating Packages Conditionally
**Requirement**: Update `openSSH` and `openSSL` if they exist; skip if they don't.
```yaml
- name: Update openSSH and openSSL if present
  ansible.builtin.apt:
    name: "{{ item }}"
    state: latest
  loop:
    - openssh
    - openssl
  ignore_errors: yes
```

---

### Scenario 2: Install Docker Based on its Presence
**Requirement**: Check if Docker is installed; if not, install it.
```yaml
- name: Verify Docker installation
  ansible.builtin.command: docker --version
  register: docker_status
  ignore_errors: yes

- name: Install Docker if not installed
  ansible.builtin.apt:
    name: docker.io
    state: present
  when: docker_status.failed
```

---

### Scenario 3: Handle Specific Errors
**Requirement**: Ignore errors about "No such file or directory" but fail for permission issues.
```yaml
- name: Check for a directory
  ansible.builtin.command: ls /path/to/check
  register: check_result
  failed_when: "'No such file' not in check_result.stderr"
```

---

## 4. Advanced Concepts

### Handling Multiple Conditions
Combine multiple conditions in `when` or `failed_when`.
```yaml
- name: Install Docker only if missing
  ansible.builtin.apt:
    name: docker.io
    state: present
  when: docker_status.failed and "'Docker' not in docker_status.stdout"
```

### Defining Failure Globally
Define failure conditions for specific tasks globally in your playbook or roles for better maintainability.

---

## 5. Debugging: 
- Use the `debug` module to inspect variables or outputs.
  ```yaml
  - name: Debug task output
    ansible.builtin.debug:
      var: docker_status
  ```
  
---

