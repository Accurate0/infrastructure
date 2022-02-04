FROM node:14.17-alpine3.11 as clients
WORKDIR /clients

RUN mkdir paste

COPY frontend/package.json ./paste
COPY frontend/yarn.lock ./paste

RUN cd ./paste && yarn

COPY frontend/ ./paste
RUN cd ./paste && yarn prod

FROM nginx:1.21-alpine

COPY ./paste.conf /etc/nginx/sites-enabled/
COPY ./default.conf /etc/nginx/sites-enabled/

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=clients /clients/paste/build /www/data/paste
