include_recipe 'pivotal_workstation::workspace_directory'

node['hpm']['git_projects'].each do |project|
  directory = project['directory']
  origin = project['remotes']['origin']
  remotes = project['remotes']
  workspace = "#{node['sprout']['home']}/#{node['workspace_directory']}/"

  execute "clone #{origin} into #{directory}" do
    command "git clone #{origin} #{directory}"
    user node['current_user']
    cwd workspace
    not_if { File.exists? "#{workspace}/#{directory}" }
  end

  remotes.each do |name, url|
    execute "#{directory} - set #{name} to track #{url}" do
      command "git remote add -f #{name} #{url}"
      cwd "#{workspace}/#{directory}"
      user node['current_user']
      not_if { File.exists? "#{workspace}/#{directory}" }
    end
  end

  ['git branch --set-upstream master origin/master',
   'git submodule update --init --recursive'].each do |command|
    execute "#{directory} - #{command}" do
      command command
      cwd "#{workspace}/#{directory}"
      user node['current_user']
      not_if { File.exists? "#{workspace}/#{directory}" }
    end
  end
end
