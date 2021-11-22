FROM nginx:1.21.3-alpine

COPY ./services/files/files.conf /etc/nginx/sites-enabled/

COPY ./nginx/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/ssl.conf /etc/nginx/ssl.conf

COPY ./nginx/certs/* /etc/ssl/
