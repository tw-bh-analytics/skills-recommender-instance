package 'nginx'

cookbook_file 'local-proxy.conf' do
  path '/etc/nginx/sites-available/local-proxy.conf'
  owner 'root'
  group 'root'
  mode  00644
  action :create
  notifies :restart, 'service[nginx]', :delayed
end

link '/etc/nginx/sites-enabled/local-proxy.conf' do
  to '/etc/nginx/sites-available/local-proxy.conf'
  notifies :restart, 'service[nginx]', :delayed
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
  action :nothing
end
