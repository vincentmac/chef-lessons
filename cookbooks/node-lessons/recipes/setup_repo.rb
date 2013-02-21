#
# Cookbook Name:: node-lessons
# Recipe:: setup_repo
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute

# Create repos directory if it does not exist
directory node['node-lessons']['repos_dir'] do
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['repo_user']
  mode 00755
  action :create
  not_if do FileTest.directory?(node['node-lessons']['repos_dir']) end
end

# Only create remote repo and init if it does not exist
if (! FileTest.directory?(node['node-lessons']['remote_repo']))

  # Create repo directory if it does not exist
  directory node['node-lessons']['remote_repo'] do
    owner node['node-lessons']['repo_user']
    group node['node-lessons']['repo_user']
    mode 00755
    action :create
    # not_if do FileTest.directory?(node['node-lessons']['remote_repo']) end
  end

  # init bare repo
  execute "init_remote_repo" do
    user node['node-lessons']['repo_user']
    cwd node['node-lessons']['remote_repo']
    command "git init --bare"
  end

end

# Copy post-receive hook to repo
template node['node-lessons']['remote_hooks'] do
  path "#{node['node-lessons']['remote_hooks']}/post-receive"
  source "post-receive.erb"
  owner node['node-lessons']['repo_user']
  group node['node-lessons']['repo_user']
  mode 00774
  variables(
    :service => node['node-lessons']['service_name'],
    :app_dir => node['node-lessons']['app_dir']
  )
  # notifies :restart, 'service[lessonsforlife]'
end