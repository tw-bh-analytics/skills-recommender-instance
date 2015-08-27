include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'java'
include_recipe 'git'
include_recipe 'nginx'
include_recipe 'maven'
include_recipe 'nodejs'

user 'mysql' do
  action :create
end

mysql_service 'default' do
  bind_address '0.0.0.0'
  run_user 'mysql'
  initial_root_password node['mysql']['root']['password']
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

execute "add-mysql-user" do
  command "/usr/bin/mysql -h 127.0.0.1 -u root -D mysql -p#{node['mysql']['root']['password']} -r -B -N -e \"CREATE USER '#{node['mysql']['app']['user']}'@'%' IDENTIFIED BY '#{node['mysql']['app']['password']}'\""
  action :run
  only_if { `/usr/bin/mysql -h 127.0.0.1 -u root -D mysql -p#{node['mysql']['root']['password']} -r -B -N -e \"SELECT COUNT(*) FROM user where User='#{node['mysql']['app']['user']}'\"`.to_i == 0 }
end

