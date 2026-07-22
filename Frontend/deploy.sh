#!/bin/bash
echo "Building frontend..."
npm run build

echo "Uploading files to server..."
scp -r dist minipc@100.119.121.108:/home/minipc/

echo "Deploying on server..."
ssh minipc@100.119.121.108 "sudo rm -rf /var/www/student-app/* && sudo cp -r ~/dist/* /var/www/student-app/ && rm -rf ~/dist && sudo systemctl restart nginx"

echo "Deployment completed successfully!"