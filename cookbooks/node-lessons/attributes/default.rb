#
# Cookbook Name:: node-lessons
# Attributes:: default
#
# Author:: Vincent Mac (<vincent@avant.io>)
#
# Copyright 2013, Avant.io.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# In order to update the version, the checksum attribute should be
# changed too. It is in the source.rb file, though we recommend
# overriding attributes by modifying a role, or the node itself.
# default['nginx']['source']['checksum']

default['node-lessons']['service_name'] = "lessonsforlife"
default['node-lessons']['use_upstart']  = node['platform'] == "ubuntu" && node['platform_version'].to_f >= 10.04

default['node-lessons']['node_bin'] = "/usr/bin/node"
default['node-lessons']['app_dir']  = "/var/www/lessonsforlifeproject.com"
default['node-lessons']['app_bin']  = "/var/www/lessonsforlifeproject.com/app.js"
default['node-lessons']['log_dir']  = "/var/log/lessonsforlifeproject.com"
default['node-lessons']['log_path']  = "/var/log/lessonsforlifeproject.com/lessons.log"
default['node-lessons']['www_user'] = "www-data"

default['node-lessons']['repos_dir']  = "/home/ubuntu/repos"
default['node-lessons']['remote_repo']  = "/home/ubuntu/repos/lessonsforlifeproject.com"
default['node-lessons']['remote_hooks'] = "/home/ubuntu/repos/lessonsforlifeproject.com/hooks"
default['node-lessons']['repo_user']    = "ubuntu"

# Wordpress API Repo
default['node-lessons']['remote_repo_api']  = "/home/ubuntu/repos/api.lessonsforlifeproject.com"
default['node-lessons']['remote_hooks_api'] = "/home/ubuntu/repos/api.lessonsforlifeproject.com/hooks"
default['node-lessons']['app_dir_api']      = "/var/www/api.lessonsforlifeproject.com"