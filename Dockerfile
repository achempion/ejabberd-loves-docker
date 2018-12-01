FROM erlang:21.1.3-slim

RUN apt update && apt install apk add \
    build-base expat-dev openssl-dev make automake autoconf git yaml-dev

WORKDIR /app

RUN wget https://github.com/processone/ejabberd/archive/18.09.zip && \
    unzip 18.09.zip && cd ejabberd-18.09/ && \
    ./autogen.sh && ./configure && make && make install

COPY ejabberd.yml.example /usr/local/etc/ejabberd/ejabberd.yml
COPY certs/localhost/server.pem /etc/ejabberd/server.pem

CMD ejabberdctl foreground
