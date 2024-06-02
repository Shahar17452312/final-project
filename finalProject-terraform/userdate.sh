#!/bin/bash
### check path version if not changed !
echo "fixing path"
export PATH=$PATH:/root/.nvm/versions/node/v18.20.3/bin

# Start the backend service
cd /opt/clouds-finalProject/backend/
nohup npm start &

### Fetch the public IP address of the server
PUBLIC_IP="${lb_dns_name}"
### Create the .env file with the public IP address
echo "PUBLIC_IP=$PUBLIC_IP" > /opt/clouds-finalProject/frontend/.env

# Start the frontend service
cd /opt/clouds-finalProject/frontend/
npm run build
nohup serve -s build &

# nohup is to avoid the process being killed when the terminal is stoped
