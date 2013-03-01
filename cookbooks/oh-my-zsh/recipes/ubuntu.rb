# ubuntu.rb
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

# theme = data_bag_item( "users", user_id )["oh-my-zsh-theme"]
theme = "vincent"

template "/home/#{user_id}/.zshrc" do
  source "zshrc.erb"
  owner user_id
  group user_id
  variables( :theme => ( theme || node[:ohmyzsh][:theme] ))
  # action :create_if_missing
  action :create
end

template "/home/#{user_id}/.oh-my-zsh/themes/vincent.zsh-theme" do
  source "vincent.zsh-theme"
  owner user_id
  group user_id
  action :create_if_missing
end

# cookbook_file "/home/#{user_id}/.oh-my-zsh/themes/vincent.zsh-theme" do
#   source "vincent.zsh-theme"
#   owner user_id
#   group user_id
#   not_if do FileTest.file?("/home/#{user_id}/.oh-my-zsh/themes/vincent.zsh-theme") end
# end

user user_id do
  action :modify
  shell '/bin/zsh'
end