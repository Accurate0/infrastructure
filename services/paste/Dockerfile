FROM node:14.17-alpine3.11 as clients
WORKDIR /clients

RUN mkdir paste

COPY ./services/paste/frontend/package.json ./paste
COPY ./services/paste/frontend/yarn.lock ./paste

RUN cd ./paste && yarn

COPY ./services/paste/frontend/ ./paste
RUN cd ./paste && yarn prod

FROM nginx:1.21-alpine

COPY services/paste/paste.conf /etc/nginx/sites-enabled/

COPY ./nginx/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/origin-ssl.conf /etc/nginx/ssl.conf

COPY ./nginx/certs/* /etc/ssl/

COPY --from=clients /clients/paste/build /www/data/paste
