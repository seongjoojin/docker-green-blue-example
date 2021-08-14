# 실행 방법

서버에서 미리 샐행
```bash
docker-compose -p nginx -f docker-compose.nginx.yml up -d --build
```

ci/cd를 통해서 실행
```bash
deploy.sh
```
