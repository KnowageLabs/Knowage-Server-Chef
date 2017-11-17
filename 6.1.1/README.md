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
Just launch the `bin/installation.sh` script to install and launch the Knowage environment. This will use the default recipe to download,install and start Docker with a container for the Knowage Web application and a container with MySQL database use for the metadata.
