# Knowage-Server-Chef
Chef deployment script for Knowage Server https://www.knowage-suite.com

## Usage

### Option 1
Include `knowage` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[knowage::default]"
  ]
}
```
### Option 2
Just launch the `bin/installation.sh` script to install and launch the Knowage environment. This will use the default recipe to download, install and start Docker with a container for the Knowage Web application and a container with MySQL database use for the metadata.

```bash
./installation.sh <ip_address_or_hostname>
```

## Version release
To release a new version of the Chef recipe, the following steps must be performed:

- edit `cookbooks/knowage/files/docker-compose.yml` and `cookbooks/knowage/files/docker-compose.yml.bak` by updating the Knowage docker image version (e.g. from 6.1.1 to 6.2.1);
- zip the folder `cookbooks`, rename the zip file `chef-cookbooks.zip` and make a new release at https://github.com/KnowageLabs/Knowage-Server-Chef/releases (adding `chef-cookbooks.zip` as asset).
- edit `bin/installation.sh` by updating the Chef cookbooks link with the newest version.
- create a folder (e.g. `6.2.1` for the same Knowage release version)
- copy/paste the folders `bin`, `cookbooks` and all (but not other versioning folder).
