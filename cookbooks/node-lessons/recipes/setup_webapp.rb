#
# Cookbook Name:: node-lessons
# Recipe:: setup_webapp
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute


# Create webapp directory if it does not exist
directory node['node-lessons']['app_dir'] do
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['www_user']
  mode 00755
  action :create
  not_if do FileTest.directory?(node['node-lessons']['app_dir']) end
end

# Create webapp log directory if it does not exist
directory node['node-lessons']['log_dir'] do
  owner node['node-lessons']['www_user']
  group "root"
  mode 00755
  action :create
  not_if do FileTest.directory?(node['node-lessons']['log_dir']) end
end

cookbook_file node['node-lessons']['app_bin'] do
  source "app.js"
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['www_user']
  mode 00755
  not_if do FileTest.file?(node['node-lessons']['app_bin']) end
end