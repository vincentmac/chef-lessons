#
# Cookbook Name:: zsh-z
# Recipe:: default
#
# Copyright 2013, Avant.io
#
# All rights reserved - Do Not Redistribute
#
include_recipe "git"
include_recipe "zsh"

user_id = "ubuntu"

git "/home/#{user_id}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user user_id
  group user_id
  action :checkout
  not_if "test -d /home/#{user_id}/.oh-my-zsh"
end