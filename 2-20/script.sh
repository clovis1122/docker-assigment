#!/bin/sh

# This script is for the assigment found at section 2, lecture 20.

# Initializes our containers

docker container run -d -p 80:80 --name nginx nginx
docker container run -d -p 3306:3306 --name mysql -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker container run -d -p 8080:80 --name httpd httpd

## To check if it worked, we can try hitting them with curl:

# curl localhost:80
# curl localhost:8080

# Find the random root password in the mySQL container logs

docker container logs mysql

# Faster with grep. We'll have to redirect the output and chain a pipe to it

# docker container logs mysql 2>&1 | grep PASSWORD

# Stop all three containers

docker container stop nginx mysql httpd

# Remove all three containers

docker container rm nginx mysql httpd

# Check the containers status

docker container ls

# To check for inactive containers

# docker container ls -a
