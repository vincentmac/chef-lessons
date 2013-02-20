#
# Cookbook Name:: node-lessons
# Recipe:: default
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#
# http://stackoverflow.com/questions/11084279/node-js-setup-for-easy-deployment-and-updating/11157223#11157223

# install forever
execute "npm install -g forever" do
  command "sudo npm install -g forever"
end


service "lessonsforlife" do
  service_name node['node-lessons']['service_name']
  if node['node-lessons']['use_upstart']
    provider Chef::Provider::Service::Upstart
  end
  supports :status => true, :restart => true, :reload => true
  action :enable
end

template "/etc/init/lessonsforlife.conf" do
  path "/etc/init/lessonsforlife.conf"
  source "lessonsforlife.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    :user => node['node-lessons']['user'],
    :node_bin => node['node-lessons']['node_bin'],
    :app => node['node-lessons']['app_bin'],
    :log => node['node-lessons']['log_dir']
  )
  notifies :restart, 'service[lessonsforlife]'
end

service "lessonsforlife" do
  action :start
end