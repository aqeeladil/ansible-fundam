# Setting Up a Web Server Using Ansible Role

**Create an Ansible role to set up an Nginx web server.**
```bash
mkdir -p nginx/{tasks,handlers,templates,files,vars,defaults,meta} && touch nginx/README.md
```

**Run the Playbook**
```bash
ansible-playbook -i inventory.ini site.yml
```
