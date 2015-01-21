#!/bin/bash

PATH="~/.node/bin:$PATH"

# Install sample app
if [ ! -e /var/www/sails-app/app.js ]; then
    echo "Generate a Sails.js application"
    rm /var/www/sails-app/README.md
    cd /var/www
    sails new sails-app
    cd /var/www/sails-app
    npm install sails-mongo 
    sails generate api demo
    sed -i "s/\/\/ migrate: 'alter'/migrate:'alter'/g" /var/www/sails-app/config/models.js
    sed -i "s/\/\/ connection: 'localDiskDb',/connection: 'someMongodbServer',/g" /var/www/sails-app/config/models.js
    sed -i "s/host: 'localhost',/host: 'db',/g" /var/www/sails-app/config/connections.js
else
    echo "An app is already installed"
fi

cp /var/init/.foreverignore /var/www/sails-app/.foreverignore
mkdir /var/www/sails-app/log
cd /var/www/sails-app
forever -w -o log/out.log -e log/err.log app.js