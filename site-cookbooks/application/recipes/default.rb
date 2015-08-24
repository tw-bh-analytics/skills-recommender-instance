git '/opt/skills-recommender' do
  repository 'https://github.com/tw-bh-analytics/skills-recommender.git'
  revision 'master'
  action :sync
  notifies :restart, 'service[skills-recommender]', :delayed
end

directory '/opt/data' do
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end

cookbook_file '/etc/init.d/skills-recommender' do
  source 'service.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

service 'skills-recommender' do
  action :enable
  supports :restart => true, :reload => false, :status => true
end
