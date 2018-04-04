# We're assuming that there's the given dockerfile in the same repository
# as this script, as well as all the files of the docker-assigment-1 folder.
# https://github.com/BretFisher/udemy-docker-mastery/tree/master/dockerfile-assignment-1

# Build the image

docker image build -t nodeapp .

# Run the image

docker container run -d --name nodeapp -p 80:3000 nodeapp
