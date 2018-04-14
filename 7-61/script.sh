#!/bin/sh

# This script is for the assigment found at section 7, lecture 61.

# We've created three machines before using docker-machine running this:

# docker-machine create node1
# docker-machine create node2
# docker-machine create node3

# To SSH into each machine using docker-machine:

# docker-machine ssh node1
# docker-machine ssh node2
# docker-machine ssh node3

# We SSH into node1 to give manager powers.

# docker swarm init

# The following join link will be given. Then we SSH into node2 and node3 and copy paste the given command.
# The command is:
# docker swarm join --token SWMTKN-1-0j7zoocdvq6wap6mt2cm6d88joruw8eemai6yihxu67f52escy-38304j7r4ry8ctrjby0wxqj09 192.168.99.100:2377
# After running it on both node2 and node3 the message "This node joined a swarm as a worker" appears.

# We can list all the nodes in the swarm by running this command in node1
# docker node ls

# Begin creating the voting app networks

docker network create --driver overlay backend
docker network create --driver overlay frontend

# We can check that the network were created using
# docker network ls

# Create the vote service

docker service create --replicas 2 --name vote --publish 80:80 --network frontend dockersamples/examplevotingapp_vote:before

# Create the redis service

docker service create --name redis --network frontend redis:3.2

# Create the worker service (I actually had problems with this one, check afterwards)

docker service create --name worker --network frontend --network backend dockersamples/examplevotingapp_worker

# Create the postgres database service

docker service create --name db --mount type=volume,destination=/var/lib/postgresql/data --network backend  postgres:9.4

# Finally, create the result service.

docker service create --name result --publish 5001:80 --network backend dockersamples/examplevotingapp_result:before


## Afterwords

# Pew! This one was tricky to get working. The worker container gave me many problems, ranging from randomly losing swarm status to causing me some errors in my
# tocker installation. At the end I had to run it as a container first, then as a service as reported here to get my node 1 to get it running.

# Another interesting thing was port forwarding: docker-machine does NOT forward the ports outside! In my case I had to configure port forwarding via VirtualBox GUI.

# Lastly, I attempted to vote, but the results did not update. While asserting the connection between containers I realized that everything was working up
# to the DB database, which throws a "DUPLICATE KEY VALUE" error in the logs. I attempted with another browser - same results. Solving this problem
# is outside of my scope.
