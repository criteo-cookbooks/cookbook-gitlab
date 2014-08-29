pkg_path = "#{Chef::Config[:file_cache_path]}/#{node['gitlab']['package']['filename']}"

remote_file pkg_path do
  source "#{node['gitlab']['package']['url']}/#{node['gitlab']['package']['filename']}"
  checksum node['gitlab']['package']['checksum']
end

package 'gitlab' do
  source pkg_path
  notifies :run, 'execute[reconfigure-gitlab]'
end

directory '/etc/gitlab' do
  owner 'root'
  group 'root'
end

template '/etc/gitlab/gitlab.rb' do
  owner 'root'
  group 'root'
  source 'gitlab.rb.erb'
  variables(
    :gitlab_config => node['gitlab']['config'] || {}
  )
  notifies :run, 'execute[reconfigure-gitlab]', :immediately
end

execute 'reconfigure-gitlab' do
  command 'gitlab-ctl reconfigure'
  action :nothing
end
