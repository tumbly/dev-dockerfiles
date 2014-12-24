#!/bin/bash

# Retrieve current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

# Create webserver image
echo "Building webserver image"
docker build -t magento-ce-apache-php-image $DIR/dockerfiles/apache-php