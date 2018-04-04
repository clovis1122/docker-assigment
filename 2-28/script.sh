#!/bin/sh

# This script is for the assigment found at section 2, lecture 28.

# Enter in ubuntu CLI.

docker container run --rm -it ubuntu:14.04

# Inside there, curl was not installed. So I installed it by using 
# apt-get update && apt-get install curl

# Enter centos CLI

docker container run --rm -it centos:7

# Inside there, curl was already installed! :)
