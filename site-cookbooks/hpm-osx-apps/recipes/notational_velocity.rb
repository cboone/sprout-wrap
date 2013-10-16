configuration = node['hpm']['notational_velocity']
application_path = configuration['application']['path']

unless File.exists? application_path
  cache_path = "#{Chef::Config[:file_cache_path]}/nv.zip"

  remote_file 'download Notational Velocity' do
    path cache_path
    source configuration['zip']['url']
    owner node['current_user']
    checksum configuration['zip']['checksum']
  end

  execute 'unzip Notational Velocity' do
    command "unzip '#{cache_path}' -x '__MACOSX*' -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
  end

  execute 'copy Notational Velocity to /Applications' do
    command "mv '#{Chef::Config[:file_cache_path]}/#{configuration['application']['name']}' '#{application_path}'"
    user node['current_user']
    group 'admin'
  end
end
