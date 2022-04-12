server {
listen 80;
    server_name jenkins.sumateracommodity.com;
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl default deferred;
    server_name jenkins.sumateracommodity.com;

ssl on;

ssl_certificate /etc/letsencrypt/live/jenkins.sumateracommodity.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/jenkins.sumateracommodity.com/privkey.pem;

ssl_session_cache shared:SSL:10m;
ssl_session_timeout 1440m;

ssl_prefer_server_ciphers on;
ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

ssl_dhparam /etc/nginx/ssl/dhparam.pem;
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";

ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/letsencrypt/live/jenkins.sumateracommodity.com/fullchain.pem;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;

access_log  /var/log/nginx/jenkins.sumateracommodity.com.access.log;
error_log   /var/log/nginx/jenkins.sumateracommodity.com.error.log;

proxy_buffers 16 64k;
proxy_buffer_size 128k;
location / {
    proxy_pass http://localhost:8080;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto https;
    }
}