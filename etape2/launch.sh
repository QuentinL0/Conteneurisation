docker network create network2
docker run -d --name data --network network2 -e MARIADB_RANDOM_ROOT_PASSWORD=yes -v "$(pwd)/db:/docker-entrypoint-initdb.d" mariadb:latest
docker build -t php-mysqli ./php
docker run -d --name script --network network2 -v "$(pwd)/app:/app" php-mysqli
docker run -d --name http --network network2 -p 8080:80 -v "$(pwd)/app:/app" -v "$(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf" nginx:latest