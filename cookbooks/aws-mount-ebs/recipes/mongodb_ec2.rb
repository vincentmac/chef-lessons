#
# Cookbook Name:: aws-mount-ebs
# Recipe:: mongodb_ec2
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#

# This recipe will move an mongodb data and log to an existing, already attached EBS volumes
# Move and mount mongodb data
if (node.attribute?('ec2') && ! FileTest.directory?(node['aws-mount-ebs']['mongodb_dbpath']))

  service "mongodb" do
    action :stop
  end

  # Create mongo directory `/vol2/lib if it does not exist
  directory node['aws-mount-ebs']['mongodb_libdir'] do
    owner "root"
    group "root"
    mode 00755
    action :create
    not_if do FileTest.directory?(node['aws-mount-ebs']['mongodb_libdir'] ) end
  end

  execute "install-mongodb-dbpath" do
    command "mv #{node['mongodb']['dbpath']} #{node['aws-mount-ebs']['mongodb_dbpath']}"
    not_if do FileTest.directory?(node['aws-mount-ebs']['mongodb_dbpath']) end
  end

  [node['mongodb']['dbpath'], node['aws-mount-ebs']['mongodb_dbpath']].each do |dir|
    directory dir do
      owner "mongodb"
      group "mongodb"
    end
  end

  mount node['mongodb']['dbpath'] do
    device node['aws-mount-ebs']['mongodb_dbpath']
    fstype "none"
    options "bind,rw"
    action [:mount, :enable]
  end

  service "mongodb" do
    action :start
  end

end

# Move and mount mongodb log
if (node.attribute?('ec2') && ! FileTest.directory?(node['aws-mount-ebs']['mongodb_logpath']))

  service "mongodb" do
    action :stop
  end

  # Create mongo directory `/vol2/log if it does not exist
  directory node['aws-mount-ebs']['mongodb_logdir'] do
    owner "root"
    group "root"
    mode 00755
    action :create
    not_if do FileTest.directory?(node['aws-mount-ebs']['mongodb_logdir'] ) end
  end

  execute "install-mongodb-logpath" do
    command "mv #{node['mongodb']['logpath']} #{node['aws-mount-ebs']['mongodb_logpath']}"
    not_if do FileTest.directory?(node['aws-mount-ebs']['mongodb_logpath']) end
  end

  [node['mongodb']['logpath'], node['aws-mount-ebs']['mongodb_logpath']].each do |dir|
    directory dir do
      owner "mongodb"
      group "mongodb"
    end
  end

  mount node['mongodb']['logpath'] do
    device node['aws-mount-ebs']['mongodb_logpath']
    fstype "none"
    options "bind,rw"
    action [:mount, :enable]
  end

  service "mongodb" do
    action :start
  end

end
