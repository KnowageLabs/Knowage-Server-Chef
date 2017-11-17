name 'knowage'
maintainer 'Knowage'
maintainer_email 'marco.cortella@eng.it'
license 'All Rights Reserved'
description 'Installs/Configures knowage'
long_description 'Installs/Configures knowage'
version '1.0.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'docker', '~> 2.0'
depends 'docker_compose', '~> 0.0'


