## Create folder stuent-app

Create the folder  student-app at the root operation system on Ubuntu ```/var/www/ ``` for host web-applications

```bash
sudo mkdir -p /var/www/student-app
```

## Give Nginx ownership and proper read permissions so the web server can access your files safely

```bash
sudo chown -R www-data:www-data /var/www/student-app
sudo chmod -R 755 /var/www/student-app
```

## Configure Nginx on Ubuntu

```bash
sudo nano /etc/nginx/sites-available/student-app
```

## Configuration template

```bash
server {
    listen 80;
    server_name _;

    # Serve your frontend static files
    root /var/www/student-app;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Route API requests to your Node.js backend (running on port 3000)
    location /api/ {
        proxy_pass http://localhost:3000/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## Enable the Site, Test, and Restart Nginx

Enable your configuration by creating a symbolic link to sites-enabled:
```bash
sudo ln -s /etc/nginx/sites-available/student-app /etc/nginx/sites-enabled/
```

```Noted*``` If you have a default site active, you can remove it with sudo rm /etc/nginx/sites-enabled/default to prevent conflicts.

## Test Nginx Again
Run the test command to make sure your new student-app configuration passes without errors:
```bash
sudo nginx -t
```

## Restart Nginx and Launch ngrok
Restart the Nginx service:
```bash
sudo systemctl restart nginx
```

## Building the frontend dist

- open terminal local machine :> mac, window

```bash
npm run build
```

## Transfer the build into your Ubuntu

Use scp to copy the newly generated dist folder from your Mac to your home directory on the Ubuntu server (replace YOUR_UBUNTU_IP with your server's actual IP address):

```bash
scp -r dist minipc@YOUR_UBUNTU_IP:/home/minipc/
```

## Move the Files to the Nginx Web Directory on Ubuntu

SSH into your Ubuntu server from your Mac, window:

```bash
ssh minipc@YOUR_UBUNTU_IP
```

Once connected, run the following commands to move the files into your web server path, clean up the temporary folder, and restart Nginx:

```bash
sudo rm -rf /var/www/student-app/*
sudo cp -r ~/dist/* /var/www/student-app/
rm -rf ~/dist
sudo systemctl restart nginx
```

## Keep Ngrok Running in the Background 
Cuz this remote via ssh with tailscale, So i needs to keep running background :D

To ensure your frontend remains accessible via your ngrok public link even after you close your SSH terminal, run ngrok as a background process using nohup:

```bash
nohup ngrok http 80 > /dev/null 2>&1 &
```


## Check backend container is up running 


```bash
docker logs -f student_api
```