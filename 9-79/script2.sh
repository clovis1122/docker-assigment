#!/bin/sh

# This script is for the assigment found at section 9, lecture 79 - part 2.

# This script assumes that the previous part was completed. 
# Material for this assigment can be found here:

# https://training.play-with-docker.com/linux-registry-part2/

# Create a self-signed certificate using openssl

mkdir -p certs 
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt

# Now we need the daemon to trust this certificate. We can achive it copying it in the certs folder:

mkdir /etc/docker/certs.d
mkdir /etc/docker/certs.d/127.0.0.1:5000 
cp $(pwd)/certs/domain.crt /etc/docker/certs.d/127.0.0.1:5000/ca.crt


# Restarts the docker daemon.

pkill dockerd

dockerd > /dev/null 2>&1 &

# Create a trusted HTTPS registry

mkdir registry-data

docker run -d -p 5000:5000 --name registry \
  --restart unless-stopped \
  -v $(pwd)/registry-data:/var/lib/registry -v $(pwd)/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry


# Test!

docker pull hello-world

docker tag hello-world 127.0.0.1:5000/hello-world

docker push 127.0.0.1:5000/hello-world

docker pull 127.0.0.1:5000/hello-world


# Afterwords

# I actually encountered https://github.com/docker/distribution/issues/1652 as I was testing. That ended up being a docker machine issue. The solution for me was to restart the VM.
