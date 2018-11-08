#!/bin/bash
#Knowage VM installation script

#install chef 13 client
wget https://packages.chef.io/files/stable/chef/13.5.3/ubuntu/16.04/chef_13.5.3-1_amd64.deb
dpkg -i chef_13.5.3-1_amd64.deb
rm -f chef_13.5.3-1_amd64.deb

if [[ ! -d "cookbooks/knowage" ]]; then
        #download recipes
        wget https://github.com/KnowageLabs/Knowage-Server-Chef/releases/download/6.1.1/chef-cookbooks.zip
        #install zip
        apt-get install unzip
        unzip chef-cookbooks.zip
fi

#restore original docker-compose file configuration
cp cookbooks/knowage/files/docker-compose.yml.bak cookbooks/knowage/files/docker-compose.yml

#check if the script has been started without a specific IP address
if [[ -z "$1" ]]; then
        #remove PUBLIC_ADDRESS env attribute
        sed -i "/- PUBLIC_ADDRESS=.*/d" cookbooks/knowage/files/docker-compose.yml
fi

#replace the local IP (127.0.0.1) with the provided one, if any
sed -i "s|- PUBLIC_ADDRESS=.*|- PUBLIC_ADDRESS=${1}|" cookbooks/knowage/files/docker-compose.yml

#install knowage
if [ ! -d "/etc/chef" ]; then
        # Control will enter here if doesn't exist
        mkdir /etc/chef
fi

chef-client -z -o 'recipe[knowage::default]'
