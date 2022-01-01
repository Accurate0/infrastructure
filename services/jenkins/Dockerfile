FROM nginx:1.21.3-alpine

COPY ./nginx/certs/* /etc/ssl/

COPY ./services/jenkins/jenkins.conf /etc/nginx/sites-enabled/

COPY ./nginx/nginx.conf /etc/nginx
