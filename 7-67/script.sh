#!/bin/sh

# This script is for the assigment found at section 7, lecture 67.

# We're using a machine with swarm enabled. We've also changed the docker env
# to allows us to talk to the docker inside the VM from the outside via this
# command:

# eval $(docker-machine env node1)

# Create our secret

echo "mypass" | docker secret create psql-pw -

# Deploy!

docker stack deploy -c docker-compose.yml drupal-app