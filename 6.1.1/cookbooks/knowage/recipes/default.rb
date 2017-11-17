#
# Cookbook:: knowage
# Recipe:: default
#
# Copyright:Engineering Ingegneria Informatica 2017 S.p.A, All Rights Reserved.

docker_installation 'default' do
  action :create
end

docker_service 'default' do
  action [:create, :start]
end

include_recipe 'docker_compose::installation'

# Provision Compose file
cookbook_file '/etc/docker-compose.yml' do
  source 'docker-compose.yml'
  owner 'root'
  group 'root'
  mode 0777
  notifies :up, 'docker_compose_application[knowage]', :delayed
end

docker_compose_application 'knowage' do
  action :up
  compose_files [ '/etc/docker-compose.yml'  ]
end
