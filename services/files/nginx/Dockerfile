FROM nginx:1.21.3-alpine

COPY files.conf /etc/nginx/sites-enabled/

COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl.conf /etc/nginx/ssl.conf

COPY certs/* /etc/ssl/
