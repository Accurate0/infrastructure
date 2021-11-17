FROM nginx:1.21.3-alpine

COPY jenkins.conf /etc/nginx/sites-enabled/
COPY aur.conf /etc/nginx/sites-enabled/
COPY jellyfin.conf /etc/nginx/sites-enabled/
COPY ip.conf /etc/nginx/sites-enabled/
COPY files.conf /etc/nginx/sites-enabled/
COPY kernel.conf /etc/nginx/sites-enabled/

COPY nginx.conf /etc/nginx/nginx.conf
