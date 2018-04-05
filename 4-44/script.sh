#!/bin/sh

# This script is for the assigment found at section 4, lecture 44.

# Start the first container. The volumen is auto-created if it doesn't exists.

docker container run -d --name postgres1 -v postgres-db:/var/lib/postgresql/data postgres:9.6.1

# Check the logs

docker container logs postgres1

# We see that the logs contains a lot of init information... now stop the container.

docker container stop postgres1

# Start a new postgres container with the version 9.6.2

docker container run -d --name postgres2 -v postgres-db:/var/lib/postgresql/data postgres:9.6.2

# Check the new container logs

docker container logs postgres2

# We see that the new logs are quite short and doesn't contains init logs. This is a clear signal that
# our new container is using our first container's volume :)
