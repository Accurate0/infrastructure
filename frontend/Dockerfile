FROM node:14.17-alpine3.11 as clients
WORKDIR /clients
RUN apk add --no-cache python make g++

COPY ./clients/ .
RUN ./build.sh

FROM nginx:1.21-alpine

COPY --from=clients /clients/anurag/dist /www/data/anurag
COPY nginx/anurag.conf /etc/nginx/sites-enabled/

COPY --from=clients /clients/paste/build /www/data/paste
COPY nginx/paste.conf /etc/nginx/sites-enabled/

COPY nginx/default.conf /etc/nginx/conf.d/
COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY nginx/certs/* /etc/ssl/
