# Dynamic Configuration Management with Ansible Error Handling

## Prerequisites

1. **Ansible Installed**:
   - Ensure Ansible is installed on your control machine.
   - Check installation with:
     ```bash
     ansible --version
     ```

2. **Target Nodes**:
   - At least two managed nodes (e.g., EC2 instances or local VMs) with passwordless SSH access configured.
   - Verify connectivity with:
     ```bash
     ansible all -m ping -i inventory.ini
     ```

## Explanation of the Playbook

1. **Task 1: Verify Docker Installation**:
   - Checks if Docker is installed.
   - If Docker is not installed, the task fails but execution continues due to `ignore_errors: yes`.

2. **Task 2: Debug Output**:
   - Prints the output of the `docker --version` command for inspection.

3. **Task 3: Conditional Docker Installation**:
   - Installs Docker **only if** the previous task (`docker_check`) failed.
   - The `when: docker_check.failed` condition ensures Docker is installed only when necessary.

4. **Task 4: Post-Installation Verification**:
   - Re-runs `docker --version` to confirm successful installation.

5. **Task 5: Success Message**:
   - Prints a success message if Docker is verified to be installed correctly.

## Execute the Playbook

### Run the Playbook
1. Execute the playbook using:
   ```bash
   ansible-playbook -i inventory.ini error_handling_demo.yml -v
   ```

2. **Expected Output**:
   - If Docker is already installed:
     - Task 1 succeeds.
     - Task 3 is skipped due to the `when` condition.
     - Task 5 confirms Docker installation.
   - If Docker is not installed:
     - Task 1 fails, but is ignored.
     - Task 3 installs Docker.
     - Task 5 confirms successful installation.

## Verification

1. **Check Docker Installation on Target Nodes**:
   - Log in to one of the nodes and run:
     ```bash
     docker --version
     ```
   - Confirm that Docker is installed.

2. **Debug Output Inspection**:
   - Ensure `docker_check` and `post_install_check` outputs show correct statuses.
