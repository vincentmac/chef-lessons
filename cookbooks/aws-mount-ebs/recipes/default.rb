#
# Cookbook Name:: aws-mount-ebs
# Recipe:: default
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#

# This recipe will mount existing already attached EBS volumes
# Installs xfsprogs package, loads xfs into kernel, mounts mysql volume

include_recipe "aws-mount-ebs::mysql"
include_recipe "aws-mount-ebs::mongodb"
