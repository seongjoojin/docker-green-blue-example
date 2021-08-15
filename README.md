# 실행 방법

서버에서 미리 실행 (docker)

```bash
$ docker-compose -p nginx -f docker-compose.nginx.yml up -d --build
```

ci/cd를 통해서 배포

```bash
$ chmod +x ./deploy.sh
$ ./deploy.sh
```
