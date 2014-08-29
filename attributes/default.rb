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
