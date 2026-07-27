## 1. Login into your server via SSH
Open your local terminal and log into your server (whether it's your Ubuntu Mini PC or your Contabo VPS)

```bash
ssh root@YOUR_SERVER_IP
```

## 2. Install ```cloudflared``` on your server
Run these commands in your server terminal to install the official Cloudflare tunnel software:

Setup Environment: Choose your operating system to get installation instructions.

- Debian : Architecture: ```64bit``` For this follow by your OS System

```bash
# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# install cloudflared
sudo apt-get update && sudo apt-get install cloudflared
```

- Install as service

```bash
sudo cloudflared service install eyJhIjoiOWEwY2ViOWJlYzg5YTUxNjYzODdiZjg3NzlmNDA4YTkiLCJ0IjoiZTBkNjhjOGItZDk3OS00NjJjLThmYTUtNjdjZjQ1YzUwMjMyIiwicyI6Ik5HSmhORGRtTkRJdFpUSTFNaTAwTXp
```

## 3. Create the Ingress Configuration File
For this path a separate 2 files of add Route demo:

Select the type of route you want to add to this tunnel: Published Applications
- eroxii.com: for ```Frontend``` : Service URL -> exampel demo http://localhost:80
- api.eroxii.com: for ```Backend``` : Service URL -> exampel demo http://localhost:80
- and use with reverse proxy

## 4. Install Nginx on Your Mini PC
If you haven't installed Nginx on your server yet, run this in your terminal:

```bash
sudo apt update
sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### 4.1 Check status nginx

```bash
sudo systemctl status nginx
```

## 5. Create the Nginx Configuration Files
You will create two separate server configuration blocks in Nginx—one for your frontend and one for your backend API
### 5.1. Create a configuration file for your main domain (eroxiichoubo.com):

```bash
sudo nano /etc/nginx/sites-available/eroxiichoubo.com
```

Paste the following configuration for your Frontend:

```bash
server {
    listen 80;
    server_name eroxii.com;

    # Point this to where your built frontend files will live
    root /var/www/eroxii/dist;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 5.2. Create a second configuration file for your backend subdomain (api.eroxii.com)

```bash
sudo nano /etc/nginx/sites-available/api.eroxii.com
```

Paste this configuration (replace api_your_app_name with your actual app name and the port your backend uses):

```bash
server {
    listen 80;
    server_name api.eroxii.com;

    location / {
        proxy_pass http://localhost:8001; # Change 8001 to your backend port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```
### 5.3. Enable the Sites and Restart Nginx
Activate both configuration files by creating symbolic links to sites-enabled:
```bash
sudo ln -s /etc/nginx/sites-available/eroxiichoubo.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/api.eroxiichoubo.com /etc/nginx/sites-enabled/
```

### 5.4. Create the directories for your frontend app

```bash
sudo mkdir -p /var/www/eroxii/dist
```

#### 5.4.1. Quick Fixes depending on what you find:
If the folder is empty or missing: Build your frontend project and copy or upload the built files into /var/www/eroxiichoubo/dist.

If permission is denied: Give Nginx permission to read the folder:

```bash
sudo chown -R www-data:www-data /var/www/eroxii
sudo chmod -R 755 /var/www/eroxii
```

#### 5.4.2. Test your Nginx configuration for syntax errors:

```bash
sudo nginx -t
```
If it says syntax is ok and test is successful, reload Nginx to apply the changes:

```bash
sudo systemctl reload nginx
```