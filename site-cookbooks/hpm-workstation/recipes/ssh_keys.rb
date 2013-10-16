run_unless_marker_file_exists 'ssh_keys' do
  ssh_dir = "#{node['sprout']['home']}/.ssh"

  directory 'create ~/.ssh directory (if needed)' do
    action :create
    group 'staff'
    mode '0700'
    owner node['current_user']
    path ssh_dir
  end

  file 'create ~/.ssh/config (if needed)' do
    action :create_if_missing
    group 'staff'
    mode '0644'
    owner node['current_user']
    path "#{ssh_dir}/config"
  end

  file 'create ~/.ssh/known_hosts (if needed)' do
    action :create_if_missing
    group 'staff'
    mode '0644'
    owner node['current_user']
    path "#{ssh_dir}/known_hosts"
  end

  file 'remove default SSH private key (if present)' do
    action :delete
    path "#{ssh_dir}/id_rsa"
  end

  file 'remove default SSH public key (if present)' do
    action :delete
    path "#{ssh_dir}/id_rsa.pub"
  end

  Dir["#{ssh_dir}/id_rsa*"].each do |private_key|
    execute "limit the permissions on #{private_key} to 600" do
      command "chmod 600 #{private_key}"
    end
  end
end
