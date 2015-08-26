git '/opt/skills-recommender' do
  repository 'https://github.com/tw-bh-analytics/skills-recommender.git'
  revision 'master'
  action :sync
  only_if node['code_strategy'].eql? 'scm'
  notifies :restart, 'service[skills-recommender]', :delayed
end

git '/opt/skills-recommender-ui' do
  repository 'https://github.com/tw-bh-analytics/skills-recommender-ui.git'
  revision 'master'
  action :sync
  only_if node['code_strategy'].eql? 'scm'
  notifies :run, 'execute[skills-recommender-ui-build]', :delayed
  notifies :create, 'cookbook_file[/opt/skills-recommender-ui/build-ui.sh]', :immediately
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

cookbook_file '/opt/skills-recommender-ui/build-ui.sh' do
  source 'build-ui.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :nothing
end

execute 'skills-recommender-ui-build' do
  command '/opt/skills-recommender-ui/build-ui.sh'
  user 'root'
  group 'root'
  action :nothing
end
