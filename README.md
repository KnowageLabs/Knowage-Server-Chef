# Knowage-Server-Chef
Chef deployment script for Knowage Server https://www.knowage-suite.com. 
This recipe will automatically download, install and start Docker and Docker Compose with a container for the Knowage Web application and a container with MySQL database for metadata.

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
Just launch the `bin/installation.sh` script to install and launch the Knowage environment.

```bash
./installation.sh [<ip_address_or_hostname>]
```

If `<ip_address_or_hostname>` is not provided, then default is `localhost`.
Port is `8080` by default.

## Version release
To release a new version of the Chef recipe (starting from the new Docker image), the following steps must be performed:

- edit `cookbooks/knowage/files/docker-compose.yml` and `cookbooks/knowage/files/docker-compose.yml.bak` by updating the Knowage docker image version (e.g. from 6.1.1 to 6.2.1);
- zip the folder `cookbooks`, rename the zip file `chef-cookbooks.zip` and make a new release at https://github.com/KnowageLabs/Knowage-Server-Chef/releases (adding `chef-cookbooks.zip` as asset).
- edit `bin/installation.sh` by updating the Chef cookbooks link with the newest version.
- create a folder (e.g. `6.2.1` for the same Knowage release version)
- copy/paste the folders `bin`, `cookbooks` and all (but not other versioning folder).

## How to contribute

Knowage is open to external contributions. You can submit your contributions into this repository through pull requests.
Before starting, here there are a few things you must be aware of: 

-   This project is released with a [Contributor Code of Conduct](./CODE_OF_CONDUCT.md). By participating in this
    project, you agree to abide by its terms.
-   When you open a pull request, you must sign the
    [Individual Contributor License Agreement](./CLA.md) by stating in a comment 
	_"I have read the CLA Document and I hereby sign the CLA"_
-   Please ensure that your contribution passes all tests. If there are test failures, you will need to address them
    before we can merge your contribution.