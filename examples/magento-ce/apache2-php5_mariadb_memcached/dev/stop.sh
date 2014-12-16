#!/bin/bash

declare -a containers=(magento-ce-memcached magento-ce-mariadb magento-ce-apache2-php5)

for var in "${containers[@]}"
do

    RUNNING=$(docker inspect --format="{{ .State.Running }}" $var 2> /dev/null)

    if [ $? -eq 0 ] && [ "$RUNNING" == "true" ]; then
        echo "Stopping $var container"
        docker stop ${var} > /dev/null
    fi

done