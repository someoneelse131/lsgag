# HTTP server block - redirects to HTTPS
server {
    listen 80;
    server_name lsgag.chiaruzzi.ch;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$server_name$request_uri;
    }
}

# HTTPS server block
server {
    listen 443 ssl;
    server_name lsgag.chiaruzzi.ch;

    # SSL configuration
    ssl_certificate /etc/letsencrypt/live/lsgag.chiaruzzi.ch/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/lsgag.chiaruzzi.ch/privkey.pem;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    root /usr/share/nginx/html;
    index index.html;

    # Main location
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API endpoints for jobs and images only
    location ~ ^/api/(jobs|images)\.php$ {
        try_files $uri =404;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /var/www/html$fastcgi_script_name;
        include fastcgi_params;
    }

    # Static files
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|webmanifest)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Deny access to hidden files
    location ~ /\. {
        deny all;
    }
}

# Initial setup without SSL (use this first to get certificates)
# server {
#     listen 80;
#     server_name lsgag.chiaruzzi.ch;
#
#     root /usr/share/nginx/html;
#     index index.html;
#
#     location /.well-known/acme-challenge/ {
#         root /var/www/certbot;
#     }
#
#     location / {
#         try_files $uri $uri/ /index.html;
#     }
# }