Open your Nginx configuration file (usually located at /etc/nginx/sites-available/default or inside your domain configuration block) and apply these security headers and rules:

```bash
server {
    listen 80;
    server_name my-app.com;

    # 1. HIDE NGINX VERSION (Prevents attackers from knowing your exact software version)
    server_tokens off;

    # 2. SECURITY HEADERS (Protects against XSS, clickjacking, and MIME-sniffing)
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # 3. LIMIT UPLOAD FILE SIZE (Prevents malicious users from crashing your server with massive file uploads)
    client_max_body_size 10M;

    # Serve your Frontend static files
    location / {
        root /var/www/my-frontend/dist;
        try_files $uri $uri/ /index.html;
    }

    # Forward API requests to your Node.js backend
    location /api/ {
        proxy_pass http://localhost:3000/;
        proxy_http_version 1.1;
        
        # Standard proxy security and routing headers
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;

        # Pass real user IP and protocol details to your backend
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```