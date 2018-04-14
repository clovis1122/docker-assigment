#!/bin/sh

# This script is for the assigment found at section 9, lecture 79 - part 3.

# This script assumes that the previous part was completed. We've now got a secure HTTPS registry!

# We'll add some basic authentication over HTTPS using moby and apache's htpasswd

mkdir auth
docker run --entrypoint htpasswd registry:latest -Bbn moby gordon > auth/htpasswd

# We can verify the clear text password and a cipher text password.

# cat auth/htpasswd

# Now we'll restart our container to include this auth.

docker kill registry
docker rm registry
docker run -d -p 5000:5000 --name registry \
  --restart unless-stopped \
  -v $(pwd)/registry-data:/var/lib/registry \
  -v $(pwd)/certs:/certs \
  -v $(pwd)/auth:/auth \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -e REGISTRY_AUTH=htpasswd \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  registry

# If we try the following command, we'll get an error. We have to authenticate first!

# docker pull 127.0.0.1:5000/hello-world

# Authenticate using Docker login, username=moby, password=gordon (as created using htpasswd)

docker login 127.0.0.1:5000

# We can pull now :)

docker pull 127.0.0.1:5000/hello-world

# Afterwords

# The message I received after pulling was different from the one in the documentation:
# `HTTP/1.x transport connection broken: malformed HTTP response`
# I though it was an HTTPS misconfiguration and looked over lots of possible workaround
# with not much success. Later on when I moved on and did docker login, it worked.
# This malformed request is related to the fact that docker is trying to use
# HTTP over a HTTPS network.



