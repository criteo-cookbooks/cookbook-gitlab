#
# Cookbook Name:: gitlab
# Attributes:: default
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
# Copyright 2012, Eric G. Wolfe
# Copyright 2013, Johannes Becker
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

default['gitlab']['version'] = '6.9.0'

case platform
when 'debian'
  default['gitlab']['package']['url'] = "https://downloads-packages.s3.amazonaws.com/debian-7.4"
  default['gitlab']['package']['filename'] = "gitlab_#{node['gitlab']['version']}-omnibus.2-1_amd64.deb"
  default['gitlab']['package']['checksum'] = '38da9119c25a6f1f4ece4355dcad3acf1a5d9c8a6fa19a25e40b7b7ec843f046'
when 'ubuntu'
  default['gitlab']['package']['url'] = "https://downloads-packages.s3.amazonaws.com/ubuntu-12.04"
  default['gitlab']['package']['filename'] = "gitlab_#{node['gitlab']['version']}-omnibus-1_amd64.deb"
  default['gitlab']['package']['checksum'] = '42e8224f8aa8689ba80380d036a3b367ffb63a85b5e447670a5233d888b85924'
when 'rhel', 'centos'
  default['gitlab']['package']['url'] = "https://downloads-packages.s3.amazonaws.com/centos-6.5"
  default['gitlab']['package']['filename'] = "gitlab-#{node['gitlab']['version']}_omnibus-1.el6.x86_64.rpm"
  default['gitlab']['package']['checksum'] = '069067225494df842d4c724667282a0665de832b11fb044b0493cf15070b178a'
end

# Config in /etc/gitlab/gitlab.rb
# default['gitlab']['config']['git_data_dir'] = "/my/dir"
# default['gitlab']['config']['gitlab_rails']['giltab_https'] = true


# Set attributes for the git user
default['gitlab']['user'] = "git"
default['gitlab']['group'] = "git"
default['gitlab']['home'] = "/srv/git"
default['gitlab']['app_home'] = default['gitlab']['home'] + '/gitlab'
default['gitlab']['web_fqdn'] = nil
default['gitlab']['nginx_server_names'] = [ 'gitlab.*', node['fqdn'] ]
default['gitlab']['email_from'] = "gitlab@#{node['domain']}"
default['gitlab']['support_email'] = "gitlab-support@#{node['domain']}"
default['gitlab']['default_projects_limit'] = 10
default['gitlab']['default_can_create_group'] = true
default['gitlab']['username_changing_enabled'] = true

# Set github URL for gitlab
default['gitlab']['git_url'] = "git://github.com/gitlabhq/gitlabhq.git"
default['gitlab']['git_branch'] = "6-1-stable"

# gitlab-shell attributes
default['gitlab']['shell']['home'] = node['gitlab']['home'] + '/gitlab-shell'
default['gitlab']['shell']['git_url'] = "git://github.com/gitlabhq/gitlab-shell.git"
default['gitlab']['shell']['git_branch'] = "v1.7.1"

# Database setup
default['gitlab']['database']['type'] = "mysql"
default['gitlab']['database']['adapter'] = node['gitlab']['database']['type'] == "mysql" ? "mysql2" : "postgresql"
default['gitlab']['database']['encoding'] = node['gitlab']['database']['type'] == "mysql" ? "utf8" : "unicode"
default['gitlab']['database']['host'] = "localhost"
default['gitlab']['database']['pool'] = 5
default['gitlab']['database']['database'] = "gitlab"
default['gitlab']['database']['username'] = "gitlab"

default['gitlab']['install_ruby'] = "1.9.3-p448"
default['gitlab']['cookbook_dependencies'] = %w[
  build-essential zlib readline ncurses git openssh
  redisio::install redisio::enable xml python::package python::pip
  ruby_build sudo
]

# Required packages for Gitlab
case node['platform_family']
when 'debian'
  default['gitlab']['packages'] = %w[
    libyaml-dev libssl-dev libgdbm-dev libffi-dev checkinstall
    curl libcurl4-openssl-dev libicu-dev wget python-docutils
  ]
when "rhel"
  default['gitlab']['packages'] = %w[
    libyaml-devel openssl-devel gdbm-devel libffi-devel
    curl libcurl-devel libicu-devel wget python-docutils
  ]
else
  default['gitlab']['install_ruby'] = "package"
  default['gitlab']['cookbook_dependencies'] = %w[
    build-essential git openssh readline xml zlib sudo ruby_build
    python::package python::pip redisio::install redisio::enable
  ]
  default['gitlab']['packages'] = %w[
    build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev
    libreadline-dev libncurses5-dev libffi-dev curl git-core openssh-server
    redis-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev
    libicu-dev python-docutils
  ]
end

default['gitlab']['trust_local_sshkeys'] = "yes"

default['gitlab']['https'] = false
default['gitlab']['certificate_databag_id'] = nil
default['gitlab']['ssl_certificate'] = "/etc/nginx/ssl/certs/#{node['fqdn']}.pem"
default['gitlab']['ssl_certificate_key'] = "/etc/nginx/ssl/private/#{node['fqdn']}.key"

default['gitlab']['backup_path'] = node['gitlab']['app_home'] + "/backups"
default['gitlab']['backup_keep_time'] = 604800

# Ip and port nginx will be serving requests on
default['gitlab']['listen_ip'] = "*"
default['gitlab']['listen_port'] = nil
