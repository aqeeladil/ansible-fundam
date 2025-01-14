# Ansible Roles

Ansible Roles are a way to organize and structure Ansible Playbooks for better readability, modularity, and reuse.

They are used when:

- A Playbook becomes too long or complex (e.g., 50+ tasks).

- Multiple teams need to share common configurations.

- You want to break down configurations into logical components.

Ansible Roles break a Playbook into multiple parts and organize them into separate directories. This modular structure makes it easier to manage large-scale automation tasks.

## Key Advantages of Ansible Roles

- **Readability:** Splitting tasks, variables, handlers, etc., into separate files and directories makes it easier to understand and maintain.

- **Modularity:** Each role focuses on one specific function (e.g., installing a web server).

- **Reusability:** Roles can be shared within teams or downloaded from Ansible Galaxy, a marketplace for roles.

- **Scalability:** It simplifies managing large automation projects, such as Kubernetes setups or database installations.

## Ansible Role Structure

When you create a role (using the command `ansible-galaxy role init <role_name>`), the following directory structure is generated:

```bash
<role_name>/
  ├── defaults/
  │   └── main.yml
  ├── files/
  ├── handlers/
  │   └── main.yml
  ├── meta/
  │   └── main.yml
  ├── tasks/
  │   └── main.yml
  ├── templates/
  ├── vars/
      └── main.yml
```

- `tasks/`: Contains the main task file (main.yml) where tasks are defined.

- `vars/`: Stores variables specific to the role.

- `defaults/`: Contains default values for variables.

- `handlers/`: Defines handlers that can be triggered during the play execution.

- `meta/`: Stores metadata about the role, like dependencies.

- `files/`: For static files to be copied to the target machine.

- `templates/`: For dynamic files that use Jinja2 templating.

- `tests/`: Optional folder for testing the role.

## Difference Between Playbooks and Roles

```bash
Aspect	        Playbooks	                Roles

Structure	    All tasks in one YAML file	Tasks split into separate folders/files
Readability	    Decreases with complexity	Easier to read and manage
Sharing	        Not easily shareable	    Can be shared via Ansible Galaxy
Modularity	    Limited	                    High
```

## Example: Web Server Role

```bash
# Scenario: A Playbook installs Apache and deploys a static website.

# Create the role: 
ansible-galaxy role init webserver.

# Move the tasks into roles/webserver/tasks/main.yml.

# Place static files (e.g., index.html) into roles/webserver/files/.

# Reference the role in the Playbook.

# Run the Playbook.
ansible-playbook -i inventory_file playbook.yml
```

## Advanced Role Management with Ansible Galaxy

```bash
# Downloading Roles:
ansible-galaxy install username.role_name

# Uploading Roles:
ansible-galaxy role init my_role
ansible-galaxy login
ansible-galaxy role publish my_role/

# Role Dependencies:
Use `meta/main.yml` to specify dependent roles.
```

