--Part 2--
--Docker Setup with Ansible--
This project uses Ansible to automate the installation and configuration of Docker on an AWS EC2 instance.  
--Steps Performed:--  
1. **Update Packages:** Ensures the server’s software list is up-to-date.  
2. **Install Docker:** Installs Docker from the default package repository.  
3. **Start Docker on Boot:** Ensures Docker starts automatically when the server reboots.  
--How to Run:--  
1. Connect to your server using SSH to test the installation.  
2. Save the Ansible playbook as `docker_setup.yml`.  
3. Run the playbook from your local machine:  
4. After the playbook finishes, connect to the server and verify the Docker installation:  
```bash  
ssh -i "your-key.pem" ubuntu@your-server-ip  
docker --version  

3. Save the file:  
   - Press: `CTRL + X`  
   - Type: `Y` to confirm saving  
   - Press: `Enter`

---

--Step 7: Verify Docker Installation (On Your Server)--

After the playbook finishes running, connect to the EC2 instance to check if Docker was installed successfully!  

1. SSH into the server (from your local machine):  
   ssh -i "your-key.pem" ubuntu@your-server-ip

--part 3--
Docker Container Deployment

Overview

This project automates the deployment of a sample web application in a Docker container on an AWS EC2 instance.

Project Components

Server IP: **.**5.1*8.*1*:8080/ #Ec2 server public ip which you get from aws management console#

Files:

docker_setup.yml: Ansible playbook for Docker setup and deployment

Dockerfile: To containerize the sample web app

index.html: Sample web application file

inventory.ini: Inventory file for server connection

How Did It

1. Writing the Dockerfile

Created a Dockerfile to package our sample web application into a Docker container.

FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 8080

This Dockerfile:

Uses the latest Nginx image

Copies the index.html to the Nginx web directory

Exposes port 8080

2. Automating Deployment with Ansible

Wrote an Ansible playbook (dockersetup.yml) to install Docker, build the Docker image, and run the container.

- name: Setup and Deploy Docker Container
  hosts: all
  become: true
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: true

    - name: Start Docker service
      service:
        name: docker
        state: started
        enabled: true

    - name: Copy index.html to server
      copy:
        src: index.html
        dest: /home/ubuntu/index.html

    - name: Build Docker image
      command: docker build -t my-web-app .

    - name: Run Docker container
      command: docker run -d -p 8080:80 --name web-container my-web-app

3. Running the Automation

Connected to the EC2 instance and ran the Ansible playbook to automate everything.

ansible-playbook -i inventory.ini dockersetup.yml

4. Accessing the Application

After successful deployment, the web application is accessible via the public IP address.

http://18.2*5.**8.**0:8080/

Final Deliverables

Dockerfile

Ansible playbook (dockersetup.yml)

Sample web app (index.html)

Inventory file (inventory.ini)