#
# Cookbook Name:: node-lessons
# Recipe:: setup_repo_api
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute

# This manages the WORDPRESS API Repo

# Create repos directory if it does not exist
directory node['node-lessons']['repos_dir'] do
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['repo_user']
  mode 00755
  action :create
  not_if do FileTest.directory?(node['node-lessons']['repos_dir']) end
end

# Only create remote repo and init if it does not exist
if (! FileTest.directory?(node['node-lessons']['remote_repo_api']))

  # Create repo directory if it does not exist
  directory node['node-lessons']['remote_repo_api'] do
    owner node['node-lessons']['repo_user']
    group node['node-lessons']['repo_user']
    mode 00755
    action :create
    # not_if do FileTest.directory?(node['node-lessons']['remote_repo']) end
  end

  # init bare repo
  execute "init_remote_repo" do
    user node['node-lessons']['repo_user']
    cwd node['node-lessons']['remote_repo_api']
    command "git init --bare"
  end

end

# Copy post-receive hook to repo
template node['node-lessons']['remote_hooks_api'] do
  path "#{node['node-lessons']['remote_hooks_api']}/post-receive"
  source "wordpress-post-receive.erb"
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['repo_user']
  mode 00774
  variables(
    :app_dir => node['node-lessons']['app_dir_api']
  )
  # notifies :restart, 'service[lessonsforlife]'
end