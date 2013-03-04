#
# Cookbook Name:: aws-mount-ebs
# Recipe:: mysql
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#

# This recipe will mount existing already attached EBS volumes
# Installs xfsprogs package, loads xfs into kernel, mounts mysql volume

if (node.attribute?('ec2') && ! FileTest.directory?(node['aws-mount-ebs']['mysql_volume']))

  package "xfsprogs" do
    action :install
  end

  # add xfs to file systems and load into kernel
  execute "modprobe xfs" do
    command "grep -q xfs /proc/filesystems || sudo modprobe xfs"
  end

  # execute "mkdir" do
  #   command "sudo mkdir -p #{node['mysql']['ec2_path']}"
  #   not_if do FileTest.directory?(node['mysql']['ec2_path']) end
  # end

  directory node['aws-mount-ebs']['mysql_volume'] do
    owner "root"
    group "root"
    mode 00755
    action :create
  end

  # execute "add device to fstab" do
  #   command "echo \"#{node['mysql']['ebs_vol_device']} #{node['mysql']['ec2_path']} xfs noatime 0 0\" | sudo tee -a /etc/fstab"
  # end

  mount node['aws-mount-ebs']['mysql_volume'] do
    device node['aws-mount-ebs']['mysql_device']
    fstype "xfs"
    options "noatime"
    action [:mount, :enable]
  end

end

template "/etc/apparmor.d/local/usr.sbin.mysqld" do
  # source "default-site.erb"
  source "local.usr.sbin.mysqld.erb"
  owner "root"
  group "root"
  mode 00644
  # notifies :reload, 'service[nginx]'
end