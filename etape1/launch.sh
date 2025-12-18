docker run --name nginx-temp -d nginx
docker cp nginx-temp:/etc/nginx/conf.d/default.conf ($pwd)/nginx
docker rm -f nginx-temp

docker network create network1
docker container run -d --name script --network network1 -v "$(pwd)/app:/app" php:8.2-fpm
docker container run -d --name http --network network1 -p 8080:80 -v "$(pwd)/app:/app" -v "$(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf" nginx:latest

http://localhost:8080/index.php