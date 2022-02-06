FROM alpine:3.15.0

RUN apk add --no-cache python3 gcc libc-dev linux-headers python3-dev
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

WORKDIR /app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . /app
RUN adduser -D flask
USER flask

CMD [ "uwsgi", "--ini", "uwsgi.ini" ]
