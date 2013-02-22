#
# Cookbook Name:: node-lessons
# Recipe:: default
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#
# http://stackoverflow.com/questions/11084279/node-js-setup-for-easy-deployment-and-updating/11157223#11157223
# http://kvz.io/blog/2009/12/15/run-nodejs-as-a-service-on-ubuntu-karmic/
# http://clock.co.uk/tech-blogs/upstart-and-nodejs

include_recipe "node-lessons::setup_repo_node"
include_recipe "node-lessons::setup_repo_api"
include_recipe "node-lessons::setup_webapp"

# install forever
# execute "npm install -g forever" do
#   command "sudo npm install -g forever"
# end

service "lessonsforlife" do
  service_name node['node-lessons']['service_name']
  if node['node-lessons']['use_upstart']
    provider Chef::Provider::Service::Upstart
  end
  supports :start => true, :status => true, :restart => true, :reload => true
  action :enable
end

template "/etc/init/lessonsforlife.conf" do
  path "/etc/init/lessonsforlife.conf"
  source "lessonsforlife.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    :user => node['node-lessons']['www_user'],
    :node_bin => node['node-lessons']['node_bin'],
    :app => node['node-lessons']['app_bin'],
    :log => node['node-lessons']['log_path']
  )
  # notifies :restart, 'service[lessonsforlife]'
  notifies :restart, resources(:service => "lessonsforlife")
end

service "lessonsforlife" do
  # action [:enable, :start]
  action :start
end