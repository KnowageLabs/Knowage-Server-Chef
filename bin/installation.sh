#!/bin/bash
#Knowage VM installation script
usage() { echo "Usage: $0 [-a <ip address>] [-v <version>]"; exit 1; }
while getopts ":a:v:" OPTION
do
     case $OPTION in
	a)
	address=$OPTARG
	;;
        v)
	version=$OPTARG 
        ;; 
        ?)
        usage
        ;;
     esac
	  
done

#exit if any command fails
set -e

#install chef 13 client
wget https://packages.chef.io/files/stable/chef/13.5.3/ubuntu/16.04/chef_13.5.3-1_amd64.deb
dpkg -i chef_13.5.3-1_amd64.deb
rm -f chef_13.5.3-1_amd64.deb

if [[ ! -d "cookbooks/knowage" ]]; then
	apt-get install git-core
	git clone https://github.com/KnowageLabs/Knowage-Server-Chef.git
	cd Knowage-Server-Chef
	git checkout parametric-recipe
	cd ..
	mv Knowage-Server-Chef/cookbooks .
	rm -rf Knowage-Server-Chef
fi

#restore original docker-compose file configuration
cp cookbooks/knowage/files/docker-compose.yml.bak cookbooks/knowage/files/docker-compose.yml

#check if the script has been started without a specific IP address
if [[ -z "$address" ]]; then
        #remove PUBLIC_ADDRESS env attribute
        sed -i "/- PUBLIC_ADDRESS=.*/d" cookbooks/knowage/files/docker-compose.yml
fi

# choosing a knowage version
if [[ -n "$version" ]]; then
	sed -i "s|knowagelabs/knowage-server-docker|knowagelabs/knowage-server-docker:$version|" cookbooks/knowage/files/docker-compose.yml
fi

#replace the local IP (127.0.0.1) with the provided one, if any
sed -i "s|- PUBLIC_ADDRESS=.*|- PUBLIC_ADDRESS=$address|" cookbooks/knowage/files/docker-compose.yml

#install knowage
if [ ! -d "/etc/chef" ]; then
        # Control will enter here if doesn't exist
        mkdir /etc/chef
fi

chef-client -z -o 'recipe[knowage::default]'
