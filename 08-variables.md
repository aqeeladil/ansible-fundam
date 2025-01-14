## Ansible Variables

Variables in Ansible help make Playbooks reusable by avoiding hardcoding values. For example, instead of hardcoding `instance_type`, use a variable.

Ansible supports defining variables in multiple locations, but the most common are:

1. **Defaults (defaults/main.yml)**

  - Used to set default values for variables. Lowest priority.

  - Example: `instance_type: t2.micro`

2. **Vars (vars/main.yml)**

  - Overrides defaults. Higher priority.

  - Example: `instance_type: t2.medium`

3. **Group Vars (group_vars/)**

  - Used to define variables specific to groups of hosts defined in the inventory file.

4. **Extra Vars (--extra-vars)**

  - Passed via the command line during execution and have the highest priority.

  - Example: `ansible-playbook ec2_create.yml --extra-vars "instance_type=t2.large"`

### Variable Precedence

When variables are defined in multiple places, precedence determines which value is used.

**Precedence Order (Simplified):**

- Extra Vars (--extra-vars) Highest priority.
- Vars (vars/main.yml)
- Group Vars (group_vars)
- Defaults (defaults/main.yml) Lowest priority.

**Example:** If instance_type is defined as:

- t2.micro in defaults/main.yml
- t2.medium in vars/main.yml
- t2.large passed via --extra-vars

The Playbook will use t2.large since extra vars have the highest precedence.