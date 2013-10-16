include_recipe 'sprout-osx-base::addloginitem'

time_out_application_path = "/Applications/#{node['hpm']['time_out']['application_name']}"
time_out_application_name = node['hpm']['time_out']['application_name']

remote_file 'download Time Out' do
  checksum node['hpm']['time_out']['zip']['checksum']
  path "#{Chef::Config[:file_cache_path]}/time_out.zip"
  source node['hpm']['time_out']['zip']['url']
  group 'admin'
  user node['current_user']
  not_if { File.exists? time_out_application_path }
end

execute 'unzip Time Out' do
  command "unzip -q #{Chef::Config[:file_cache_path]}/time_out.zip -d #{Chef::Config[:file_cache_path]}/"
  group 'admin'
  user node['current_user']
  not_if { File.exists? time_out_application_path }
end

execute 'move Time Out to /Applications' do
  command "mv '#{Chef::Config[:file_cache_path]}/#{time_out_application_name}' /Applications/"
  group 'admin'
  user node['current_user']
  not_if { File.exists? time_out_application_path }
end
