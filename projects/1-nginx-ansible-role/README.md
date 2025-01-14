# Setting Up a Web Server Using Ansible Role

**Create an Ansible role to set up an Nginx web server.**
```bash
mkdir -p roles/nginx/{tasks,handlers,templates,defaults}

# Or fetch a role using ansible galaxy
ansible-galaxy role init nginx 
```

**Run the Playbook**
```bash
ansible-playbook -i inventory.ini site.yml
```
