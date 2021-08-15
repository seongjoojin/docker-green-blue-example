# 실행 방법

서버에서 미리 실행 (docker)

```bash
# docker install
$ sudo apt update
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
$ sudo apt update
$ apt-cache policy docker-ce
$ sudo apt install docker-ce

# docker install checkpoint
$ sudo systemctl status docker

# docker-compose install
$ sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo usermod -aG docker $USER


# docker-compose version check
$ docker-compose --version

# nginx install
$ sudo apt-get install nginx
$ sudo service nginx status
$ sudo service nginx start

ec2 ip에 접속해 확인

# nginx setting & restart
$ sudo nano /etc/nginx/nginx.conf

`nginx.conf`
```
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
}

http {
	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	#gzip on;

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

	upstream nextjs {
        #least_conn;
        server 127.0.0.1:3001 weight=5 max_fails=3 fail_timeout=10s;
        server 127.0.0.1:3002 weight=10 max_fails=3 fail_timeout=10s;
        }

	server {
        listen 80;
        server_name _;
            location / {
                proxy_pass http://nextjs;
            }
        }
}
```

$ sudo service nginx restart


# 서버 실행
$ chmod +x ./deploy.sh
$ ./deploy.sh
```

ci/cd를 통해서 배포

```bash
$ ./deploy.sh
```
