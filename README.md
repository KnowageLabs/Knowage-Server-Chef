# Knowage-Server-Chef
Chef deployment script for Knowage Server https://www.knowage-suite.com. This recipe will automatically download, install and start Docker and Docker Compose with a container for the Knowage Web application and a container with MySQL database for metadata.

## Usage: Option 1
This will deploy Knowage latest version by using Chef runner.

### Installation
Include `knowage` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[knowage::default]"
  ]
}
```

## Usage: Option 2
This will deploy Knowage, but you can specify IP/hostname and version to be installed.

### Installation
Just launch download the script under `bin/installation.sh` and execute `sudo ./installation.sh` to install all the dependencies automatically (Chef, Docker, Knowage) and to launch Knowage server.

```bash
sudo ./installation.sh [-a <ip_address_or_hostname>] [-v <knowage-version>] 
```

If `-a <ip_address_or_hostname>` is not provided, then default is `localhost`.
If `-v <knowage-version>` is not provided, then default is `latest`.
Port is `8080` by default anc cannot be changed at the moment.

### Stopping Knowage
Knowage Chef recipe relies on Docker toolbox and Knowage image available on Docker Hub. Therefore, to stop Knowage you will need to deal with Docker functionalities to manage Knowage lifecycle.

- To get list of running containers (including Knowage and its MySQL) execute `docker container ls`
- To stop containers, you can execute `docker container stop <container1_id> <container2_id> ... <containerN_id>`

### Restarting Knowage
To restart the last Knowage installation, simply execute `chef-client -z -o 'recipe[knowage::default]'`

## Version release
To release a new version of the Chef recipe (starting from the new Docker image), the following steps must be performed:

- edit `cookbooks/knowage/files/docker-compose.yml` and `cookbooks/knowage/files/docker-compose.yml.bak` by updating the Knowage docker image version (e.g. from 6.1.1 to 6.2.1);
- zip the folder `cookbooks`, rename the zip file `chef-cookbooks.zip` and make a new release at https://github.com/KnowageLabs/Knowage-Server-Chef/releases (adding `chef-cookbooks.zip` as asset).
- edit `bin/installation.sh` by updating the Chef cookbooks link with the newest version.
- create a folder (e.g. `6.2.1` for the same Knowage release version)
- copy/paste the folders `bin`, `cookbooks` and all (but not other versioning folder).
