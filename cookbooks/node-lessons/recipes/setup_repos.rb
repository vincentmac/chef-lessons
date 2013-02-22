#
# Cookbook Name:: node-lessons
# Recipe:: setup_repos
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#
# http://stackoverflow.com/questions/11084279/node-js-setup-for-easy-deployment-and-updating/11157223#11157223

include_recipe "node-lessons::setup_repo_node"
include_recipe "node-lessons::setup_repo_api"
include_recipe "node-lessons::setup_webapp"