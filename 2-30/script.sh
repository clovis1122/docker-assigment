#!/bin/sh

# This script is for the assigment found at section 2, lecture 30.

# Creates the network

docker network create mynetwork

# Create two elastic search instances in this network

docker container run -d --network mynetwork --name search1 --net-alias search elasticsearch:2
docker container run -d --network mynetwork --name search2 --net-alias search elasticsearch:2

# Run a nslookup from the alpine image.

docker container run --network mynetwork alpine nslookup search

# After running nslookup, both containers appears with their respective IP.

# Lastly we'll try to hit both using a centos image with curl.

docker container run --network mynetwork centos curl -s search:9200

# After running it 6 times, we saw that both containers were replying :)
