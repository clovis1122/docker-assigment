#!/bin/sh

# This script is for the assigment found at section 9, lecture 79 - part 1.

# Previous to the assigment, we'll need to create a registry first!
# We'll also need to allow Docker to trust registry through HTTP (for testing).

# Now, we can use an editor or just append it from the terminal right away.

echo "DOCKER_OPTS="--insecure-registry 127.0.0.1:5000"" >> /etc/docker/docker

# Restart Docker (this depends on the OS)

# service docker restart

# Create a registry. Pull some images, and save them there.

docker run -d -p 5000:5000 --name registry registry:2

docker pull hello-world

docker tag hello-world 127.0.0.1:5000/hello-world

docker push 127.0.0.1:5000/hello-world

# Optional: for testing it we do indeed have the hello world image in our local registry.

docker rmi 127.0.0.1:5000/hello-world

docker rmi hello-world

docker pull 127.0.0.1:5000/hello-world

# Optional: adding a volume to persist registry images

# Kill the previous registry image if alive.

# docker kill registry
# docker rm registry

mkdir registry-data

docker run -d -p 5000:5000 --name registry -v $(pwd)/registry-data:/var/lib/registry registry

# Add the previous hello-world image again to the new registry

docker pull hello-world

docker tag hello-world 127.0.0.1:5000/hello-world

docker push 127.0.0.1:5000/hello-world
