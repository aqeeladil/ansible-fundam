# Creating two Ec2-Ubuntu machines where one serves as the Ansible_Controller, and the other as Target_node

### AWS-EC2 setup

- Launch two EC2 instances with Ubuntu as the operating system.
- Ensure both instances are in the same region and security group.
- Allow inbound SSH (port 22) from your local machine.
- Ensure both instances can communicate (allow all traffic within the security group).

### Install Ansible:

```bash
sudo apt update
sudo apt install -y ansible
```

### Set up an SSH key-based connection between the controller and target node:

Apply this command in both machines.
```bash
ssh-keygen
```
Copy the Public Key of the Controller_Node (```.ssh/id_rsa.pub```) to the Target_Node (```.ssh/authorized_keys```). But if ```ssh-copy-id``` is unavailable, you can manually add the Public key.
```bash
ssh-copy-id ubuntu@<Target_Node_IP>
```
Establish SSH connection.
```bash
ssh ubuntu@<Target_Node_IP>
```

### Install and configure Apache service and serve an html page using ansible-playbook:

Run a ping command to verify Ansible can reach the target node. A successful connection returns pong.
```bash
ansible -i inventory.ini webservers -m ping
```
Run the Playbook
```bash
ansible-playbook -i inventory.ini my_playbook.yml
```
Verify the configuration. Open a browser and enter the public IP of the managed node.
```bash
http://<Target_Node_IP>
```
You should see a webpage with the text: ```Hello World from Ansible Playbook```.

### Create a File on the Target-node using ansible-ad-hoc command.

Create a file named ```ansible_demo.txt``` on the target machine.
```bash
ansible -i inventory.ini webservers -m file -a "path=/home/ubuntu/ansible_demo.txt state=touch"
```
SSH into the target machine and check if the file was created.
```bash
ssh ubuntu@<Target_Node_IP>
ls /home/ubuntu/ansible_demo.txt
```