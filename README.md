# Ejabberd <3 Docker

Hassle-free ejabberd bootstrap as a docker container

## Quick start

### generate certificate for tls
```sh
$ mkdir -p certs/localhost && cd certs/localhost
$ # generate certs [Certificate section](#Certificate), make sure “Common name” is "localhost"
```

### dockerize it
```sh
$ docker build . -t ejj
$ docker run -p 5222:5222 ejj
```

### create first user
```sh
$ docker ps // obtain ejj container id
$ docker exec -it <container-id> sh

# user "test" with password "test"
$ > ejabberdctl register test localhost test
```

### Connect with your favorite xmpp client
- https://swift.im
- https://monal.im

## Certificate

Create Key file for certificate
```sh
$ openssl genrsa -out key.pem 2048
```

Create Certificate file. Make sure “Common name” matches your desired server name.
```sh
$ openssl req -new -key key.pem -out request.pem
```

Sign the Certificate file for 900 days expiration:::
```sh
$ openssl x509 -req -days 900 -in request.pem -signkey key.pem -out certificate.pem
```

Final step is that you have to cat the certificate file and key file into one file (server.pem) and replace the server.pem file in the configuration directory of ejabberd.
```sh
$ cat certificate.pem > server.pem
$ cat key.pem >> server.pem
```

## Server

```sh
$ ejabberdctl foreground
$ ejabberdctl register test localhost test
```

## Setups
`Dockerfile` — alpine setup

`Dockerfile.debian` — debian setup

`Dockerfile.debian-raspberry` — to run with raspberry-pi board

## Gateway

In order if you want to proxy traffic from some server
to your ejabbered server you can run nginx config on proxy host

```sh
$ docker run  -v /srv/app/nginx.conf:/etc/nginx/nginx.conf:ro -p 5222:5222 -d nginx:alpine
``

Of course it is better to use some unpapular port to limit possible bots' requests
