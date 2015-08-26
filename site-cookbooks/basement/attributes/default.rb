default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['ark_timeout'] = 7200
default['java']['ark_download_timeout'] = 7200

default['nodejs']['npm_packages'] = [
  { 'name' => 'gulp' },
  { 'name' => 'bower' }
]
